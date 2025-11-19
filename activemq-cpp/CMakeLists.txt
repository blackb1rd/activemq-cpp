cmake_minimum_required(VERSION 3.15)
project(activemq-cpp LANGUAGES C CXX)

set(CMAKE_CXX_STANDARD 11)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

# Options
option(AMQCPP_BUILD_EXAMPLES "Build example programs" ON)
option(AMQCPP_BUILD_TESTS "Build tests" OFF)
option(AMQCPP_SHARED_LIB "Build shared library instead of static" OFF)

add_subdirectory(src)

if(AMQCPP_BUILD_EXAMPLES)
  if(EXISTS ${CMAKE_CURRENT_SOURCE_DIR}/src/examples)
    add_subdirectory(src/examples)
  endif()
endif()
