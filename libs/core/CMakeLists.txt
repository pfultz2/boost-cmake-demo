
cmake_minimum_required(VERSION 3.5)
project(boost_core)
include(CMakePackageConfigHelpers)
set(DEPS assert config)

foreach(dep ${DEPS})
find_package(boost_${dep})
endforeach()

add_library(boost_core INTERFACE)
add_library(boost::core ALIAS boost_core)
set_property(TARGET boost_core PROPERTY EXPORT_NAME core)

target_include_directories(boost_core INTERFACE
  $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/include>
)

foreach(dep ${DEPS})
target_link_libraries(boost_core INTERFACE boost::${dep})
endforeach()

install(DIRECTORY include/ DESTINATION include)

install(TARGETS boost_core EXPORT boost_core-targets
    RUNTIME DESTINATION bin
    LIBRARY DESTINATION lib
    ARCHIVE DESTINATION lib
    INCLUDES DESTINATION include
)

install(EXPORT boost_core-targets
  FILE boost_core-targets.cmake
  NAMESPACE boost::
  DESTINATION lib/cmake/boost_core
)

file(WRITE "${PROJECT_BINARY_DIR}/boost_core-config.cmake" "
include(CMakeFindDependencyMacro)

foreach(dep ${DEPS})
find_dependency(boost_\${dep})
endforeach()

include(\"\${CMAKE_CURRENT_LIST_DIR}/boost_core-targets.cmake\")
")

write_basic_package_version_file("${PROJECT_BINARY_DIR}/boost_core-config-version.cmake"
  VERSION 1.64
  COMPATIBILITY AnyNewerVersion
  )

install(FILES
    "${PROJECT_BINARY_DIR}/boost_core-config.cmake"
    "${PROJECT_BINARY_DIR}/boost_core-config-version.cmake"
  DESTINATION lib/cmake/boost_core
)

