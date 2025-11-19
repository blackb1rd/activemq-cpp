# activemq core library

file(GLOB_RECURSE ACTIVEMQ_SOURCES
  ${CMAKE_CURRENT_SOURCE_DIR}/*.c
  ${CMAKE_CURRENT_SOURCE_DIR}/*.cc
  ${CMAKE_CURRENT_SOURCE_DIR}/*.cpp
  ${CMAKE_CURRENT_SOURCE_DIR}/*.cxx
)

list(FILTER ACTIVEMQ_SOURCES EXCLUDE REGEX ".*/test/.*|.*/tests?/.*")

if(AMQCPP_SHARED_LIB)
  add_library(activemq_core SHARED ${ACTIVEMQ_SOURCES})
else()
  add_library(activemq_core STATIC ${ACTIVEMQ_SOURCES})
endif()

target_include_directories(activemq_core
  PUBLIC
    ${CMAKE_CURRENT_SOURCE_DIR}
    ${CMAKE_SOURCE_DIR}/src/main
)

target_link_libraries(activemq_core PUBLIC decaf)

set_target_properties(activemq_core PROPERTIES
  POSITION_INDEPENDENT_CODE ON
)

# Windows-specific settings
if(WIN32)
  if(AMQCPP_SHARED_LIB)
    set_target_properties(activemq_core PROPERTIES WINDOWS_EXPORT_ALL_SYMBOLS ON)
  endif()
  target_link_libraries(activemq_core PRIVATE ws2_32)
  target_compile_definitions(activemq_core PRIVATE _WIN32_WINNT=0x0601)
endif()
