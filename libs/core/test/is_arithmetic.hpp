#ifndef GUARD_IS_ARITHMETIC_HPP
#define GUARD_IS_ARITHMETIC_HPP

#include <boost/config.hpp>
#ifndef BOOST_NO_CXX11_HDR_TYPE_TRAITS
#include <type_traits>
#endif

#ifndef BOOST_NO_CXX11_HDR_TYPE_TRAITS
using std::is_arithmetic;
#else
template<class T> struct is_arithmetic
{
  BOOST_STATIC_CONSTANT( bool, value = false );
};
#define MAKE_IS_ARITHMETIC(T) \
template<> struct is_arithmetic<T> \
{ \
  BOOST_STATIC_CONSTANT( bool, value = true ); \
};
MAKE_IS_ARITHMETIC(int)
MAKE_IS_ARITHMETIC(long)
MAKE_IS_ARITHMETIC(short)
MAKE_IS_ARITHMETIC(float)
MAKE_IS_ARITHMETIC(double)
#endif

#endif
