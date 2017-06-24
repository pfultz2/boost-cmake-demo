include(CMakeParseArguments)
include(GNUInstallDirs)

function(bcm_boost_package PACKAGE)
    set(options)
    set(oneValueArgs VERSION VERSION_HEADER)
    set(multiValueArgs SOURCES DEPENDS)

    cmake_parse_arguments(PARSE "${options}" "${oneValueArgs}" "${multiValueArgs}" ${ARGN})

    if(PARSE_SOURCES)
        add_library(boost_${PACKAGE} ${PARSE_SOURCES})
        target_include_directories(boost_${PACKAGE} PUBLIC 
            $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/include>
        )
    else()
        add_library(boost_${PACKAGE} INTERFACE)
        target_include_directories(boost_${PACKAGE} INTERFACE 
            $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/include>
        )
    endif()
    add_library(boost::${PACKAGE} ALIAS boost_${PACKAGE})
    set_property(TARGET boost_${PACKAGE} PROPERTY EXPORT_NAME ${PACKAGE})



    set(DEPENDS_PACKAGES)

    foreach(PACKAGE ${_bcm_public_packages})
        list(APPEND DEPENDS_PACKAGES PACKAGE ${PACKAGE})
    endforeach()

    foreach(DEPEND ${PARSE_DEPENDS})
        find_package(boost_${DEPEND} REQUIRED)
        if(PARSE_SOURCES)
            target_link_libraries(boost_${PACKAGE} boost::${DEPEND})
        else()
            target_link_libraries(boost_${PACKAGE} INTERFACE boost::${DEPEND})
        endif()
    endforeach()

    install(DIRECTORY include/ DESTINATION include)

    install(TARGETS boost_${PACKAGE} EXPORT boost_${PACKAGE}-targets
        RUNTIME DESTINATION bin
        LIBRARY DESTINATION lib
        ARCHIVE DESTINATION lib
        INCLUDES DESTINATION include
    )

    install(EXPORT boost_${PACKAGE}-targets
      FILE boost_${PACKAGE}-targets.cmake
      NAMESPACE boost::
      DESTINATION lib/cmake/boost_${PACKAGE}
    )


file(WRITE "${PROJECT_BINARY_DIR}/boost_${PACKAGE}-config.cmake" "
include(CMakeFindDependencyMacro)
foreach(dep ${PARSE_DEPENDS})
find_dependency(boost_\${dep})
endforeach()
include(\"\${CMAKE_CURRENT_LIST_DIR}/boost_${PACKAGE}-targets.cmake\")
")

write_basic_package_version_file("${PROJECT_BINARY_DIR}/boost_${PACKAGE}-config-version.cmake"
  VERSION ${PARSE_VERSION}
  COMPATIBILITY AnyNewerVersion
  )

install(FILES
    "${PROJECT_BINARY_DIR}/boost_${PACKAGE}-config.cmake"
    "${PROJECT_BINARY_DIR}/boost_${PACKAGE}-config-version.cmake"
  DESTINATION lib/cmake/boost_${PACKAGE}
)

endfunction()
