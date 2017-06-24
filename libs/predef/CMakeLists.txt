
cmake_minimum_required(VERSION 3.5)
project(boost_predef)

find_package(BCM)
include(BCMPackage)
include(CMakePackageConfigHelpers)

bcm_boost_package(predef
  VERSION 1.64
  DEPENDS
)
