#include "llvm/ADT/Statistic.h"
#include "llvm/IR/Function.h"
#include "llvm/Transforms/Scalar.h"
#include "llvm/IR/Instructions.h"
#include "llvm/IR/IRBuilder.h"
#include "llvm/IR/Dominators.h"
#include "llvm/Transforms/Utils/LoopSimplify.h"
#include "llvm/Transforms/Utils/Cloning.h"
#include "llvm/Support/CommandLine.h"
#include "llvm/Transforms/Utils.h"
#include "llvm/IR/Constants.h"
#include "llvm/IR/DebugInfo.h"
#include "llvm/Pass.h"
#include "llvm/Analysis/LoopInfo.h"
#include "llvm/Support/raw_ostream.h"
#include "llvm/IR/IntrinsicInst.h"
#include "llvm/IR/Metadata.h"
#include "llvm/IR/Type.h"
#include "llvm/Transforms/Utils/BasicBlockUtils.h"
#include "llvm/ADT/SmallVector.h"
#include <map>
#include <vector>
#include <algorithm>

//To be safe, this requires loop-simplify, loop-simplifycfg and unify-loop-exits to be executed before

using namespace llvm;

#define DEBUG_TYPE "dynamicStructurePrefetchingPass"

static cl::opt<std::string>
targetIdentification("target-identification", cl::Hidden, cl::init("heuristic"),
               cl::desc("Target identification method, among {heuristic, annotatedIR}"));

namespace 
{
  struct dynamicStructurePrefetchingPass : public ModulePass 
  {
    static char ID; // Pass identification, replacement for typeid
    dynamicStructurePrefetchingPass() : ModulePass(ID) {}
    void getAnalysisUsage(AnalysisUsage &AU) const override 
    {
      AU.addRequired<LoopInfoWrapperPass>();
      //AU.addRequiredID(LoopSimplifyID); should be used because it's mandatory to have only one header and one latch per loop but sometimes crashes with it and is part of O3 anyway
    }

    std::vector<Value *> getSrcVar(GetElementPtrInst * gepI, Loop * L)
    {//Gathers the operands of the gep instruction gepI that are not constant among the loop L
      std::vector<Value*> res;
      bool skipFirst = true;
      for (Value * op : gepI->operands())
      {
        if (skipFirst)
        {//This is because we want to know if the getelementptr is using a variable as a stride to get the address
        //we ignore the starting address of the getelementptr
          skipFirst = false;
          continue;
        }
        if (L->isLoopInvariant(op)) continue;
        res.push_back(op);
      }
      return res;
    }

    bool contains(std::vector<MDNode *>& vect, MDNode * mdn)
    {//checks if mdn is inside vect
      for (MDNode * mdNode : vect)
        if (mdNode == mdn) return true;
      return false;
    }

    bool contains(std::vector<Value *>& vect, Value * v)
    {//checks if v is inside vect
      for (Value * val : vect)
        if (val == v) return true;
      return false;
    }

    bool contains(std::vector<Instruction *>& vect, Instruction * I)
    {//checks if I is inside vect
      for (Value * i : vect)
        if (i == I) return true;
      return false;
    }

    bool contains(std::vector<StoreInst *>& vect, StoreInst * S)
    {//checks if S is inside vect
      for (Value * s : vect)
        if (s == S) return true;
      return false;
    }

    bool contains(std::vector<Function *>& vect, Function * f)
    {//checks if f is inside vect
      for (Function * fun : vect)
        if (fun == f) return true;
      return false;
    }

    bool contains(std::vector<BasicBlock *>& vect, BasicBlock * bb)
    {//checks if bb is inside vect
      for (BasicBlock * BB : vect)
        if (BB == bb) return true;
      return false;
    }

    bool contains(std::vector<BasicBlock*>& vect, Value * v)
    {//checks if v is inside one of the BasicBlocks of vect
      for (BasicBlock* BB : vect)
        for (Instruction & I : *BB)
          if (&I == v)
            return true;
      return false;
    }

    bool contains(std::vector<Loop*>& loops, BasicBlock * BB)
    {//checks if BB is a block of one of the loops in loops
      for (Loop * L : loops)
      {
        if (L->contains(BB))
          return true;
      }
      return false;
    }

    std::vector<Function *> findCalledFunctions(Module& M)
    {//Computes a vector of the functions inside the module that are called
    //to ignore defined functions that are useless
      std::vector<Function*> calledFunctions;
      for(Module::iterator f = M.begin(), fend = M.end(); f != fend; ++f)
      {//We look for main because it's always the first function executed
        if ((*f).getName() != "main") continue;
        std::vector<Function *> lastAdded;
        lastAdded.push_back(&(*f));
        calledFunctions.push_back(&(*f));
        while (!lastAdded.empty())
        {//we iterate in a DFS manner in the call graph of the called functions
        //to fill our return vector
          std::vector<Function*> addedThisIteration;
          for (Function * fun : lastAdded)
          {
            for (BasicBlock & B : *fun)
            {
              for (Instruction & I : B)
              {
                if (CallInst * ci = dyn_cast<CallInst>(&I))
                {
                  if (ci->getCalledFunction() && !contains(calledFunctions, ci->getCalledFunction()))
                  {
                    addedThisIteration.push_back(ci->getCalledFunction());
                    calledFunctions.push_back(ci->getCalledFunction());
                  }
                  Function *fun = ci->getCalledFunction();
                  if (fun && fun->getName() == "pthread_create")
                  {
                    Value *secondArg = ci->getArgOperand(2);
                    if (Function* callbackFunction = dyn_cast<Function>(secondArg)) 
                    {
                      // If the second argument is a function, add it to calledFunctions
                      if (callbackFunction && !contains(calledFunctions, callbackFunction)) 
                      {
                        addedThisIteration.push_back(callbackFunction);
                        calledFunctions.push_back(callbackFunction);
                      }
                    }
                  }
                }
              }
            }
        }
          lastAdded = addedThisIteration;
        }
      }
      return calledFunctions;
    }

    int nbInstrInLoop(Loop * L)
    {//Counts the number of instructions inside the loop
      int count = 0;
      for (BasicBlock * BB : L->getBlocks())
      {
        for (Instruction & I : *BB)
        {
          count++;
        }
      }
      return count;
    }

    std::vector<Value *> getVarsDefinedInLoop(Loop * L)
    {//Gathers the values that are defined inside the loop
      std::vector<Value *> res;
      for (BasicBlock * B : L->getBlocks())
        for (Instruction & I : *B)
          if (Value * v = dyn_cast<Instruction>(&I))
            if (!contains(res, v))
              res.push_back(v);
      return res;
    }

    std::vector<Value *> getVarsStoredToInLoop(Loop * L)
    {//Gathers the values that are being stored to inside the loop
      std::vector<Value *> res;
      for (BasicBlock * B : L->getBlocks())
        for (Instruction & I : *B)
          if (StoreInst * store = dyn_cast<StoreInst>(&I))
          {
            Value * storeAddr = store->getOperand(1);
            if (!contains(res, storeAddr))
              res.push_back(storeAddr);
          }
      return res;
    }

    std::vector<Instruction*> findDelinquentLoads(Loop * L, std::vector<Value*>& defInLoop, std::vector<Loop*>& subLoops, std::vector<MDNode*> targetMDs)
    {//Gathers the delinquent loads (function to be redefined if willing to change the heuristic)
      std::map<Value*, Instruction&> delinquentMap;
      std::vector<Instruction*> delinquentLoads;
      if (targetIdentification == "annotatedIR")
      {//In that case we do not use the heuristic
        for (BasicBlock * BB : L->getBlocks())
        {
          for (Instruction & I : *BB)
          {
            SmallVector<std::pair<unsigned, MDNode *>, 4> MDs;
            I.getAllMetadata(MDs);
            for (std::pair<unsigned, MDNode*> mdPair : MDs)
              if (contains(targetMDs, mdPair.second))
                delinquentLoads.push_back(&I);
          }
        }
        return delinquentLoads;
      }
      //otherwise we use the heuristic (this part is to be redefined if we want to change the heuristic)
      for(BasicBlock *BB : L->getBlocks())
      {
        if (contains(subLoops, BB))
          continue; //We don't want to consider the same load twice,
          //so we consider it only as part of the deep most loop
        for (Instruction & I : *BB)
        {
          if (LoadInst * li = dyn_cast<LoadInst>(&I))
          {
            Value * v = li->getOperand(0);
            if (GetElementPtrInst * gepI = dyn_cast<GetElementPtrInst>(v))
            {
              Value * op0 = gepI->getOperand(0);
              std::vector<Value *> sourceVariables = getSrcVar(gepI, L);
              if (sourceVariables.empty() && !delinquentMap.contains(op0) && contains(defInLoop, op0))
              {
                //Then the getelementptr uses only constants to stride from the address op0
                //So it loads op0 and its surroundings
                delinquentMap.insert({op0, I});
                delinquentLoads.push_back(&I);
              }
              else if (!sourceVariables.empty() && !delinquentMap.contains(v))
              {
                //here it uses a variable to stride away from the start address op0 of the getelementptr
                //so we want to check if that stride is defined in the loop, otherwise it's constant among the loop
                //so for us it's as if it was constant
  
                for (Value * val : sourceVariables)
                {
                  if (contains(defInLoop, val))
                  {
                    delinquentMap.insert({v, I});
                    delinquentLoads.push_back(&I);
                    break;
                  }
                }
              }
            }
            else if (!delinquentMap.contains(v) && contains(defInLoop, v))
            {//Then it is constant if not defined in the loop
              delinquentMap.insert({v, I});
              delinquentLoads.push_back(&I);
            }
          }
        }
      }
      return delinquentLoads;
    }

