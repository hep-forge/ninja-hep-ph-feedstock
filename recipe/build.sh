#! /usr/bin/bash
set -e

cp "${BUILD_PREFIX}/share/gnuconfig/config.sub" "${BUILD_PREFIX}/share/gnuconfig/config.guess" .
autoreconf --install

./configure --prefix="${PREFIX}" --enable-static=no \
  --with-avholo="${FFLAGS} -lavh_olo" \
  --with-looptools="${FLDFLAGS} -looptools -lgfortran -lquadmath" \
  FCINCLUDE="${FCINCLUDE} -I${PREFIX}/include/oneloop"

NPROC=$(nproc 2>/dev/null || sysctl -n hw.ncpu)
make -j"${NPROC}"
make install
