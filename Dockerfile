FROM ubuntu:18.04

ENV TZ=Europe/Prague
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

RUN apt-get update
RUN apt-get install -y cmake libeigen3-dev libboost-all-dev

RUN apt-get install -y git build-essential linux-libc-dev
RUN apt-get install -y cmake cmake-gui 
RUN apt-get install -y libusb-dev libudev-dev
RUN apt-get install -y mpi-default-dev openmpi-bin openmpi-common 

RUN apt-get install -y libpcap-dev
RUN apt-get install -y libflann-dev
RUN apt-get install -y libopenni2-dev
RUN apt-get install -y libqhull7 libqhull-dev 

RUN apt-get install -y freeglut3-dev pkg-config
RUN apt-get install -y libxmu-dev libxi-dev 
RUN apt-get install -y mono-complete
RUN apt-get install -y openjdk-8-jdk openjdk-8-jre

RUN apt-get install -y libpcl-dev

RUN apt-get install -y python3-pip
RUN pip3 install numpy
RUN pip3 install pybind11
RUN pip3 install open3d

RUN ln -snf python3.6 usr/bin/python

RUN cd home && git clone https://github.com/MIT-SPARK/TEASER-plusplus.git && cd TEASER-plusplus && mkdir build && cd build && cmake .. && make && ctest && make install

RUN cd home && cd TEASER-plusplus && cd build && cmake -DCMAKE_BUILD_TYPE=Release -DTEASERPP_PYTHON_VERSION=3.6 .. && make teaserpp_python -j4 && cd python && pip3 install .

#CMD python "teaserpp.py"
CMD bash
