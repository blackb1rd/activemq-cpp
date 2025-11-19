# CMS layer library

file(GLOB_RECURSE CMS_SOURCES
  ${CMAKE_CURRENT_SOURCE_DIR}/*.c
  ${CMAKE_CURRENT_SOURCE_DIR}/*.cc
  ${CMAKE_CURRENT_SOURCE_DIR}/*.cpp
  ${CMAKE_CURRENT_SOURCE_DIR}/*.cxx
)

list(FILTER CMS_SOURCES EXCLUDE REGEX ".*/test/.*|.*/tests?/.*")

if(AMQCPP_SHARED_LIB)
  add_library(activemq_cms SHARED ${CMS_SOURCES})
else()
  add_library(activemq_cms STATIC ${CMS_SOURCES})
endif()

target_include_directories(activemq_cms
  PUBLIC
    ${CMAKE_CURRENT_SOURCE_DIR}
    ${CMAKE_SOURCE_DIR}/src/main
)

target_link_libraries(activemq_cms PUBLIC activemq_core decaf)

set_target_properties(activemq_cms PROPERTIES
  POSITION_INDEPENDENT_CODE ON
)

# Windows-specific settings
if(WIN32)
  if(AMQCPP_SHARED_LIB)
    set_target_properties(activemq_cms PROPERTIES WINDOWS_EXPORT_ALL_SYMBOLS ON)
  endif()
  target_link_libraries(activemq_cms PRIVATE ws2_32)
  target_compile_definitions(activemq_cms PRIVATE _WIN32_WINNT=0x0601)
endif()
