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
include CMakeFiles/HT_DP.dir/depend.make
# Include any dependencies generated by the compiler for this target.
include CMakeFiles/HT_DP.dir/compiler_depend.make

# Include the progress variables for this target.
include CMakeFiles/HT_DP.dir/progress.make

# Include the compile flags for this target's objects.
include CMakeFiles/HT_DP.dir/flags.make

CMakeFiles/HT_DP.dir/ht.c.o: CMakeFiles/HT_DP.dir/flags.make
CMakeFiles/HT_DP.dir/ht.c.o: ht.c
CMakeFiles/HT_DP.dir/ht.c.o: CMakeFiles/HT_DP.dir/compiler_depend.ts
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/home/jab/M1/Internship/Benchmarks/benchmarks/CMakeFiles --progress-num=$(CMAKE_PROGRESS_1) "Building C object CMakeFiles/HT_DP.dir/ht.c.o"
	/usr/bin/gcc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -MD -MT CMakeFiles/HT_DP.dir/ht.c.o -MF CMakeFiles/HT_DP.dir/ht.c.o.d -o CMakeFiles/HT_DP.dir/ht.c.o -c /home/jab/M1/Internship/Benchmarks/benchmarks/ht.c

CMakeFiles/HT_DP.dir/ht.c.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing C source to CMakeFiles/HT_DP.dir/ht.c.i"
	/usr/bin/gcc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -E /home/jab/M1/Internship/Benchmarks/benchmarks/ht.c > CMakeFiles/HT_DP.dir/ht.c.i

CMakeFiles/HT_DP.dir/ht.c.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling C source to assembly CMakeFiles/HT_DP.dir/ht.c.s"
	/usr/bin/gcc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -S /home/jab/M1/Internship/Benchmarks/benchmarks/ht.c -o CMakeFiles/HT_DP.dir/ht.c.s

# Object files for target HT_DP
HT_DP_OBJECTS = \
"CMakeFiles/HT_DP.dir/ht.c.o"

# External object files for target HT_DP
HT_DP_EXTERNAL_OBJECTS =

HT_DP: CMakeFiles/HT_DP.dir/ht.c.o
HT_DP: CMakeFiles/HT_DP.dir/build.make
HT_DP: CMakeFiles/HT_DP.dir/link.txt
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --bold --progress-dir=/home/jab/M1/Internship/Benchmarks/benchmarks/CMakeFiles --progress-num=$(CMAKE_PROGRESS_2) "Linking C executable HT_DP"
	$(CMAKE_COMMAND) -E cmake_link_script CMakeFiles/HT_DP.dir/link.txt --verbose=$(VERBOSE)

# Rule to build all files generated by this target.
CMakeFiles/HT_DP.dir/build: HT_DP
.PHONY : CMakeFiles/HT_DP.dir/build

CMakeFiles/HT_DP.dir/clean:
	$(CMAKE_COMMAND) -P CMakeFiles/HT_DP.dir/cmake_clean.cmake
.PHONY : CMakeFiles/HT_DP.dir/clean

CMakeFiles/HT_DP.dir/depend:
	cd /home/jab/M1/Internship/Benchmarks/benchmarks && $(CMAKE_COMMAND) -E cmake_depends "Unix Makefiles" /home/jab/M1/Internship/Benchmarks/benchmarks /home/jab/M1/Internship/Benchmarks/benchmarks /home/jab/M1/Internship/Benchmarks/benchmarks /home/jab/M1/Internship/Benchmarks/benchmarks /home/jab/M1/Internship/Benchmarks/benchmarks/CMakeFiles/HT_DP.dir/DependInfo.cmake --color=$(COLOR)
.PHONY : CMakeFiles/HT_DP.dir/depend