    bool isBefore(Instruction * i, Instruction * j, Loop * L)
    {//Returns true if i is necessarily executed before j inside a loop iteration of L
    //If i and j are in distinct branches of a "if" then it'll return false
    //So this is not antisymmetric
      //If both are in the same block, a builtin function exists
      if (i->getParent() == j->getParent())
        return i->comesBefore(j);
      else
      {//We do a DFS through the succesors of i's parent, stopping when arriving
      //on the loop header without finding j because then j is before i
      //We also ignore already seen blocks to avoid looping indefinitely if L contains another loop
        std::vector<BasicBlock *> successors = {i->getParent()};
        std::vector<BasicBlock*> seen = {i->getParent()};
        while (!successors.empty())
        {
          BasicBlock * b = successors.back();
          for (Instruction & I : *b)
          {//We check if b contains j
            if (&I == j) return true;
          }
          successors.pop_back();
          for (int i = 0; i < b->getTerminator()->getNumSuccessors(); i++)
          {//We add the not already seen successors to continue the DFS
            BasicBlock * bl = b->getTerminator()->getSuccessor(i);
            if (L->getHeader() != bl && L->contains(bl) && !contains(seen, bl))
            {
              successors.push_back(bl);
              seen.push_back(bl);
            }
          }
        }
        return false;
      }
    }

    bool isBetween(Instruction * i, Instruction * j, Instruction * k, Loop * L)
    {//Returns true if i is between j and k (either in a loop iteration i is executed before j which is executed before k: left of the ||
    //or i is executed before j then in the next loop iteration k is executed before both: mid of the ||
    //or i is executed last and in the next loop iteration j will be executed then k: right of the ||)
      return (isBefore(i, k, L) && isBefore(j, k, L) && isBefore(j, i, L)) || (isBefore(i, j, L) && isBefore(k, j, L) && isBefore(k, i, L)) || (isBefore(j, k, L) && isBefore(k, i, L) && isBefore(j, i, L));
    }

    Instruction * getLastArg(std::vector<Value*> coroArgs, Loop * L)
    {//Returns the latest executed instruction among coroArgs in a loop iteration of L
    //to find the insertion point of the coroutine call
      Instruction * max = NULL;
      for (int i = 0; i < coroArgs.size(); i++)
      {
        if (Instruction* I = dyn_cast<Instruction>(coroArgs[i]))
        {
          if (max == NULL || (!L->contains(max) && L->contains(I)) || isBefore(max, cast<Instruction>(I), L))
            max = I;
        }
      }
      return max;
    }

    Instruction * getFirstInst(std::vector<Instruction*> instructions, Loop * L)
    {//Returns the first executed instruction of instructions in a loop iteration of L
      Instruction * min = NULL;
      for (int i = 0; i < instructions.size(); i++)
      {
        if (min == NULL || isBefore(instructions[i], min, L))
          min = instructions[i];
      }
      return min;
    }

    struct diamondInfo
    {
      BasicBlock * entry;
      BasicBlock * exit;
      std::vector<BasicBlock*> diamond;
    };

    struct diamondInfo findTargetDiamond(Instruction * target, DominatorTree& DT, BasicBlock * loopLatch, Loop* L)
    {
      //Returns an empty vector if it's not part of a diamond
      //First we check if it's the case
      bool partOfDiamond =  !(DT.dominates(target->getParent(), loopLatch) || loopLatch == target->getParent()); //for this check if dominates the end of the loop
      //diamond: start at the first block (going up in the preds) that dominates the end of the loop
      //ends at the first block (going down in the succs) that dominates the end of the loop
      if (!partOfDiamond) return {};
      std::vector<BasicBlock *> diamond;
      BasicBlock * diamondEntry = DT.findNearestCommonDominator(loopLatch, target->getParent());
      BasicBlock * diamondExit = target->getParent();
      std::vector<BasicBlock*> toExplore = {diamondExit};
      std::vector<BasicBlock*> seen = toExplore;
      while (!DT.dominates(diamondExit, loopLatch))
      {//DFS through the successors of target's block until reaching a block which dominates the latch
        for (auto it = succ_begin(diamondExit), et = succ_end(diamondExit); it != et; it++)
        {
          if (contains(seen, *it))
            continue;
          toExplore.push_back(*it);
          seen.push_back(*it);
        }
        diamondExit = toExplore.back();
        toExplore.pop_back();
      }
      //We have the delimiters of the diamond, we need to compute all the inside, we can do another DFS
      //starting from the entry
      toExplore = {diamondEntry};
      seen = toExplore;
      while (!toExplore.empty())
      {
        BasicBlock * BB = toExplore.back();
        toExplore.pop_back();
        diamond.push_back(BB);
        for (auto it = succ_begin(BB), et = succ_end(BB); it != et; it++)
        {
          if (!contains(diamond, *it) && !contains(seen, *it) && diamondExit != *it && L->contains(*it))
          {
            toExplore.push_back(*it);
            seen.push_back(*it);
          }
        }
      }
      struct diamondInfo diamInf;
      diamInf.diamond = diamond;
      diamInf.entry = diamondEntry;
      diamInf.exit = diamondExit;
      return diamInf;
    }

    bool cannotCreateCoroutine(Loop * L, DominatorTree& DT, std::vector<BasicBlock*>& coroutineBlocks, BasicBlock * diamEntry, std::vector<Value*>& coroArgs, Instruction * lastArg, Instruction* target)
    {
      //If the diamEntry has phis, we need to pass them as args and so we will most likely not be timely
      for (PHINode & pn : diamEntry->phis())
        return true;

      for (Value * v : coroArgs)
        if (Instruction * I = dyn_cast<Instruction>(v))
          if (I->getParent() != L->getHeader() && L->contains(I->getParent()))
            return true;//if not, the prefetch will be done relatively late so we don't do it
            
      //We verify that the diamond doesn't have a write instruction that the target doesn't dominate and that
      //can be used before the diamEntry, otherwise we cannot build the coroutine safely (the writes risk affecting
      //the application's execution as we'll make the computations in advance)

      for (BasicBlock * BB : coroutineBlocks)
      {
        if (DT.dominates(target->getParent(), BB)) continue;
        for (Instruction & I : *BB)
        {
          Value * storedTo = NULL;
          if (StoreInst * s = dyn_cast<StoreInst>(&I))
            storedTo = s->getOperand(1);
          else if (MemSetInst * m = dyn_cast<MemSetInst>(&I))
            storedTo = m->getArgOperand(0);
          if (!storedTo) continue;

          for (User * U : storedTo->users())
          {
            if (Instruction * UI = dyn_cast<Instruction>(U))
            {
              if (BB != diamEntry && isBefore(UI, &I, L) && isBefore(lastArg, UI, L))
                return true;//may be used before coroutine and the writing operation isn't in the header
                //so we cannot move it
              if (isBefore(&I, UI, L) && contains(coroutineBlocks, UI->getParent()))
                return true;//may be used in coroutine
            }
          }
        }
      }
      return false;
    }

    struct GVarInfo
    {
      std::vector<GlobalVariable*> returnVars;
      std::map<GlobalVariable *, Instruction*> GVarMap;
    };

    struct GVarInfo getGlobalReturnVariables(Module& M, Function * f, std::vector<BasicBlock*>& coroutineBlocks, BasicBlock* diamExit, std::string& coroString)
    {//Creates the global variables used as return values of the coroutine
      std::vector<GlobalVariable*> returnVars = std::vector<GlobalVariable*>();
      std::map<GlobalVariable *, Instruction*> GVarMap;
      int i = 0;
      for (PHINode & p : diamExit->phis())
      {//The phinodes in the diamond exit naturally depend on the diamond's execution
      //so they need to be replaced by a return variable
        Type * t = p.getType();
        M.getOrInsertGlobal(coroString+".return"+std::to_string(i), t);
        GlobalVariable * ret = M.getNamedGlobal(coroString+".return"+std::to_string(i));
        GVarMap.insert({ret, &p});
        ret->setLinkage(GlobalValue::InternalLinkage);
        ret->setAlignment(Align(8));
        ret->setInitializer(Constant::getNullValue(t));
        ret->setConstant(false);
        returnVars.push_back(ret);
        i++;
      }

      i = 0;
      for (PHINode & p : diamExit->phis())
      {//We replace the phiNodes by their corresponding return variable
        replaceUsesOutsideCoro(&p, returnVars[i], coroutineBlocks, f);
        i++;
      }
        
      //We add return variables for every values defined in the coroutine's diamond that are used outside
      //Because the diamond will be removed from the original loop
      for (Instruction * I : coroutineInstructions(coroutineBlocks))
      {
        //We must compute coroutineInstructions because the loop adds instructions
        //and it'd loop infinitely otherwise
        for (User * U : I->users())
        {
          if (!contains(coroutineBlocks, U) && (!(dyn_cast<PHINode>(U)) || !(cast<PHINode>(U)->getParent() == diamExit)))
          {
            M.getOrInsertGlobal(coroString+".return"+std::to_string(i), I->getType());
            GlobalVariable * ret = M.getNamedGlobal(coroString+".return"+std::to_string(i));
            GVarMap.insert({ret, I});
            ret->setLinkage(GlobalValue::InternalLinkage);
            if (LoadInst * li = dyn_cast<LoadInst>(I))
              ret->setAlignment(li->getAlign());
            ret->setInitializer(Constant::getNullValue(I->getType()));
            ret->setConstant(false);
            returnVars.push_back(ret);
            replaceUsesOutsideCoro(I, ret, coroutineBlocks, f);
            i++;
            break;
          }
        }
      }
      struct GVarInfo res;
      res.returnVars = returnVars;
      res.GVarMap = GVarMap;
      return res;
    }

    void sortedInsertion(std::vector<Value*>& vect, Value * val, Loop * L)
    {//We ignore values that are not instructions because the order makes no sense
      if (Instruction * i = dyn_cast<Instruction>(val))
      {//We insert val in vect maintaining the order in which the instructions are executed in the vector
        int ind =0;
        for (std::vector<Value*>::iterator it = vect.begin(); it != vect.end(); it++)
        {
          Value * v = *it;
          if (Instruction * j = dyn_cast<Instruction>(v))
          {
            if (isBefore(i, j, L))
            {
              vect.insert(it, val);
              return;
            }
          }
        }
        vect.push_back(val);
      }
    }

    void sortedInsertion(std::vector<Instruction*>& vect, Instruction * i, Loop * L)
    {//We insert val in vect maintaining the order in which the instructions are executed in the vector
      int ind =0;
      for (std::vector<Instruction*>::iterator it = vect.begin(); it != vect.end(); it++)
      {
        Instruction * j = *it;
        if (isBefore(i,j,L))
        {
          vect.insert(it, i);
          return;
        }
      }
      vect.push_back(i);
    }

