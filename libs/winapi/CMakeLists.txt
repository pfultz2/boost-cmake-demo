
cmake_minimum_required(VERSION 3.5)
project(boost_winapi)

find_package(BCM)
include(BCMPackage)
include(CMakePackageConfigHelpers)

bcm_boost_package(winapi
  VERSION 1.64
  DEPENDS
    config
    predef
)
