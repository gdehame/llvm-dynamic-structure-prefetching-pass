# Scripts usage
I cannot guarantee what the scripts will do for any other use than those described here.
Please verify that your usage of the scripts fits in one of the possibilities mentionned before executing the command.

## generateMeasurements
- if given no argument, will generate measurements for all 3 baselines as well as all 3 coroutines
- if given "pass" as argument and no second, it will generate the measurements for all 6 passes outputs
- if given "pass" as argument as well as a benchmark number [1,2,3] as second argument, it will generate the measurements for the 2 outputs of the pass for this benchmark
- if given a specific measurement (among [1,2,3,CORO1,CORO2,CORO3,HT1,HT2,Basic3]) will generate the corresponding measurement. Beware, for HT1, HT2 and Basic3, a chunk size / prefetch distance should be given as third argument.
- if given "timeAll" as well as I, J, K, in that order, with I the chunk size for HT1, J the one for HT2 and K the prefetch distance for Basic3, the script will generate the time measurements for each versions of each benchmarks (this takes approximately 1 hour)
- if given "timePass" as argument, it will generate the time measurements for all 6 outputs of the pass
- if given "time" as well as a command to measure in quote as second argument and the name of the benchmark to measure, the script will measure the average execution time of the given benchmark with the given command on 100 runs. Example of use: `bash generateMeasurements.sh time "./Ba3 20000 8" Ba3-8` (especially, it is important for HT1, HT2 and Ba3 to add the -N with N the chunk size or prefetch distance, not just HT1/HT2/Ba3 as third argument)

## generateGraphs
- if given no argument, will generate graphs for the 3 baselines
- if given the name of a report excluding its path and extension (ex for ./results/reports/1.txt give 1), will generate the graph for this report
- if given "compare" as first argument then a second one must be given, and should be the benchmark number N (example N=1 for benchmark1), and it will generate the comparison graph for benchmark n°N. If a third argument is passed, it'll be taken as the prefetch distance for Basic3 or the chunk size for HT1/HT2, if not then these methods will not appear in the comparison graph.
- if given "time" as first argument but no second argument, it will generate execution time graphs for all 3 benchmarks. By default it takes 8 as chunk size for HT1, 60056 for HT2 and a prefetch distance of 16 for Basic3, but if you give three additional arguments for HT1, HT2, Basic3 in that order, they'll be used.
- if given "time" as first argument and "Basic3" as second then it will generation an execution time graph comparing all existing time measurements for Basic3 (distinct prefetch distance) and the baseline. Similar thing for "HT1" as second argument.
- if given "timePass" as first argument, it will generate the graphs to compare the execution times of the baseline, coroutine, pass with annotations, pass with heuristic for all 3 benchmarks

## Python scripts
These are meant to be used inside the bash scripts, you can still use them based on how they're used in the bash scripts.