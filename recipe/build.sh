#! /usr/bin/bash
set -e

cp "${BUILD_PREFIX}/share/gnuconfig/config.sub" "${BUILD_PREFIX}/share/gnuconfig/config.guess" .
autoreconf --install

# Static and shared: MG5_aMC links its generated code against libninja.a.
./configure --prefix="${PREFIX}" --enable-static=yes \
  --with-avholo="${FFLAGS} -lavh_olo" \
  --with-looptools="${FLDFLAGS} -looptools -lgfortran -lquadmath" \
  FCINCLUDE="${FCINCLUDE} -I${PREFIX}/include/oneloop"

# upstream's Makefile is not parallel-safe -- don't use -j
make
make install
