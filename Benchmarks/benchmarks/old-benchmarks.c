#include <stdlib.h>
#include <string.h>
#include <stdio.h>
#include <stdbool.h>
#include <pthread.h>
#include <signal.h>
#include <time.h>
#include <unistd.h> 

#define ELEMENTS 1000000

__attribute__ ((noinline)) void RMS_Start_Transaction() { asm volatile("nop"); };
__attribute__ ((noinline)) void RMS_End_Transaction() { asm volatile("nop"); };

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
typedef struct Symbol_50 {
  struct Symbol_50 *Symbol_650;
  struct Symbol_50 *Symbol_648;
  void *Symbol_386;
} Symbol_51;
typedef struct {
  Symbol_51 Symbol_649;
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
void Symbol_315(Symbol_314 Symbol_77, const char *Symbol_495, uint32_t Symbol_643) {
}
void Symbol_316(Symbol_314 Symbol_77, const char *Symbol_495, uint32_t Symbol_643) {
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
  struct Symbol_6 *Symbol_694;
  struct Symbol_6 *Symbol_693;
} Symbol_7;
int test_eq(Symbol_7 * x, Symbol_7 * y)
{
  return (x->Symbol_694 == y->Symbol_694 && x->Symbol_693 == y->Symbol_693);
}
typedef struct Symbol_4 {
  Symbol_7 *Symbol_646;
  Symbol_7 *Symbol_651;
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
Symbol_69 *Symbol_520 = ((void *)0);
Symbol_46 Symbol_519;
static inline uint32_t getNumIter(void)
{
  return Symbol_519.num_iter;
}
typedef struct {
  uint8_t _data[15];
} Symbol_239;
typedef struct Symbol_48 {
  Symbol_51 Symbol_646;
  Symbol_25 Symbol_654;
  uint32_t Symbol_691;
  uint8_t _data[4];
} Symbol_49;
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
static inline void Symbol_227(Symbol_5 *Symbol_645, Symbol_7 *Symbol_692)
{//1093   646 (ind var)
  do { if (((__builtin_expect((!!((Symbol_645) == ((void *)0))), 0))) || ((__builtin_expect((!!((Symbol_692) == ((void *)0))), 0)))) { return; } } while (0);
  if (Symbol_645->Symbol_646 == Symbol_692) {
    if (Symbol_645->Symbol_651 != Symbol_692) {
      Symbol_645->Symbol_646 = Symbol_692->Symbol_693;
      if (!((__builtin_expect((!!((Symbol_692->Symbol_693) == ((void *)0))), 0)))) {
	Symbol_692->Symbol_693->Symbol_694 = ((void *)0);
	Symbol_692->Symbol_693 = ((void *)0);
      }
    } else {
      Symbol_645->Symbol_646 = ((void *)0);
      Symbol_645->Symbol_651 = ((void *)0);
    }
    Symbol_692->Symbol_694 = ((void *)0);
    Symbol_692->Symbol_693 = ((void *)0);
    return;
  }
  if (Symbol_645->Symbol_651 == Symbol_692) {
    Symbol_645->Symbol_651 = Symbol_692->Symbol_694;
    if (!((__builtin_expect((!!((Symbol_692->Symbol_694) == ((void *)0))), 0)))) {
      Symbol_692->Symbol_694->Symbol_693 = ((void *)0);
    }
    Symbol_692->Symbol_694 = ((void *)0);
    Symbol_692->Symbol_693 = ((void *)0);
    return;
  }
  if (!((__builtin_expect((!!((Symbol_692->Symbol_694) == ((void *)0))), 0)))) {
    Symbol_692->Symbol_694->Symbol_693 = Symbol_692->Symbol_693;
  }
  if (!((__builtin_expect((!!((Symbol_692->Symbol_693) == ((void *)0))), 0)))) {
    Symbol_692->Symbol_693->Symbol_694 = Symbol_692->Symbol_694;
  }
  Symbol_692->Symbol_694 = ((void *)0);
  Symbol_692->Symbol_693 = ((void *)0);
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
} Array32;
typedef struct {
  uint8_t _data[32];
  uint8_t Symbol_371;
  uint8_t Symbol_819;
  uint16_t num_iter;
  Array32 array32[ELEMENTS];
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
  Symbol_67 Symbol_557[];
} Symbol_68;
typedef struct {
  uint8_t _data[120];
} Symbol_84;
uint32_t Symbol_17(void *Symbol_668, uint32_t Symbol_761, uint32_t Symbol_644) {
}
Symbol_69 *Symbol_236(uint32_t Symbol_880)
{
  do { if (((((__builtin_expect((!!((Symbol_520) == ((void *)0))), 0)))) || ((Symbol_880) >= getNumIter()))) { return((((void *)0))); } } while (0);
  return (Symbol_520 + Symbol_880);
}
typedef enum Symbol_321 {
  Symbol_70
} Symbol_61;
void Symbol_273(Symbol_69 *Symbol_879)
{
  do { if (((__builtin_expect((!!((Symbol_879) == ((void *)0))), 0)))) { return; } } while (0);
  uint32_t position = Symbol_879->Symbol_858.Symbol_555; //180 L1 miss 80 hits 69% 191 LLCm 161 LLCh 54% | L1(29m, 96h, 23%) LLC(270m, 50h, 84%)
  Symbol_267 *Symbol_974 = (Symbol_267 *)calloc(1, sizeof(Symbol_267));
  do { if (((__builtin_expect((!!((Symbol_974) == ((void *)0))), 0)))) { return; } } while (0);
  (void)memset(Symbol_974, 0, sizeof(Symbol_267));
  Symbol_974->position = position;
  Symbol_974->Symbol_1066 = Symbol_879->Symbol_858.Symbol_859.Symbol_1067.Symbol_1068; // 63 L1 miss 33 hits 66% 91 LLCm 81 LLCh 53% | L1(14m, 4h, 77%) LLC(1m, 7h, 13%)
  Symbol_974->Symbol_699 = Symbol_879->Symbol_858.Symbol_699;
  Symbol_974->Symbol_1006 = Symbol_879->Symbol_419.Symbol_1009; //337 L1miss 66 hits 84% 435 LLCm 416 LLCh 51% |  L1(26m, 23h, 53%) LLC(1m, 85h, 1%)
  Symbol_974->Symbol_999 = Symbol_879->Symbol_419.Symbol_999;
  Symbol_974->Symbol_991 = Symbol_879->Symbol_874.Symbol_416; //136 L1miss 116 hits 54% 405 LLCm 459 LLCh 47% | L1(369m, 46h, 89%) LLC(7m, 922h, 1%)
  Symbol_974->Symbol_1080 = Symbol_879->Symbol_874.Symbol_424;
  Symbol_974->Symbol_418 = Symbol_879->Symbol_874.Symbol_418;
  Symbol_974->Symbol_417 = Symbol_879->Symbol_874.Symbol_417;
  Symbol_879->Symbol_874.Symbol_416 = 0;
  Symbol_879->Symbol_874.Symbol_424 = 0; //THIS before: L1 61/121 LLC 208/291 after: L1 0% LLC 2/28
  Symbol_879->Symbol_874.Symbol_418 = 0;
  Symbol_879->Symbol_874.Symbol_417 = 0; //THIS before: L1 15/22 LLC 312/434 after: L1 0% LLC 0%
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
static inline void Symbol_15(Symbol_51 *Symbol_650, Symbol_51 *Symbol_648)
{
  if (((__builtin_expect((!!((Symbol_650) == ((void *)0))), 0))) || ((__builtin_expect((!!((Symbol_648) == ((void *)0))), 0)))) {
    return;
  }
  Symbol_648->Symbol_650 = Symbol_650;
  Symbol_650->Symbol_648 = Symbol_648;
}
uint32_t Symbol_24(Symbol_49 *Symbol_645, Symbol_51 *Symbol_706)
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
  if (Symbol_645->Symbol_691 == 0) {
    Symbol_313((Symbol_645->Symbol_654), "", 135);
    return 7;
  }
  Symbol_15(Symbol_706->Symbol_650, Symbol_706->Symbol_648);
  Symbol_706->Symbol_648 = ((void *)0);
  Symbol_706->Symbol_650 = ((void *)0);
  Symbol_706->Symbol_386 = ((void *)0);
  Symbol_645->Symbol_691--;
  Symbol_313((Symbol_645->Symbol_654), "", 146);
  return 0;
}
static uint32_t Symbol_225(Symbol_49 *Symbol_897, Symbol_304 *Symbol_377)
{
  return Symbol_24(Symbol_897, &Symbol_377->Symbol_649);
}

pthread_barrier_t barrier;
int looping;
int LIMIT = 0;
pthread_t thread_id;
int chunk_size = 0;

Symbol_304* Symbol_377_ht_real;
Symbol_304* Symbol_377_ht;
Symbol_304* Symbol_647_ht_real;

__attribute__((optimize(1)))
void * helper_thread_1(void * x)
{
  int nbComputed = 0;
  Symbol_267 *Symbol_974 = (Symbol_267 *)calloc(1, sizeof(Symbol_267));
  pthread_barrier_wait(&barrier);
  while (looping)
  {
    for (; nbComputed < LIMIT && Symbol_377_ht && looping; nbComputed++)
    {
      {if ((Symbol_377_ht_real == Symbol_647_ht_real || ((__builtin_expect((!!((Symbol_377_ht) == ((void *)0))), 0))))) return NULL;};
      Symbol_304 *Symbol_685 = (Symbol_304*)(Symbol_377_ht->Symbol_649.Symbol_648);
      Symbol_69 *Symbol_879 = NULL;
      if (!(((((__builtin_expect((!!((Symbol_520) == ((void *)0))), 0)))) || ((Symbol_377_ht->position) >= getNumIter()))))
      {
        Symbol_879 = (Symbol_520 + Symbol_377_ht->position);
      }
      if (((__builtin_expect((!!((Symbol_879) == ((void *)0))), 0)))) 
      {
        Symbol_377_ht_real = Symbol_685;
        if (Symbol_685) memcpy(Symbol_377_ht, Symbol_685, sizeof(Symbol_304));
        else Symbol_377_ht = NULL;
        continue;
      }
      if (Symbol_377_ht->Symbol_649.Symbol_386 == Symbol_647_ht_real) 
      {
        if (Symbol_377_ht->Symbol_380 == 0) 
        {
          for (uint32_t Symbol_1076 = 0; Symbol_1076 < 12; Symbol_1076++) 
          {
            Struct1 *struct1_aux = &(Symbol_377_ht->Symbol_1077[Symbol_1076]);
            {if ((!struct1_aux->Symbol_593)) continue;};
            struct1_aux->Symbol_1078++;
            if (struct1_aux->Symbol_1078 >= struct1_aux->Symbol_1079)
            {
              if (((__builtin_expect((!!((Symbol_879) == ((void *)0))), 0)))) { break; }
              uint32_t position = Symbol_879->Symbol_858.Symbol_555; //L1(219m, 24h, 90%) LLC(494m, 431h, 53%)
              if (((__builtin_expect((!!((Symbol_974) == ((void *)0))), 0)))) { break; }
              struct1_aux->Symbol_1078 = 0;
              Symbol_974->Symbol_1066 = Symbol_879->Symbol_858.Symbol_859.Symbol_1067.Symbol_1068; // L1(161m, 16h, 91%) LLC(489m, 389h, 56%)
              Symbol_974->Symbol_1006 = Symbol_879->Symbol_419.Symbol_1009; // L1(208m, 25h, 89%) LLC(433m, 355h, 55%)
              Symbol_974->Symbol_991 = Symbol_879->Symbol_874.Symbol_416; // L1(220m, 19h, 92%) LLC(590m, 423h, 58%)
              Symbol_879->Symbol_874.Symbol_416 = 0;
            }
          }
        }
      }
      else
      {
        return NULL;
      }
      Symbol_377_ht_real = Symbol_685;
      if (Symbol_685) memcpy(Symbol_377_ht, Symbol_685, sizeof(Symbol_304));
      else Symbol_377_ht = NULL;
    }
  }
  return NULL;
}

__attribute__((optimize(1)))
void * ht_1_2(void * x)
{
  int nbComputed = 0;
  //pthread_barrier_wait(&barrier);
  while (looping)
  {
    for (; nbComputed < LIMIT && Symbol_377_ht; nbComputed++)
    {
      {if ((Symbol_377_ht_real == Symbol_647_ht_real || ((__builtin_expect((!!((Symbol_377_ht) == ((void *)0))), 0))))) return NULL;};
      Symbol_304 *Symbol_685 = (Symbol_304*)(Symbol_377_ht->Symbol_649.Symbol_648);
      Symbol_69 *Symbol_879 = NULL;
      if (!(((((__builtin_expect((!!((Symbol_520) == ((void *)0))), 0)))) || ((Symbol_377_ht->position) >= getNumIter()))))
      {
        Symbol_879 = (Symbol_520 + Symbol_377_ht->position);
      }
      if (((__builtin_expect((!!((Symbol_879) == ((void *)0))), 0)))) 
      {
        Symbol_377_ht_real = Symbol_685;
        if (Symbol_685) memcpy(Symbol_377_ht, Symbol_685, sizeof(Symbol_304));
        else Symbol_377_ht = NULL;
        continue;
      }
      if (Symbol_377_ht->Symbol_649.Symbol_386 == Symbol_647_ht_real) 
      {
        if (Symbol_377_ht->Symbol_380 == 0) 
        {
          for (uint32_t Symbol_1076 = 0; Symbol_1076 < 12; Symbol_1076++) 
          {
            Struct1 *struct1_aux = &(Symbol_377_ht->Symbol_1077[Symbol_1076]);
            {if ((!struct1_aux->Symbol_593)) continue;};
            struct1_aux->Symbol_1078++;
            if (struct1_aux->Symbol_1078 >= struct1_aux->Symbol_1079)
            {
              if (((__builtin_expect((!!((Symbol_879) == ((void *)0))), 0)))) { break; }
              Symbol_879->Symbol_874.Symbol_424 = 0;
              Symbol_879->Symbol_874.Symbol_417 = 0;
            }
          }
        }
      }
      else
      {
        return NULL;
      }
      Symbol_377_ht_real = Symbol_685;
      if (Symbol_685) memcpy(Symbol_377_ht, Symbol_685, sizeof(Symbol_304));
      else Symbol_377_ht = NULL;
      if (!looping) break;
    }
  }
}

Symbol_304* coroutine1(Symbol_304* Symbol_377, Symbol_304* Symbol_647)
{
  static int state = 0;
  switch(state)
  {
    case 0:
      state = 1;
      while(Symbol_377)
      {
        Symbol_304 *Symbol_685 = (Symbol_304*)(Symbol_377->Symbol_649.Symbol_648);
        Symbol_69 *Symbol_879 = NULL;
        if (!(((((__builtin_expect((!!((Symbol_520) == ((void *)0))), 0)))) || ((Symbol_377->position) >= getNumIter()))))
        {
          Symbol_879 = (Symbol_520 + Symbol_377->position);
        }
        if (((__builtin_expect((!!((Symbol_879) == ((void *)0))), 0)))) 
        {
          Symbol_377 = Symbol_685;
          return Symbol_377;
        }
        if (Symbol_377->Symbol_649.Symbol_386 == Symbol_647) 
        {
          if (Symbol_377->Symbol_380 == 0) 
          {
            for (uint32_t Symbol_1076 = 0; Symbol_1076 < 12; Symbol_1076++) 
            {
              Struct1 *struct1_aux = &(Symbol_377->Symbol_1077[Symbol_1076]);
              {if ((!struct1_aux->Symbol_593)) continue;};
              struct1_aux->Symbol_1078++;
              if (struct1_aux->Symbol_1078 >= struct1_aux->Symbol_1079)
              {
                if (((__builtin_expect((!!((Symbol_879) == ((void *)0))), 0)))) { break; }
                Symbol_879->Symbol_874.Symbol_424 = 0;
                Symbol_879->Symbol_874.Symbol_417 = 0;
              }
            }
          }
        }
        else
        {
          break;
        }
        Symbol_377 = Symbol_685;

        case 1:;
      }
  }
  state = 0;
  return NULL;
}

__attribute__ ((noinline))
static uint32_t bench1func(const Symbol_239 *Symbol_892, Symbol_49 *Symbol_897)
{
  do { if ((((__builtin_expect((!!((Symbol_892) == ((void *)0))), 0))) || ((__builtin_expect((!!((Symbol_897) == ((void *)0))), 0))))) { return((0)); } } while (0);
  uint32_t Symbol_781 = 0;
  uint32_t Symbol_782 = 0;
  _Bool Symbol_579 = 0;
  uint32_t Symbol_691 = ((Symbol_897->Symbol_691) <= (getNumIter()) ? (Symbol_897->Symbol_691) : (getNumIter()));
  Symbol_304 *Symbol_647 = (Symbol_304*)&Symbol_897->Symbol_646;
  Symbol_304 *Symbol_377 = (Symbol_304*)Symbol_897->Symbol_646.Symbol_648;
/*
  //HT
  looping = 1;
  //pthread_barrier_init(&barrier, NULL, 2);
  pthread_create(&thread_id, NULL, ht_1_2, NULL);
  Symbol_647_ht_real = Symbol_647;
  Symbol_377_ht = (Symbol_304*) malloc(sizeof(Symbol_304));
  Symbol_377_ht_real = Symbol_377;
  memcpy(Symbol_377_ht, Symbol_377, sizeof(Symbol_304));
  LIMIT = chunk_size;
  //pthread_barrier_wait(&barrier);
*/

  //Coroutine
  Symbol_304* prefetched_addr = Symbol_377;
  for (int i = 0; i < chunk_size; i++) prefetched_addr = coroutine1(prefetched_addr, Symbol_647);

  struct timespec start, finish;
  clock_gettime(CLOCK_MONOTONIC, &start);

  for (uint32_t i = 0; i < Symbol_691; i++) {
    //LIMIT++;
    {if ((Symbol_377 == Symbol_647 || ((__builtin_expect((!!((Symbol_377) == ((void *)0))), 0))))) break;};
    prefetched_addr = coroutine1(prefetched_addr, Symbol_647);
    Symbol_304 *Symbol_685 = (Symbol_304*)(Symbol_377->Symbol_649.Symbol_648);
    Symbol_69 *Symbol_879 = Symbol_236(Symbol_377->position);
    if (((__builtin_expect((!!((Symbol_879) == ((void *)0))), 0)))) {
      Symbol_377 = Symbol_685;
      continue;
    }
    Symbol_315((Symbol_879->Symbol_949), "", 184);
    if (Symbol_377->Symbol_649.Symbol_386 == Symbol_647) {
      if (Symbol_377->Symbol_380 == 0) {
	Symbol_782 += Symbol_262(Symbol_879, Symbol_377);
      } else {
	(void)Symbol_225(Symbol_897, Symbol_377);
      }
    } else {
      Symbol_579 = 1;
    }
    Symbol_316((Symbol_879->Symbol_949), "", 199);
    {if ((Symbol_579)) break;};
    Symbol_781++;
    Symbol_377 = Symbol_685;
  }
  coroutine1(NULL,NULL);
  clock_gettime(CLOCK_MONOTONIC, &finish);
  printf("loop exe: %f\n", (finish.tv_sec - start.tv_sec) + (finish.tv_nsec - start.tv_nsec) / 1000000000.0);
  //looping = 0;
  //pthread_join(thread_id, NULL);
  uint32_t Symbol_822 = (uint32_t)((Symbol_781 << 16U) | Symbol_782);
  return Symbol_822;
}
void Symbol_1(Symbol_49 *Symbol_897, int Symbol_686) {
  Symbol_304 *Symbol_778=((void *)0);
  for(int i=0;i<Symbol_686;i++) {
    Symbol_304 *Symbol_464 = calloc(1,sizeof(Symbol_304));
    Symbol_464->Symbol_649.Symbol_650=(Symbol_51*)Symbol_778;
    Symbol_464->position=i;
    if(Symbol_778 != ((void *)0)) {
      Symbol_778->Symbol_649.Symbol_648=(Symbol_51*)Symbol_464;
    }
    Symbol_778=Symbol_464;
    for(int Symbol_600=0;Symbol_600<12;Symbol_600++) {
      Symbol_464->Symbol_1077[Symbol_600].Symbol_593=1;
    }
    if(Symbol_897->Symbol_691 == 0) {
      Symbol_897->Symbol_691=Symbol_686;
      Symbol_897->Symbol_646.Symbol_650=((void *)0);
      Symbol_897->Symbol_646.Symbol_648=(Symbol_51*)Symbol_464;
    }
    if(i<ELEMENTS) {
      Symbol_464->Symbol_649.Symbol_386=(void*)&Symbol_897->Symbol_646;
    }
    else {
      Symbol_464->Symbol_649.Symbol_386=(void*)&Symbol_464->Symbol_649;
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
  (void)memset(
	       Symbol_881, 0, sizeof(Symbol_69) * num_iter);
  Symbol_520 = (Symbol_69 *)Symbol_881;
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
  Symbol_315((Symbol_547->Symbol_654), "", 353);
  if (Symbol_547->Symbol_690[Symbol_690] != ((uint16_t)0xFFFF)) {
    Symbol_316((Symbol_547->Symbol_654), "", 357);
    return (((uint32_t)(71936)) | (((uint32_t)((0x11))) & (0x1FFU)));
  }
  Symbol_22(Symbol_547, Symbol_690);
  Symbol_316((Symbol_547->Symbol_654), "", 363);
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

//int resume = 0;
Symbol_7 * Symbol_646_ht;
Symbol_7 * Symbol_646_ht_real;
Symbol_5 * Symbol_1093_ht;


//__attribute__((optimize(0)))
void * helper_thread_2(void * Symbol_646)
{
  int nbComputed = 0;
  pthread_barrier_wait(&barrier);
  //while (!resume){}
  while(looping)
  {
    //while (nbComputed + chunk_size < LIMIT && looping){
    for (/*int i = 0*/; nbComputed < LIMIT/*i<chunk_size*/ && Symbol_646_ht && looping; nbComputed/*i*/++)
    {
      //Symbol_308 * Symbol_1164 = (Symbol_308 *)Symbol_646_ht;
      //Symbol_1164->position = getNumIter();
      uint32_t position = ((Symbol_308*)Symbol_646_ht)->position;
      if (!((((__builtin_expect((!!((Symbol_1093_ht) == ((void *)0))), 0))) || ((__builtin_expect((!!((Symbol_646_ht_real) == ((void *)0))), 0))))))
      {
        if (Symbol_1093_ht->Symbol_646 == Symbol_646_ht_real) {
          if (Symbol_1093_ht->Symbol_651 != Symbol_646_ht_real) {
            Symbol_1093_ht->Symbol_646 = Symbol_646_ht->Symbol_693;
            if (!((__builtin_expect((!!((Symbol_646_ht->Symbol_693) == ((void *)0))), 0)))) {
        Symbol_646_ht->Symbol_693 = ((void *)0);
            }
          } else {
            Symbol_1093_ht->Symbol_646 = ((void *)0);
            Symbol_1093_ht->Symbol_651 = ((void *)0);
          }
          Symbol_646_ht->Symbol_693 = ((void *)0);
        }
        else if (Symbol_1093_ht->Symbol_651 == Symbol_646_ht_real) {
          Symbol_1093_ht->Symbol_651 = Symbol_646_ht->Symbol_694;
          Symbol_646_ht->Symbol_693 = ((void *)0);
        }
        else
        {
          Symbol_646_ht->Symbol_693 = ((void *)0);
        }
      }
      Symbol_69 *Symbol_879 = NULL;
      if (!(((((__builtin_expect((!!((Symbol_520) == ((void *)0))), 0)))) || (position >= getNumIter()))))
      {
        Symbol_879 = Symbol_520 + position;
      }
      if (!((((__builtin_expect((!!((Symbol_879) == ((void *)0))), 0))))))
      {
        if (!((Symbol_879->Symbol_857.Symbol_474 != Symbol_0)))
        {
          Symbol_646_ht_real = Symbol_1093_ht->Symbol_646;
          if (Symbol_1093_ht->Symbol_646) memcpy(Symbol_646_ht, Symbol_1093_ht->Symbol_646, sizeof(Symbol_308));
          else Symbol_646_ht = NULL;
        }
      }
    }
    //}
  }
  return NULL;
}
/*
void handleUSR2()
{
  free(Symbol_646_ht);
  free(Symbol_1093_ht);
  pthread_exit(NULL);
}*/

__attribute__ ((noinline))
void bench2func(Symbol_5 *Symbol_1093)
{
  Symbol_308 *Symbol_1164 = ((void *)0);
  Symbol_7 *Symbol_646 = Symbol_1093->Symbol_646;
  //clock_t time = clock();
  //pthread_detach(thread_id);
  if (Symbol_646)
  {
    looping = 1;
    pthread_barrier_init(&barrier, NULL, 2);
    pthread_create(&thread_id, NULL, helper_thread_2, NULL);
    Symbol_646_ht_real = Symbol_646;
    Symbol_646_ht = (Symbol_7*) malloc(sizeof(Symbol_308));
    memcpy(Symbol_646_ht, Symbol_646, sizeof(Symbol_308));
    Symbol_1093_ht = (Symbol_5*) malloc(sizeof(Symbol_5));
    memcpy(Symbol_1093_ht, Symbol_1093, sizeof(Symbol_5));
    LIMIT = chunk_size;
    //resume = 1;
    pthread_barrier_wait(&barrier);
  }
  //overhead += (float) (clock() - time);
  while (Symbol_646 != ((void *)0)) {
    //time = clock();
    LIMIT++;
    //overhead += (float) (clock()-time);
    
    Symbol_1164 = (Symbol_308 *)Symbol_646;
    uint32_t position = Symbol_1164->position; //161 LLC miss 168 hits for store 48%
    uint16_t Symbol_352 = Symbol_1164->Symbol_352;
    Symbol_1164->position = getNumIter();
    Symbol_227(Symbol_1093, Symbol_646);
    Symbol_235(Symbol_352);
    Symbol_69 *Symbol_879 = Symbol_236(position);
    {if ((((__builtin_expect((!!((Symbol_879) == ((void *)0))), 0))))) continue;};
    {if ((Symbol_879->Symbol_857.Symbol_474 != Symbol_0)) continue;}; // 242 L1 miss 133 hits for cmp 65%
    Symbol_315((Symbol_879->Symbol_949), "", 420);
    Symbol_272(Symbol_879, 1);
    Symbol_316((Symbol_879->Symbol_949), "", 422);
    Symbol_646 = Symbol_1093->Symbol_646;
  }
  looping = 0;
  //pthread_kill(thread_id, SIGUSR2);
  //printf("overhead = %f\n", overhead/CLOCKS_PER_SEC);
  pthread_join(thread_id,NULL);
  //printf("time spent waiting %f\n", time_spent_waiting / CLOCKS_PER_SEC);
  //printf("time_spent_creating %f\n",time_spent_creating / CLOCKS_PER_SEC);
}
void Symbol_2(Symbol_5 *Symbol_1093, int Symbol_686) {
  // Corutine
  Symbol_308 *Symbol_778=((void *)0);
  for(int i=0;i<Symbol_686;i++) {
    Symbol_308 *Symbol_464 = calloc(1,sizeof(Symbol_308));
    ((Symbol_7*)&Symbol_464->Symbol_972)->Symbol_694=(Symbol_7*)Symbol_778;
    Symbol_464->position=i;
    if(Symbol_778 != ((void *)0)) {
      ((Symbol_7*)&Symbol_778->Symbol_972)->Symbol_693=(Symbol_7*)Symbol_464;
    }
    Symbol_778=Symbol_464;
    if(Symbol_1093->Symbol_646 == ((void *)0)) {
      Symbol_1093->Symbol_646=(Symbol_7*)Symbol_464;
    }
  }
}
void Symbol_319(int Symbol_686) {
  for(int i=0;i<Symbol_686;i++) {
    Symbol_69 *Symbol_879 = Symbol_236(i);
    Symbol_879->Symbol_857.Symbol_474=Symbol_0;
  }
}

__attribute__ ((noinline))
static uint32_t bench3func(const Array3 *array3)
{
  uint32_t hash = 0;
  uint16_t num_iter = (uint16_t)getNumIter();
  do { if (((__builtin_expect((!!((array3) == ((void *)0))), 0)))) { return hash; } } while (0);
  uint16_t Symbol_552 = ((array3->num_iter) <= (num_iter) ? (array3->num_iter) : (num_iter));
  Symbol_552 = ((Symbol_552) <= (256) ? (Symbol_552) : (256));
  uint32_t Symbol_551 = sizeof(Symbol_67) * Symbol_552;
  uint32_t Symbol_1096 = sizeof(Symbol_68) + Symbol_551;
  Symbol_68 *Symbol_550 = (Symbol_68*)calloc(1,((32768 - 64) - (64 + sizeof(Symbol_84))));
  if (((__builtin_expect((!!((Symbol_550) == ((void *)0))), 0)))) {
    return hash;
  }
  Symbol_67 *array_aux = &Symbol_550->Symbol_557[0];
  Symbol_550->Symbol_553 = Symbol_552;
  for (uint32_t i = 0; i < Symbol_552; i++) {
    uint16_t position = array3->array32[i].position;
    Symbol_69 *Symbol_879 = Symbol_236((uint32_t)position);
    {if ((((__builtin_expect((!!((Symbol_879) == ((void *)0))), 0))))) continue;};
    array_aux[i].Symbol_652 = Symbol_879->Symbol_858.Symbol_699;
    array_aux[i].Symbol_556 = position;
    array_aux[i].Symbol_364 = Symbol_879->Symbol_858.Symbol_364;
    array_aux[i].Symbol_665 = array3->array32[i].Symbol_665;
    hash += array_aux[i].Symbol_652 + array_aux[i].Symbol_556 + array_aux[i].Symbol_364 + array_aux[i].Symbol_665 + (1 << 16);
  }
  Symbol_550->Symbol_371 = array3->Symbol_371;
  Symbol_550->Symbol_819 = array3->Symbol_819;
  (void)Symbol_17((Symbol_550), (1223), 503);
  return hash;
}

int main(int argc, char **argv) {
  
  /*struct sigaction usr2Handler;
  usr2Handler.sa_handler = &handleUSR2;
  usr2Handler.sa_flags = SA_RESTART;
  sigemptyset(&usr2Handler.sa_mask);
  sigaction(SIGUSR2, &usr2Handler, NULL);*/
  char *a = argv[1];
  chunk_size = atoi(a);
  //overhead += (float)(clock()-time);

#ifdef benchmark1
  Symbol_519.num_iter= ELEMENTS;
  if(Func1() != 0) {
    return -1;
  }
  Symbol_239 Symbol_892;
  Symbol_49 *Symbol_897=calloc(1,sizeof(Symbol_49));
  Symbol_1(Symbol_897, ELEMENTS);
  RMS_Start_Transaction();
  bench1func(&Symbol_892, Symbol_897);
  RMS_End_Transaction();
#endif

#ifdef benchmark2
  Symbol_519.num_iter= ELEMENTS;
  if(Func1() != 0) {
    return -1;
  }
  Symbol_5 *Symbol_1093=calloc(1,sizeof(Symbol_5));
  Symbol_2(Symbol_1093, ELEMENTS);
  Symbol_319(ELEMENTS);
  RMS_Start_Transaction();
  bench2func(Symbol_1093);
  RMS_End_Transaction();
  printf("Done 2.");
#endif

#ifdef benchmark3
  Symbol_519.num_iter= ELEMENTS;
  if(Func1() != 0) {
    return -1;
  }
  Array3 *array3=(Array3*)calloc(1,sizeof(Array3));
  for(int i=0; i < ELEMENTS; i++) {
    array3->array32[i].position=i;
  }
  array3->num_iter=(uint16_t)getNumIter();;
  // Make this a coroutine 
  RMS_Start_Transaction();
  uint32_t hash = bench3func(array3);
  RMS_End_Transaction();
  printf("Done 3. %d %d\n", hash, (hash >> 16));
#endif

  return 0;
}
