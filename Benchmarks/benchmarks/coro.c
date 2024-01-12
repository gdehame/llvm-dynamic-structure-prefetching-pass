#include <stdlib.h>
#include <string.h>
#include <stdio.h>
#include <assert.h>
#include <pthread.h>
#include "/usr/lib/clang/16/include/stdbool.h"

#define SIZE_SUB_ARRAY_BENCH3 20000

__attribute__ ((noinline)) void RMS_Start_Transaction() { asm volatile("nop"); };
__attribute__ ((noinline)) void RMS_End_Transaction() { asm volatile("nop"); };

// #define validate_shuffle
// #define debug_shuffling

typedef signed char int8_t;
typedef unsigned char uint8_t;
typedef short int16_t;
typedef unsigned short uint16_t;
typedef int int32_t;
typedef unsigned uint32_t;
// typedef long long int64_t;
typedef unsigned long long uint64_t;
typedef signed char int_least8_t;
typedef unsigned char uint_least8_t;
typedef short int_least16_t;
typedef unsigned short uint_least16_t;
typedef int int_least32_t;
typedef unsigned uint_least32_t;
typedef long long int_least64_t;
typedef unsigned long long uint_least64_t;
typedef signed char int_fast8_t;
typedef unsigned char uint_fast8_t;
typedef short int_fast16_t;
typedef unsigned short uint_fast16_t;
typedef int int_fast32_t;
typedef unsigned int uint_fast32_t;
typedef long long int_fast64_t;
typedef unsigned long long uint_fast64_t;
typedef long long intmax_t;
typedef unsigned long long uintmax_t;
typedef struct {
  _Bool Symbol_593;
  uint8_t Symbol_975[3];
  uint16_t Symbol_1078;
  uint16_t Symbol_1079;
} Struct1;
typedef struct Node_struct {
  struct Node_struct *prev;
  struct Node_struct *next;
#ifdef validate_shuffle
  int tag;
#endif
  void *Symbol_386;
} NodeB;
typedef struct {
  NodeB ListNode;
  uint32_t position;
  uint8_t Symbol_380;
  uint8_t Symbol_975[3];
  Struct1 Symbol_1077[12];
} Symbol_304;
typedef struct {
  uint8_t _data[53];
  uint32_t num_iter;
  uint32_t Symbol_448;
  uint8_t _data2[78];
} Symbol_46;
typedef struct {
  uint8_t Symbol_474;
  uint8_t _data[54];
  _Bool Symbol_581;
  uint8_t _data2[16];
} Symbol_221;
typedef struct {
  uint8_t _data[4];
  uint32_t Symbol_1068;
  uint8_t _data2[16];
} Symbol_224;
typedef struct {
  uint8_t _data[32];
  Symbol_224 Symbol_1067;
} Symbol_223;
typedef struct {
  uint32_t Symbol_555;
  uint8_t _data[4];
  uint32_t Symbol_364;
  uint8_t _data2[12];
  uint16_t Symbol_699;
  uint8_t _data3[64];
  Symbol_223 Symbol_859;
  uint8_t _data4[24];
} Symbol_222;
typedef void *Symbol_29;
typedef Symbol_29 Symbol_314;
typedef Symbol_29 Symbol_311;
void Lock(Symbol_314 Symbol_77, const char *Symbol_495, uint32_t Symbol_643) {
}
void Unlock(Symbol_314 Symbol_77, const char *Symbol_495, uint32_t Symbol_643) {
}
void Symbol_312(Symbol_311 Symbol_77, const char *Symbol_495, uint32_t Symbol_643) {
}
void Symbol_313(Symbol_311 Symbol_77, const char *Symbol_495, uint32_t Symbol_643) {
}
typedef enum {
  Symbol_44 = 8,
} Symbol_52;
typedef enum
  {
    Symbol_78 = 16 ,
    Symbol_79 = 32 ,
    Symbol_80 = 64 ,
    Symbol_81 = 128 ,
    Symbol_82 = 256 ,
    Symbol_83
  }Symbol_86;
