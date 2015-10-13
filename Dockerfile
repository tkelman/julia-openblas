FROM tkelman/julia-llvm33
MAINTAINER Tony Kelman <tony@kelman.net>

RUN apt-get install -y --no-install-recommends gfortran-multilib && \
    cd /home/julia32 && make -j4 -C deps install-openblas && \
    cd /home/julia64 && make -j4 -C deps install-openblas
