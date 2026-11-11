cmake_minimum_required(VERSION 3.24)

project(custom_ml_lib
    VERSION 0.0.1
    DESCRIPTION "A from-scratch ML runtime in C++/CUDA"
    LANGUAGES CXX
)

# ---------------------------------------------------------------------------
# Global settings
# ---------------------------------------------------------------------------
set(CMAKE_CXX_STANDARD 20)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_CXX_EXTENSIONS OFF)
set(CMAKE_EXPORT_COMPILE_COMMANDS ON)   # for clangd / editor autocomplete

if(NOT CMAKE_BUILD_TYPE AND NOT CMAKE_CONFIGURATION_TYPES)
    set(CMAKE_BUILD_TYPE Debug CACHE STRING "Build type" FORCE)
endif()

# ---------------------------------------------------------------------------
# Options
# ---------------------------------------------------------------------------
option(CML_ENABLE_CUDA        "Build the CUDA backend"           OFF)
option(CML_BUILD_TESTS        "Build unit tests"                 ON)
option(CML_BUILD_BENCHMARKS   "Build benchmarks"                 ON)
option(CML_ENABLE_SANITIZERS  "Build with ASan + UBSan"          OFF)
option(CML_WARNINGS_AS_ERRORS "Treat compiler warnings as errors" OFF)

list(APPEND CMAKE_MODULE_PATH "${CMAKE_CURRENT_SOURCE_DIR}/cmake")
include(CompilerWarnings)
include(Sanitizers)

if(CML_ENABLE_CUDA)
    enable_language(CUDA)
    set(CMAKE_CUDA_STANDARD 17)
    set(CMAKE_CUDA_STANDARD_REQUIRED ON)
endif()

# ---------------------------------------------------------------------------
# Library
# ---------------------------------------------------------------------------
add_library(custom_ml_lib
    src/version.cpp
)
add_library(custom_ml_lib::custom_ml_lib ALIAS custom_ml_lib)

target_include_directories(custom_ml_lib
    PUBLIC
        $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/include>
)

cml_apply_warnings(custom_ml_lib)
cml_apply_sanitizers(custom_ml_lib)

# ---------------------------------------------------------------------------
# Subprojects
# ---------------------------------------------------------------------------
if(CML_BUILD_TESTS)
    enable_testing()
    add_subdirectory(tests)
endif()

if(CML_BUILD_BENCHMARKS)
    add_subdirectory(benchmarks)
endif()