void *Symbol_310(uint32_t Symbol_1149, uint8_t Symbol_1105, uint32_t Symbol_1150, Symbol_86 Symbol_465, const char *Symbol_719,
		 uint32_t Symbol_1148)
{
  uint32_t Symbol_339 = ((Symbol_1150 + Symbol_465 - 1) & (~(Symbol_465 - 1)));
  if (Symbol_339 == 0) {
    return ((void *)0);
  }
  void *Symbol_667 = (void *)malloc(Symbol_339);
  return Symbol_667;
}
static inline void *Symbol_19(
			      uint32_t Symbol_670, uint8_t Symbol_785, uint32_t Symbol_1022, Symbol_86 Symbol_338, const char *Symbol_495, uint32_t Symbol_643)
{
  return Symbol_310(Symbol_670, Symbol_785, Symbol_1022, Symbol_338, Symbol_495, Symbol_643);
}
static void Symbol_18(uint32_t Symbol_761, uint32_t Symbol_641, void *Symbol_821, const char *Symbol_517, uint32_t Symbol_643)
{
}
void *Symbol_16(uint32_t Symbol_641, uint32_t Symbol_338, uint32_t Symbol_761, const char *Symbol_517, uint32_t Symbol_643)
{
  if ((((Symbol_761) < 1200) || ((Symbol_761) > 1230))) {
    return ((void *)0);
  }
  void *Symbol_821 = Symbol_19(
			       Symbol_761, Symbol_44, Symbol_641, (Symbol_86)((Symbol_338) >= (64) ? (Symbol_338) : (64)), Symbol_517, Symbol_643);
  if (((__builtin_expect((!!((Symbol_821) == ((void *)0))), 0)))) {
    return ((void *)0);
  }
  Symbol_18(Symbol_761, Symbol_641, Symbol_821, Symbol_517, Symbol_643);
  return Symbol_821;
}
static inline void *Symbol_14(
			      uint32_t Symbol_641, uint32_t Symbol_338, uint32_t Symbol_761, const char *Symbol_720, uint32_t Symbol_643)
{
  return Symbol_16(Symbol_641, Symbol_338, Symbol_761, Symbol_720, Symbol_643);
}
typedef void *Symbol_25;
typedef struct Symbol_6 {
  struct Symbol_6 *prev;
  struct Symbol_6 *next;
} NodeC;
typedef struct Symbol_4 {
  NodeC *ListNode;
  NodeC *Symbol_651;
} Symbol_5;
typedef struct {
  uint8_t _data[32];
  uint32_t Symbol_999;
  uint32_t Symbol_1009;
  uint8_t _data2[55];
} Symbol_271;
typedef struct {
  uint16_t Symbol_416;
  uint8_t Symbol_977[2];
  uint32_t Symbol_424;
  uint32_t Symbol_418;
  uint32_t Symbol_417;
} Symbol_229;
struct Symbol_69 {
  Symbol_25 Symbol_949;
  Symbol_221 Symbol_857;
  Symbol_222 Symbol_858;
  uint8_t _data[392];
  Symbol_271 Symbol_419;
  uint8_t _data2[2600];
  Symbol_229 Symbol_874;
  uint8_t _data3[128];
};
typedef struct Symbol_69 Symbol_69;
Symbol_69 *structure_of_interest = ((void *)0);
Symbol_46 Symbol_519;
static inline uint32_t getNumIter(void)
{
  return Symbol_519.num_iter;
}
typedef struct {
  uint8_t _data[15];
} OutStringStruct;
typedef struct Symbol_48 {
  NodeB ListNode;
  Symbol_25 Symbol_654;
  uint32_t num_iter;
  uint8_t _data[4];
} NodeBContainer;
typedef struct {
  uint32_t position;
  uint32_t Symbol_1066;
  uint16_t Symbol_699;
  uint16_t Symbol_991;
  uint32_t Symbol_1080;
  uint8_t _data[20];
  uint32_t Symbol_418;
  uint32_t Symbol_417;
  uint32_t Symbol_1006;
  uint32_t Symbol_999;
} Symbol_267;
typedef enum {
  Symbol_85 = 0,
  Symbol_13,
  Symbol_0,
  Symbol_318,
  Symbol_317,
  Symbol_309,
  Symbol_89,
  Symbol_10,
} Symbol_12;
typedef uint8_t Symbol_11;
typedef struct {
  Symbol_5 Symbol_972;
  uint16_t Symbol_352;
  uint8_t Symbol_977[2];
  uint32_t position;
} Symbol_308;
static inline void Symbol_227(Symbol_5 *Symbol_645, NodeC *Symbol_692)
{
  do { if (((__builtin_expect((!!((Symbol_645) == ((void *)0))), 0))) || ((__builtin_expect((!!((Symbol_692) == ((void *)0))), 0)))) { return; } } while (0);
  if (Symbol_645->ListNode == Symbol_692) {
    if (Symbol_645->Symbol_651 != Symbol_692) {
      Symbol_645->ListNode = Symbol_692->next; //Slightly delinquent
      if (!((__builtin_expect((!!((Symbol_692->next) == ((void *)0))), 0)))) {
	Symbol_692->next->prev = ((void *)0);
	Symbol_692->next = ((void *)0);
      }
    } else {
      Symbol_645->ListNode = ((void *)0);
      Symbol_645->Symbol_651 = ((void *)0);
    }
    Symbol_692->prev = ((void *)0);
    Symbol_692->next = ((void *)0);
    return;
  }
  if (Symbol_645->Symbol_651 == Symbol_692) {
    assert(0);
    Symbol_645->Symbol_651 = Symbol_692->prev;
    if (!((__builtin_expect((!!((Symbol_692->prev) == ((void *)0))), 0)))) {
      Symbol_692->prev->next = ((void *)0);
    }
    Symbol_692->prev = ((void *)0);
    Symbol_692->next = ((void *)0);
    return;
  }
  if (!((__builtin_expect((!!((Symbol_692->prev) == ((void *)0))), 0)))) {
    Symbol_692->prev->next = Symbol_692->next;
  }
  if (!((__builtin_expect((!!((Symbol_692->next) == ((void *)0))), 0)))) {
    Symbol_692->next->prev = Symbol_692->prev;
  }
  Symbol_692->prev = ((void *)0);
  Symbol_692->next = ((void *)0);
}
static inline uint32_t Symbol_20(void)
{
  return Symbol_519.Symbol_448;
}
typedef struct Symbol_47 {
  Symbol_25 Symbol_654;
  uint8_t Symbol_978[56];
  uint16_t Symbol_1022;
  uint16_t Symbol_1136;
  uint8_t Symbol_979[60];
  uint16_t Symbol_511;
  uint8_t Symbol_980[62];
  uint16_t Symbol_513;
  uint8_t Symbol_981[62];
  uint16_t Symbol_690[];
} Symbol_47;
typedef struct {
  Symbol_47 *Symbol_351;
} Symbol_307;
typedef struct {
  uint16_t position;
  uint8_t Symbol_665;
  uint8_t Symbol_975;
} Array3sub;
typedef struct {
  uint8_t _data[32];
  uint8_t Symbol_371;
  uint8_t Symbol_819;
  uint16_t num_iter;
  Array3sub array3sub[SIZE_SUB_ARRAY_BENCH3];
} Array3;
typedef struct {
  uint16_t Symbol_652;
  uint16_t Symbol_556;
  uint32_t Symbol_364;
  uint8_t Symbol_665;
  uint8_t Symbol_977[7];
} Symbol_67;
typedef struct {
  uint16_t Symbol_553;
  uint8_t Symbol_371;
  uint8_t Symbol_819;
  uint8_t Symbol_977[4];
    Symbol_67 Symbol_557[SIZE_SUB_ARRAY_BENCH3];
} Symbol_68;
typedef struct {
  uint8_t _data[120];
} Symbol_84;
uint32_t free_mem(void *Symbol_668, uint32_t Symbol_761, uint32_t Symbol_644) {
}
Symbol_69 *Symbol_236(uint32_t Symbol_880)
{
  do { if (((((__builtin_expect((!!((structure_of_interest) == ((void *)0))), 0)))) || ((Symbol_880) >= getNumIter()))) { return((((void *)0))); } } while (0);
  return (structure_of_interest + Symbol_880);
}
typedef enum Symbol_321 {
  Symbol_70
} Symbol_61;
void Symbol_273(Symbol_69 *Symbol_879)
{
  do { if (((__builtin_expect((!!((Symbol_879) == ((void *)0))), 0)))) { return; } } while (0);
  uint32_t position = Symbol_879->Symbol_858.Symbol_555;
  Symbol_267 *Symbol_974 = (Symbol_267 *)calloc(1, sizeof(Symbol_267));
  do { if (((__builtin_expect((!!((Symbol_974) == ((void *)0))), 0)))) { return; } } while (0);
  (void)memset(Symbol_974, 0, sizeof(Symbol_267));
  Symbol_974->position = position;
  Symbol_974->Symbol_1066 = Symbol_879->Symbol_858.Symbol_859.Symbol_1067.Symbol_1068;
  Symbol_974->Symbol_699 = Symbol_879->Symbol_858.Symbol_699;
  Symbol_974->Symbol_1006 = Symbol_879->Symbol_419.Symbol_1009;
  Symbol_974->Symbol_999 = Symbol_879->Symbol_419.Symbol_999;
  Symbol_974->Symbol_991 = Symbol_879->Symbol_874.Symbol_416;
  Symbol_974->Symbol_1080 = Symbol_879->Symbol_874.Symbol_424;
  Symbol_974->Symbol_418 = Symbol_879->Symbol_874.Symbol_418;
  Symbol_974->Symbol_417 = Symbol_879->Symbol_874.Symbol_417;
  Symbol_879->Symbol_874.Symbol_416 = 0;
  Symbol_879->Symbol_874.Symbol_424 = 0;
  Symbol_879->Symbol_874.Symbol_418 = 0;
  Symbol_879->Symbol_874.Symbol_417 = 0;
}
static uint32_t Symbol_262(Symbol_69 *Symbol_879, Symbol_304 *Symbol_377)
{
  uint32_t Symbol_782 = 0;
  for (uint32_t Symbol_1076 = 0; Symbol_1076 < 12; Symbol_1076++) {
    Struct1 *struct1_aux = &(Symbol_377->Symbol_1077[Symbol_1076]);
    {if ((!struct1_aux->Symbol_593)) continue;};
    struct1_aux->Symbol_1078++;
    if (struct1_aux->Symbol_1078 >= struct1_aux->Symbol_1079) {
      Symbol_273(Symbol_879);
      struct1_aux->Symbol_1078 = 0;
      Symbol_782++;
    }
  }
  return Symbol_782;
}
static inline void Symbol_15(NodeB *prev, NodeB *next)
{
  if (((__builtin_expect((!!((prev) == ((void *)0))), 0))) || ((__builtin_expect((!!((next) == ((void *)0))), 0)))) {
    return;
  }
  next->prev = prev;
  prev->next = next;
}
uint32_t Symbol_24(NodeBContainer *Symbol_645, NodeB *Symbol_706)
{
  if (((__builtin_expect((!!((Symbol_645) == ((void *)0))), 0)))) {
    return 2;
  }
  if (((__builtin_expect((!!((Symbol_706) == ((void *)0))), 0)))) {
    return 3;
  }
  Symbol_312((Symbol_645->Symbol_654), "", 123);
  if (Symbol_706->Symbol_386 != Symbol_645) {
    Symbol_313((Symbol_645->Symbol_654), "", 128);
    return 5;
  }
  if (Symbol_645->num_iter == 0) {
    Symbol_313((Symbol_645->Symbol_654), "", 135);
    return 7;
  }
  Symbol_15(Symbol_706->prev, Symbol_706->next);
  Symbol_706->next = ((void *)0);
  Symbol_706->prev = ((void *)0);
  Symbol_706->Symbol_386 = ((void *)0);
  Symbol_645->num_iter--;
  Symbol_313((Symbol_645->Symbol_654), "", 146);
  return 0;
}
static uint32_t RemoveFromList(NodeBContainer *MainList1, Symbol_304 *Symbol_377)
{
  return Symbol_24(MainList1, &Symbol_377->ListNode);
}

