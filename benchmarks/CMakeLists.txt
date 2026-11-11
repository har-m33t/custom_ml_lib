include(FetchContent)

FetchContent_Declare(
    benchmark
    GIT_REPOSITORY https://github.com/google/benchmark.git
    GIT_TAG        v1.9.1
    GIT_SHALLOW    TRUE
)
set(BENCHMARK_ENABLE_TESTING        OFF CACHE BOOL "" FORCE)
set(BENCHMARK_ENABLE_GTEST_TESTS    OFF CACHE BOOL "" FORCE)
set(BENCHMARK_ENABLE_INSTALL        OFF CACHE BOOL "" FORCE)
FetchContent_MakeAvailable(benchmark)

add_executable(cml_benchmarks
    bench_smoke.cpp
)

target_link_libraries(cml_benchmarks
    PRIVATE
        custom_ml_lib::custom_ml_lib
        benchmark::benchmark_main
)

cml_apply_warnings(cml_benchmarks)

if(NOT CMAKE_BUILD_TYPE STREQUAL "Release")
    message(WARNING "Benchmarks built in ${CMAKE_BUILD_TYPE} mode - use the 'release' preset for real numbers.")
endif()