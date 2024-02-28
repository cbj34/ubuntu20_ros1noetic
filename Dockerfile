# Use the official Ubuntu 20.04 image for arm64v8
FROM arm64v8/ubuntu:20.04

# Set the shell to non-interactive
ENV DEBIAN_FRONTEND=noninteractive

# Install necessary dependencies
RUN apt-get update && apt-get install -y \
    gnupg2 \
    lsb-release \
    && rm -rf /var/lib/apt/lists/*

# Add the ROS repository
RUN sh -c 'echo "deb http://packages.ros.org/ros/ubuntu $(lsb_release -sc) main" > /etc/apt/sources.list.d/ros-latest.list' && \
    apt-key adv --keyserver 'hkp://keyserver.ubuntu.com:80' --recv-key C1CF6E31E6BADE8868B172B4F42ED6FBAB17C654

# Install ROS Noetic Desktop Full
RUN apt-get update && apt-get install -y \
    ros-noetic-desktop \
    && rm -rf /var/lib/apt/lists/*

RUN apt-get update && apt-get install --no-install-recommends -y \
    build-essential \
    python3-rosdep \
    python3-rosinstall \
    python3-vcstools \
    nano \
    && rm -rf /var/lib/apt/lists/*

# Initialize rosdep
RUN rosdep init && \
    rosdep update

# Setup ROS environment variables
ENV ROS_DISTRO noetic
ENV ROS_ROOT /opt/ros/noetic
ENV ROS_MASTER_URI=http://192.168.1.1:11311
ENV ROS_IP=192.168.2.11
ENV ROS_VERSION 1

COPY bridge/bridge.yaml /bridge.yaml
# RUN rosparam load /bridge.yaml Can only be loaded with active roscore

# Set up environment variables
ENV LANG C.UTF-8
ENV LC_ALL C.UTF-8


ENTRYPOINT ["/opt/ros/noetic/setup.bash"]

# Set up entrypoint
CMD ["bash"]
