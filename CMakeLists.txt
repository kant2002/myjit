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

include(clrdefinitions.cmake)
include(pgosupport.cmake)


set(GENERATED_INCLUDE_DIR ${CMAKE_CURRENT_BINARY_DIR}/inc)

add_component(jit)
add_component(alljits)

add_subdirectory(jit)

