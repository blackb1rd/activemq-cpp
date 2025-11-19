# Build tests under src/test

find_package(CppUnit QUIET)

file(GLOB_RECURSE TEST_SRCS
  ${CMAKE_CURRENT_SOURCE_DIR}/*.cpp
  ${CMAKE_CURRENT_SOURCE_DIR}/*.cxx
  ${CMAKE_CURRENT_SOURCE_DIR}/*.cc
)

foreach(_src IN LISTS TEST_SRCS)
  # skip main.cpp test harnesss at top-level that are run differently
  get_filename_component(_name ${_src} NAME)
  if(_name STREQUAL "main.cpp")
    continue()
  endif()
  get_filename_component(_base ${_src} NAME_WE)
  add_executable(test_${_base} ${_src})
  target_include_directories(test_${_base} PRIVATE ${CMAKE_SOURCE_DIR}/src/main)
  target_link_libraries(test_${_base} PRIVATE activemq_cms activemq_core decaf)
  if(CppUnit_FOUND)
    target_link_libraries(test_${_base} PRIVATE CppUnit::CppUnit)
  endif()
endforeach()
