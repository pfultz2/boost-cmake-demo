
cmake_minimum_required(VERSION 3.5)
project(boost_assert)
include(CMakePackageConfigHelpers)
set(DEPS config)

foreach(dep ${DEPS})
find_package(boost_${dep})
endforeach()

add_library(boost_assert INTERFACE)
add_library(boost::assert ALIAS boost_assert)
set_property(TARGET boost_assert PROPERTY EXPORT_NAME assert)

target_include_directories(boost_assert INTERFACE
  $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/include>
)

foreach(dep ${DEPS})
target_link_libraries(boost_assert INTERFACE boost::${dep})
endforeach()

install(DIRECTORY include/ DESTINATION include)

install(TARGETS boost_assert EXPORT boost_assert-targets
    RUNTIME DESTINATION bin
    LIBRARY DESTINATION lib
    ARCHIVE DESTINATION lib
    INCLUDES DESTINATION include
)

install(EXPORT boost_assert-targets
  FILE boost_assert-targets.cmake
  NAMESPACE boost::
  DESTINATION lib/cmake/boost_assert
)

file(WRITE "${PROJECT_BINARY_DIR}/boost_assert-config.cmake" "
include(CMakeFindDependencyMacro)

foreach(dep ${DEPS})
find_dependency(boost_\${dep})
endforeach()

include(\"\${CMAKE_CURRENT_LIST_DIR}/boost_assert-targets.cmake\")
")

write_basic_package_version_file("${PROJECT_BINARY_DIR}/boost_assert-config-version.cmake"
  VERSION 1.64
  COMPATIBILITY AnyNewerVersion
  )

install(FILES
    "${PROJECT_BINARY_DIR}/boost_assert-config.cmake"
    "${PROJECT_BINARY_DIR}/boost_assert-config-version.cmake"
  DESTINATION lib/cmake/boost_assert
)

