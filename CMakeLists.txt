cmake_minimum_required(VERSION 3.16)
project(cpu_assembler_simulator CXX)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

add_executable(assemble src/assembler/main.cpp)