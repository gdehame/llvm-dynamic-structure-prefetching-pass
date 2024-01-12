#!/bin/bash

for target in {"1","2","3"};
do
  clang -O3 -emit-llvm -D$1 -Dbenchmark$target -S -o tmp.ll benchmarks.c
  opt -O3 tmp.ll -S -o tmp.ll
  clang -O3 -o Benchmark$target tmp.ll
  rm tmp.ll
  clang -O3 -emit-llvm -Dbenchmark$target -D$1 -S -o CORO$target.ll coro.c
  opt -O3 -S -o CORO$target.ll CORO$target.ll
  clang -O3 -o CORO$target CORO$target.ll
  rm CORO$target.ll
  if [ $target == "3" ]
  then
    clang -O3 -emit-llvm -Dbenchmark$target -D$1 -S -o Basic3.ll basic3.c
    opt -O3 -S -o Basic3.ll Basic3.ll
    clang -O3 -o Ba3 Basic3.ll
    rm Basic3.ll
  else
    clang -O3 -emit-llvm -Dbenchmark$target -D$1 -S -o HT$target.ll ht.c
    opt -O3 -S -o HT$target.ll HT$target.ll
    clang -O3 -o HT$target HT$target.ll
    rm HT$target.ll
  fi
done