Symbol_69 * coroutine1(Symbol_304* Symbol_377, uint32_t num_iter)
{
  static int state = 0;
  static Symbol_304* previousParam = NULL;
  switch(state)
  {
    case 0:
      __builtin_prefetch(&(Symbol_377->position),0,0);
      __builtin_prefetch(&(Symbol_377->ListNode.next),0,0);
      state = 1;
      previousParam = Symbol_377;
      return NULL;
    case 1:
      __builtin_prefetch(&(Symbol_377->position),0,0);
      __builtin_prefetch(&(Symbol_377->ListNode.next),0,0);
      if (structure_of_interest && previousParam->position < num_iter)
      {
        Symbol_69* res = structure_of_interest + previousParam->position;
        previousParam = Symbol_377;
        return res;
      }
      previousParam = Symbol_377;
      return NULL;
  }
  return NULL;
}

static uint32_t Benchmark1(const OutStringStruct *OutputString, NodeBContainer *MainList1)
{
  do { if ((((__builtin_expect((!!((OutputString) == ((void *)0))), 0))) || ((__builtin_expect((!!((MainList1) == ((void *)0))), 0))))) { return((0)); } } while (0);
  uint32_t processed_elements = 0;
  uint32_t processed_tasks = 0;
  _Bool stop = 0;
  uint32_t num_iter = getNumIter(); //((MainList1->num_iter) <= (getNumIter()) ? (MainList1->num_iter) : (getNumIter()));
  Symbol_304 *Symbol_647 = (Symbol_304*)&MainList1->ListNode;
  Symbol_304 *Symbol_377 = (Symbol_304*)MainList1->ListNode.next;
  for (uint32_t i = 0; i < num_iter; i++) {
    {if ((Symbol_377 == Symbol_647 || ((__builtin_expect((!!((Symbol_377) == ((void *)0))), 0))))) break;};
    Symbol_304 *Symbol_685 = (Symbol_304*)(Symbol_377->ListNode.next);
    Symbol_69 *Symbol_879 = coroutine1(Symbol_685, num_iter); //TARGET
    if (((__builtin_expect((!!((Symbol_879) == ((void *)0))), 0)))) {
      Symbol_377 = Symbol_685;
      continue;
    }
    Lock((Symbol_879->Symbol_949), "", 184);
    if (Symbol_377->ListNode.Symbol_386 == Symbol_647) {
      if (Symbol_377->Symbol_380 == 0) {
	processed_tasks += Symbol_262(Symbol_879, Symbol_377);
      } else {
	(void)RemoveFromList(MainList1, Symbol_377);
      }
    } else {
      //stop = 1;
    }
    Unlock((Symbol_879->Symbol_949), "", 199);
    {if (stop) break;};
    processed_elements++;
    Symbol_377 = Symbol_685; // getting next element
  }
  uint32_t hash = (uint32_t)((processed_elements << 16U) | processed_tasks);
  return hash;
}

