param (
    [string]$CoreClrRoot
)
Copy-Item ${CoreClrRoot}src/coreclr/jit . -Recurse -Force
Copy-Item ${CoreClrRoot}src/coreclr/inc . -Recurse -Force
Copy-Item ${CoreClrRoot}src/coreclr/pal . -Recurse -Force
Copy-Item ${CoreClrRoot}eng . -Recurse -Force
Copy-Item ${CoreClrRoot}src/coreclr/*.cmake . -Recurse -Force
