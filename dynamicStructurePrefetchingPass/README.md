# LLVMPass directory
This directory is used to build the LLVMPass.
To do such build, one can open a terminal in the directory and do the following commands:
`cd build`
`make`
Then the library to load in `opt` for the pass to be usable will be generated as `LLVMPass/build/src/libDynamicStructurePrefetchingPass.so`.
This library is also available in the repository's main directory.
The source code for the pass is available in `LLVMPass/src/dynamicStructurePrefetchingPass.cpp`