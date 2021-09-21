Standalong JIT build
====================

This is repository for testing how build

```
export CORECLR_ROOT=~/runtimelab/
cp ${CORECLR_ROOT}src/coreclr/jit . -rf
cp ${CORECLR_ROOT}src/coreclr/inc . -rf
cp ${CORECLR_ROOT}eng . -rf
cp ${CORECLR_ROOT}src/coreclr/*.cmake . -rf
```

Go to `jit/CMakeLists.txt` and comment line `add_subdirectory(static)`. Not start build

```
cmake -B build -DCMAKE_BUILD_TYPE=Debug -DCMAKE_CXX_COMPILER_ID=clang -DCMAKE_C_COMPILER_ID=clang
cmake --build build
```