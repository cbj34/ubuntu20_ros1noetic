#!/bin/bash

# Source the setup script
source /opt/ros/noetic/setup.bash

# Load the ROS parameters from bridge.yaml
rosparam load /path/to/bridge.yaml

# Execute any additional commands here if needed
# Example:
# roslaunch my_package my_launch_file.launch

# Keep the container running
exec "$@"

