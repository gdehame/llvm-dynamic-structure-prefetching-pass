#!/bin/bash

#This requires vtune, and variable vtune_exe should be set to point to the vtune_exe binary

#This script must be executed in the benchmarks/ directory

vtune_exe="/opt/intel/oneapi/vtune/2023.1.0/bin64/vtune"

cd results

if [ -z $1 ]
then
  if ! [ -d "$PWD/graphs/" ]
  then
    mkdir graphs
  fi
  cd ..
  python3 parseReport.py $PWD/results/reports/1.txt $PWD/results/graphs/
  python3 parseReport.py $PWD/results/reports/2.txt $PWD/results/graphs/
  python3 parseReport.py $PWD/results/reports/3.txt $PWD/results/graphs/
  #for file in $PWD/results/reports/*; do python3 parseReport.py $file $PWD/results/graphs/;
  #done
elif [ $1 == "timePass" ]
then
  cd ..
  python3 exectime.py graphPass $PWD/results/time/1-target-avg.txt $PWD/results/time/CORO1-target-avg.txt $PWD/results/time/pass1-annotated-avg.txt $PWD/results/time/pass1-heuristic-avg.txt $PWD/results/time/2-target-avg.txt $PWD/results/time/CORO2-target-avg.txt $PWD/results/time/pass2-annotated-avg.txt $PWD/results/time/pass2-heuristic-avg.txt $PWD/results/time/3-target-avg.txt $PWD/results/time/CORO3-target-avg.txt $PWD/results/time/pass3-annotated-avg.txt $PWD/results/time/pass3-heuristic-avg.txt $PWD/results/graphs/
elif [ $1 == "timeAll" ]
then
  cd ..
  python3 exectime.py graphPass $PWD/results/time/1-target-avg.txt $PWD/results/time/CORO1-target-avg.txt $PWD/results/time/pass1-annotated-avg.txt $PWD/results/time/pass1-heuristic-avg.txt $PWD/results/time/HT1-8-target-avg.txt $PWD/results/time/2-target-avg.txt $PWD/results/time/CORO2-target-avg.txt $PWD/results/time/pass2-annotated-avg.txt $PWD/results/time/pass2-heuristic-avg.txt $PWD/results/time/HT2-60056-target-avg.txt $PWD/results/time/3-target-avg.txt $PWD/results/time/CORO3-target-avg.txt $PWD/results/time/pass3-annotated-avg.txt $PWD/results/time/pass3-heuristic-avg.txt $PWD/results/time/Ba3-16-target-avg.txt $PWD/results/graphs/
elif [ $1 == "time" ]
then
  cd ..
  if [ -z $2 ]
  then
    python3 exectime.py graph $PWD/results/time/1-app-avg.txt $PWD/results/time/CORO1-app-avg.txt $PWD/results/time/HT1-8-app-avg.txt $PWD/results/time/1-target-avg.txt $PWD/results/time/CORO1-target-avg.txt $PWD/results/time/HT1-8-target-avg.txt $PWD/results/graphs/
    python3 exectime.py graph $PWD/results/time/2-app-avg.txt $PWD/results/time/CORO2-app-avg.txt $PWD/results/time/HT2-60056-app-avg.txt $PWD/results/time/2-target-avg.txt $PWD/results/time/CORO2-target-avg.txt $PWD/results/time/HT2-60056-target-avg.txt $PWD/results/graphs/
    python3 exectime.py graph $PWD/results/time/3-app-avg.txt $PWD/results/time/CORO3-app-avg.txt $PWD/results/time/Ba3-16-app-avg.txt $PWD/results/time/3-target-avg.txt $PWD/results/time/CORO3-target-avg.txt $PWD/results/time/Ba3-16-target-avg.txt $PWD/results/graphs/
  elif [ $2 == "Basic3" ]
  then
    argsApp="$PWD/results/time/3-app-avg.txt"
    argsTarget="$PWD/results/time/3-target-avg.txt"
    for file in `ls -v $PWD/results/time/Ba3-*-app-avg.txt`; 
    do
      argsApp="${argsApp} $file"
    done
    for file in `ls -v $PWD/results/time/Ba3-*-target-avg.txt`; 
    do 
      argsTarget="${argsTarget} $file" 
    done
    python3 exectime.py graph $argsApp $argsTarget $PWD/results/graphs/
  elif [ $2 == "HT1" ]
  then
    argsApp="$PWD/results/time/1-app-avg.txt"
    argsTarget="$PWD/results/time/1-target-avg.txt"
    for file in `ls -v $PWD/results/time/HT1-*-app-avg.txt`; 
    do
      argsApp="${argsApp} $file"
    done
    for file in `ls -v $PWD/results/time/HT1-*-target-avg.txt`; 
    do 
      argsTarget="${argsTarget} $file" 
    done
    python3 exectime.py graph $argsApp $argsTarget $PWD/results/graphs/
  elif [ -z $3 ] || [ -z $4 ]
  then
      echo "if you enter a chunk size or prefetch distance for the time graphs, you must enter all 3"
  else
    python3 exectime.py graph $PWD/results/time/1-app-avg.txt $PWD/results/time/CORO1-app-avg.txt $PWD/results/time/HT1-$2-app-avg.txt $PWD/results/time/1-target-avg.txt $PWD/results/time/CORO1-target-avg.txt $PWD/results/time/HT1-$2-target-avg.txt $PWD/results/graphs/
    python3 exectime.py graph $PWD/results/time/2-app-avg.txt $PWD/results/time/CORO2-app-avg.txt $PWD/results/time/HT2-$3-app-avg.txt $PWD/results/time/2-target-avg.txt $PWD/results/time/CORO2-target-avg.txt $PWD/results/time/HT2-$3-target-avg.txt $PWD/results/graphs/
    python3 exectime.py graph $PWD/results/time/3-app-avg.txt $PWD/results/time/CORO3-app-avg.txt $PWD/results/time/Ba3-$4-app-avg.txt $PWD/results/time/3-target-avg.txt $PWD/results/time/CORO3-target-avg.txt $PWD/results/time/Ba3-$4-target-avg.txt $PWD/results/graphs/
  fi
