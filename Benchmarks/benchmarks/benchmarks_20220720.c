#include <stdlib.h>
#include <string.h>


typedef signed char int8_t;
typedef unsigned char uint8_t;
typedef short int16_t;
typedef unsigned short uint16_t;
typedef int int32_t;
typedef unsigned uint32_t;
typedef long long int64_t;
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
} Symbol_256;
typedef struct Symbol_50 {
    struct Symbol_50 *Symbol_650;
    struct Symbol_50 *Symbol_648;
    void *Symbol_386;
} Symbol_51;
typedef struct {
    Symbol_51 Symbol_649;
    uint32_t Symbol_888;
    uint8_t Symbol_380;
    uint8_t Symbol_975[3];
    Symbol_256 Symbol_1077[12];
} Symbol_304;
typedef struct {
    uint8_t _data[53];
    uint32_t Symbol_896;
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
static inline uint32_t Symbol_21(void)
{
    return Symbol_519.Symbol_896;
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
    uint32_t Symbol_888;
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
    uint32_t Symbol_888;
} Symbol_308;
static inline void Symbol_227(Symbol_5 *Symbol_645, Symbol_7 *Symbol_692)
{
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
    uint16_t Symbol_888;
    uint8_t Symbol_665;
    uint8_t Symbol_975;
} Symbol_75;
typedef struct {
    uint8_t _data[32];
    uint8_t Symbol_371;
    uint8_t Symbol_819;
    uint16_t Symbol_889;
    Symbol_75 Symbol_905[100];
} Symbol_74;
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
    do { if (((((__builtin_expect((!!((Symbol_520) == ((void *)0))), 0)))) || ((Symbol_880) >= Symbol_21()))) { return((((void *)0))); } } while (0);
    return (Symbol_520 + Symbol_880);
}
typedef enum Symbol_321 {
    Symbol_70
} Symbol_61;
void Symbol_273(Symbol_69 *Symbol_879)
{
    do { if (((__builtin_expect((!!((Symbol_879) == ((void *)0))), 0)))) { return; } } while (0);
    uint32_t Symbol_888 = Symbol_879->Symbol_858.Symbol_555;
    Symbol_267 *Symbol_974 = (Symbol_267 *)calloc(1, sizeof(Symbol_267));
    do { if (((__builtin_expect((!!((Symbol_974) == ((void *)0))), 0)))) { return; } } while (0);
    (void)memset(Symbol_974, 0, sizeof(Symbol_267));
    Symbol_974->Symbol_888 = Symbol_888;
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
        Symbol_256 *Symbol_759 = &(Symbol_377->Symbol_1077[Symbol_1076]);
        {if ((!Symbol_759->Symbol_593)) continue;};
        Symbol_759->Symbol_1078++;
        if (Symbol_759->Symbol_1078 >= Symbol_759->Symbol_1079) {
            Symbol_273(Symbol_879);
            Symbol_759->Symbol_1078 = 0;
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
static uint32_t Symbol_263(const Symbol_239 *Symbol_892, Symbol_49 *Symbol_897)
{
    do { if ((((__builtin_expect((!!((Symbol_892) == ((void *)0))), 0))) || ((__builtin_expect((!!((Symbol_897) == ((void *)0))), 0))))) { return((0)); } } while (0);
    uint32_t Symbol_781 = 0;
    uint32_t Symbol_782 = 0;
    _Bool Symbol_579 = 0;
    uint32_t Symbol_691 = ((Symbol_897->Symbol_691) <= (Symbol_21()) ? (Symbol_897->Symbol_691) : (Symbol_21()));
    Symbol_304 *Symbol_647 = (Symbol_304*)&Symbol_897->Symbol_646;
    Symbol_304 *Symbol_377 = (Symbol_304*)Symbol_897->Symbol_646.Symbol_648;
    for (uint32_t Symbol_539 = 0; Symbol_539 < Symbol_691; Symbol_539++) {
        {if ((Symbol_377 == Symbol_647 || ((__builtin_expect((!!((Symbol_377) == ((void *)0))), 0))))) break;};
        Symbol_304 *Symbol_685 = (Symbol_304*)(Symbol_377->Symbol_649.Symbol_648);
        Symbol_69 *Symbol_879 = Symbol_236(Symbol_377->Symbol_888);
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
    uint32_t Symbol_822 = (uint32_t)((Symbol_781 << 16U) | Symbol_782);
    return Symbol_822;
}
void Symbol_1(Symbol_49 *Symbol_897, int Symbol_686) {
    Symbol_304 *Symbol_778=((void *)0);
    for(int Symbol_539=0;Symbol_539<Symbol_686;Symbol_539++) {
        Symbol_304 *Symbol_464 = calloc(1,sizeof(Symbol_304));
        Symbol_464->Symbol_649.Symbol_650=(Symbol_51*)Symbol_778;
        Symbol_464->Symbol_888=Symbol_539;
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
        if(Symbol_539==0) {
            Symbol_464->Symbol_649.Symbol_386=(void*)&Symbol_897->Symbol_646;
        }
        else {
            Symbol_464->Symbol_649.Symbol_386=(void*)&Symbol_464->Symbol_649;
        }
    }
}
static uint32_t Symbol_213(void)
{
    uint32_t Symbol_664 = Symbol_21();
    void *Symbol_881 = Symbol_14(((uint32_t)(Symbol_664 * sizeof(Symbol_69))), ((uint32_t)64), (1223), __FUNCTION__, 256);
    if (((__builtin_expect((!!((Symbol_881) == ((void *)0))), 0)))) {
        return 0x70000 + 0x133;
    }
    (void)memset(
        Symbol_881, 0, sizeof(Symbol_69) * Symbol_664);
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
void Symbol_264(Symbol_5 *Symbol_1093)
{
    Symbol_308 *Symbol_1164 = ((void *)0);
    Symbol_7 *Symbol_646 = Symbol_1093->Symbol_646;
    while (Symbol_646 != ((void *)0)) {
        Symbol_1164 = (Symbol_308 *)Symbol_646;
        uint32_t Symbol_888 = Symbol_1164->Symbol_888;
        uint16_t Symbol_352 = Symbol_1164->Symbol_352;
        Symbol_1164->Symbol_888 = Symbol_21();
        Symbol_227(Symbol_1093, Symbol_646);
        Symbol_235(Symbol_352);
        Symbol_69 *Symbol_879 = Symbol_236(Symbol_888);
        {if ((((__builtin_expect((!!((Symbol_879) == ((void *)0))), 0))))) continue;};
        {if ((Symbol_879->Symbol_857.Symbol_474 != Symbol_0)) continue;};
        Symbol_315((Symbol_879->Symbol_949), "", 420);
        Symbol_272(Symbol_879, 1);
        Symbol_316((Symbol_879->Symbol_949), "", 422);
        Symbol_646 = Symbol_1093->Symbol_646;
    }
}
void Symbol_2(Symbol_5 *Symbol_1093, int Symbol_686) {
    Symbol_308 *Symbol_778=((void *)0);
    for(int Symbol_539=0;Symbol_539<Symbol_686;Symbol_539++) {
        Symbol_308 *Symbol_464 = calloc(1,sizeof(Symbol_308));
        ((Symbol_7*)&Symbol_464->Symbol_972)->Symbol_694=(Symbol_7*)Symbol_778;
        Symbol_464->Symbol_888=Symbol_539;
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
        for(int Symbol_539=0;Symbol_539<Symbol_686;Symbol_539++) {
            Symbol_69 *Symbol_879 = Symbol_236(Symbol_539);
            Symbol_879->Symbol_857.Symbol_474=Symbol_0;
        }
}
static void Symbol_274(const Symbol_74 *Symbol_1108)
{
    uint16_t Symbol_664 = (uint16_t)Symbol_21();
    do { if (((__builtin_expect((!!((Symbol_1108) == ((void *)0))), 0)))) { return; } } while (0);
    uint16_t Symbol_552 = ((Symbol_1108->Symbol_889) <= (Symbol_664) ? (Symbol_1108->Symbol_889) : (Symbol_664));
    Symbol_552 = ((Symbol_552) <= (256) ? (Symbol_552) : (256));
    uint32_t Symbol_551 = sizeof(Symbol_67) * Symbol_552;
    uint32_t Symbol_1096 = sizeof(Symbol_68) + Symbol_551;
    Symbol_68 *Symbol_550 = (Symbol_68*)calloc(1,((32768 - 64) - (64 + sizeof(Symbol_84))));
    if (((__builtin_expect((!!((Symbol_550) == ((void *)0))), 0)))) {
        return;
    }
    Symbol_67 *Symbol_549 = &Symbol_550->Symbol_557[0];
    Symbol_550->Symbol_553 = Symbol_552;
    for (uint32_t Symbol_548 = 0; Symbol_548 < Symbol_552; Symbol_548++) {
        uint16_t Symbol_888 = Symbol_1108->Symbol_905[Symbol_548].Symbol_888;
        Symbol_69 *Symbol_879 = Symbol_236((uint32_t)Symbol_888);
        {if ((((__builtin_expect((!!((Symbol_879) == ((void *)0))), 0))))) continue;};
        Symbol_549[Symbol_548].Symbol_652 = Symbol_879->Symbol_858.Symbol_699;
        Symbol_549[Symbol_548].Symbol_556 = Symbol_888;
        Symbol_549[Symbol_548].Symbol_364 = Symbol_879->Symbol_858.Symbol_364;
        Symbol_549[Symbol_548].Symbol_665 = Symbol_1108->Symbol_905[Symbol_548].Symbol_665;
    }
    Symbol_550->Symbol_371 = Symbol_1108->Symbol_371;
    Symbol_550->Symbol_819 = Symbol_1108->Symbol_819;
    (void)Symbol_17((Symbol_550), (1223), 503);
}


int main() {
#ifdef benchmark1
    Symbol_519.Symbol_896=100;
    if(Symbol_213() != 0) {
        return -1;
    }
    Symbol_239 Symbol_892;
    Symbol_49 *Symbol_897=calloc(1,sizeof(Symbol_49));
    Symbol_1(Symbol_897,100);
    Symbol_263(&Symbol_892, Symbol_897);
#endif

#ifdef benchmark2
   Symbol_519.Symbol_896=100;
    if(Symbol_213() != 0) {
        return -1;
    }
    Symbol_5 *Symbol_1093=calloc(1,sizeof(Symbol_5));
    Symbol_2(Symbol_1093,100);
    Symbol_319(100);
    Symbol_264(Symbol_1093);
#endif

#ifdef benchmark3
    Symbol_519.Symbol_896=100;
    if(Symbol_213() != 0) {
        return -1;
    }
    Symbol_74 *Symbol_1108=(Symbol_74*)calloc(1,sizeof(Symbol_74));
    for(int Symbol_539=0; Symbol_539<100; Symbol_539++) {
        Symbol_1108->Symbol_905[Symbol_539].Symbol_888=Symbol_539;
    }
    Symbol_1108->Symbol_889=(uint16_t)Symbol_21();;
    Symbol_274(Symbol_1108);
#endif

    return 0;
}
