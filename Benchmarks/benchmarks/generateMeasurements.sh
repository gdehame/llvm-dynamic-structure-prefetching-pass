#!/bin/bash

#This requires vtune, and variable vtune_exe should be set to point to the vtune_exe binary

#This script must be executed in the benchmarks/ directory

vtune_exe="/opt/intel/oneapi/vtune/2023.1.0/bin64/vtune"

bench3_analysis="-collect-with runsa -knob collectMemBandwidth=true -knob enable-user-tasks=true -knob dram-bandwidth-limits=true -knob event-config=CYCLE_ACTIVITY.STALLS_L1D_MISS:sa=506,CYCLE_ACTIVITY.STALLS_L2_MISS:sa=506,CYCLE_ACTIVITY.STALLS_L3_MISS:sa=506,MEM_INST_RETIRED.ALL_LOADS_PS:sa=506,MEM_LOAD_RETIRED.L1_HIT_PS:sa=506,MEM_LOAD_RETIRED.L1_MISS_PS:sa=506,MEM_LOAD_RETIRED.L2_HIT_PS:sa=506,MEM_LOAD_RETIRED.L2_MISS_PS:sa=506,MEM_LOAD_RETIRED.L3_HIT_PS:sa=506,MEM_LOAD_RETIRED.L3_MISS_PS:sa=506 -knob memoryObjectMinSize=256"
bench1_2_analysis="-collect-with runsa -knob collectMemBandwidth=true -knob enable-user-tasks=true -knob dram-bandwidth-limits=true -knob event-config=CYCLE_ACTIVITY.STALLS_L1D_MISS:sa=100003,CYCLE_ACTIVITY.STALLS_L2_MISS:sa=100003,CYCLE_ACTIVITY.STALLS_L3_MISS:sa=100003,MEM_INST_RETIRED.ALL_LOADS_PS:sa=10003,MEM_LOAD_RETIRED.L1_HIT_PS:sa=10003,MEM_LOAD_RETIRED.L1_MISS_PS:sa=10003,MEM_LOAD_RETIRED.L2_HIT_PS:sa=10003,MEM_LOAD_RETIRED.L2_MISS_PS:sa=10003,MEM_LOAD_RETIRED.L3_HIT_PS:sa=10003,MEM_LOAD_RETIRED.L3_MISS_PS:sa=10003 -knob memoryObjectMinSize=256"

