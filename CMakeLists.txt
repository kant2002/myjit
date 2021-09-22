cmake_minimum_required(VERSION 3.6.2)

cmake_policy(SET CMP0042 NEW) # MACOSX_RPATH is enabled by default.

if (CMAKE_VERSION VERSION_GREATER 3.7 OR CMAKE_VERSION VERSION_EQUAL 3.7)
  cmake_policy(SET CMP0066 NEW) # Honor per-config flags in try_compile() source-file signature.
endif()
if (CMAKE_VERSION VERSION_GREATER 3.8 OR CMAKE_VERSION VERSION_EQUAL 3.8)
  cmake_policy(SET CMP0067 NEW) # Honor language standard in try_compile() source-file signature
endif()
if (CMAKE_VERSION VERSION_GREATER 3.15 OR CMAKE_VERSION VERSION_EQUAL 3.15)
  cmake_policy(SET CMP0091 NEW) # MSVC runtime library flags are selected by an abstraction.
endif()

project(MyJIT)

include(eng/native/configurepaths.cmake)
include(${CLR_ENG_NATIVE_DIR}/configurecompiler.cmake)

if(MSVC)
  set(CMAKE_CXX_STANDARD_LIBRARIES "") # do not link against standard win32 libs i.e. kernel32, uuid, user32, etc.
endif (MSVC)

# Set commonly used directory names
set(GENERATED_INCLUDE_DIR ${CMAKE_CURRENT_BINARY_DIR}/inc)

set(CORECLR_SET_RPATH ON)

include(clrdefinitions.cmake)
include(pgosupport.cmake)

add_subdirectory(pal/prebuilt/inc)

include_directories("pal/prebuilt/inc")

if (CLR_CMAKE_HOST_UNIX)
  include_directories("pal/inc")
  include_directories("pal/inc/rt")
  include_directories("pal/src/safecrt")
endif (CLR_CMAKE_HOST_UNIX)

# Add Product Directories
#------------------------------
include_directories("inc")
include_directories("${GENERATED_INCLUDE_DIR}")

set(GENERATED_INCLUDE_DIR ${CMAKE_CURRENT_BINARY_DIR}/inc)

add_component(jit)
add_component(alljits)

# Have issues with MIDL when uncomment this line.
#add_subdirectory(inc)

add_subdirectory(jit)

