FROM ros:noetic

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && \
    apt-get install -y build-essential cmake git libgtk2.0-dev pkg-config libavcodec-dev libavformat-dev libswscale-dev \
        libtbb2 libtbb-dev libjpeg-dev libpng-dev libtiff-dev libdc1394-22-dev libv4l-dev libopenblas-dev libatlas-base-dev libxvidcore-dev libx264-dev libfontconfig1-dev libcairo2-dev \
        ros-noetic-tf ros-noetic-cv-bridge ros-noetic-pcl-conversions ros-noetic-image-transport python3-catkin-tools ros-noetic-rviz vim

COPY opencv /opencv

WORKDIR /opencv/build

RUN cmake .. && make -j$(nproc) && make install -j$(nproc)

COPY gtsam-4.1 /gtsam-4.1

WORKDIR /gtsam-4.1/build

RUN cmake .. && make check -j$(nproc) && make install -j$(nproc)

WORKDIR /

RUN rm -r opencv gtsam-4.1
