Standalong JIT build
====================

This is repository for testing how build

```
export CORECLR_ROOT=~/runtime/
./prepare.sh
```

or 
```
.\prepare.ps1 -CoreClrRoot c:\runtime\
```

Only on windows if patch command not applied.
Go to `jit/CMakeLists.txt` and comment line `add_subdirectory(static)`. 
Go to `pal/CMakeLists.txt` and comment line `add_subdirectory(tests)`. 
Now start building

```
cmake -B build -DCMAKE_BUILD_TYPE=Debug -DCLR_CMAKE_HOST_ARCH=x64 -DCMAKE_SYSTEM_VERSION=10.0 -DCMAKE_INSTALL_PREFIX=bin -DFEATURE_EVENT_TRACE=OFF
cmake --build build
cmake --install build --prefix artifacts
```

On Linux I was adding `-DCMAKE_CXX_COMPILER_ID=clang -DCMAKE_C_COMPILER_ID=clang -G Ninja`, but dit not progress with that.

On gentoo to use Clang
CC=/usr/lib/llvm/13/bin/clang CXX=/usr/lib/llvm/13/bin/clang cmake -B build -DCMAKE_BUILD_TYPE=Debug -DCLR_CMAKE_HOST_ARCH=x64 -DCMAKE_SYSTEM_VERSION=10.0 -DCMAKE_INSTALL_PREFIX=bin -DFEATURE_EVENT_TRACE=OFF

Cleanup
```
./clean.sh
```