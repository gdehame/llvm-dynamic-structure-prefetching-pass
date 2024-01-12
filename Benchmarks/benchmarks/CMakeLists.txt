cmake_minimum_required(VERSION 3.9.4)
project(Benchmark_DP LANGUAGES C)
include_directories(Benchmark_DP include)
add_executable(Benchmark_DP 
    benchmarks.c
)
add_executable(HT_DP 
    ht.c
)
add_executable(CORO_DP 
    coro.c
)

