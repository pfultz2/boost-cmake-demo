
cmake_minimum_required(VERSION 3.5)
project(boost_system)
include(CMakePackageConfigHelpers)

find_package(boost_assert)
find_package(boost_config)
find_package(boost_core)
find_package(boost_predef)

add_library(boost_system src/error_code.cpp)
add_library(boost::system ALIAS boost_system)
set_property(TARGET boost_system PROPERTY EXPORT_NAME system)

target_include_directories(boost_system PUBLIC
  $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/include>
)

target_link_libraries(boost_system boost::assert)
target_link_libraries(boost_system boost::config)
target_link_libraries(boost_system boost::core)
target_link_libraries(boost_system boost::predef)

install(DIRECTORY include/ DESTINATION include)

install(TARGETS boost_system EXPORT boost_system-targets
    RUNTIME DESTINATION bin
    LIBRARY DESTINATION lib
    ARCHIVE DESTINATION lib
    INCLUDES DESTINATION include
)

install(EXPORT boost_system-targets
  FILE boost_system-targets.cmake
  NAMESPACE boost::
  DESTINATION lib/cmake/boost_system
)

file(WRITE "${PROJECT_BINARY_DIR}/boost_system-config.cmake" "
include(CMakeFindDependencyMacro)

find_dependency(boost_assert)
find_dependency(boost_config)
find_dependency(boost_core)
find_dependency(boost_predef)

include(\"\${CMAKE_CURRENT_LIST_DIR}/boost_system-targets.cmake\")
")

write_basic_package_version_file("${PROJECT_BINARY_DIR}/boost_system-config-version.cmake"
  VERSION 1.64
  COMPATIBILITY AnyNewerVersion
  )

install(FILES
    "${PROJECT_BINARY_DIR}/boost_system-config.cmake"
    "${PROJECT_BINARY_DIR}/boost_system-config-version.cmake"
  DESTINATION lib/cmake/boost_system
)

