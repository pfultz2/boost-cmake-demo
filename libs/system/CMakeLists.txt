
cmake_minimum_required(VERSION 3.5)
project(boost_system)

find_package(BCM)
include(BCMPackage)
include(CMakePackageConfigHelpers)

bcm_boost_package(system
  VERSION 1.64
  SOURCES
    src/error_code.cpp
  DEPENDS
    assert
    config
    core
    predef
)
