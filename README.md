Standalong JIT build
====================

This is repository for testing how build

```
export CORECLR_ROOT=~/runtimelab/
cp ${CORECLR_ROOT}src/coreclr/jit . -rf
cp ${CORECLR_ROOT}src/coreclr/inc . -rf
cp ${CORECLR_ROOT}src/native/common/* inc/ -rf
cp ${CORECLR_ROOT}src/coreclr/pal . -rf
cp ${CORECLR_ROOT}src/coreclr/scripts . -rf
cp ${CORECLR_ROOT}eng . -rf
cp ${CORECLR_ROOT}src/coreclr/*.cmake . -rf
mkdir -p vm
cp ${CORECLR_ROOT}src/coreclr/vm/ClrEtwAll.man vm/ -rf
```

or 
```
.\prepare.ps1 -CoreClrRoot c:\runtime\
```

Go to `jit/CMakeLists.txt` and comment line `add_subdirectory(static)`. Now start building

```
cmake -B build -DCMAKE_BUILD_TYPE=Debug -DCLR_CMAKE_HOST_ARCH=x64 -DCMAKE_SYSTEM_VERSION=10.0 -DCMAKE_INSTALL_PREFIX=bin -DFEATURE_EVENT_TRACE=OFF
cmake --build build
```

On Linux I was adding `-DCMAKE_CXX_COMPILER_ID=clang -DCMAKE_C_COMPILER_ID=clang -G Ninja`, but dit not progress with that.