if [ -z $1 ] 
then
  bash compile.sh
  if [ -d results ]
  then
    cd results
    rm -rd 1
    rm -rd 2
    rm -rd 3
    rm -rd CORO1
    rm -rd CORO2
    rm -rd CORO3
    cd ..
  else
    mkdir results
  fi
  cd results
  mkdir reports
  mkdir 1
  mkdir 2
  mkdir 3
  mkdir CORO1
  mkdir CORO2
  mkdir CORO3
  mkdir Manual3
  cd ..


  $vtune_exe $bench1_2_analysis -r ./results/1 -allow-multiple-runs --app-working-dir=$PWD/ -- ./Benchmark1 1000000 0.5

  $vtune_exe -R hw-events -result-dir ./results/1/ -report-output ./results/reports/1.txt -format text -filter module=Benchmark1 -filter function=Benchmark1 -filter function=Symbol_236 -filter function=Symbol_262 -filter function=Symbol_273 -filter function=RemoveFromList -filter function=Symbol_24 -filter function=Symbol_312 -filter function=Symbol_313 -filter function=Symbol_15 -search-dir=$PWD/ -group-by source-line -group-by function -sort-asc="Source Line"

  $vtune_exe $bench1_2_analysis -r ./results/2 -allow-multiple-runs --app-working-dir=$PWD/ -- ./Benchmark2 1000000 0.5

  $vtune_exe -R hw-events -result-dir ./results/2/ -report-output ./results/reports/2.txt -format text -filter module=Benchmark2 -filter function=Benchmark2 -filter function=Symbol_227 -filter function=Symbol_235 -filter function=Symbol_23 -filter function=Symbol_22 -filter function=Symbol_236 -filter function=Symbol_272  -search-dir=$PWD/ -group-by source-line -group-by function -sort-asc="Source Line"

  $vtune_exe $bench3_analysis -r ./results/3 -allow-multiple-runs --app-working-dir=$PWD/ -- ./Benchmark3 20000

  $vtune_exe -R hw-events -result-dir ./results/3/ -report-output ./results/reports/3.txt -format text -filter module=Benchmark3 -filter function=Benchmark3 -filter function=Symbol_236 -search-dir=$PWD -group-by source-line -group-by function -sort-asc="Source Line"

  $vtune_exe $bench1_2_analysis -r ./results/CORO1 -allow-multiple-runs --app-working-dir=$PWD/ -- ./CORO1 1000000 0.5

  $vtune_exe -R hw-events -result-dir ./results/CORO1/ -report-output ./results/reports/CORO1.txt -format text -filter module=CORO1 -filter function=Benchmark1 -filter function=coroutine1 -filter function=Symbol_262 -filter function=Symbol_273 -filter function=RemoveFromList -filter function=Symbol_24 -filter function=Symbol_312 -filter function=Symbol_313 -filter function=Symbol_15 -search-dir=$PWD/ -group-by source-line -group-by function -sort-asc="Source Line"


  $vtune_exe $bench1_2_analysis -r ./results/CORO2 -allow-multiple-runs --app-working-dir=$PWD/ -- ./CORO2 1000000 0.5

  $vtune_exe -R hw-events -result-dir ./results/CORO2/ -report-output ./results/reports/CORO2.txt -format text -filter module=CORO2 -filter function=Benchmark2 -filter function=Symbol_227 -filter function=Symbol_235 -filter function=Symbol_23 -filter function=Symbol_22 -filter function=coroutine2 -filter function=Symbol_272  -search-dir=$PWD/ -group-by source-line -group-by function -sort-asc="Source Line"

  $vtune_exe $bench3_analysis -r ./results/CORO3 -allow-multiple-runs --app-working-dir=$PWD/ -- ./CORO3 20000

  $vtune_exe -R hw-events -result-dir ./results/CORO3/ -report-output ./results/reports/CORO3.txt -format text -filter module=CORO3 -filter function=Benchmark3 -filter function=coroutine3 -filter function=Symbol_236 -search-dir=$PWD -group-by source-line -group-by function -sort-asc="Source Line"
