
cmake_minimum_required(VERSION 3.5)
project(boost_config)

find_package(BCM)
include(BCMPackage)
include(CMakePackageConfigHelpers)

bcm_boost_package(config
  VERSION 1.64
  DEPENDS
)