void ListINIT1(NodeBContainer *MainList1, int elements) {
  Symbol_304 *current=((void *)0);
  for(int i=0;i<elements;i++) {
    Symbol_304 *newNode = calloc(1,sizeof(Symbol_304));
    newNode->ListNode.prev=(NodeB*)current;
    newNode->position=i;
    if(current != ((void *)0)) {
      current->ListNode.next=(NodeB*)newNode;
    }
    current=newNode;
    for(int Symbol_600=0;Symbol_600<12;Symbol_600++) {
      newNode->Symbol_1077[Symbol_600].Symbol_593=1;
    }
    if(MainList1->num_iter == 0) {
      MainList1->num_iter=elements;
      MainList1->ListNode.prev=((void *)0);
      MainList1->ListNode.next=(NodeB*)newNode;
    }
    if(i==0) {
      newNode->ListNode.Symbol_386=(void*)&MainList1->ListNode;
    }
    else {
      newNode->ListNode.Symbol_386=(void*)&newNode->ListNode;
    }
  }
}
static uint32_t Func1(void)
{
  uint32_t num_iter = getNumIter();
  void *Symbol_881 = Symbol_14(((uint32_t)(num_iter * sizeof(Symbol_69))), ((uint32_t)64), (1223), __FUNCTION__, 256);
  if (((__builtin_expect((!!((Symbol_881) == ((void *)0))), 0)))) {
    return 0x70000 + 0x133;
  }
  (void)memset(Symbol_881, 0, sizeof(Symbol_69) * num_iter);
  structure_of_interest = (Symbol_69 *)Symbol_881;
  return 0;
}
Symbol_307 Symbol_521 = {0};
static inline void Symbol_22(Symbol_47 *Symbol_547, uint16_t Symbol_690)
{
  if (Symbol_547->Symbol_513 != ((uint16_t)0xFFFE)) {
    Symbol_547->Symbol_690[Symbol_690] = ((uint16_t)0xFFFE);
    Symbol_547->Symbol_690[Symbol_547->Symbol_513] = Symbol_690;
    Symbol_547->Symbol_513 = Symbol_690;
  } else {
    Symbol_547->Symbol_690[Symbol_690] = ((uint16_t)0xFFFE);
    Symbol_547->Symbol_511 = Symbol_690;
    Symbol_547->Symbol_513 = Symbol_690;
  }
  if (Symbol_547->Symbol_1136 != 0) {
    Symbol_547->Symbol_1136--;
  }
}
uint32_t Symbol_23(Symbol_47 *Symbol_547, uint16_t Symbol_690)
{
  if (((__builtin_expect((!!((Symbol_547) == ((void *)0))), 0))) || (Symbol_547->Symbol_1022 <= Symbol_690)) {
    return (((uint32_t)(71936)) | (((uint32_t)((0x10))) & (0x1FFU)));
  }
  Lock((Symbol_547->Symbol_654), "", 353);
  if (Symbol_547->Symbol_690[Symbol_690] != ((uint16_t)0xFFFF)) {
    Unlock((Symbol_547->Symbol_654), "", 357);
    return (((uint32_t)(71936)) | (((uint32_t)((0x11))) & (0x1FFU)));
  }
  Symbol_22(Symbol_547, Symbol_690);
  Unlock((Symbol_547->Symbol_654), "", 363);
  return 0;
}
static void Symbol_235(uint16_t Symbol_352)
{
  do { if ((Symbol_352 >= (Symbol_20() * 18))) { return; } } while (0);
  if (Symbol_23(Symbol_521.Symbol_351, Symbol_352) != 0) {
  }
}
static void Symbol_272(Symbol_69 *Symbol_879, _Bool Symbol_569)
{
  do { if (((__builtin_expect((!!((Symbol_879) == ((void *)0))), 0)))) { return; } } while (0);
  if (Symbol_569) {
    Symbol_879->Symbol_857.Symbol_474 = Symbol_317;
  }
  Symbol_879->Symbol_857.Symbol_581 = 0;
}

