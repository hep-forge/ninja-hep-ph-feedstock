#! /usr/bin/bash
set -e

cp "${BUILD_PREFIX}/share/gnuconfig/config.sub" "${BUILD_PREFIX}/share/gnuconfig/config.guess" .
autoreconf --install

./configure --prefix="${PREFIX}" --enable-static=no \
  --with-avholo="${FFLAGS} -lavh_olo" \
  --with-looptools="${FLDFLAGS} -looptools -lgfortran -lquadmath" \
  FCINCLUDE="${FCINCLUDE} -I${PREFIX}/include/oneloop"

# upstream's Makefile is not parallel-safe -- don't use -j
make
make install
