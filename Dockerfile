FROM colstrom/ubuntu-core:latest
MAINTAINER thdespou@hotmail.com

ENV GAMBIT_VERSION 4_8_8-devel

# Install Packages
RUN DEBIAN_FRONTEND=noninteractive apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y -q build-essential git wget
RUN wget -qO- http://www.iro.umontreal.ca/~gambit/download/gambit/v4.8/source/gambit-v$GAMBIT_VERSION.tgz | tar xzv

WORKDIR /gambit-v$GAMBIT_VERSION

# Install Gambit
RUN ./configure && make -j4 current-gsc-boot && ./configure --enable-single-host && make -j4 from-scratch && make check && make install
RUN rm -rf /gambit-v$GAMBIT_VERSION

# Update path
ENV PATH="/usr/local/Gambit/bin/:${PATH}"

WORKDIR /
CMD ["gsi"]