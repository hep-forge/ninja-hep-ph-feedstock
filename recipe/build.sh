#! /usr/bin/bash
set -e

cp "${BUILD_PREFIX}/share/gnuconfig/config.sub" "${BUILD_PREFIX}/share/gnuconfig/config.guess" .
autoreconf --install

# No --with-looptools: it compiles Ninja's LoopTools interface but never links
# LoopTools, which leaves libninja.so with undefined symbols (clearcache_, ...)
./configure --prefix="${PREFIX}" --enable-static=no \
  --with-avholo="${FFLAGS} -lavh_olo" \
  FCINCLUDE="${FCINCLUDE} -I${PREFIX}/include/oneloop"

# upstream's Makefile is not parallel-safe -- don't use -j
make
make install