    int maxNumberOfInstructionsBetween(Instruction * I, Instruction * target, std::vector<BasicBlock*>& seen, Loop * L)
    {//Returns the maximum possible number of instructions between I and target, used to see if prefetching target right after I
    //can save time
      if (I == target) return 0;
      Instruction * nextInst = I->getNextNonDebugInstruction();
      if (nextInst)
      {
        if (nextInst == target)
          return 0; //we don't count the target nor the lastDependence
        return 1 + maxNumberOfInstructionsBetween(nextInst, target, seen, L);
      }
      else
      {
        int max = 0;
        for (auto it = succ_begin(I->getParent()), et = succ_end(I->getParent()); it != et; it++)
        {
          if (contains(seen, *it))
            return 10;//we have a loop between the prefetch point and the target so we expect
            //the prefetch to be timely
          if (L->contains(*it))
          {
            seen.push_back(*it);
            //The target is a load not a phi node so we can avoid calling on the phi nodes
            //and just count them right now
            int nbPhiNodes = 0;
            for (PHINode & pn : (*it)->phis())
              nbPhiNodes++;
            int tmp = nbPhiNodes + maxNumberOfInstructionsBetween((*it)->getFirstNonPHIOrDbg(), target, seen, L);
            if (tmp > max)
              max = tmp;
          }
        }
        return 1 + max;
      }
    }

    void backwardDFS(Value * v, std::vector<Value*>& defInLoop, std::vector<Instruction*>& seen, Loop * L, Instruction * target, bool ignoreIfs)
    {//does a DFS backward in the dependencies of v to find the instructions that are used for it or that are conflicting stores
      if (!contains(defInLoop,v)) return;
      BasicBlock * header = L->getHeader();
      if (Instruction * iv = dyn_cast<Instruction>(v))
      {
        if (!contains(seen, iv))
          sortedInsertion(seen, iv, L);
      }
      if (PHINode * pn = dyn_cast<PHINode>(v))
      {
        //either the end of an if or an induction variable
        if (header == pn->getParent())
        {
          return;
        }
        else if (ignoreIfs) return;
        else
        {//then it's the end of an if so we need to take the terminators
          for (Value * val : pn->incoming_values())
          {//Take the values used in the phinode
            if (Instruction * I = dyn_cast<Instruction>(v))
            {
              if (contains(defInLoop,val) && !contains(seen, I) && !L->isLoopInvariant(val))
              {//this considers that we do not leave the loop (may be false if the code has strange gotos)
                sortedInsertion(seen, I, L);
                backwardDFS(val, defInLoop, seen, L, target, ignoreIfs);
              }
            }
          }
          for (int i = 0; i < pn->getNumIncomingValues(); i++)
          {//Take the terminators
            BasicBlock * b = pn->getIncomingBlock(i);
            Instruction * t = b->getTerminator();
            if (!contains(seen,t) && !L->isLoopInvariant(t))
            {
              sortedInsertion(seen, t, L);
              backwardDFS(t, defInLoop, seen, L, target, ignoreIfs);
            }
          }
        }
      }
      else if (Instruction * i = dyn_cast<Instruction>(v))
      {//Then we first  take all non constant operands
        for (Value * op : i->operands())
        {
          if (Instruction * I = dyn_cast<Instruction>(op))
          {
            if (contains(seen, I) || L->isLoopInvariant(op)) continue;
            sortedInsertion(seen, I, L);
            backwardDFS(op, defInLoop, seen, L, target, ignoreIfs);
          }
        }
        if (LoadInst * li = dyn_cast<LoadInst>(i))
        {//Then we also take the instructions that write in the loaded address
          bool isModifiedInLoop = false;
          for (User * u : li->getOperand(0)->users())
          {
            if (StoreInst * s = dyn_cast<StoreInst>(u))
            {
              if (contains(defInLoop,s))
              {
                isModifiedInLoop = true;
                if (!contains(seen, s) && !(isBefore(s, li, L) || isBefore(li, s, L)) && !isBetween(s, li, target, L))
                {
                  sortedInsertion(seen, s, L);
                  backwardDFS(s, defInLoop, seen, L, target, ignoreIfs);
                }
              }
            }
            else if (MemSetInst * m = dyn_cast<MemSetInst>(u))
            {
              if (contains(defInLoop,m))
              {
                isModifiedInLoop = true;
                if (!contains(seen, m) && !(isBefore(m, li, L) || isBefore(li, m, L)) && !isBetween(m, li, target, L))
                {
                  sortedInsertion(seen, m, L);
                  backwardDFS(m, defInLoop, seen, L, target, ignoreIfs);
                }
              }
            }
          }
        }
      }
      return;
    }

    std::vector<PHINode*> findPhiNodes(std::vector<Instruction*>& dependencies)
    {//Returns the phinodes that are in dependencies
      std::vector<PHINode*> res;
      for (Value * v : dependencies)
        if (PHINode * pn = dyn_cast<PHINode>(v))
          res.push_back(pn);
      return res;
    }

    void insert(std::map<BasicBlock *, std::vector<Instruction*>>& res, BasicBlock * key, std::vector<Instruction*> val)
    {
      if (res.contains(key))
        for (Instruction * i : val)
          res[key].push_back(i);
      else
        res.insert({key, val});
    }

    void backwardSearchInBlock(std::vector<Instruction*>& res, BasicBlock * block, Instruction * i)
    {//Gathers in res the dependencies of i that are defined in block
      res.push_back(i);
      for (Value * op : i->operands())
      {
        if (Instruction * opi = dyn_cast<Instruction>(op))
        {
          if (opi->getParent() != block || contains(res, opi)) continue;
          backwardSearchInBlock(res, block, opi);
        }
      }
    }

    std::map<BasicBlock *, std::vector<Instruction*>> backwardSearch(std::vector<BasicBlock *> coroutineBlocks, BasicBlock * start, Instruction * target)
    {//Does a backward search in coroutineBlocks starting from start to find the dependencies of target
      std::map<BasicBlock *, std::vector<Instruction*>> res;
      std::vector<BasicBlock*> toIterate = {start};
      std::vector<BasicBlock*> seen = {start};
      
      while (!toIterate.empty())
      {//Here we take the control dependencies
        BasicBlock * bb = toIterate.back();
        toIterate.pop_back();
        for (auto it = pred_begin(bb), et = pred_end(bb); it != et; it++)
        {
          BasicBlock * pred = *it;
          if (contains(coroutineBlocks, pred) && !contains(seen, pred))
          {
            seen.push_back(pred);
            toIterate.push_back(pred);
            std::vector<Instruction*> tmp;
            backwardSearchInBlock(tmp, pred, pred->getTerminator());
            insert(res, pred, tmp);
          }
        }
      }
      //Then we consider the value dependencies
      std::vector<Instruction *> toConsider = {target};
      std::vector<Instruction *> seenInst = {target};
      if (res.contains(target->getParent()))
        res[target->getParent()].push_back(target);
      else
        res.insert({target->getParent(), {target}});
      while (!toConsider.empty())
      {
        Instruction * I = toConsider.back();
        toConsider.pop_back();
        for (Value * op : I->operands())
        {
          if (Instruction * i = dyn_cast<Instruction>(op))
          {
            if (!contains(coroutineBlocks, op) || contains(seenInst,i)) continue;
            seenInst.push_back(i);
            toConsider.push_back(i);
            if (res.contains(i->getParent()))
              res[i->getParent()].push_back(i);
            else
              res.insert({i->getParent(), {i}});
          }
        }
      }
      return res;
    }

    std::map<BasicBlock *, std::vector<Instruction*>> difference(std::vector<BasicBlock*> coroBlocks, std::map<BasicBlock *, std::vector<Instruction*>> controlInstr)
    {//Computes the instructions that are in coroBlocks but not in controlInstr grouping by basicBlock
      std::map<BasicBlock *, std::vector<Instruction*>> res;
      for (BasicBlock * BB : coroBlocks)
      {
        std::vector<Instruction*> val;
        for (Instruction & I : *BB)
        {
          if (!contains(controlInstr[BB], &I))
            val.push_back(&I);
        }
        res.insert({BB, val});
      }
      return res;
    }

    std::vector<Instruction*> findCommonPart(std::map<BasicBlock *, std::vector<Instruction*>> controlInstructions, BasicBlock* resumingBlc)
    {//Computs the instructions among controlInstructions that are used after resumingBlc
      std::vector<Instruction*> res;

      //First we compute the blocks in the resume part
      std::vector<BasicBlock*> resumePart = {resumingBlc};
      bool finished = false;
      while (!finished)
      {//We build a vector with the whole resumePart (blocks after resumingBlc, including it)
        finished = true;
        BasicBlock * BB = resumePart.back();
        for (auto it = succ_begin(BB), et = succ_end(BB); it != et; it++)
        {
          if (!contains(resumePart, *it))
          {
            finished = false;
            resumePart.push_back(*it);
          }
        }
      }
      //We actually do the main computation
      for (std::pair<BasicBlock*, std::vector<Instruction*>> pair : controlInstructions)
      {
        for (Instruction * I : pair.second)
        {
          bool isCommon = false;
          for (BasicBlock * BB : resumePart)
          {
            for (Instruction & In : *BB)
            {
              for (Value * op : In.operands())
              {
                if (op == I)
                {
                  isCommon = true;
                  break;
                }
              }
              if (isCommon) break;
            }
            if (isCommon) break;
          }
          if (isCommon && !contains(res, I))
            res.push_back(I);
        }
      }
      return res;
    }

