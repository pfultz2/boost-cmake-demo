
cmake_minimum_required(VERSION 3.5)
project(boost_type_traits)

find_package(BCM)
include(BCMDeploy)
include(BCMSetupVersion)

find_package(boost_config)
find_package(boost_core)
find_package(boost_static_assert)

bcm_setup_version(VERSION 1.64)

add_library(boost_type_traits INTERFACE)
target_link_libraries(boost_type_traits INTERFACE boost::config boost::core boost::static_assert)

set_property(TARGET boost_type_traits PROPERTY EXPORT_NAME type_traits)
bcm_deploy(TARGETS boost_type_traits INCLUDE include NAMESPACE boost::)

add_subdirectory(test)
