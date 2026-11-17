cmake_minimum_required(VERSION 3.16)
project(cpu_assembler_simulator CXX)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

if(MSVC)
    add_compile_options(/W4 /utf-8)
else()
    add_compile_options(-Wall -Wextra -pedantic)
endif()

add_executable(assemble src/assembler/main.cpp)

# ---------------------------------------------------------------- tests
# Run with: ctest --test-dir build -C Debug
enable_testing()

set(ASM_TEST_SCRIPT ${CMAKE_SOURCE_DIR}/tests/run_assembler_test.cmake)
set(ASM_TEST_OUTPUT ${CMAKE_BINARY_DIR}/test-output)

# Valid programs: tests/assembler/valid/<name>.as must assemble into <name>.mc
file(GLOB ASM_VALID_TESTS CONFIGURE_DEPENDS ${CMAKE_SOURCE_DIR}/tests/assembler/valid/*.as)
foreach(source ${ASM_VALID_TESTS})
    get_filename_component(name ${source} NAME_WE)
    get_filename_component(dir ${source} DIRECTORY)
    add_test(NAME assembler.valid.${name}
        COMMAND ${CMAKE_COMMAND}
            -DASSEMBLER=$<TARGET_FILE:assemble>
            -DINPUT=${source}
            -DEXPECTED=${dir}/${name}.mc
            -DOUTPUT=${ASM_TEST_OUTPUT}/valid/${name}.mc
            -P ${ASM_TEST_SCRIPT})
endforeach()

# Broken programs: tests/assembler/errors/<name>.as must fail with the message from <name>.err
file(GLOB ASM_ERROR_TESTS CONFIGURE_DEPENDS ${CMAKE_SOURCE_DIR}/tests/assembler/errors/*.as)
foreach(source ${ASM_ERROR_TESTS})
    get_filename_component(name ${source} NAME_WE)
    get_filename_component(dir ${source} DIRECTORY)
    add_test(NAME assembler.errors.${name}
        COMMAND ${CMAKE_COMMAND}
            -DASSEMBLER=$<TARGET_FILE:assemble>
            -DINPUT=${source}
            -DERROR=${dir}/${name}.err
            -DOUTPUT=${ASM_TEST_OUTPUT}/errors/${name}.mc
            -P ${ASM_TEST_SCRIPT})
endforeach()

# Example program from the coursework guidelines
add_test(NAME assembler.example.count5
    COMMAND ${CMAKE_COMMAND}
        -DASSEMBLER=$<TARGET_FILE:assemble>
        -DINPUT=${CMAKE_SOURCE_DIR}/tests/examples/count5.as
        -DEXPECTED=${CMAKE_SOURCE_DIR}/tests/examples/count5.mc
        -DOUTPUT=${ASM_TEST_OUTPUT}/examples/count5.mc
        -P ${ASM_TEST_SCRIPT})
