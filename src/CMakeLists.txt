# Add subdirectories

add_subdirectory(parse)

# Add the binary and sources
add_executable(
  ../../parser
  main.cc
)

target_link_libraries(../../parser parse)
