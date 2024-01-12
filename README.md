# M1 Internship

## Author
Gabriel Dehame

## Content
This repository contians the files necessary to reproduce the results of the internship report.
- Directory `Benchmarks/` contains subdirectories for distinct benchmark suites.
- `Benchmarks/benchmarks/` contains the main benchmarks, the industry ones called benchmark1, benchmark2 and benchmark3
- `Benchmarks/olden-master/` contains the benchmarks taken from the Olden benchmark suite
- `dynamicStructurePrefetchingPass/` is the directory used to build the LLVM pass
- `libDynamicStructurePrefetchingPass.so` is the shared library to load in `opt` to use the LLVM pass
- `Gabriel_M1_Internship.pdf` is the internship report I submitted to the jury.

## Dependencies
The dependencies for this repository are the following:
- LLVM toolchain to use the pass, `clang`, `opt`, we used LLVM 16.0.0
- vTune 2023.1.0 to generate profiling measurements the same way we did. This only works on x86 architectures.
- Makefile and CMake
- Python3 to generate the graphs and time measurements.