    void replaceUsesOutsideCoro(Value * v, GlobalVariable * gv, std::vector<BasicBlock*>& coroutineBlocks, Function * f)
    {//Replaces the uses of v by gv in blocks of f that are not in coroutineBlocks
      for (BasicBlock & BB : *f)
      {
        if (contains(coroutineBlocks, &BB))
          continue;
        for (Instruction & I : BB)
        {
          if (PHINode * pn = dyn_cast<PHINode>(&I))
          {
            for (int i = 0; i < pn->getNumIncomingValues(); i++)
            {
              if (contains(coroutineBlocks, pn->getIncomingBlock(i)))
                break;//the phinode is in the diamond's end, it'll be removed so it's useless to replace its uses
              if (pn->getIncomingValue(i) == v)
              {
                //We first check if a load of gv is already defined to avoid adding useless ones
                Value * alreadyDefinedLoad = NULL;
                for (Instruction & I : *(pn->getIncomingBlock(i)))
                {
                  if (LoadInst * li = dyn_cast<LoadInst>(&I))
                  {
                    if (li->getOperand(0) == gv)
                      alreadyDefinedLoad = li;
                  }
                }
                //Then we replace the use and add a load if necessary
                if (alreadyDefinedLoad)
                  pn->setIncomingValue(i, alreadyDefinedLoad);
                else
                {
                  LoadInst * loadGvar = new LoadInst(v->getType(), gv, "", pn->getIncomingBlock(i));
                  loadGvar->moveBefore(pn->getIncomingBlock(i)->getFirstNonPHI());
                  pn->setIncomingValue(i, loadGvar);
                }
              }
            }
          }
          else
          {//Here it's a value defined in the coroutine blocks and used outside (most likely defined in the entry)
            int opN = 0;
            for (Value * op : I.operands())
            {
              if (op == v)
              {
                //We check if a load is already defined
                LoadInst * alreadyDefinedLoad = NULL;
                for (Instruction & i : BB)
                {
                  if (LoadInst * li = dyn_cast<LoadInst>(&i))
                  {
                    if (li->getOperand(0) == gv)
                      alreadyDefinedLoad = li;
                  }
                }
                //We add a load if necessary and replace the use
                if (!alreadyDefinedLoad)
                {
                  alreadyDefinedLoad = new LoadInst(v->getType(), gv, "", &I);
                  alreadyDefinedLoad->moveBefore(BB.getFirstNonPHI());
                }

                I.setOperand(opN, alreadyDefinedLoad);
              }
              opN++;
            }
          }
        }
      }
    }

    std::vector<Instruction*> coroutineInstructions(std::vector<BasicBlock*>& coroutineBlocks)
    {//Computes a vector of all the instructions in coroutineBlocks
      std::vector<Instruction*> res;
      for (BasicBlock * BB : coroutineBlocks)
        for (Instruction & I : *BB)
          res.push_back(&I);
      return res;
    }

    void replaceAllUses(std::vector<BasicBlock*>& blocks, ValueToValueMapTy& mapping)
    {//Replaces all uses inside blocks of values defined in mapping by their corresponding mapped value
      for (BasicBlock * BB : blocks)
      {
        for (Instruction & I : *BB)
        {
          if (I.isUsedByMetadata())
          {//We replace metadata uses
            SmallVector<DbgVariableIntrinsic *> DbgUsers;
            findDbgUsers(DbgUsers, &I);
            for (auto *DVI : DbgUsers) 
            {
              if (contains(blocks, DVI->getParent()))
                DVI->replaceVariableLocationOp(&I, mapping[&I]);
            }
          }
          if (PHINode * pn = dyn_cast<PHINode>(&I))
          {//Then we must both replace used values and blocks, but blocks are not counted as operands
          //so we have to treat it differently from other instructions
            for (int i = 0; i < pn->getNumIncomingValues(); i++)
            {
              if (mapping.count(pn->getIncomingValue(i)))
                pn->setIncomingValue(i, mapping[pn->getIncomingValue(i)]);
              if (mapping.count(pn->getIncomingBlock(i)))
                pn->setIncomingBlock(i, cast<BasicBlock>(mapping[pn->getIncomingBlock(i)]));
            }
          }
          else
          {
            int i = 0;
            for (Value * op : I.operands())
            {
              if (mapping.count(op))
                I.setOperand(i, mapping[op]);
              i++;
            }
          }
        }
      }
    }

    Instruction * earliestPositionPossible(Instruction * I, Loop * L)
    {//Finds the earliest position where we can execute I in a loop iteration of L
    //without altering the execution of the application
      if (dyn_cast<PHINode>(I))
      {//Then we cannot move it sooner, but to avoid issues where we add instructions between
      //phi nodes, we put it after the last phiNode
        PHINode * lastPHI = NULL;
        for (PHINode & pn : I->getParent()->phis())
        {
          lastPHI = &pn;
        }
        return lastPHI;
      }
      Instruction * soonest = NULL;
      for (Value * op : I->operands())
      {//We must be after the ealiest position possible of all our operands
        if (Instruction * i = dyn_cast<Instruction>(op))
        {
          i = earliestPositionPossible(i, L);
          if (!soonest || isBefore(i, soonest, L))
            soonest = i;
        }
      }
      if (LoadInst * li = dyn_cast<LoadInst>(I))
      {//Then we must also be after all the memory writing instructions that write in the loaded address
        for (BasicBlock * BB : L->getBlocks())
        {
          for (Instruction & i : *BB)
          {
            if (!isBefore(&i, I, L)) continue;
            if (StoreInst * S = dyn_cast<StoreInst>(&i))
            {
              if (S->getOperand(1) == I && (!soonest || !isBefore(S, soonest, L)))
              {
                soonest = S;
              }
            }
          }
        }
      }
      if (!soonest)
        return I;
      return soonest;
    }

    Instruction * earliestPositionPossible(std::vector<Instruction*>& indVarValInLastIt, Loop * L)
    {//Earliest position possible for all instructions of indVarValInLastIt
      Instruction * earliest = NULL;
      for (Instruction * I : indVarValInLastIt)
      {
        Instruction * candidate = earliestPositionPossible(I, L);
        if (!earliest || !isBefore(candidate, earliest, L))
          earliest = candidate;
      }
      return earliest;
    }

    void moveInstAsEarlyAsPossible(Instruction * I, Loop * L)
    {//Actually performs the moves, but the function is overall the same as earliestPositionPossible
      if (dyn_cast<PHINode>(I))
      {
        I->moveBefore(I->getParent()->getFirstNonPHI());
        return;
      }

      Instruction * soonest = NULL;
      for (Value * op : I->operands())
      {
        if (Instruction * i = dyn_cast<Instruction>(op))
        {
          if (!L->contains(i->getParent()))
            continue;
          moveInstAsEarlyAsPossible(i, L);
          if (!soonest || !isBefore(i, soonest, L))
          {
            soonest = i;
          }
        }
      }
      if (LoadInst * li = dyn_cast<LoadInst>(I))
      {
        for (BasicBlock * BB : L->getBlocks())
        {
          for (Instruction & i : *BB)
          {
            if (!isBefore(&i, I, L)) continue;
            if (StoreInst * S = dyn_cast<StoreInst>(&i))
            {
              if (S->getOperand(1) == I->getOperand(0))
              {
                if (!soonest || !isBefore(S, soonest, L))
                  soonest = S;
              }
            }
            else if (MemSetInst * M = dyn_cast<MemSetInst>(&i))
            {
              if (M->getArgOperand(0) == I->getOperand(0))
              {
                if (!soonest || !isBefore(M, soonest, L))
                  soonest = M;
              }
            }
          }
        }
      }
      if (soonest)
      {
        if (dyn_cast<PHINode>(soonest))
        {
          I->moveBefore(soonest->getParent()->getFirstNonPHI());
        }
        else
        {
          I->moveAfter(soonest);
        }
      }
      else
      {
        I->moveBefore(I->getParent()->getFirstNonPHI());
      }
    }

    void moveInstAsEarlyAsPossible(std::vector<Instruction*>& indVarValInLastIt, Loop * L)
    {//Actually performs the moves, but the function is overall the same as earliestPositionPossible
      for (Instruction * I : indVarValInLastIt)
        moveInstAsEarlyAsPossible(I, L);
    }

    bool moveBeforePHINode(Instruction * I, PHINode* P, Loop * L)
    { //Takes I which is defined based on a phi node, reorder it in the phi node's preds
      //and recursively continue until there is no conflicting store or loop
      //Returns whether it could or not
      if (isBefore(I, P, L))
        return true; //This means that I has already been moved
      if (LoadInst * LI = dyn_cast<LoadInst>(I))
      {
        std::vector<BasicBlock*> toIterate = {P->getParent()};
        std::vector<BasicBlock*> seen = toIterate;
        //We iterate over the BB between P and I to check if there is a conflicting store
        while (!toIterate.empty())
        {
          BasicBlock * BB = toIterate.back();
          toIterate.pop_back();
          if (BB != I->getParent())
          {
            for (auto it = succ_begin(BB), et = succ_end(BB); it != et; it++)
            {
              if (!contains(seen, *it))
              {
                seen.push_back(*it);
                toIterate.push_back(*it);
              }
            }
          }
          for (Instruction & i : *BB)
          {
            if (StoreInst * S = dyn_cast<StoreInst>(&i))
              if (S->getOperand(1) == LI->getOperand(0))
                return false; // We cannot move I before the PHINode P
            else if (MemSetInst * MI = dyn_cast<MemSetInst>(&i))
              if (MI->getArgOperand(0) == LI->getOperand(0))
                return false;
          }
        }
      }
      bool hasPasOperand = false;
      int opN = 0;
      int opNumP = 0;
      for (Value * op : I->operands())
      {//We move the operands before the phiNode
        opN++;
        if (P == op)
        {
          opNumP = opN-1;
          hasPasOperand = true;
          continue;
        }
        if (Instruction * opI = dyn_cast<Instruction>(op))
        {
          if (!moveBeforePHINode(opI, P, L))
            return false;
        }
      }
      if (hasPasOperand)
      {//Then it cannot be moved before P so we have to duplicate it in all
      //incoming blocks of P and replace the use of P with uses of the correspong incomingValue
        PHINode * pn = PHINode::Create(I->getType(), P->getNumIncomingValues(), "", P);
        I->replaceAllUsesWith(pn);
        for (int i = 0; i < P->getNumIncomingValues(); i++)
        {
          if (i == 0)
          {
            I->moveBefore(P->getIncomingBlock(i)->getTerminator());
            I->setOperand(opNumP, P->getIncomingValue(i));
            pn->addIncoming(I, P->getIncomingBlock(i));
          }
          else
          {
            Instruction * IC = I->clone();
            IC->insertBefore(P->getIncomingBlock(i)->getTerminator());
            IC->setOperand(opNumP, P->getIncomingValue(i));
            pn->addIncoming(IC, P->getIncomingBlock(i));
          }
        }
      }
      else
      {//Then we duplicate I in all incomingBlocks of P and create a phiNode to
      //take the right value of I (right copy)
        PHINode * pn = PHINode::Create(I->getType(), P->getNumIncomingValues(), "", P);
        I->replaceAllUsesWith(pn);
        for (int i = 0; i < P->getNumIncomingValues(); i++)
        {
          if (i == 0)
          {
            I->moveBefore(P->getIncomingBlock(i)->getTerminator());
            pn->addIncoming(I, P->getIncomingBlock(i));
          }
          else
          {
            Instruction * IC = I->clone();
            IC->insertBefore(P->getIncomingBlock(i)->getTerminator());
            pn->addIncoming(IC, P->getIncomingBlock(i));
          }
        }
      }
      return true;
    }

