# CMAKE generated file: DO NOT EDIT!
# Generated by "Unix Makefiles" Generator, CMake Version 3.22

# Delete rule output on recipe failure.
.DELETE_ON_ERROR:

#=============================================================================
# Special targets provided by cmake.

# Disable implicit rules so canonical targets will work.
.SUFFIXES:

# Disable VCS-based implicit rules.
% : %,v

# Disable VCS-based implicit rules.
% : RCS/%

# Disable VCS-based implicit rules.
% : RCS/%,v

# Disable VCS-based implicit rules.
% : SCCS/s.%

# Disable VCS-based implicit rules.
% : s.%

.SUFFIXES: .hpux_make_needs_suffix_list

# Command-line flag to silence nested $(MAKE).
$(VERBOSE)MAKESILENT = -s

#Suppress display of executed commands.
$(VERBOSE).SILENT:

# A target that is always out of date.
cmake_force:
.PHONY : cmake_force

#=============================================================================
# Set environment variables for the build.

# The shell in which to execute make rules.
SHELL = /bin/sh

# The CMake executable.
CMAKE_COMMAND = /usr/bin/cmake

# The command to remove a file.
RM = /usr/bin/cmake -E rm -f

# Escaping for special characters.
EQUALS = =

# The top-level source directory on which CMake was run.
CMAKE_SOURCE_DIR = /home/jab/M1/Internship/Benchmarks/benchmarks

# The top-level build directory on which CMake was run.
CMAKE_BINARY_DIR = /home/jab/M1/Internship/Benchmarks/benchmarks

# Include any dependencies generated for this target.
include CMakeFiles/Benchmark_DP.dir/depend.make
# Include any dependencies generated by the compiler for this target.
include CMakeFiles/Benchmark_DP.dir/compiler_depend.make

# Include the progress variables for this target.
include CMakeFiles/Benchmark_DP.dir/progress.make

# Include the compile flags for this target's objects.
include CMakeFiles/Benchmark_DP.dir/flags.make

CMakeFiles/Benchmark_DP.dir/benchmarks.c.o: CMakeFiles/Benchmark_DP.dir/flags.make
CMakeFiles/Benchmark_DP.dir/benchmarks.c.o: benchmarks.c
CMakeFiles/Benchmark_DP.dir/benchmarks.c.o: CMakeFiles/Benchmark_DP.dir/compiler_depend.ts
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/home/jab/M1/Internship/Benchmarks/benchmarks/CMakeFiles --progress-num=$(CMAKE_PROGRESS_1) "Building C object CMakeFiles/Benchmark_DP.dir/benchmarks.c.o"
	/usr/bin/gcc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -MD -MT CMakeFiles/Benchmark_DP.dir/benchmarks.c.o -MF CMakeFiles/Benchmark_DP.dir/benchmarks.c.o.d -o CMakeFiles/Benchmark_DP.dir/benchmarks.c.o -c /home/jab/M1/Internship/Benchmarks/benchmarks/benchmarks.c

CMakeFiles/Benchmark_DP.dir/benchmarks.c.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing C source to CMakeFiles/Benchmark_DP.dir/benchmarks.c.i"
	/usr/bin/gcc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -E /home/jab/M1/Internship/Benchmarks/benchmarks/benchmarks.c > CMakeFiles/Benchmark_DP.dir/benchmarks.c.i

CMakeFiles/Benchmark_DP.dir/benchmarks.c.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling C source to assembly CMakeFiles/Benchmark_DP.dir/benchmarks.c.s"
	/usr/bin/gcc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -S /home/jab/M1/Internship/Benchmarks/benchmarks/benchmarks.c -o CMakeFiles/Benchmark_DP.dir/benchmarks.c.s

# Object files for target Benchmark_DP
Benchmark_DP_OBJECTS = \
"CMakeFiles/Benchmark_DP.dir/benchmarks.c.o"

# External object files for target Benchmark_DP
Benchmark_DP_EXTERNAL_OBJECTS =

Benchmark_DP: CMakeFiles/Benchmark_DP.dir/benchmarks.c.o
Benchmark_DP: CMakeFiles/Benchmark_DP.dir/build.make
Benchmark_DP: CMakeFiles/Benchmark_DP.dir/link.txt
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --bold --progress-dir=/home/jab/M1/Internship/Benchmarks/benchmarks/CMakeFiles --progress-num=$(CMAKE_PROGRESS_2) "Linking C executable Benchmark_DP"
	$(CMAKE_COMMAND) -E cmake_link_script CMakeFiles/Benchmark_DP.dir/link.txt --verbose=$(VERBOSE)

# Rule to build all files generated by this target.
CMakeFiles/Benchmark_DP.dir/build: Benchmark_DP
.PHONY : CMakeFiles/Benchmark_DP.dir/build

CMakeFiles/Benchmark_DP.dir/clean:
	$(CMAKE_COMMAND) -P CMakeFiles/Benchmark_DP.dir/cmake_clean.cmake
.PHONY : CMakeFiles/Benchmark_DP.dir/clean

CMakeFiles/Benchmark_DP.dir/depend:
	cd /home/jab/M1/Internship/Benchmarks/benchmarks && $(CMAKE_COMMAND) -E cmake_depends "Unix Makefiles" /home/jab/M1/Internship/Benchmarks/benchmarks /home/jab/M1/Internship/Benchmarks/benchmarks /home/jab/M1/Internship/Benchmarks/benchmarks /home/jab/M1/Internship/Benchmarks/benchmarks /home/jab/M1/Internship/Benchmarks/benchmarks/CMakeFiles/Benchmark_DP.dir/DependInfo.cmake --color=$(COLOR)
.PHONY : CMakeFiles/Benchmark_DP.dir/depend

