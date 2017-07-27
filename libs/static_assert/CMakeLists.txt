
cmake_minimum_required(VERSION 3.5)
project(boost_static_assert)

find_package(BCM)
include(BCMDeploy)
include(BCMSetupVersion)

find_package(boost_config)

bcm_setup_version(VERSION 1.64)

add_library(boost_static_assert INTERFACE)
set_property(TARGET boost_static_assert PROPERTY EXPORT_NAME static_assert)

target_link_libraries(boost_static_assert INTERFACE boost::config)

bcm_deploy(TARGETS boost_static_assert INCLUDE include NAMESPACE boost::)


include(BCMTest)

bcm_test_link_libraries(boost_static_assert)

bcm_test(NAME static_assert_test SOURCES static_assert_test.cpp)
# bcm_test(NAME static_assert_example_1 SOURCES static_assert_example_1.cpp)
# TODO: Need type traits
# bcm_test(NAME static_assert_example_2 SOURCES static_assert_example_2.cpp)
bcm_test(NAME static_assert_example_3 SOURCES static_assert_example_3.cpp)
bcm_test(NAME static_assert_test_fail_1 SOURCES static_assert_test_fail_1.cpp COMPILE_ONLY WILL_FAIL)
bcm_test(NAME static_assert_test_fail_2 SOURCES static_assert_test_fail_2.cpp COMPILE_ONLY WILL_FAIL)
bcm_test(NAME static_assert_test_fail_3 SOURCES static_assert_test_fail_3.cpp COMPILE_ONLY WILL_FAIL)
bcm_test(NAME static_assert_test_fail_4 SOURCES static_assert_test_fail_4.cpp COMPILE_ONLY WILL_FAIL)
bcm_test(NAME static_assert_test_fail_5 SOURCES static_assert_test_fail_5.cpp COMPILE_ONLY WILL_FAIL)
bcm_test(NAME static_assert_test_fail_6 SOURCES static_assert_test_fail_6.cpp COMPILE_ONLY WILL_FAIL)
bcm_test(NAME static_assert_test_fail_7 SOURCES static_assert_test_fail_7.cpp COMPILE_ONLY WILL_FAIL)
bcm_test(NAME static_assert_test_fail_8 SOURCES static_assert_test_fail_8.cpp COMPILE_ONLY WILL_FAIL)
bcm_test(NAME static_assert_test_fail_9 SOURCES static_assert_test_fail_9.cpp COMPILE_ONLY WILL_FAIL)
bcm_test(NAME static_assert_test_fail_10 SOURCES static_assert_test_fail_10.cpp COMPILE_ONLY WILL_FAIL)

