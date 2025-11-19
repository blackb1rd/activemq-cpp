# Build the decaf utility library

file(GLOB_RECURSE DECAF_SOURCES
  ${CMAKE_CURRENT_SOURCE_DIR}/*.c
  ${CMAKE_CURRENT_SOURCE_DIR}/*.cc
  ${CMAKE_CURRENT_SOURCE_DIR}/*.cpp
  ${CMAKE_CURRENT_SOURCE_DIR}/*.cxx
)

# Exclude test directories if any
list(FILTER DECAF_SOURCES EXCLUDE REGEX ".*/test/.*|.*/tests?/.*")

if(AMQCPP_SHARED_LIB)
  add_library(decaf SHARED ${DECAF_SOURCES})
else()
  add_library(decaf STATIC ${DECAF_SOURCES})
endif()

target_include_directories(decaf
  PUBLIC
    ${CMAKE_CURRENT_SOURCE_DIR}
    ${CMAKE_SOURCE_DIR}/src/main
)

find_package(OpenSSL QUIET)
if(OpenSSL_FOUND)
  target_compile_definitions(decaf PUBLIC HAVE_OPENSSL)
  target_link_libraries(decaf PUBLIC OpenSSL::SSL OpenSSL::Crypto)
endif()

set_target_properties(decaf PROPERTIES
  POSITION_INDEPENDENT_CODE ON
)

# Windows-specific settings
if(WIN32)
  # Ensure symbols are exported when building shared libs on Windows
  if(AMQCPP_SHARED_LIB)
    set_target_properties(decaf PROPERTIES WINDOWS_EXPORT_ALL_SYMBOLS ON)
  endif()
  target_link_libraries(decaf PRIVATE ws2_32)
  target_compile_definitions(decaf PRIVATE _WIN32_WINNT=0x0601)
endif()
