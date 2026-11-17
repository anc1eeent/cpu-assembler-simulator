# Runs the assembler on one test program and checks the result.
#
# Required variables: ASSEMBLER, INPUT, OUTPUT
# Valid program:  EXPECTED=<file.mc>  -> exit code 0 and output equal to EXPECTED
# Broken program: ERROR=<file.err>    -> exit code 1, the expected message on stderr
#                                        and no output file

get_filename_component(output_dir "${OUTPUT}" DIRECTORY)
file(MAKE_DIRECTORY "${output_dir}")
file(REMOVE "${OUTPUT}")

execute_process(
    COMMAND "${ASSEMBLER}" "${INPUT}" "${OUTPUT}"
    RESULT_VARIABLE exit_code
    OUTPUT_VARIABLE stdout
    ERROR_VARIABLE stderr
)

if(DEFINED EXPECTED)
    if(NOT exit_code EQUAL 0)
        message(FATAL_ERROR "assembler failed with exit code ${exit_code}:\n${stderr}")
    endif()
    execute_process(
        COMMAND "${CMAKE_COMMAND}" -E compare_files --ignore-eol "${OUTPUT}" "${EXPECTED}"
        RESULT_VARIABLE diff
    )
    if(NOT diff EQUAL 0)
        message(FATAL_ERROR "machine code in ${OUTPUT} differs from ${EXPECTED}")
    endif()
elseif(DEFINED ERROR)
    if(NOT exit_code EQUAL 1)
        message(FATAL_ERROR "expected exit code 1, got ${exit_code}")
    endif()
    file(READ "${ERROR}" expected_message)
    string(STRIP "${expected_message}" expected_message)
    string(FIND "${stderr}" "${expected_message}" position)
    if(position EQUAL -1)
        message(FATAL_ERROR "expected error:\n  ${expected_message}\ngot:\n  ${stderr}")
    endif()
    if(EXISTS "${OUTPUT}")
        message(FATAL_ERROR "output file must not be created when the program has errors")
    endif()
else()
    message(FATAL_ERROR "either EXPECTED or ERROR must be set")
endif()