    void sortTargets(std::vector<Instruction*>& otherTargets, std::vector<Instruction*>& coroutineLess, std::vector<Instruction*>& withCoroutine, std::vector<Value*>& defInLoop, Function * f, Loop * L)
    {//Sorts the targets depending on whether they require to build a coroutine of not
      DominatorTree DT = DominatorTree(*f);
      for (Instruction* target : otherTargets)
      {
        std::vector<BasicBlock *> coroutineBlocks = {target->getParent()};
        BasicBlock * diamEntry = target->getParent();
        std::vector<Instruction*> dependencies;
        backwardDFS(target, defInLoop, dependencies, L, target, true);

        //This works only if there is no "if" defining the dependencies
        //When the if in the same loop iteration and before the target,
        //I did something but couldn't test yet it by lack of example
        std::vector<PHINode*> phiNodes = findPhiNodes(dependencies);
                
        bool dependsOnAIf = false;
        std::vector<Instruction*> indVarValInPrevIt;
        std::vector<Loop*> subLoops = L->getSubLoops();
        for (PHINode * pn : phiNodes)
        {
          if (!dependsOnAIf && pn->getParent() != L->getHeader() && !contains(subLoops, pn->getParent()))
            dependsOnAIf = true;
          if (pn->getParent() != L->getHeader())
            continue;
          for (int i = 0; i < pn->getNumIncomingValues(); i++)
          {
            if (L->contains(pn->getIncomingBlock(i)))
              if (Instruction * I = dyn_cast<Instruction>(pn->getIncomingValue(i)))
                if (contains(defInLoop, I) && !contains(indVarValInPrevIt, I))
                  indVarValInPrevIt.push_back(I);
          }
        }
        
        if (indVarValInPrevIt.empty())
          continue;//In this case, the target is in fact constant so shouldn't be there
          //But in case, we still put that verification

        if (!dependsOnAIf)
        {
          coroutineLess.push_back(target);
        }
        else
        {
          //TODO: test this part (I have no example)
          PHINode * lastPHINode = NULL;
          for (PHINode * pn : phiNodes)
          {
            if (pn->getParent() != L->getHeader() && !contains(subLoops, pn->getParent()))
            {
              if (!lastPHINode || isBefore(lastPHINode, pn, L))
              {
                lastPHINode = pn;
              }
            }
          }
          if (moveBeforePHINode(target, lastPHINode, L))
          {//We only add those that can be turned into a coroutine,
          //others require duplicating the whole diamond and it can be costly
            withCoroutine.push_back(target);
          }
        }
      }
    }

    bool prefetchOtherTargets(std::vector<Instruction*>& otherTargets, std::map<BasicBlock*, struct diamondInfo>& diamMap, std::vector<Value*>& defInLoop, Function * f, Loop * L)
    {//Prefetches the targets that are always executed and thus do not need a coroutine
      bool modified = false;
      DominatorTree DT = DominatorTree(*f);
      for (Instruction* target : otherTargets)
      {
        std::vector<BasicBlock *> coroutineBlocks = {target->getParent()};
        BasicBlock * diamEntry = target->getParent();
        std::vector<Instruction*> dependencies;
        backwardDFS(target, defInLoop, dependencies, L, target, true);

        //This works only if there is no "if" defining the dependencies
        //When the if in the same loop iteration and before the target,
        //I did something but couldn't test yet it by lack of example
        std::vector<PHINode*> phiNodes = findPhiNodes(dependencies);
                
        std::vector<Instruction*> indVarValInPrevIt;
        for (PHINode * pn : phiNodes)
        {
          if (pn->getParent() != L->getHeader())
            continue;
          for (int i = 0; i < pn->getNumIncomingValues(); i++)
          {
            if (L->contains(pn->getIncomingBlock(i)))
              if (Instruction * I = dyn_cast<Instruction>(pn->getIncomingValue(i)))
                if (contains(defInLoop, I) && !contains(indVarValInPrevIt, I))
                  indVarValInPrevIt.push_back(I);
          }
        }
        
        if (indVarValInPrevIt.empty())
          continue;//In this case, the target is in fact constant so shouldn't be there
          //But in case, we still put that verification
        Instruction * hypotheticalInsertPos = earliestPositionPossible(indVarValInPrevIt, L);
        if (!isBefore(hypotheticalInsertPos, target, L))
        {
          std::vector<BasicBlock*> seenForMax;
          int maxInstDuringPrefetch = maxNumberOfInstructionsBetween(hypotheticalInsertPos, target, seenForMax, L) - dependencies.size() + 1;//we remove the dependencies because they'll be moved earlier
          if (maxInstDuringPrefetch < 10)
            continue;
        }

        Instruction * lastDepInPrevIteration = NULL;
        for (PHINode * pn : phiNodes)
        {
          if (pn->getParent() != L->getHeader())
            continue;
          for (int i = 0; i < pn->getNumIncomingValues(); i++)
          {
            if (L->contains(pn->getIncomingBlock(i)))
              if (Instruction * I = dyn_cast<Instruction>(pn->getIncomingValue(i)))
                if (contains(defInLoop, I) && (!lastDepInPrevIteration || isBefore(lastDepInPrevIteration, I, L)))
                  lastDepInPrevIteration = I;
          }
        }
        
        std::map<Value*, Value*> ValMap;
        moveInstAsEarlyAsPossible(indVarValInPrevIt, L);
        Instruction * last = NULL;
        for (PHINode * pn : phiNodes)
        {
          if (pn->getParent() != L->getHeader())
            continue;
          for (int i = 0; i < pn->getNumIncomingValues(); i++)
          {
            if (L->contains(pn->getIncomingBlock(i)))
              if (Instruction * I = dyn_cast<Instruction>(pn->getIncomingValue(i)))
                if (contains(defInLoop, I) && (!last || isBefore(last, I, L)))
                  last = I;
          }
        }
        std::vector<Instruction*> clonedInst;
        //We copy the computation of the next address as soon as possible and prefetch it
        for (int i = 0; i < dependencies.size()-1; i++)
        {//We ignore the last one because it's the target, we replace it by the prefetch
          Value * v = dependencies[i];
          if (Instruction * I = dyn_cast<Instruction>(v))
          {
            if (PHINode * pn = dyn_cast<PHINode>(v))
            {
              ValMap[pn] = pn->getIncomingValueForBlock(L->getLoopLatch());
              continue;
            }
            Instruction * IC = I->clone();
            clonedInst.push_back(IC);
            ValMap[I] = IC;
            IC->insertAfter(last);
            int opN = 0;
            for (Value * op : IC->operands())
            {
              if (ValMap.contains(op))
                IC->setOperand(opN, ValMap[op]);
              opN++;
            }
            last = IC;
          }
        }
        
        modified = true;
        Type *I32 = Type::getInt32Ty(f->getParent()->getContext());
        Function * PrefetchFunc = Intrinsic::getDeclaration(f->getParent(), Intrinsic::prefetch, target->getOperand(0)->getType());
        CallInst * prefetch = CallInst::Create(PrefetchFunc, {ValMap[dependencies[dependencies.size()-2]], ConstantInt::get(I32, 0), ConstantInt::get(I32, 0), ConstantInt::get(I32, 1)});
        prefetch->insertAfter(last);

        BasicBlock * resumingBlock = prefetch->getParent();
        BasicBlock * originalBlock = prefetch->getParent();
        BasicBlock * prefetchingBlock = NULL;
        for (Instruction * IC : clonedInst)
        {
          if (LoadInst * li = dyn_cast<LoadInst>(IC))
          {
            if (!prefetchingBlock)
            {
              Instruction * first = getFirstInst(clonedInst, L);
              prefetchingBlock = prefetch->getParent()->splitBasicBlock(first);
              resumingBlock = prefetchingBlock->splitBasicBlock(prefetch);
              prefetch->moveBefore(prefetchingBlock->getTerminator());
            }
            BasicBlock * verifBlc = li->getParent();
            prefetchingBlock = verifBlc->splitBasicBlock(li);
            IRBuilder<> verifBuilder(verifBlc->getTerminator());
            Value * cmp = verifBuilder.CreateICmpNE(li->getOperand(0),Constant::getNullValue(li->getOperand(0)->getType()));
            if (GetElementPtrInst * gep = dyn_cast<GetElementPtrInst>(li->getOperand(0)))
            {
              Value * cmp2 = verifBuilder.CreateICmpNE(gep->getOperand(0),Constant::getNullValue(gep->getOperand(0)->getType()));
              cmp = verifBuilder.CreateAnd(cmp, cmp2);
            }
            BranchInst * newTerm = BranchInst::Create(prefetchingBlock, resumingBlock, cmp);
            ReplaceInstWithInst(verifBlc->getTerminator(), newTerm);
          }
        }
      }
      return modified;
    }

    void moveInstBefore(Instruction * I, Instruction * before, std::vector<Instruction*> memoryWritingInst)
    {//Moves I before "before", recursively moving its dependencies
      if (I->getParent() == before->getParent()) return;
      I->moveBefore(before);
      for (Value * op : I->operands())
      {//We move the operands
        if (Instruction * opI = dyn_cast<Instruction>(op))
          moveInstBefore(opI, I, memoryWritingInst);
        for (Instruction * i : memoryWritingInst)
        {//We move the instructions that write in the operand
          if (dyn_cast<StoreInst>(i) && i->getOperand(1) == op)
          {
            if (Instruction * opI = dyn_cast<Instruction>(op))
              moveInstBefore(i, opI, memoryWritingInst);
            else
              moveInstBefore(i, I, memoryWritingInst);
          }
          else if (MemSetInst * MI = dyn_cast<MemSetInst>(i))
          {
            if (MI->getArgOperand(0) == op)
            {
              if (Instruction * opI = dyn_cast<Instruction>(op))
                moveInstBefore(i, opI, memoryWritingInst);
              else
                moveInstBefore(i, I, memoryWritingInst);
            }
          }
          //There are probably more to take into account... but I didn't find a way to access the written memory
          //independently from checking all known instructions that can write and treat them separatly
        }
      }
    }

