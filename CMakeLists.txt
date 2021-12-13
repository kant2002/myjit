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
set(CLR_DIR ${CMAKE_CURRENT_SOURCE_DIR})
set(VM_DIR ${CMAKE_CURRENT_SOURCE_DIR}/vm)
set(GENERATED_INCLUDE_DIR ${CMAKE_CURRENT_BINARY_DIR}/inc)
set(GENERATED_EVENTING_DIR ${CMAKE_CURRENT_BINARY_DIR}/Eventing)

set(CORECLR_SET_RPATH ON)

include(pgosupport.cmake)
set(CMAKE_INSTALL_DEFAULT_COMPONENT_NAME coreclr_misc)

add_component(alljits)
add_component(jit)
add_component(alljits)
#add_component(runtime)
add_component(coreclr_misc)
add_component(coreclr_misc)
add_dependencies(jit coreclr_misc)
add_dependencies(alljits coreclr_misc)

#add_definitions(-DPAL_STDCPP_COMPAT=1)

# Add Product Directories
#------------------------------
include_directories("native")

if(CLR_CMAKE_HOST_UNIX)
    add_subdirectory(pal)
endif(CLR_CMAKE_HOST_UNIX)

include(clrdefinitions.cmake)

add_subdirectory(pal/prebuilt/inc)
add_subdirectory(minipal)

include_directories("pal/prebuilt/inc")

if (CLR_CMAKE_HOST_UNIX)
  include_directories("pal/inc")
  include_directories("pal/inc/rt")
  include_directories("pal/src/safecrt")
endif (CLR_CMAKE_HOST_UNIX)

include_directories("inc")
include_directories("debug/inc")
include_directories("debug/inc/amd64")
include_directories("debug/inc/dump")
include_directories("md/inc")
include_directories("${GENERATED_INCLUDE_DIR}")
include_directories(${CMAKE_CURRENT_BINARY_DIR})
include_directories("minipal")

if(CLR_CMAKE_HOST_UNIX)
  include_directories("pal/inc/rt/cpp")
 
  set (NATIVE_RESOURCE_DIR ${CMAKE_CURRENT_SOURCE_DIR}/nativeresources)
  include_directories(${NATIVE_RESOURCE_DIR})
  set (PROCESS_RC_SCRIPT ${NATIVE_RESOURCE_DIR}/processrc.sh)
  set (RESOURCE_STRING_HEADER_DIR ${NATIVE_RESOURCE_DIR})

  # Create a command to create a C++ source file containing an array of
  # NativeStringResource structs which represent the information from a
  # given Windows .rc file. The target C++ file path is returned in the
  # variable specified by the TARGET_FILE parameter.
  function(build_resources SOURCE TARGET_NAME TARGET_FILE)

    set(PREPROCESSED_SOURCE ${CMAKE_CURRENT_BINARY_DIR}/${TARGET_NAME}.rc.i)

    preprocess_file(${SOURCE} ${PREPROCESSED_SOURCE})

    set(RESOURCE_ENTRY_ARRAY_CPP ${CMAKE_CURRENT_BINARY_DIR}/${TARGET_NAME}.cpp)

    add_custom_command(
      OUTPUT ${RESOURCE_ENTRY_ARRAY_CPP}
      # Convert the preprocessed .rc file to a C++ file which will be used to make a static lib.
      COMMAND ${PROCESS_RC_SCRIPT} ${PREPROCESSED_SOURCE} ${TARGET_NAME} >${RESOURCE_ENTRY_ARRAY_CPP}
            DEPENDS ${PREPROCESSED_SOURCE} ${PROCESS_RC_SCRIPT}
    )

    include_directories(${RESOURCE_STRING_HEADER_DIR})
    set(${TARGET_FILE} ${RESOURCE_ENTRY_ARRAY_CPP} PARENT_SCOPE)

  endfunction()

endif (CLR_CMAKE_HOST_UNIX)

set(GENERATED_INCLUDE_DIR ${CMAKE_CURRENT_BINARY_DIR}/inc)
set(COREPAL_SOURCE_DIR ${CMAKE_CURRENT_SOURCE_DIR}/pal)


# Have issues with MIDL when uncomment this line.
#add_subdirectory(inc)

add_subdirectory(palrt)
add_subdirectory(md)
#add_subdirectory(debug)
add_subdirectory(utilcode)
add_subdirectory(dlls/mscorrc)
add_subdirectory(nativeresources)
add_subdirectory(jit)

