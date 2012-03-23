#Minimum version of CMake to build this project
cmake_minimum_required(VERSION 2.6)

# Declaration et nommage du projet
project(parser)

set(CXX "g++")
set(CMAKE_CXX_FLAGS_DEBUG "-Wall -W -Werror -pedantic -g")
set(CMAKE_CXX_FLAGS "-Wall -W -Werror -pedantic")

#Defines subdirectory
add_subdirectory(src/)
