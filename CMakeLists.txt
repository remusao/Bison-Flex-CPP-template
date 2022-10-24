#Minimum version of CMake to build this project
cmake_minimum_required(VERSION 2.8.12)

# Declaration et nommage du projet
project(parser)

set(CXX "clang++")
set(CMAKE_CXX_FLAGS_DEBUG "-Wall -W -Werror -pedantic -g")
set(CMAKE_CXX_FLAGS "-O3 -Wall -W -pedantic")

#Defines subdirectory
add_subdirectory(src/)
