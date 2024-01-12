#!/bin/bash

if [ -z $1 ]
then
  rm -r CMakeFiles/
  rm CMakeCache.txt
  rm Makefile
  rm cmake_install.cmake
  rm Benchmark1
  rm Benchmark2
  rm Benchmark3
  rm HT1
  rm HT2
  rm HT_DP
  rm CORO1
  rm CORO_DP
  rm CORO2
  rm CORO3
  rm Ba3

  gcc -O3 -gdwarf-4 basic3.c -o Ba3

  cmake -DCMAKE_TOOLCHAIN_FILE=toolchain -DCMAKE_C_FLAGS="-Dbenchmark1 -lpthread -O3 -gdwarf-4"
  make

  mv Benchmark_DP Benchmark1
  mv HT_DP HT1
  mv CORO_DP CORO1

  ##################

  rm -r CMakeFiles/
  rm CMakeCache.txt
  rm Makefile
  rm cmake_install.cmake

  cmake -DCMAKE_TOOLCHAIN_FILE=toolchain -DCMAKE_C_FLAGS="-Dbenchmark2 -lpthread -O3 -gdwarf-4"
  make

  mv Benchmark_DP Benchmark2
  mv CORO_DP CORO2
  mv HT_DP HT2

  ##################

  rm -r CMakeFiles/
  rm CMakeCache.txt
  rm Makefile
  rm cmake_install.cmake

  cmake -DCMAKE_TOOLCHAIN_FILE=toolchain -DCMAKE_C_FLAGS="-Dbenchmark3 -lpthread -O3 -gdwarf-4"
  make

  mv Benchmark_DP Benchmark3
  mv CORO_DP CORO3
  rm HT_DP
else
  gcc $1 basic3.c -o Ba3

  cmake -DCMAKE_TOOLCHAIN_FILE=toolchain -DCMAKE_C_FLAGS="${1} -Dbenchmark1"
  make

  mv Benchmark_DP Benchmark1
  mv HT_DP HT1
  mv CORO_DP CORO1

  ##################

  rm -r CMakeFiles/
  rm CMakeCache.txt
  rm Makefile
  rm cmake_install.cmake

  cmake -DCMAKE_TOOLCHAIN_FILE=toolchain -DCMAKE_C_FLAGS="${1} -Dbenchmark2"
  make

  mv Benchmark_DP Benchmark2
  mv CORO_DP CORO2
  mv HT_DP HT2

  ##################

  rm -r CMakeFiles/
  rm CMakeCache.txt
  rm Makefile
  rm cmake_install.cmake

  cmake -DCMAKE_TOOLCHAIN_FILE=toolchain -DCMAKE_C_FLAGS="${1} -Dbenchmark3"
  make

  mv Benchmark_DP Benchmark3
  mv CORO_DP CORO3
  rm HT_DP
fi
