FROM ubuntu:14.04
MAINTAINER Tony Kelman <tony@kelman.net>

RUN dpkg --add-architecture i386 && apt-get update && \
    apt-get install -y --no-install-recommends ca-certificates git \
      build-essential gcc-multilib g++-multilib gfortran-multilib \
      python curl m4 cmake libssl-dev libssl-dev:i386 && \
    rm -rf /var/lib/apt/lists/* && \
    git clone -b release-0.4 https://github.com/JuliaLang/julia /home/julia-i686 && \
    cp -R /home/julia-i686 /home/julia-x86_64 && \
    echo 'override ARCH = i686' >> /home/julia-i686/Make.user && \
    echo 'override MARCH = pentium4' >> /home/julia-i686/Make.user && \
    for ARCH in i686 x86_64; do \
      DEPS="openblas arpack suitesparse"; \
      for dep in $DEPS; do \
        cd /home/julia-$ARCH && make -C deps install-$dep; \
      done && \
      for dep in $DEPS; do \
        cd /home/julia-$ARCH && make -C deps distclean-$dep; \
      done \
    done
# distclean should leave in place the installed libraries and headers