/*int coroutine2(uint32_t position)
{
  static int state = 0;
  static Symbol_69 *Symbol_879 = NULL;
  switch(state)
  {
    case 0:
      state = 1;
      Symbol_879 = Symbol_236(position);
      {if ((((__builtin_expect((!!((Symbol_879) == ((void *)0))), 0))))) return 1;};
      __builtin_prefetch(&(Symbol_879->Symbol_857.Symbol_474),0,0);
      return 0;
    case 1:
      state = 0;
      {if ((Symbol_879->Symbol_857.Symbol_474 != Symbol_0)) return 1;}; // massively delinquent, stalls a lot
      Lock((Symbol_879->Symbol_949), "", 420);
      Symbol_272(Symbol_879, 1);
      Unlock((Symbol_879->Symbol_949), "", 422);
      return 0;
  }
}

__attribute__ ((noinline))
void Benchmark2(Symbol_5 *MainList2)
{
  Symbol_308 *Symbol_1164 = ((void *)0);
  NodeC *ListNode = MainList2->ListNode;
  while (ListNode != ((void *)0)) {
    Symbol_1164 = (Symbol_308 *)ListNode;
    uint32_t position = Symbol_1164->position; //slightly delinquent
    int cont = coroutine2(position);
    uint16_t Symbol_352 = Symbol_1164->Symbol_352;
    Symbol_1164->position = getNumIter();
    Symbol_227(MainList2, ListNode);
    Symbol_235(Symbol_352);
    if (cont || coroutine2(position)) continue;
    ListNode = MainList2->ListNode;
  }
}
*/

Symbol_69 * coroutine2(NodeC* ListNode)
{
  static int state = 0;
  static Symbol_69* previousResult = NULL;
  Symbol_69* res = NULL;
  switch(state)
  {
    case 0:
      previousResult = structure_of_interest + ((Symbol_308 *)ListNode)->position;
      __builtin_prefetch(&(previousResult->Symbol_857.Symbol_474),0,0);
      //__builtin_prefetch(&(Symbol_377->ListNode.prev),0,0);
      state = 1;
      return NULL;
    case 1:
      res = previousResult;
      if (!structure_of_interest || !ListNode)
      {
        previousResult = NULL;
      }
      else
      {
        previousResult = structure_of_interest + ((Symbol_308 *)ListNode)->position;
      __builtin_prefetch(&(previousResult->Symbol_857.Symbol_474),0,0);
      }
      return res;
  }
  return NULL;
}

