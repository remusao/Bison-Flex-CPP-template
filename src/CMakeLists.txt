# Add subdirectories

add_subdirectory(parse)

# Add the binary and sources
add_executable(
  parser
  main.cc
)

target_link_libraries(parser parse)
set_target_properties(parser PROPERTIES RUNTIME_OUTPUT_DIRECTORY "../..")
