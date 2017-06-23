
cmake_minimum_required(VERSION 3.5)
project(boost_system)
include(CMakePackageConfigHelpers)
set(DEPS assert config core predef)

foreach(dep ${DEPS})
find_package(boost_${dep})
endforeach()

add_library(boost_system src/error_code.cpp)
add_library(boost::system ALIAS boost_system)
set_property(TARGET boost_system PROPERTY EXPORT_NAME system)

target_include_directories(boost_system PUBLIC
  $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/include>
)

foreach(dep ${DEPS})
target_link_libraries(boost_system boost::${dep})
endforeach()

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

foreach(dep ${DEPS})
find_dependency(boost_\${dep})
endforeach()

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

