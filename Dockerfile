FROM ubuntu:18.04

USER root
ARG DEBIAN_FRONTEND=noninteractive

ADD sources.list .
RUN rm /etc/apt/sources.list
RUN mv sources.list /etc/apt/sources.list

# Install dependencies
RUN apt-get update && apt-get install -y cmake git libssl-dev wget python-minimal build-essential libilmbase-dev

# Download & build cmake
RUN git clone https://github.com/Kitware/CMake.git
WORKDIR CMake
RUN ./bootstrap && make && make install
WORKDIR ..

## Download & build openexr
RUN git clone https://github.com/AcademySoftwareFoundation/openexr.git
WORKDIR openexr
RUN mkdir build
WORKDIR build
RUN cmake ..
RUN make
RUN make install
WORKDIR ../..

RUN apt-get update && apt-get install -y libboost-python-dev

# Download & upack pyilmbase
RUN wget http://download.savannah.gnu.org/releases/openexr/ilmbase-2.2.0.tar.gz
RUN tar -xf ilmbase-2.2.0.tar.gz
WORKDIR ilmbase-2.2.0
RUN ./configure
RUN make
RUN make install
WORKDIR ..

RUN apt-get install -y python-numpy

# Download & upack pyilmbase
RUN wget http://download.savannah.gnu.org/releases/openexr/pyilmbase-2.2.0.tar.gz
RUN tar -xf pyilmbase-2.2.0.tar.gz
WORKDIR pyilmbase-2.2.0
RUN ./configure
RUN make
RUN make install

# Build alembic
# Download repo
RUN git clone https://github.com/FilipSivak/alembic.git
WORKDIR alembic
RUN mkdir build
WORKDIR build
RUN cmake ..
RUN make
RUN make install
WORKDIR ..

RUN apt-get update && apt-get install -y python-setuptools libboost-all-dev

# Modules must be copied to site-packages since that's where alembic is looking for them
RUN cp /usr/local/lib/python2.7/dist-packages/*.la /usr/local/lib/python2.7/site-packages
RUN cp /usr/local/lib/python2.7/dist-packages/*.so /usr/local/lib/python2.7/site-packages

# Install alembic python package
RUN python setup.py install

WORKDIR ../..

CMD [ "/bin/bash" ]