    void moveOtherInstInResume(std::map<BasicBlock*, std::vector<Instruction*>>& otherInstructions, BasicBlock* resumingBlc, Instruction* stateSet0, Instruction* stateSet1, Instruction * prefetch, DominatorTree& DT)
    {//Moves the instructions that are not required to know if the target will be executed or not in the resuming part of the coroutine
    //This way we maximize the number of instructions during the prefetch to maximize the chances of timeliness and we avoid having execution alterations because
    //the non moved instructions are executed sooner than in the original code
      std::vector<Instruction*> toMove;
      BasicBlock* prefetchingBlc = prefetch->getParent();
      for (std::pair<BasicBlock*, std::vector<Instruction*>> pair : otherInstructions)
      {
        if (DT.dominates(pair.first, prefetchingBlc) || pair.first == prefetchingBlc)
        {
          for (Instruction * I : pair.second)
          {
            if (I != prefetch && I != stateSet1 && I != stateSet0 && !(dyn_cast<BranchInst>(I)) && !contains(toMove, I))
            {
              toMove.push_back(I);
            }
          }
        }
      }
      for (int i = toMove.size()-1; i >= 0; i--)
      {//we insert starting from the last so that they are in the same order in the resuming
      //block as they were in the initial computation
        toMove[i]->moveBefore(resumingBlc->getFirstNonPHI());
      }
    }

    void moveCommonInstInEntry(std::vector<BasicBlock*>& newBlocks, std::vector<Instruction*>& commonInstructions, BasicBlock* BBentry)
    {//Moves the instructions required both in the resuming part and control part in the entry so that the values are defined for both
    //(creates overhead because it duplicates their execution)
      std::vector<Instruction*> memoryWritingInst;
      for (BasicBlock * BB : newBlocks)
      {
        for (Instruction & I : *BB)
        {
          if (I.mayWriteToMemory())
            if (!contains(memoryWritingInst, &I))
              memoryWritingInst.push_back(&I);
        }
      }

      for (Instruction* I : commonInstructions)
        moveInstBefore(I, BBentry->getTerminator(), memoryWritingInst);
    }

    void moveWritingInstInResume(BasicBlock * diamEntry, BasicBlock* resumingBlc, ValueToValueMapTy& VMap, Loop * L)
    {//Moves the instructions that write in memory in the resuming part to avoid altering the execution
      for (Instruction & I : *diamEntry)
      {
        Value * storedTo = NULL;
        if (StoreInst * s = dyn_cast<StoreInst>(&I))
          storedTo = s->getOperand(1);
        else if (MemSetInst * m = dyn_cast<MemSetInst>(&I))
          storedTo = m->getArgOperand(0);

        if (!storedTo) continue;

        if (VMap[diamEntry] != VMap[I.getParent()])
        {
          dbgs() << I << "\n" << "this shouldn't happen, this coroutine cannot be created\n";
        }

        bool hasAUseBefore = false;
        for (User * U : storedTo->users())
        {
          if (Instruction * UI = dyn_cast<Instruction>(U))
          {
            if (isBefore(UI, &I, L))
            {
              hasAUseBefore = true;
              break;
            }
          }
        }
        //if it has a use before we must move it to the resuming block
        if (hasAUseBefore)
          cast<Instruction>(VMap[&I])->moveBefore(resumingBlc->getFirstNonPHI());
      }
    }

    void addReturnStores(std::vector<GlobalVariable*>& returnVars, std::map<GlobalVariable*, Instruction*>& GVarMap, std::vector<BasicBlock*>& coroutineBlocks, ValueToValueMapTy& VMap, BasicBlock * BBentry, BasicBlock * BBexit)
    {//Adds stores to the return variables
      for (GlobalVariable* retVar : returnVars)
      {
        if (!contains(coroutineBlocks, GVarMap[retVar]))
        {//return variable corresponds to a PHINode using values computed in the diamond turned into a coroutine
          if (PHINode * pn = dyn_cast<PHINode>(GVarMap[retVar]))
          {
            std::vector<Value*> seenIncomingVal;
            for (int i = 0; i < pn->getNumIncomingValues(); i++)
            {
              Value * op = pn->getIncomingValue(i);
              if (contains(seenIncomingVal, op)) continue;
                seenIncomingVal.push_back(op);
              if (!VMap.count(op))
              {
                if (Instruction * opI = dyn_cast<Instruction>(op))
                  dbgs() << *opI << " should be arg of a coroutine\n";
                else//it's a constant or a global variable
                  StoreInst * store = new StoreInst(op, retVar, (cast<BasicBlock>(VMap[pn->getIncomingBlock(i)]))->getTerminator());
              }
              else if (dyn_cast<Instruction>(op))
                StoreInst * store = new StoreInst(VMap[op], retVar, (cast<BasicBlock>(VMap[pn->getIncomingBlock(i)]))->getTerminator());
              else//it's a constant or a global variable
                StoreInst * store = new StoreInst(op, retVar, (cast<BasicBlock>(VMap[pn->getIncomingBlock(i)]))->getTerminator());
            }
          }
        }
        else if (!(cast<Instruction>(VMap[GVarMap[retVar]])->getParent() == BBentry))
        {//This shouldn't happen because it means the instruction used outside the diamond isn't dominating its uses
          StoreInst * store = new StoreInst(VMap[GVarMap[retVar]], retVar, (cast<Instruction>(VMap[GVarMap[retVar]]))->getParent()->getTerminator());
        }
        else
        {//Otherwise it must be in the entry of the diamond because it's used after it and an instruction must dominate its uses
          StoreInst * store = new StoreInst(VMap[GVarMap[retVar]], retVar, BBexit->getTerminator());
        }
      }
    }

    bool isACoroCall(std::vector<CallInst*> calls, Instruction * I)
    {//checks if I is a call to a coroutine
      for (CallInst * C : calls)
        if (C == I)
          return true;
      return false;
    }

    void addCoroCallsAndCleanSourceCode(Loop* L, Function * f, Function * coro, BasicBlock* diamEntry, std::vector<CallInst*>& coroutineCalls, std::vector<BasicBlock*>& coroutineBlocks, std::vector<Value*>& coroArgs, Instruction* lastArg, GlobalVariable* condLoopExit, BasicBlock* loopExit)
    {//Adds the calls to the coroutine in the loop L and removes the target's diamond (we didn't manage to properly remove it so we put everything in an unaccessible block so that O3 removes it)
      CallInst * coroCall = NULL;
      if (!lastArg || !L->contains(lastArg->getParent()))
      {
        Instruction* firstNonPhi = L->getHeader()->getFirstNonPHI();
        LoadInst* loadCondLoopExit = new LoadInst(Type::getInt1Ty(f->getContext()), condLoopExit, "", firstNonPhi);
        coroCall = CallInst::Create(coro, coroArgs, "", loadCondLoopExit);
        coroutineCalls.push_back(coroCall);

        BasicBlock* oldHeader = L->getHeader();
        BasicBlock* blockPart1 = oldHeader->splitBasicBlock(firstNonPhi, "", true);
        blockPart1->getTerminator()->removeFromParent();
        BranchInst::Create(loopExit, oldHeader, loadCondLoopExit, blockPart1);
      }
      else
      {
        Instruction* insertionPoint = lastArg->getNextNonDebugInstruction();
        LoadInst* loadCondLoopExit = new LoadInst(Type::getInt1Ty(f->getContext()), condLoopExit, "", insertionPoint);
        coroCall = CallInst::Create(coro, coroArgs, "", loadCondLoopExit);
        coroutineCalls.push_back(coroCall);

        BasicBlock* oldBlock = loadCondLoopExit->getParent();
        BasicBlock* blockPart1 = oldBlock->splitBasicBlock(loadCondLoopExit->getNextNonDebugInstruction(), "", true);
        blockPart1->getTerminator()->removeFromParent();
        BranchInst::Create(loopExit, oldBlock, loadCondLoopExit, blockPart1);
      }
      LoadInst* loadCondLoopExit = new LoadInst(Type::getInt1Ty(f->getContext()), condLoopExit, "", diamEntry->getTerminator());
      coroCall = CallInst::Create(coro, coroArgs, "", loadCondLoopExit);
      coroutineCalls.push_back(coroCall);

      BasicBlock* oldBlock = loadCondLoopExit->getParent();
      BasicBlock* blockPart1 = oldBlock->splitBasicBlock(diamEntry->getTerminator(), "", true);
      blockPart1->getTerminator()->removeFromParent();
      BranchInst::Create(loopExit, oldBlock, loadCondLoopExit, blockPart1);

      BasicBlock * junkBlock = BasicBlock::Create(f->getContext(), "", f);
      BranchInst * junkBr = BranchInst::Create(junkBlock, junkBlock);

      for (Instruction * I : coroutineInstructions(coroutineBlocks))
      {//We move all instructions except coroutine calls, branches and phi nodes in the junk block
        if (isACoroCall(coroutineCalls, I) || dyn_cast<BranchInst>(I) || dyn_cast<PHINode>(I)) continue;
        if (!(I->hasNUses(0)))
         I->replaceAllUsesWith(Constant::getNullValue(I->getType()));
        I->moveBefore(junkBr);
      }
    }

    bool dominatesONE(BasicBlock* BB, std::vector<BasicBlock*>& blocks, DominatorTree& DT)
    {//Returns true if BB domines one of the blocks in blocks
      for (BasicBlock* bb : blocks)
        if (DT.dominates(BB, bb))
          return true;
      return false;
    }

