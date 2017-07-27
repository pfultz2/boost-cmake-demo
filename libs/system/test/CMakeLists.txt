# Boost System Library test Jamfile

# Copyright Beman Dawes 2003, 2006

# Distributed under the Boost Software License, Version 1.0.
# See accompanying file LICENSE_1_0.txt or http://www.boost.org/LICENSE_1_0.txt

# See library home page at http://www.boost.org/libs/system

include(BCMTest)
include(BCMProperties)

bcm_test_link_libraries(boost_system)

add_library(throw_test throw_test.cpp)
bcm_mark_as_test(throw_test)
target_link_libraries(throw_test boost_system)
if(BUILD_SHARED_LIBS)
    target_compile_definitions(throw_test PUBLIC BOOST_SYSTEM_DYN_LINK=1)
else()
    target_compile_definitions(throw_test PUBLIC BOOST_SYSTEM_STATIC_LINK=1)
endif()

bcm_test(NAME error_code_test SOURCES error_code_test.cpp)
bcm_test(NAME error_code_user_test SOURCES error_code_user_test.cpp)
bcm_test(NAME system_error_test SOURCES system_error_test.cpp)
bcm_test(NAME dynamic_link_test SOURCES dynamic_link_test.cpp)
target_link_libraries(dynamic_link_test throw_test)
bcm_test(NAME initialization_test SOURCES initialization_test.cpp)
bcm_test(NAME header_only_test SOURCES header_only_test.cpp)
bcm_test(NAME system_config_test SOURCES config_test.cpp)