__attribute__ ((noinline))
void Benchmark2(Symbol_5 *MainList2)
{
  Symbol_308 *Symbol_1164 = ((void *)0);
  NodeC *ListNode = MainList2->ListNode;
  while (ListNode != ((void *)0)) {
    Symbol_1164 = (Symbol_308 *)ListNode;
    uint32_t position = Symbol_1164->position; //slightly delinquent
    uint16_t Symbol_352 = Symbol_1164->Symbol_352;
    Symbol_1164->position = getNumIter();
    Symbol_227(MainList2, ListNode);
    Symbol_235(Symbol_352);
    Symbol_69 *Symbol_879 = coroutine2(MainList2->ListNode);
    {if ((((__builtin_expect((!!((Symbol_879) == ((void *)0))), 0))))) continue;};
    {if ((Symbol_879->Symbol_857.Symbol_474 != Symbol_0)) continue;}; // massively delinquent, stalls a lot
    Lock((Symbol_879->Symbol_949), "", 420);
    Symbol_272(Symbol_879, 1);
    Unlock((Symbol_879->Symbol_949), "", 422);
    ListNode = MainList2->ListNode;
  }
}

void ListINIT2(Symbol_5 *MainList2, int elements) {
  // Corutine
  Symbol_308 *current=((void *)0);
  for(int i=0;i<elements;i++) {
    Symbol_308 *newNode = calloc(1,sizeof(Symbol_308));
    ((NodeC*)&newNode->Symbol_972)->prev=(NodeC*)current;
    newNode->position=i;
    if(current != ((void *)0)) {
      ((NodeC*)&current->Symbol_972)->next=(NodeC*)newNode;
    }
    current=newNode;
    if(MainList2->ListNode == ((void *)0)) {
            MainList2->ListNode=(NodeC*)newNode; //the head element
        }
        else if(i == elements-1) {
             MainList2->Symbol_651 = (NodeC*)newNode; //the tail element
    }
  }
}
void Symbol_319(int elements) {
  for(int i=0;i<elements;i++) {
    Symbol_69 *Symbol_879 = Symbol_236(i);
    Symbol_879->Symbol_857.Symbol_474=Symbol_0;
  }
}

uint16_t coroutine3(Array3 *array3, uint32_t i)
{
  static int state = 0;
  static uint16_t previousI = 0;
  switch(state)
  {
    case 0:
      state = 1;
      previousI = i;
      if (structure_of_interest)
      {
         __builtin_prefetch(&(((array3->array3sub[i].position) + structure_of_interest)->Symbol_858.Symbol_699),0,0);
      }
    case 1:
      if (structure_of_interest)
      {
        __builtin_prefetch(&(((array3->array3sub[i].position) + structure_of_interest)->Symbol_858.Symbol_699),0,0);
      }
      uint16_t prevI = previousI;
      previousI = i;
      return array3->array3sub[prevI].position;
  }
}

__attribute__ ((noinline))
static uint32_t Benchmark3(const Array3 *array3)
{
  (void) coroutine3(array3, 0);
  uint32_t hash = 0;
  uint16_t num_iter = (uint16_t)getNumIter();
  do { if (((__builtin_expect((!!((array3) == ((void *)0))), 0)))) { return hash; } } while (0);
  num_iter = ((array3->num_iter) <= (num_iter) ? (array3->num_iter) : (num_iter));
  // num_iter = ((num_iter) <= (256) ? (num_iter) : (256)); // Bounded to 256 iterations
  uint32_t Symbol_551 = sizeof(Symbol_67) * num_iter;
  uint32_t Symbol_1096 = sizeof(Symbol_68) + Symbol_551;
    Symbol_68 *new_struct = (Symbol_68*)calloc(1,sizeof(Symbol_68)); //fix
  if (((__builtin_expect((!!((new_struct) == ((void *)0))), 0)))) {
    return hash;
  }
  Symbol_67 *array_aux = &new_struct->Symbol_557[0];
  new_struct->Symbol_553 = num_iter;
  for (uint32_t i = 0; i < num_iter; i++) {
    //__builtin_prefetch(&(((array3->array3sub[i+8].position) + structure_of_interest)->Symbol_858.Symbol_699),0,0);

    uint16_t position = coroutine3(array3, i+1);
    Symbol_69 *Symbol_879 = Symbol_236((uint32_t)position);
    {if ((((__builtin_expect((!!((Symbol_879) == ((void *)0))), 0))))) continue;};
    array_aux[i].Symbol_652 = Symbol_879->Symbol_858.Symbol_699; //main
    array_aux[i].Symbol_556 = position;
    array_aux[i].Symbol_364 = Symbol_879->Symbol_858.Symbol_364; //aux
    array_aux[i].Symbol_665 = array3->array3sub[i].Symbol_665;
    hash += array_aux[i].Symbol_652 + array_aux[i].Symbol_556 + array_aux[i].Symbol_364 + array_aux[i].Symbol_665 + (1 << 16);
  }
  new_struct->Symbol_371 = array3->Symbol_371;
  new_struct->Symbol_819 = array3->Symbol_819;
  (void)free_mem((new_struct), (1223), 503);
  return hash;
}



