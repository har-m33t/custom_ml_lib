function(cml_apply_warnings target)
    if(CMAKE_CXX_COMPILER_ID MATCHES "GNU|Clang")
        set(warnings
            -Wall
            -Wextra
            -Wpedantic
            -Wshadow
            -Wconversion
            -Wsign-conversion
            -Wnon-virtual-dtor
            -Wold-style-cast
            -Wnull-dereference
        )
        if(CML_WARNINGS_AS_ERRORS)
            list(APPEND warnings -Werror)
        endif()
    elseif(MSVC)
        set(warnings /W4 /permissive-)
        if(CML_WARNINGS_AS_ERRORS)
            list(APPEND warnings /WX)
        endif()
    endif()

    # Only apply to C++ sources (not CUDA, which uses nvcc flags)
    target_compile_options(${target} PRIVATE $<$<COMPILE_LANGUAGE:CXX>:${warnings}>)
endfunction()