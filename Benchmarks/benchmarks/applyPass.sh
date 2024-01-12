#!/bin/bash

libraryPath=../../libDynamicStructurePrefetchingPass.so

if [ -z $1 ]
then
  for benchNum in {"1","2","3"};
  do
    opt -O3 b$benchNum.ll -S -o b$benchNum.ll
    opt -enable-new-pm=0 -load $libraryPath --dynamicStructurePrefetchingPass -target-identification=annotatedIR -S -o pass$benchNum-annotated.ll b$benchNum.ll
    opt -enable-new-pm=0 -load $libraryPath --dynamicStructurePrefetchingPass -target-identification=heuristic -S -o pass$benchNum-heuristic.ll b$benchNum.ll
    opt -O3 pass$benchNum-annotated.ll -S -o pass$benchNum-annotated.ll
    opt -O3 pass$benchNum-heuristic.ll -S -o pass$benchNum-heuristic.ll
    clang -O3 pass$benchNum-annotated.ll -o pass$benchNum-annotated
    clang -O3 pass$benchNum-heuristic.ll -o pass$benchNum-heuristic
  done
elif [ $1 == "1" ] || [ $1 == "2" ] || [ $1 == "3" ]
then
  benchNum=$1
  opt -O3 b$benchNum.ll -S -o b$benchNum.ll
  opt -enable-new-pm=0 -load $libraryPath --dynamicStructurePrefetchingPass -target-identification=annotatedIR -S -o pass$benchNum-annotated.ll b$benchNum.ll
  opt -enable-new-pm=0 -load $libraryPath --dynamicStructurePrefetchingPass -target-identification=heuristic -S -o pass$benchNum-heuristic.ll b$benchNum.ll
  opt -O3 pass$benchNum-annotated.ll -S -o pass$benchNum-annotated.ll
  opt -O3 pass$benchNum-heuristic.ll -S -o pass$benchNum-heuristic.ll
  clang -O3 pass$benchNum-annotated.ll -o pass$benchNum-annotated
  clang -O3 pass$benchNum-heuristic.ll -o pass$benchNum-heuristic
else
  echo "Wrong argument: must be either nothing or 1,2 or 3"
fi