void shuffleDoublyLinkedList1(NodeBContainer** head, double shuffleProbability) {
  NodeBContainer* current = *head;

  // Count the number of nodes in the doubly-linked list
  int count = 0;
  while (current != NULL) {
    count++;
    current = (NodeBContainer*) current->ListNode.next;
  }

  // Create an array to store the node addresses
  NodeBContainer** nodeArray = (NodeBContainer**)malloc(count * sizeof(NodeBContainer*));
  current = *head;
  int i = 0;
  while (current != NULL) {
    nodeArray[i] = current;
    current = (NodeBContainer*) current->ListNode.next;
    i++;
  }

  // Shuffle the elements based on the given probability
  // srand(time(NULL));
  for (int j = count - 1; j > 0; j--) {
    if  ( (shuffleProbability != 0.0) && ((double)rand() / RAND_MAX <= shuffleProbability)){
      int k = rand() % (j + 1);
      NodeBContainer* temp = nodeArray[j];
      nodeArray[j] = nodeArray[k];
      nodeArray[k] = temp;
    }
  }

  // Rebuild the doubly-linked list using the shuffled node addresses
  *head = nodeArray[0];
  current = *head;
  for (int j = 1; j < count; j++) {
    current->ListNode.next = (struct Node_struct*) nodeArray[j];
    nodeArray[j]->ListNode.prev = (struct Node_struct*) current;
    current = (NodeBContainer*) current->ListNode.next;
  }
  current->ListNode.next = NULL;

  // Free the temporary node array
  free(nodeArray);
}

void shuffleDoublyLinkedList2(Symbol_5** head, double shuffleProbability) {
  Symbol_308 *current;
  Symbol_308 *temp;
  current = (Symbol_308*) (*head)->ListNode;
 
  // Count the number of nodes in the doubly-linked list
  int count = 0;
  while (current != NULL) {
    count++;
    // printf("%d ",current->position);
    current = (Symbol_308*) ((NodeC*)&current->Symbol_972)->next;
  }
  // printf("\nThe list has %d elements\n",count);
    
  // Create an array to store the node addresses
  Symbol_5** nodeArray = (Symbol_5**)malloc(count * sizeof(Symbol_5*));
  current = (Symbol_308*) (*head)->ListNode;
  int i = 0;
  while (current != NULL) {
    nodeArray[i] = (Symbol_5*) current;
    current = (Symbol_308*) ((NodeC*)&current->Symbol_972)->next;
    i++;
  }
    
#ifdef debug_shuffling
  printf("nodeArray BEFORE Shuffling\n");
    
  for (int j=0; j<count; j++) {
    printf("%d : %d\n", j,((Symbol_308*)nodeArray[j])->position);
  }
#endif
    
  // Shuffle the elements based on the given probability
  // srand(time(NULL));
  for (int j = count - 1; j > 0; j--) {
    if  ( (shuffleProbability != 0.0) && ((double)rand() / RAND_MAX <= shuffleProbability)){
      int k = rand() % (j + 1);
      Symbol_5* temp = nodeArray[j];
      nodeArray[j] = nodeArray[k];
      nodeArray[k] = temp;
    }
  }
 
#ifdef debug_shuffling
  printf("nodeArray AFTER Shuffling\n");
    
  for (int j=0; j<count; j++) {
    printf("%d : %d\n", j,((Symbol_308*)nodeArray[j])->position);
  }
#endif
    
  // Rebuild the doubly-linked list using the shuffled node addresses
  (*head)->ListNode = (NodeC*) nodeArray[0];
  current = (Symbol_308*) (*head)->ListNode;
  for (int j = 1; j < count; j++) {
    // current->ListNode.next = nodeArray[j];
    ((NodeC*)&current->Symbol_972)->next = (struct Symbol_6*) nodeArray[j];
    temp = (Symbol_308*) nodeArray[j];
    ((NodeC*)&temp->Symbol_972)->next = (struct Symbol_6*) current;
    current = (Symbol_308*) ((NodeC*)&current->Symbol_972)->next;
  }
  ((NodeC*)&current->Symbol_972)->next = NULL;

#ifdef debug_shuffling
  printf("After Shuffling\n");
  current=(*head)->ListNode;
  count = 0;
  while (current != NULL) {
    count++;
    printf("%d ",current->position);
    current=((NodeC*)&current->Symbol_972)->next;
  }
  printf("\nThe list has %d elements\n",count);
#endif
  // Free the temporary node array
  free(nodeArray);
        
}


#ifdef validate_shuffle
void tagDoublyLinkedList1(NodeBContainer* head) {
  NodeBContainer* current = head;
  int i=0;
    
  // Count the number of nodes in the doubly-linked list

  while (current != NULL) {
    i++;
    current->ListNode.tag = i;
    current = current->ListNode.next;
  }
  printf("The list has %d elements\n",i);
}

void printDoublyLinkedList1(NodeBContainer* head) {
  NodeBContainer* current = head;
    
  while (current != NULL) {
    printf("%d ", current->ListNode.tag);
    current = current->ListNode.next;
        
  }
  printf("\n");
}

void printDoublyLinkedList2(Symbol_5 *MainList2) {
  Symbol_308 *current=((void *)0);
  int i=0;
  current=MainList2->ListNode;
  while (current != NULL) {
    printf("%d ",current->position);
    current=((NodeC*)&current->Symbol_972)->next;
    i++;
  }
  printf("\nThe list has %d elements\n",i);
}
#endif


