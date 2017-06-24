
cmake_minimum_required(VERSION 3.5)
project(boost_core)

find_package(BCM)
include(BCMPackage)
include(CMakePackageConfigHelpers)

bcm_boost_package(core
  VERSION 1.64
  DEPENDS
    assert
    config
)
