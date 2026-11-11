include(FetchContent)

FetchContent_Declare(
    googletest
    GIT_REPOSITORY https://github.com/google/googletest.git
    GIT_TAG        v1.15.2
    GIT_SHALLOW    TRUE
)
set(INSTALL_GTEST OFF CACHE BOOL "" FORCE)
set(gtest_force_shared_crt ON CACHE BOOL "" FORCE)   # Windows/MSVC
FetchContent_MakeAvailable(googletest)

add_executable(cml_tests
    test_smoke.cpp
)

target_link_libraries(cml_tests
    PRIVATE
        custom_ml_lib::custom_ml_lib
        GTest::gtest_main
)

cml_apply_warnings(cml_tests)

include(GoogleTest)
gtest_discover_tests(cml_tests)