int main(int argc, char **argv) {
  #ifdef MEASURE_APP
    struct timespec start, finish;
    clock_gettime(CLOCK_MONOTONIC, &start);
  #endif

  char *a = argv[1];
  int element_num = atoi(a);

#ifdef benchmark1
  Symbol_519.num_iter= element_num;
  if(Func1() != 0) {
    return -1;
  }
  OutStringStruct OutputString;
  NodeBContainer *MainList1=calloc(1,sizeof(NodeBContainer));
  ListINIT1(MainList1, element_num);
#ifdef validate_shuffle
  tagDoublyLinkedList1(MainList1);
  printDoublyLinkedList1(MainList1);
  printf("Shuffling\n");
#endif
  // by controlling the probability to shuffleDoublyLinkedList different  shuffling intensity is achieved
  double prob = atof(argv[2]);
  shuffleDoublyLinkedList1(&MainList1, prob);
  #ifdef MEASURE_TARGET
    struct timespec start, finish;
    double time = 0;
    clock_gettime(CLOCK_MONOTONIC, &start);
  #endif
  (void)coroutine1((Symbol_304*)MainList1->ListNode.next, 0);
  #ifdef MEASURE_TARGET
    clock_gettime(CLOCK_MONOTONIC, &finish);
    time = (finish.tv_sec - start.tv_sec) + (finish.tv_nsec - start.tv_nsec) / 1000000000.0;
  #endif
#ifdef validate_shuffle
  printDoublyLinkedList1(MainList1);
#endif
  RMS_Start_Transaction();
  #ifdef MEASURE_TARGET
    clock_gettime(CLOCK_MONOTONIC, &start);
  #endif
  uint32_t hash = Benchmark1(&OutputString, MainList1);
  #ifdef MEASURE_TARGET
    clock_gettime(CLOCK_MONOTONIC, &finish);
    printf("exectime %f\n", time + (finish.tv_sec - start.tv_sec) + (finish.tv_nsec - start.tv_nsec) / 1000000000.0);
  #endif
  RMS_End_Transaction();
  printf("Benchmark1 Done. %d %d\n", hash, (hash >> 16));
#endif

#ifdef benchmark2
  Symbol_519.num_iter= element_num;
  if(Func1() != 0) {
    return -1;
  }
  Symbol_5 *MainList2=calloc(1,sizeof(Symbol_5));
  ListINIT2(MainList2, element_num);
#ifdef validate_shuffle
  printDoublyLinkedList2(MainList2);
#endif
  double prob = atof(argv[2]);
  shuffleDoublyLinkedList2(&MainList2, prob);
  #ifdef MEASURE_TARGET
    struct timespec start, finish;
    double time = 0;
    clock_gettime(CLOCK_MONOTONIC, &start);
  #endif
  (void)coroutine2((NodeC*)MainList2->ListNode);
  #ifdef MEASURE_TARGET
    clock_gettime(CLOCK_MONOTONIC, &finish);
    time = (finish.tv_sec - start.tv_sec) + (finish.tv_nsec - start.tv_nsec) / 1000000000.0;
  #endif
#ifdef validate_shuffle
  printDoublyLinkedList2(MainList2);
#endif
  Symbol_319(element_num);
  RMS_Start_Transaction();
  #ifdef MEASURE_TARGET
    clock_gettime(CLOCK_MONOTONIC, &start);
  #endif
  Benchmark2(MainList2);
  #ifdef MEASURE_TARGET
    clock_gettime(CLOCK_MONOTONIC, &finish);
    printf("exectime %f\n", time + (finish.tv_sec - start.tv_sec) + (finish.tv_nsec - start.tv_nsec) / 1000000000.0);
  #endif
  RMS_End_Transaction();
  printf("Benchmark2 Done.\n");
#endif

#ifdef benchmark3
  if (element_num > SIZE_SUB_ARRAY_BENCH3) {
    printf("Wrong params: element_num must be lower or equal than SIZE_SUB_ARRAY_BENCH3 (%d)\n", SIZE_SUB_ARRAY_BENCH3);
    return -1;
  }

  Symbol_519.num_iter = element_num;
  if(Func1() != 0) {
    return -1;
  }
  Array3 *array3=(Array3*)calloc(1,sizeof(Array3));
  // Initialised with subsequent elements, but shuffled in the real-world usages
  // The prefetcher shall not assume any particular order of the elements
  for(int i=0; i < element_num; i++) {
    array3->array3sub[i].position=i;
  }
  array3->num_iter=(uint16_t)getNumIter();
  // Make this a coroutine 
  RMS_Start_Transaction();
  #ifdef MEASURE_TARGET
    struct timespec start, finish;
    clock_gettime(CLOCK_MONOTONIC, &start);
  #endif
  uint32_t hash = Benchmark3(array3);
  #ifdef MEASURE_TARGET
    clock_gettime(CLOCK_MONOTONIC, &finish);
    printf("exectime %f\n", (finish.tv_sec - start.tv_sec) + (finish.tv_nsec - start.tv_nsec) / 1000000000.0);
  #endif
  RMS_End_Transaction();
  printf("Benchmark3 Done. %d %d\n", hash, (hash >> 16));
#endif

  #ifdef MEASURE_APP
    clock_gettime(CLOCK_MONOTONIC, &finish);
    printf("exectime %f\n", (finish.tv_sec - start.tv_sec) + (finish.tv_nsec - start.tv_nsec) / 1000000000.0);
  #endif
  return 0;
}
