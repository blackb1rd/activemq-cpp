# Build simple examples found under src/examples

file(GLOB_RECURSE EXAMPLE_SRCS
  ${CMAKE_CURRENT_SOURCE_DIR}/*/*.cpp
  ${CMAKE_CURRENT_SOURCE_DIR}/*/*.cxx
  ${CMAKE_CURRENT_SOURCE_DIR}/*/*.cc
)

foreach(_src IN LISTS EXAMPLE_SRCS)
  get_filename_component(_name ${_src} NAME_WE)
  add_executable(example_${_name} ${_src})
  target_include_directories(example_${_name} PRIVATE ${CMAKE_SOURCE_DIR}/src/main)
  target_link_libraries(example_${_name} PRIVATE activemq_cms activemq_core decaf)
endforeach()