elif [ $1 == "pass" ]
then
  bash applyPass.sh
  if [ -z $2 ]
  then
    cd results
    rm -rd pass1-annotated
    rm -rd pass2-annotated
    rm -rd pass3-annotated
    rm -rd pass1-heuristic
    rm -rd pass2-heuristic
    rm -rd pass3-heuristic
    cd ..
    $vtune_exe $bench1_2_analysis -r ./results/pass1-annotated -allow-multiple-runs --app-working-dir=$PWD/ -- ./pass1-annotated 1000000 0.5

    $vtune_exe -R hw-events -result-dir ./results/pass1-annotated/ -report-output ./results/reports/pass1-annotated.txt -format text -filter module=pass1-annotated -filter function=Benchmark1 -filter function=Symbol_236 -filter function=Symbol_262 -filter function=Symbol_273 -filter function=RemoveFromList -filter function=Symbol_24 -filter function=Symbol_312 -filter function=Symbol_313 -filter function=Symbol_15 -search-dir=$PWD/ -group-by source-line -group-by function -sort-asc="Source Line"

    $vtune_exe $bench1_2_analysis -r ./results/pass2-annotated -allow-multiple-runs --app-working-dir=$PWD/ -- ./pass2-annotated 1000000 0.5

    $vtune_exe -R hw-events -result-dir ./results/pass2-annotated/ -report-output ./results/reports/pass2-annotated.txt -format text -filter module=pass2-annotated -filter function=Benchmark2 -filter function=Symbol_227 -filter function=Symbol_235 -filter function=Symbol_23 -filter function=Symbol_22 -filter function=Symbol_236 -filter function=Symbol_272  -search-dir=$PWD/ -group-by source-line -group-by function -sort-asc="Source Line"

    $vtune_exe $bench3_analysis -r ./results/pass3-annotated -allow-multiple-runs --app-working-dir=$PWD/ -- ./pass3-annotated 20000

    $vtune_exe -R hw-events -result-dir ./results/pass3-annotated/ -report-output ./results/reports/pass3-annotated.txt -format text -filter module=pass3-annotated -filter function=Benchmark3 -filter function=Symbol_236 -search-dir=$PWD -group-by source-line -group-by function -sort-asc="Source Line"

    $vtune_exe $bench1_2_analysis -r ./results/pass1-heuristic -allow-multiple-runs --app-working-dir=$PWD/ -- ./pass1-heuristic 1000000 0.5

    $vtune_exe -R hw-events -result-dir ./results/pass1-heuristic/ -report-output ./results/reports/pass1-heuristic.txt -format text -filter module=pass1-heuristic -filter function=Benchmark1 -filter function=Symbol_262 -filter function=Symbol_273 -filter function=RemoveFromList -filter function=Symbol_24 -filter function=Symbol_312 -filter function=Symbol_313 -filter function=Symbol_15 -search-dir=$PWD/ -group-by source-line -group-by function -sort-asc="Source Line"

    $vtune_exe $bench1_2_analysis -r ./results/pass2-heuristic -allow-multiple-runs --app-working-dir=$PWD/ -- ./pass2-heuristic 1000000 0.5

    $vtune_exe -R hw-events -result-dir ./results/pass2-heuristic/ -report-output ./results/reports/pass2-heuristic.txt -format text -filter module=pass2-heuristic -filter function=Benchmark2 -filter function=Symbol_227 -filter function=Symbol_235 -filter function=Symbol_23 -filter function=Symbol_22 -filter function=Symbol_272  -search-dir=$PWD/ -group-by source-line -group-by function -sort-asc="Source Line"

    $vtune_exe $bench3_analysis -r ./results/pass3-heuristic -allow-multiple-runs --app-working-dir=$PWD/ -- ./pass3-heuristic 20000

    $vtune_exe -R hw-events -result-dir ./results/pass3-heuristic/ -report-output ./results/reports/pass3-heuristic.txt -format text -filter module=pass3-heuristic -filter function=Benchmark3 -filter function=Symbol_236 -search-dir=$PWD -group-by source-line -group-by function -sort-asc="Source Line"
  elif [ $2 == "3" ]
  then
    cd results
    rm -rd pass3-annotated
    rm -rd pass3-heuristic
    cd ..
    $vtune_exe $bench3_analysis -r ./results/pass3-annotated -allow-multiple-runs --app-working-dir=$PWD/ -- ./pass3-annotated 20000

    $vtune_exe -R hw-events -result-dir ./results/pass3-annotated/ -report-output ./results/reports/pass3-annotated.txt -format text -filter module=pass3-annotated -filter function=Benchmark3 -filter function=Symbol_236 -search-dir=$PWD -group-by source-line -group-by function -sort-asc="Source Line"

    $vtune_exe $bench3_analysis -r ./results/pass3-heuristic -allow-multiple-runs --app-working-dir=$PWD/ -- ./pass3-heuristic 20000

    $vtune_exe -R hw-events -result-dir ./results/pass3-heuristic/ -report-output ./results/reports/pass3-heuristic.txt -format text -filter module=pass3-heuristic -filter function=Benchmark3 -filter function=Symbol_236 -search-dir=$PWD -group-by source-line -group-by function -sort-asc="Source Line"
  elif [ $2 != "1" ] && [ $2 != "2" ]
  then
    echo "Wrong argument, second one should be one of 1,2,3"
  else
    cd results
    rm -rd pass$2-annotated
    rm -rd pass$2-heuristic
    cd ..
    if [ $2 == 1 ]
    then
      $vtune_exe $bench1_2_analysis -r ./results/pass1-annotated -allow-multiple-runs --app-working-dir=$PWD/ -- ./pass1-annotated 1000000 0.5

      $vtune_exe -R hw-events -result-dir ./results/pass1-annotated/ -report-output ./results/reports/pass1-annotated.txt -format text -filter module=pass1-annotated -filter function=Benchmark1 -filter function=Symbol_236 -filter function=Symbol_262 -filter function=Symbol_273 -filter function=RemoveFromList -filter function=Symbol_24 -filter function=Symbol_312 -filter function=Symbol_313 -filter function=Symbol_15 -search-dir=$PWD/ -group-by source-line -group-by function -sort-asc="Source Line"

      $vtune_exe $bench1_2_analysis -r ./results/pass1-heuristic -allow-multiple-runs --app-working-dir=$PWD/ -- ./pass1-heuristic 1000000 0.5

      $vtune_exe -R hw-events -result-dir ./results/pass1-heuristic/ -report-output ./results/reports/pass1-heuristic.txt -format text -filter module=pass1-heuristic -filter function=Benchmark1 -filter function=Symbol_262 -filter function=Symbol_273 -filter function=RemoveFromList -filter function=Symbol_24 -filter function=Symbol_312 -filter function=Symbol_313 -filter function=Symbol_15 -search-dir=$PWD/ -group-by source-line -group-by function -sort-asc="Source Line"
    else
      $vtune_exe $bench1_2_analysis -r ./results/pass2-annotated -allow-multiple-runs --app-working-dir=$PWD/ -- ./pass2-annotated 1000000 0.5

      $vtune_exe -R hw-events -result-dir ./results/pass2-annotated/ -report-output ./results/reports/pass2-annotated.txt -format text -filter module=pass2-annotated -filter function=Benchmark2 -filter function=Symbol_227 -filter function=Symbol_235 -filter function=Symbol_23 -filter function=Symbol_22 -filter function=Symbol_236 -filter function=Symbol_272  -search-dir=$PWD/ -group-by source-line -group-by function -sort-asc="Source Line"

      $vtune_exe $bench1_2_analysis -r ./results/pass2-heuristic -allow-multiple-runs --app-working-dir=$PWD/ -- ./pass2-heuristic 1000000 0.5

      $vtune_exe -R hw-events -result-dir ./results/pass2-heuristic/ -report-output ./results/reports/pass2-heuristic.txt -format text -filter module=pass2-heuristic -filter function=Benchmark2 -filter function=Symbol_227 -filter function=Symbol_235 -filter function=Symbol_23 -filter function=Symbol_22 -filter function=Symbol_272  -search-dir=$PWD/ -group-by source-line -group-by function -sort-asc="Source Line"
    fi  
  fi