    bool runOnModule(Module &M) override 
    {
      bool modified = false;
      //maybe try finding the first load to a structure, prefetch those
      //must pay attention to structures on which you write address to a structure you prefetch
      //for example: MainList2->ListNode isn't interesting because we already loaded Symbol_377->next and this
      //is what we write in MainList2->ListNode

      //Ignore when source is outside the loop (we won't prefetch something that is not changing along the loop iteration)
      //Similarly, ignore when it's a global variable
      //Take care when the getelementptr is striding (like when you do ptr = ptr' + x) it shouldn't lead to checking the structure ptr'
      //but rather the structure ptr, whereas the usual getelementptr do not do such thing (src: b1.ll line 617 vs line 1356)

      //Idea to preftch: add a coroutine for each target load that replaces the given load, instead of loading you call the coroutine
      //Giving as parameter the next value of the variables it needs and which value depends on the loop iteration
      //the coroutine will prefetch the next element and store a pointer to it and return the previous value thx to the pointer stored.
      std::vector<Function *> calledFunctions = findCalledFunctions(M);
      //This is mandatory to avoid useless work because LLVM IR contains functions that are not called  
      
      std::vector<MDNode*> targetMDs;
      if (targetIdentification == "annotatedIR")
      {//We look for the annotations
        NamedMDNode * targets = M.getNamedMetadata("meta.targets");
        for (int i = 0; i < targets->getNumOperands(); i++)
        {
          MDNode * mdNode = targets->getOperand(i);
          if (!contains(targetMDs, mdNode))
            targetMDs.push_back(mdNode);
        }
      }

      int funID = 0;
      Type *I32 = Type::getInt32Ty(M.getContext());
      for(Function * f : calledFunctions)
      {
        if ((*f).size() == 0) continue;
        LoopInfo &LI = getAnalysis<LoopInfoWrapperPass>(*f).getLoopInfo();
        int loopID = 0;
        for(Loop *L : LI)
        {
          BasicBlock* loopExit = L->getUniqueExitBlock();
          if (!loopExit)//abort this loop if it has multiple exits
            continue;
          //TODO: order in which we consider the loops might have an impact
          //consider iterating on deep most first
          //Also, there might be issues with coroutines that have a loop inside them

          if (nbInstrInLoop(L) < 20)
            continue; //in that case we won't prefetch anything timely and will
            //mostly add overhead

          //identify the target loads
          std::vector<Value*> defInLoop = getVarsDefinedInLoop(L);
          std::vector<Instruction*> delinquentLoads = findDelinquentLoads(L, defInLoop, L->getSubLoopsVector(), targetMDs);
          DominatorTree DT = DominatorTree(*f);

          auto compForSortedInsertion = [&DT](BasicBlock* b1, BasicBlock* b2){return b2 != b1 && DT.dominates(b2,b1);};
          //We use this lambda comparison function so that we create the coroutines in bottom up order
          //because the creation of the coroutine puts loads to the return variables in the exit block
          //and if that block is the entry of another coroutine then it will get destroyed
          //as the creation of a coroutine "removes" the block.
          std::map<BasicBlock*, std::vector<Instruction*>, decltype(compForSortedInsertion)> groupTargetsByDiamond(compForSortedInsertion);
          std::map<BasicBlock*, struct diamondInfo> diamMap;
          std::vector<Instruction*> otherTargets;
          for (Instruction * target : delinquentLoads)
          {
            struct diamondInfo diam = findTargetDiamond(target, DT, L->getLoopLatch(), L);
            if (diam.diamond.empty())
              otherTargets.push_back(target);
            else if (groupTargetsByDiamond.contains(diam.entry))
              groupTargetsByDiamond[diam.entry].push_back(target);
            else
            {
              diamMap.insert({diam.entry, diam});
              groupTargetsByDiamond.insert({diam.entry, {target}});
            }
          }

          std::vector<Instruction*> coroutineLess;
          std::vector<Instruction*> withCoroutine;
          sortTargets(otherTargets, coroutineLess, withCoroutine, defInLoop, f, L); //finds targets in otherTargets that depend on a if and put the loads inside the if so that it becomes part of a diamond

          for (Instruction * target : withCoroutine)
          {
            struct diamondInfo diam = findTargetDiamond(target, DT, L->getLoopLatch(), L);
            if (diam.diamond.empty())
            {
              dbgs() << "Error (aborting): diamond empty for a load depending on a if: " << *target << " in" << f->getName() << "\n";
              return modified;
            }
            if (groupTargetsByDiamond.contains(diam.entry))
              groupTargetsByDiamond[diam.entry].push_back(target);
            else
            {
              diamMap.insert({diam.entry, diam});
              groupTargetsByDiamond.insert({diam.entry, {target}});
            }
          }

          //handle the targets that are always executed
          if (prefetchOtherTargets(coroutineLess, diamMap, defInLoop, f, L))
            modified = true;

          int coroID = 0;
          std::vector<CallInst*> coroutineCalls;
          
          for (std::pair<BasicBlock*,std::vector<Instruction*>> p : groupTargetsByDiamond)
          {

            DominatorTree DT = DominatorTree(*f); //we recompute it because it might change with the otherTargets
            struct diamondInfo diamInf = diamMap[p.first];
            std::vector<BasicBlock *> coroutineBlocks = diamInf.diamond;
            BasicBlock * diamExit = diamInf.exit;
            BasicBlock * diamEntry = diamInf.entry;
            if (diamEntry == L->getHeader())
              continue; //it's pointless to remove the whole loop and put it in a coroutine

            //First, we compute the arguments to pass to the coroutine
            //(values used in the coroutineBlocks but not defined in it)
            std::vector<Value *> coroArgs;
            for (BasicBlock * BB : coroutineBlocks)
              for (Instruction & I : *BB)
                for (Value * op : I.operands())
                  if (!contains(coroutineBlocks, op) && !contains(coroArgs, op) && ((dyn_cast<Instruction>(op)) || (dyn_cast<Argument>(op))))
                    coroArgs.push_back(op);
            for (PHINode & pn : diamExit->phis())
            {
              for (Value * op : pn.incoming_values())
              {//We also add the values taken by the exit phis because they are to be stored in a return variable from inside the coroutine
                if (!contains(coroArgs, op) && !contains(coroutineBlocks, op) && !(dyn_cast<GlobalVariable>(op) || dyn_cast<Constant>(op)))
                  coroArgs.push_back(op);
              }
            }
            Instruction * lastArg = getLastArg(coroArgs, L);

            //check if the coroutine can actually be done without altering the execution or if it risks not being timely
            std::vector<Instruction*> prefetchableTargets;
            //TODO: find a way to solve the resume issue, the first prefetch leads to a hold
            //then the resume resumes from this load and if a prefetch happens after, it makes
            //the application bug because will not be resumed in time (only one call in the main loop resumes the coro)
            //Sol1: take only one prefetch per coro (but which one)
            //Sol2: a bit more accurate, take one prefetch per group of dependent prefetches (if two prefetches are in distinct
            //branches of the diamond, they can both be kept)
            //There might be an even better solution
            //Done Sol2 but taking the first prefetch only, maybe I can take the first of those that have a value/control dep
            //and delay the prefetches until reaching the last one, but it might make them less timely
            std::vector<Instruction*> potentialTargets = p.second;
            sort(potentialTargets, [L, this](Instruction* i1, Instruction* i2){return i1 != i2 && !isBefore(i2, i1, L);});
            //We sort to compute first the elements that are independent and then take the first in the dependence
            for (Instruction * potentialTarget : potentialTargets)
            {
              if (cannotCreateCoroutine(L, DT, coroutineBlocks, diamEntry, coroArgs, lastArg, potentialTarget))
                continue;
              bool skip = false;
              for (Instruction * t : prefetchableTargets)
              {
                if (isBefore(t, potentialTarget, L))
                {
                  //we ignore dependent targets, taking only the first one because prefetching it will prevent
                  //prefetching the others
                  skip = true;
                  break;
                }
              }
              if (skip) continue;
              prefetchableTargets.push_back(potentialTarget);
            }

            int nbTargets = prefetchableTargets.size();

            if (nbTargets == 0) continue;

            //generate the coroutine
            modified = true;
            std::string coroString = "coro"+std::to_string(funID)+"-"+std::to_string(loopID)+"-"+std::to_string(coroID);

            std::vector<Type*> argTypes;
            for (Value * v : coroArgs)
              argTypes.push_back(v->getType());

            FunctionType * FT = FunctionType::get(Type::getVoidTy(M.getContext()), argTypes, false);
            Function * coro = Function::Create(FT, Function::InternalLinkage, coroString, &M);

            struct GVarInfo globVars = getGlobalReturnVariables(M, f, coroutineBlocks, diamExit, coroString);
            std::vector<GlobalVariable*> returnVars = globVars.returnVars;
            std::map<GlobalVariable *, Instruction*> GVarMap = globVars.GVarMap;

            bool hasConditionalExitGlobal = false;
            for (BasicBlock* BB : coroutineBlocks)
            {
              Instruction* terminator = BB->getTerminator();
              if (BranchInst* Br = dyn_cast<BranchInst>(terminator))
              {
                bool canJumpToExit = false;
                for (int ind = 0; ind < Br->getNumSuccessors(); ind++)
                {
                  if (Br->getSuccessor(ind) == loopExit)
                  {
                    canJumpToExit = true;
                    break;
                  }
                }
                if (canJumpToExit)
                {
                  hasConditionalExitGlobal = true;
                  M.getOrInsertGlobal(coroString+".return-conditional-exit", Type::getInt1Ty(M.getContext()));
                  break;
                }
              }
            }
            GlobalVariable* conditionalExitReturnGVar = M.getNamedGlobal(coroString+".return-conditional-exit");

            //We create the coroutine's BBs
            //The entry
            BasicBlock *BBentry = BasicBlock::Create(coro->getContext(), "entry", coro);

            //We copy the diamond's blocks
            std::vector<BasicBlock*> newBlocks;
            ValueToValueMapTy VMap;
            for (BasicBlock * BB : coroutineBlocks)
            {
              BasicBlock * newBB = CloneBasicBlock(BB, VMap, "_clone", coro, NULL, NULL);
              newBlocks.push_back(newBB);
              VMap[BB] = newBB;
            }

            //Create the exit
            BasicBlock *BBexit = BasicBlock::Create(coro->getContext(), "exit", coro);
            IRBuilder<> BuilderExit(BBexit);
            BuilderExit.CreateRetVoid();
              
            //We create the coroutine's state
            M.getOrInsertGlobal(coroString+".state", BuilderExit.getInt8Ty());
            GlobalVariable* gVar = M.getNamedGlobal(coroString+".state");
            gVar->setLinkage(GlobalValue::InternalLinkage);
            gVar->setAlignment(Align(4));
            gVar->setInitializer(BuilderExit.getInt8(0));
            gVar->setConstant(false);
            IRBuilder<> BuilderEntry(BBentry);
            LoadInst * loadGVar = BuilderEntry.CreateAlignedLoad(BuilderExit.getInt8Ty(), gVar, Align(4), false, "");
            BasicBlock * preExit = BasicBlock::Create(coro->getContext(), "preExit", coro, BBexit);
            SwitchInst * entrySwitch = BuilderEntry.CreateSwitch(loadGVar, preExit, nbTargets+1);
            IRBuilder<> BuilderPreExit(preExit);
            BuilderPreExit.CreateBr(BBexit);
            StoreInst * stateSet0 = new StoreInst(ConstantInt::get(Type::getInt8Ty(coro->getContext()),0), gVar, preExit->getTerminator());
            entrySwitch->addCase(ConstantInt::get(Type::getInt8Ty(coro->getContext()),0), cast<BasicBlock>(VMap[diamEntry]));

            VMap[diamExit] = BBexit;
            VMap[BBexit] = diamExit;
            int i = 0;
            for (Value * arg : coroArgs)
            {
              VMap[arg] = coro->getArg(i);
              VMap[coro->getArg(i)] = arg;
              if (arg->isUsedByMetadata())
              {
                SmallVector<DbgVariableIntrinsic *> DbgUsers;
                findDbgUsers(DbgUsers, arg);
                for (auto *DVI : DbgUsers) 
                {
                  if (contains(newBlocks, DVI->getParent()))
                    DVI->replaceVariableLocationOp(arg, coro->getArg(i));
                }
              }
              i++;
            }
            //We replace the values to the new ones
            replaceAllUses(newBlocks, VMap);
            
            std::vector<BasicBlock*> prefetchBlocks;

            for (int i = 0; i < nbTargets; i++)
            {
              Instruction * target = prefetchableTargets[i];

              //We create the prefetch and split the block for the hold/resume
              Function * PrefetchFunc = Intrinsic::getDeclaration(&M, Intrinsic::prefetch, target->getOperand(0)->getType());
              Instruction * targetAddr = cast<Instruction>(VMap[target->getOperand(0)]);
              CallInst * prefetch = CallInst::Create(PrefetchFunc, {targetAddr, ConstantInt::get(I32, 0), ConstantInt::get(I32, 0), ConstantInt::get(I32, 1)});
              prefetch->insertBefore(cast<Instruction>(VMap[target]));
              BasicBlock * resumingBlc = prefetch->getParent()->splitBasicBlock(cast<Instruction>(VMap[target]));
              auto iterator = newBlocks.begin();
              while (*iterator != prefetch->getParent())
                iterator++;
              iterator++;
              newBlocks.insert(iterator, resumingBlc);
              StoreInst * stateSet0 = new StoreInst(ConstantInt::get(Type::getInt8Ty(coro->getContext()),0), gVar, resumingBlc->getFirstNonPHI());
              prefetch->getParent()->getTerminator()->setOperand(0, BBexit);
              prefetchBlocks.push_back(prefetch->getParent());
              
              StoreInst * stateSet1 = new StoreInst(ConstantInt::get(Type::getInt8Ty(coro->getContext()),i+1), gVar, prefetch->getParent()->getTerminator());
              entrySwitch->addCase(ConstantInt::get(Type::getInt8Ty(coro->getContext()),i+1), resumingBlc);
              
              //Now we need to split the coroutine's code in 2
              //- One that will compute whether the load is done
              //- Another that will do the rest of the computations
              std::map<BasicBlock *, std::vector<Instruction*>> controlInstructions = backwardSearch(newBlocks, cast<Instruction>(VMap[target->getOperand(0)])->getParent(), cast<Instruction>(VMap[target->getOperand(0)]));
              std::map<BasicBlock *, std::vector<Instruction*>> otherInstructions = difference(newBlocks, controlInstructions);

              DominatorTree coroDT(*coro);
              moveOtherInstInResume(otherInstructions, resumingBlc, stateSet0, stateSet1, prefetch, coroDT);
              
              std::vector<Instruction*> commonInstructions = findCommonPart(controlInstructions, resumingBlc);
              
              moveCommonInstInEntry(newBlocks, commonInstructions, BBentry);

              //We can only move writes that are in the diamEntry, the others might not be executed
              //depending on the conditionals, thus we cannot consider target loads for which the diamond
              //contains writes that may influence the previous code and are not in the diamEntry
              moveWritingInstInResume(diamEntry, resumingBlc, VMap, L);
            }
            //We add the stores to the return variables
            addReturnStores(returnVars, GVarMap, coroutineBlocks, VMap, BBentry, BBexit);

            //Finally, we now add the calls to the coroutine
            //and remove the original diamond

            //for now it's done in a very unsatifactory manner
            //TODO: make it clean
            //here we move all instructions to a newly created "junk" block
            //which is unreachable so that further optimizations will remove it
            //because when I remove something (instr or BB) the pass crashes
            
            BasicBlock* conditionalExitBlock = NULL;
            for (BasicBlock& BB : *coro)
            {
              if (BranchInst* Br = dyn_cast<BranchInst>(BB.getTerminator()))
              {
                for (int i = 0; i < Br->getNumSuccessors(); i++)
                {
                  if (Br->getSuccessor(i) == loopExit)
                  {
                    if (!conditionalExitBlock)
                    {
                      conditionalExitBlock = BasicBlock::Create(coro->getContext(), coroString+".cond-exit", coro, BBexit);
                      BranchInst* brToExit = BranchInst::Create(BBexit, conditionalExitBlock);
                      new StoreInst(ConstantInt::get(Type::getInt1Ty(coro->getContext()),1), conditionalExitReturnGVar, brToExit);                      
                    }
                    Br->setSuccessor(i, conditionalExitBlock);
                  }
                }
              }
            }

            BasicBlock* newLoopExit = loopExit;
            if (conditionalExitBlock)
            {
              BasicBlock* condExitBlc = NULL;
              int retCount = 0;
              for (PHINode& pn : loopExit->phis())
              {
                unsigned int numIncoming = 0;
                for (int i = 0; i < pn.getNumIncomingValues(); i++)
                  if (VMap.count(pn.getIncomingBlock(i)))
                    numIncoming++;
                
                if (!numIncoming)
                  continue;

                if (!condExitBlc)
                {
                  condExitBlc = BasicBlock::Create(f->getContext(), coroString+".cond-loop-exit", f, loopExit);
                  newLoopExit = condExitBlc;
                  BranchInst::Create(loopExit, condExitBlc);
                }

                PHINode* coroPN = PHINode::Create(pn.getType(), numIncoming, "", conditionalExitBlock->getFirstNonPHI());
                
                M.getOrInsertGlobal(coroString+".return-cond-exit-"+std::to_string(retCount), pn.getType());
                GlobalVariable * retPN = M.getNamedGlobal(coroString+".return-cond-exit-"+std::to_string(retCount));
                retCount++;
                LoadInst* retLoad = new LoadInst(pn.getType(), retPN, "", condExitBlc->getTerminator());
                new StoreInst(coroPN, retPN, conditionalExitBlock->getFirstNonPHI());
                pn.addIncoming(retLoad, condExitBlc);
                
                for (int i = 0; i < pn.getNumIncomingValues(); i++)
                {
                  if (VMap.count(pn.getIncomingBlock(i)))
                  {
                    Value* incomingValue = VMap.count(pn.getIncomingValue(i)) ? cast<Value>(VMap[pn.getIncomingValue(i)]) : pn.getIncomingValue(i);
                    coroPN->addIncoming(incomingValue, cast<BasicBlock>(VMap[pn.getIncomingBlock(i)]));
                  }
                }

              }
            }

            addCoroCallsAndCleanSourceCode(L, f, coro, diamEntry, coroutineCalls, coroutineBlocks, coroArgs, lastArg, conditionalExitReturnGVar, newLoopExit);

            //We add a block to put the instant exit state in case no prefetch is reached
            BasicBlock * BBset2 = BasicBlock::Create(coro->getContext(), "", coro, BBexit);
            BranchInst* brToExit = BranchInst::Create(BBexit, BBset2);
            StoreInst * stateSet2 = new StoreInst(ConstantInt::get(Type::getInt8Ty(coro->getContext()),2), gVar, brToExit);

            //One last thing for the coroutine code:
            //At that point, when a block exits the coroutine with state 0
            //before prefetching (because a conditional is leading somewhere else)
            //then the state isn't updated, we have to replace those branches to BBexit
            //by branches to stateSet2
            //These blocks are all dominated by the VMap[diamEntry] block so we find them that way

            DominatorTree coroDT(*coro);
            for (BasicBlock & BB : *coro)
            {
              //we skip blocks that are not dominated by the entry (they are blocks for when the coroutine is resumed)
              //we skip the prefetch block because it should set state to 1 to inform that it has prefetched
              //we skip the BBset2 block because it has to go to the exit otherwise we loop infinitely
              if (contains(prefetchBlocks, &BB) || &BB == BBset2 || &BB == preExit) continue;
              BasicBlock * blockToJumpOn = NULL;
              if (dominatesONE(&BB, prefetchBlocks, coroDT))
                blockToJumpOn = BBset2;
              else
              continue;
              int opN = 0;
              for (Value * op : BB.getTerminator()->operands())
              {
                if (op == BBexit)
                  BB.getTerminator()->setOperand(opN, blockToJumpOn);
                opN++;
              }
            }            
            coroID++;
          }
          loopID++;
        }
        funID++;
      }
      return modified;
    }
  };
}

char dynamicStructurePrefetchingPass::ID = 0;
static RegisterPass<dynamicStructurePrefetchingPass> X("dynamicStructurePrefetchingPass", "Dynamic structure prefetching pass");
