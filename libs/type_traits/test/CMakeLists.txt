include(BCMTest)
include(BCMProperties)

bcm_test_link_libraries(boost_type_traits)

# TODO: We currently need to prepend boost_type_traits_ to all the tests
# we add here, otherwise some of them will conflict with tests in other
# Boost libraries. This is madness!

# Wrapper around bcm_test to set our own warning levels
#
# TODO: Do all of this in a portable way
function(type_traits_add_test target)
  bcm_test(NAME ${target} ${ARGV})
  target_compile_options(${target} PRIVATE -Wall)
  if (CMAKE_CXX_COMPILER_ID EQUAL GNU)
    target_compile_options(${target} PRIVATE -Wextra -Wno-uninitialized -Werror)
  elseif (CMAKE_CXX_COMPILER_ID EQUAL Intel)
    target_compile_options(${target} PRIVATE -Werror)
  elseif (CMAKE_CXX_COMPILER_ID EQUAL SunPro)
    target_compile_options(${target} PRIVATE -Werror)
  elseif (CMAKE_CXX_COMPILER_ID EQUAL MSVC)
    target_compile_options(${target} PRIVATE -Werror)
  endif()
endfunction()

file(GLOB test_sources RELATIVE "${CMAKE_CURRENT_SOURCE_DIR}" *_test*.cpp)
foreach(source IN LISTS test_sources)
  string(REPLACE ".cpp" "" name "${source}")
  type_traits_add_test(boost_type_traits_${name} SOURCES ${source})
endforeach()

# These traits have both intrinsic support, and a std conforming version, test
# a version with intrinsics disabled for better code coverage:
set(intrinsic_tests has_nothrow_assign_test
                    has_nothrow_constr_test
                    has_nothrow_copy_test
                    is_nothrow_move_assignable_test
                    is_nothrow_move_constructible_test)
foreach(test IN LISTS intrinsic_tests)
  type_traits_add_test(boost_type_traits_${test}_no_intrinsics SOURCES ${test}.cpp)
  target_compile_definitions(boost_type_traits_${test}_no_intrinsics PRIVATE BOOST_TT_DISABLE_INTRINSICS)
endforeach()
