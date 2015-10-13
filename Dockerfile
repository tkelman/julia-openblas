FROM ubuntu:14.04
MAINTAINER Tony Kelman <tony@kelman.net>

RUN dpkg --add-architecture i386 && apt-get update && \
    apt-get install -y --no-install-recommends ca-certificates git \
        build-essential gcc-multilib g++-multilib gfortran-multilib \
        python curl m4 cmake libssl-dev libssl-dev:i386 && \
    rm -rf /var/lib/apt/lists/* && \
    git clone https://github.com/JuliaLang/julia /home/julia-i686 && \
    cp -R /home/julia-i686 /home/julia-x86_64 && \
    echo 'override ARCH = i686' >> /home/julia-i686/Make.user && \
    echo 'override MARCH = pentium4' >> /home/julia-i686/Make.user && \
    cd /home/julia-i686 && make -j2 -C deps install-openblas && \
    cd /home/julia-x86_64 && make -j2 -C deps install-openblas
