# Copyright Rene Rivera 2011-2016
# Distributed under the Boost Software License, Version 1.0.
# (See accompanying file LICENSE_1_0.txt or copy at
# http://www.boost.org/LICENSE_1_0.txt)

include(BCMTest)
include(BCMProperties)

bcm_test_link_libraries(boost_predef)

bcm_test(NAME info_as_cpp SOURCES info_as_cpp.cpp)
bcm_test(NAME info_as_c SOURCES info_as_c.c)
# bcm_test(NAME info_as_objcpp SOURCES info_as_objcpp.mm)
# bcm_test(NAME info_as_objc SOURCES info_as_objc.m)
bcm_test(NAME version SOURCES version.cpp)
bcm_test(NAME make SOURCES make.cpp)
if(APPLE)
    bcm_test(NAME macos_endian SOURCES macos_endian.c COMPILE_ONLY)
    bcm_test(NAME macos_vs_bsd SOURCES macos_vs_bsd.c COMPILE_ONLY)
endif()
bcm_test(NAME check_value SOURCES check_value.cpp)
# [ predef-check "BOOST_COMP_CLANG > 0.0.0" "BOOST_OS_LINUX == 0" : : <cxxflags>-DCHECK_VALUE=true ]
