# Use the official Ubuntu 20.04 image for arm64v8
# FROM arm64v8/ubuntu:20.04
# Generic
FROM ros:noetic-ros-base-focal

# Set the shell to non-interactive
ENV DEBIAN_FRONTEND=noninteractive

# Install necessary dependencies
RUN apt-get update && apt-get install -y \
    gnupg2 \
    lsb-release \
    && rm -rf /var/lib/apt/lists/*

# Add the ROS repository already included in generic image
# RUN sh -c 'echo "deb http://packages.ros.org/ros/ubuntu $(lsb_release -sc) main" > /etc/apt/sources.list.d/ros-latest.list' && \
#    apt-key adv --keyserver 'hkp://keyserver.ubuntu.com:80' --recv-key C1CF6E31E6BADE8868B172B4F42ED6FBAB17C654

# Update and install tools
RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys F42ED6FBAB17C654 \
    && apt-get update && apt-get install -y --no-install-recommends \
    tilix \
    ros-noetic-rospy-tutorials \
    build-essential \
    python3-rosdep \
    python3-rosinstall \
    python3-vcstools \
    nano \
    && rm -rf /var/lib/apt/lists/*

# Initialize rosdep (not needed if everything is installed by apt and not build step in docker file)
# RUN rosdep init && \
#    rosdep update

# Setup ROS environment variables
ENV ROS_DISTRO=noetic
ENV ROS_VERSION=1
ENV LANG=C.UTF-8
ENV LC_ALL=C.UTF-8

# Set in start.sh
# ENV ROS_MASTER_URI=http://192.168.1.123:11311
# ENV ROS_IP=192.168.2.211

COPY bridge/bridge.yaml /bridge.yaml
# RUN rosparam load /bridge.yaml Can only be loaded with active roscore

# File setup
COPY bridge/start.sh /start.sh
RUN chmod +x /start.sh
ENTRYPOINT ["/start.sh"]

# Set up entrypoint
ENTRYPOINT ["/start.sh"]
CMD ["bash"]
