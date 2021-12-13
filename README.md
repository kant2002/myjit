Standalong JIT build
====================

This is repository for testing how build

```
export CORECLR_ROOT=~/runtime/
cp ${CORECLR_ROOT}src/coreclr/jit . -rf
cp ${CORECLR_ROOT}src/coreclr/inc . -rf
mkdir -p gc/env
cp ${CORECLR_ROOT}src/coreclr/gc/env/etmdummy.h gc/env/
mkdir -p native
cp ${CORECLR_ROOT}src/native/* native/ -rf
cp ${CORECLR_ROOT}src/coreclr/gcinfo . -rf
cp ${CORECLR_ROOT}src/coreclr/gcdump . -rf
cp ${CORECLR_ROOT}src/coreclr/pal . -rf
cp ${CORECLR_ROOT}src/coreclr/palrt . -rf
cp ${CORECLR_ROOT}src/coreclr/debug . -rf
cp ${CORECLR_ROOT}src/coreclr/scripts . -rf
cp ${CORECLR_ROOT}src/coreclr/nativeresources . -rf
cp ${CORECLR_ROOT}src/coreclr/utilcode . -rf
cp ${CORECLR_ROOT}src/coreclr/md . -rf
cp ${CORECLR_ROOT}src/coreclr/minipal . -rf
cp ${CORECLR_ROOT}eng . -rf
cp ${CORECLR_ROOT}src/coreclr/*.cmake . -rf
mkdir -p dlls
cp ${CORECLR_ROOT}src/coreclr/dlls/mscorrc dlls/ -rf
mkdir -p vm
cp ${CORECLR_ROOT}src/coreclr/vm/ClrEtwAll.man vm/ -rf
mkdir -p build/
echo "static char sccsid[] __attribute__((used)) = \"@(#)Version 42.42.42.42424\";" > artifacts/obj/_version.c
cat <<EOF > build/runtime_version.h
#define RuntimeAssemblyMajorVersion 7
#define RuntimeAssemblyMinorVersion 0

#define RuntimeFileMajorVersion 42
#define RuntimeFileMinorVersion 42
#define RuntimeFileBuildVersion 42
#define RuntimeFileRevisionVersion 42424

#define RuntimeProductMajorVersion 7
#define RuntimeProductMinorVersion 0
#define RuntimeProductPatchVersion 0

#define RuntimeProductVersion 7.0.0-dev
EOF
```

or 
```
.\prepare.ps1 -CoreClrRoot c:\runtime\
```

Go to `jit/CMakeLists.txt` and comment line `add_subdirectory(static)`. 
Go to `pal/CMakeLists.txt` and comment line `add_subdirectory(tests)`. 
Now start building

```
cmake -B build -DCMAKE_BUILD_TYPE=Debug -DCLR_CMAKE_HOST_ARCH=x64 -DCMAKE_SYSTEM_VERSION=10.0 -DCMAKE_INSTALL_PREFIX=bin -DFEATURE_EVENT_TRACE=OFF
cmake --build build
cmake --install build --prefix artifacts
```

On Linux I was adding `-DCMAKE_CXX_COMPILER_ID=clang -DCMAKE_C_COMPILER_ID=clang -G Ninja`, but dit not progress with that.

Cleanup
```
rm -rf {native,inc,eng,scripts,jit,debug,dlls,gc,gcdump,gcinfo,md,minipal,nativeresources,pal,palrt,utilcode,vm}
```