# Initialize
AC_INIT([main], [1.0])
LT_INIT
AC_CONFIG_MACRO_DIR([m4])

# Generate the Makefile
AM_INIT_AUTOMAKE([foreign])

# Path to source file
AC_CONFIG_SRCDIR([src/main.f90])

# Clean build dir
#AC_CONFIG_AUX_DIR

# Make sure Fortran is available
AC_PROG_FC([ifort])

# Make sure gcc is working
AC_PROG_CC([gcc])

# Make sure g++ is working
AC_PROG_CXX([g++])

# Generate Makefile from Makefile.in
AC_CONFIG_FILES([Makefile src/Makefile])

# MIPP
AC_ARG_WITH(mipp,
  AS_HELP_STRING([--without-mipp],
                 [Do not use mipp. Default: auto-detect]), [
case "$with_mipp" in
  yes|no)
    : # Nothing special to do here
    ;;
  *)
    if test ! -d "$withval" ; then
      AC_MSG_ERROR([--with-mipp path does not point to a directory])
    fi
    LIBMIPP_PATH="-L$with_mipp/lib"
    CFLAGS="$LIBMIPP_CFLAGS $CFLAGS"
    CXXFLAGS="-I$with_mipp/include $CXXFLAGS"
    CPPFLAGS="$LIBMIPP_CFLAGS $CPPFLAGS"
  esac
])
AH_TEMPLATE(USE_MIPP,[MIPP support is available])

if test "x$with_mipp" != "xno"; then
  LIBS="$LIBS $LIBMIPP_PATH"

  if test "x$with_mipp" = "xyes" -a "x$LIBMIPP_LIBS" = "x"; then
    AC_MSG_ERROR([Required mipp library not found])
  fi
  if test "x$LIBMIPP_LIBS" != "x" ; then
    CFLAGS="$LIBMIPP_CFLAGS $CFLAGS"
    CXXFLAGS="$LIBMIPP_CFLAGS $CXXFLAGS"
    CPPFLAGS="$LIBMIPP_CFLAGS $CPPFLAGS"
    MIPPLIB="$LIBMIPP_PATH $LIBMIPP_LIBS"
    AC_DEFINE(USE_MIPP,1,[MIPP support is available])
    with_MIPP=yes
  else
    with_MIPP=no
  fi
fi
AC_MSG_NOTICE([MIPP library support: ${with_MIPP:=auto} ${LIBMIPP_PATH} ${LIBMIPP_LIBS}])
AC_SUBST(MIPPLIB)
# auto-detect using pkg-config
PKG_CHECK_MODULES([LIBMIPP],[MIPP >= 1.0.0],,[

  ## something went wrong.
  ## try to find the package without pkg-config

  ## check that the library is actually new enough.
  ## by testing for a 1.0.0+ function which we use
  AC_CHECK_LIB(mipp,MIPP_finalize,[LIBMIPP_LIBS="-lmipp"])
])
if test "x$LIBMIPP_LIBS" != "x" ; then
  AC_CHECK_HEADERS(mipp.h)
fi

echo "---------------------
USE MIPP.....: ${with_mipp}"
echo "---------------------"


# Done
AC_OUTPUT