elif [ $1 == "timePass" ]
then
  rm $PWD/results/time/pass*.txt
  for ((i = 1; i <= 100; i++));
  do
    ./pass1-annotated 1000000 0.5 >> $PWD/results/time/pass1-annotated.txt
    ./pass2-annotated 1000000 0.5 >> $PWD/results/time/pass2-annotated.txt
    ./pass3-annotated 20000 >> $PWD/results/time/pass3-annotated.txt
    ./pass1-heuristic 1000000 0.5 >> $PWD/results/time/pass1-heuristic.txt
    ./pass2-heuristic 1000000 0.5 >> $PWD/results/time/pass2-heuristic.txt BUG TO FIX: pass2-heuristic runs infinitely
    ./pass3-heuristic 20000 >> $PWD/results/time/pass3-heuristic.txt
  done
  for file in {"pass1-annotated","pass2-annotated","pass3-annotated","pass1-heuristic","pass2-heuristic","pass3-heuristic"};
  do
    python3 exectime.py $PWD/results/time/$file.txt > $PWD/results/time/$file-avg.txt;
  done
elif [ $1 == "timeAll" ] && ! [ -z $2 ] && ! [ -z $3 ] && ! [ -z $4 ]
then
  cd results
  if ! [ -d time ]
  then
    mkdir time
  fi
  cd time
  rm *-app-avg.txt
  m *-target-avg.txt
  cd ../..
  bash compileCLANG.sh MEASURE_APP
  for ((i = 1; i <= 100; i++)); 
  do
    ./Benchmark1 1000000 0.5 >> $PWD/results/time/1-app.txt
    ./Benchmark2 1000000 0.5 >> $PWD/results/time/2-app.txt
    ./Benchmark3 20000 >> $PWD/results/time/3-app.txt
    ./CORO1 1000000 0.5 >> $PWD/results/time/CORO1-app.txt
    ./CORO2 1000000 0.5 >> $PWD/results/time/CORO2-app.txt
    ./CORO3 20000 >> $PWD/results/time/CORO3-app.txt
    ./HT1 1000000 0.5 $2 >> $PWD/results/time/HT1-$2-app.txt
    ./HT2 1000000 0.5 $3 >> $PWD/results/time/HT2-$3-app.txt
    ./Ba3 20000 $4 >> $PWD/results/time/Ba3-$4-app.txt
  done
  for file in {"1","2","3","CORO1","CORO2","CORO3","HT1-${2}","HT2-${3}","Ba3-${4}"}; 
  do 
    python3 exectime.py $PWD/results/time/$file-app.txt > $PWD/results/time/$file-app-avg.txt
  done
  rm $PWD/results/time/*-app.txt
  bash compileCLANG.sh MEASURE_TARGET
  for ((i = 1; i <= 100; i++)); 
  do
    ./Benchmark1 1000000 0.5 >> $PWD/results/time/1-target.txt
    ./Benchmark2 1000000 0.5 >> $PWD/results/time/2-target.txt
    ./Benchmark3 20000 >> $PWD/results/time/3-target.txt
    ./CORO1 1000000 0.5 >> $PWD/results/time/CORO1-target.txt
    ./CORO2 1000000 0.5 >> $PWD/results/time/CORO2-target.txt
    ./CORO3 20000 >> $PWD/results/time/CORO3-target.txt
    ./HT1 1000000 0.5 $2 >> $PWD/results/time/HT1-$2-target.txt
    ./HT2 1000000 0.5 $3 >> $PWD/results/time/HT2-$3-target.txt
    ./Ba3 20000 $4 >> $PWD/results/time/Ba3-$4-target.txt
  done
  for file in {"1","2","3","CORO1","CORO2","CORO3","HT1-${2}","HT2-${3}","Ba3-${4}"}; 
  do 
    python3 exectime.py $PWD/results/time/$file-target.txt > $PWD/results/time/$file-target-avg.txt
  done
  rm $PWD/results/time/*-target.txt
  bash compile.sh
elif [ $1 == "time" ] && ! [ -z $2 ] && ! [ -z $3 ]
then
  rm "${PWD}/results/time/${3}-app.txt"
  rm "${PWD}/results/time/${3}-target.txt"
  bash compileCLANG.sh MEASURE_APP
  for ((i = 1; i <= 100; i++)); 
  do
    eval "$2 >> "${PWD}/results/time/${3}-app.txt""
  done
  python3 exectime.py "${PWD}/results/time/${3}-app.txt" > "${PWD}/results/time/${3}-app-avg.txt"
  rm $PWD/results/time/$3-app.txt
  bash compileCLANG.sh MEASURE_TARGET
  for ((i = 1; i <= 100; i++)); 
  do
    eval "$2 >> "${PWD}/results/time/${3}-target.txt""
  done
  python3 exectime.py "${PWD}/results/time/${3}-target.txt" > "${PWD}/results/time/${3}-target-avg.txt"
  rm $PWD/results/time/$3-target.txt
else
  bash compile.sh
  cd results
  if ! [ -d "reports/" ]
  then
    mkdir reports
  fi
  if [ $1 = "1" ];
  then
    rm -rd 1
    mkdir 1
    cd ..

    $vtune_exe $bench1_2_analysis -r ./results/1 -allow-multiple-runs --app-working-dir=$PWD/ -- ./Benchmark1 1000000 0.5

    $vtune_exe -R hw-events -result-dir ./results/1/ -report-output ./results/reports/1.txt -format text -filter module=Benchmark1 -filter function=Benchmark1 -filter function=Symbol_236 -filter function=Symbol_262 -filter function=Symbol_273 -filter function=RemoveFromList -filter function=Symbol_24 -filter function=Symbol_312 -filter function=Symbol_313 -filter function=Symbol_15 -search-dir=$PWD/ -group-by source-line -group-by function -sort-asc="Source Line"
  elif [ $1 = "2" ];
  then
    rm -rd 2
    mkdir 2
    cd ..

    $vtune_exe $bench1_2_analysis -r ./results/2 -allow-multiple-runs --app-working-dir=$PWD/ -- ./Benchmark2 1000000 0.5

    $vtune_exe -R hw-events -result-dir ./results/2/ -report-output ./results/reports/2.txt -format text -filter module=Benchmark2 -filter function=Benchmark2 -filter function=Symbol_227 -filter function=Symbol_235 -filter function=Symbol_23 -filter function=Symbol_22 -filter function=Symbol_236 -filter function=Symbol_272  -search-dir=$PWD/ -group-by source-line -group-by function -sort-asc="Source Line"
  elif [ $1 = "3" ];
  then
    rm -rd 3
    mkdir 3
    cd ..

    $vtune_exe $bench3_analysis -r ./results/3 -allow-multiple-runs --app-working-dir=$PWD/ -- ./Benchmark3 20000

    $vtune_exe -R hw-events -result-dir ./results/3/ -report-output ./results/reports/3.txt -format text -filter module=Benchmark3 -filter function=Benchmark3 -filter function=Symbol_236 -search-dir=$PWD -group-by source-line -group-by function -sort-asc="Source Line"
  elif [ $1 = "CORO1" ]; 
  then
    rm -rd CORO1
    mkdir CORO1
    cd ..

    $vtune_exe $bench1_2_analysis -r ./results/CORO1 -allow-multiple-runs --app-working-dir=$PWD/ -- ./CORO1 1000000 0.5

    $vtune_exe -R hw-events -result-dir ./results/CORO1/ -report-output ./results/reports/CORO1.txt -format text -filter module=CORO1 -filter function=Benchmark1 -filter function=coroutine1 -filter function=Symbol_262 -filter function=Symbol_273 -filter function=RemoveFromList -filter function=Symbol_24 -filter function=Symbol_312 -filter function=Symbol_313 -filter function=Symbol_15 -search-dir=$PWD/ -group-by source-line -group-by function -sort-asc="Source Line"
  elif [ $1 = "CORO2" ]; 
  then
    rm -rd CORO1
    mkdir CORO1
    cd ..

    $vtune_exe $bench1_2_analysis -r ./results/CORO2 -allow-multiple-runs --app-working-dir=$PWD/ -- ./CORO2 1000000 0.5

    $vtune_exe -R hw-events -result-dir ./results/CORO2/ -report-output ./results/reports/CORO2.txt -format text -filter module=CORO2 -filter function=Benchmark2 -filter function=Symbol_227 -filter function=Symbol_235 -filter function=Symbol_23 -filter function=Symbol_22 -filter function=coroutine2 -filter function=Symbol_272  -search-dir=$PWD/ -group-by source-line -group-by function -sort-asc="Source Line"
  elif [ $1 = "CORO3" ]; 
  then
    rm -rd CORO3
    mkdir CORO3
    cd ..

    $vtune_exe $bench3_analysis -r ./results/CORO3 -allow-multiple-runs --app-working-dir=$PWD/ -- ./CORO3 20000

    $vtune_exe -R hw-events -result-dir ./results/CORO3/ -report-output ./results/reports/CORO3.txt -format text -filter module=CORO3 -filter function=Benchmark3 -filter function=coroutine3 -filter function=Symbol_236 -search-dir=$PWD -group-by source-line -group-by function -sort-asc="Source Line"
  elif [ $1 = "HT1" ]
  then
    if [ -z $2 ]
    then
      echo "No prefetch distance given, for helper thread measurements you need to run as follow: 'bash generateMeasurements.sh HT1 prefetch_distance'"
      cd ..
    else
      rm -rd HT1-$2
      mkdir HT1-$2
      cd ..
      $vtune_exe $bench1_2_analysis -r ./results/HT1-$2 -allow-multiple-runs --app-working-dir=$PWD/ -- ./HT1 1000000 0.5 $2

      $vtune_exe -R hw-events -result-dir ./results/HT1-$2/ -report-output ./results/reports/HT1-$2.txt -format text -filter module=HT1 -filter function=Benchmark1 -filter function=Symbol_236 -filter function=ht_1 -filter function=ht_1_init -filter function=Symbol_262 -filter function=Symbol_273 -filter function=RemoveFromList -filter function=Symbol_24 -filter function=Symbol_312 -filter function=Symbol_313 -filter function=Symbol_15 -search-dir=$PWD/ -group-by source-line -group-by function -sort-asc="Source Line"
    fi
  elif [ $1 = "HT2" ]
  then
    if [ -z $2 ]
    then
      echo "No chunk size given, for helper thread measurements you need to run as follow: 'bash generateMeasurements.sh HT2 chunk_size'"
      cd ..
    else
      rm -rd HT2-$2
      mkdir HT2-$2
      cd ..
      $vtune_exe $bench1_2_analysis -r ./results/HT2-$2 -allow-multiple-runs --app-working-dir=$PWD/ -- ./HT2 1000000 0.5 $2

      $vtune_exe -R hw-events -result-dir ./results/HT2-$2/ -report-output ./results/reports/HT2-$2.txt -format text -filter module=HT2 -filter function=Benchmark2 -filter function=Symbol_227 -filter function=Symbol_235 -filter function=Symbol_23 -filter function=Symbol_22 -filter function=Symbol_236 -filter function=ht_2 -filter function=ht_2_init -filter function=Symbol_272  -search-dir=$PWD/ -group-by source-line -group-by function -sort-asc="Source Line"
    fi
  elif [ $1 = "Basic3" ]
  then
    if [ -z $2 ]
    then
      echo "No prefetch distance given"
    else
      rm -rd Ba3
      mkdir Ba3
      cd ..
      $vtune_exe $bench3_analysis -r ./results/Ba3 -allow-multiple-runs --app-working-dir=$PWD/ -- ./Ba3 20000 $2

      $vtune_exe -R hw-events -result-dir ./results/Ba3/ -report-output ./results/reports/Ba3-$2.txt -format text -filter module=Ba3 -filter function=Benchmark3 -filter function=Symbol_236 -search-dir=$PWD -group-by source-line -group-by function -sort-asc="Source Line"
    fi
  else
    echo "Wrong parameter, should be none to generate all results or one of: 1, 2, 3, CORO1, CORO2, CORO3, HT1, HT2, Basic3"
    cd ..
  fi
fi