elif [ $1 == "comparePass" ]
then
  if [ -z $2 ]
  then
    echo "Should specify as second argument a benchmark number"
  else
    if ! [ -d "graphs" ]
    then
      mkdir graphs
    fi
    cd ..
    python3 compareResults.py $PWD/results/reports/$2.txt $PWD/results/reports/CORO$2.txt $PWD/results/reports/pass$2-annotated.txt $PWD/results/reports/pass$2-heuristic.txt $PWD/results/graphs/
  fi
elif [ $1 == "compare" ]
then
  if ! [ -d "$PWD/results/graphs/" ]
  then
    mkdir graphs
  fi
  cd ..
  if [ -z $2 ]
  then
    echo "Comparison mode must be used with a second argument (benchmark number)"
  elif ! [ -d "$PWD/results/$2/" ]
  then
    echo "$PWD/results/$2/ doesn't exist, please generate results before using this script"
  else
    if [ -f "$PWD/results/reports/CORO$2.txt" ]
    then
      if ! [ -z $3 ] && [ -f "$PWD/results/reports/HT$2-$3.txt" ]
      then
        if [ $4 == "pass" ] && [ -f "$PWD/results/reports/pass$2-annotated.txt" ]
        then
           python3 compareResults.py $PWD/results/reports/$2.txt $PWD/results/reports/CORO$2.txt $PWD/results/reports/pass$2-annotated.txt $PWD/results/reports/pass$2-heuristic.txt $PWD/results/reports/HT$2-$3.txt $PWD/results/graphs/
        else
          python3 compareResults.py $PWD/results/reports/$2.txt $PWD/results/reports/CORO$2.txt $PWD/results/reports/HT$2-$3.txt $PWD/results/graphs/
        fi
      elif [ $2 == "3" ] && ! [ -z $3 ]
      then
        if [ $4 == "pass" ] && [ -f "$PWD/results/reports/pass$2-annotated.txt" ]
        then
          python3 compareResults.py $PWD/results/reports/$2.txt $PWD/results/reports/CORO$2.txt $PWD/results/reports/pass$2-annotated.txt $PWD/results/reports/pass$2-heuristic.txt $PWD/results/reports/Ba3-$3.txt $PWD/results/graphs/
        else
          python3 compareResults.py $PWD/results/reports/$2.txt $PWD/results/reports/CORO$2.txt $PWD/results/reports/Ba3-$3.txt $PWD/results/graphs/
        fi
      else
        python3 compareResults.py $PWD/results/reports/$2.txt $PWD/results/reports/CORO$2.txt $PWD/results/graphs/
      fi
    elif ! [ -z $3 ] && [ -d "$PWD/results/HT$2-$3/" ]
    then
      python3 compareResults.py $PWD/results/reports/$2.txt $PWD/results/reports/HT$2-$3.txt $PWD/results/graphs
    else
      echo "Nothing to compare for benchmark$2, only $PWD/results/$2/ exists"
    fi
  fi
else
  if ! [ -d "$PWD/results/graphs/" ]
  then
    mkdir graphs
  fi
  cd ..
  python3 parseReport.py $PWD/results/reports/$1.txt $PWD/results/graphs/
fi
