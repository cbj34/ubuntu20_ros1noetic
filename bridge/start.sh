#!/bin/bash

# Source the setup script
source /opt/ros/noetic/setup.bash

# Use the environment variables provided, or default to localhost if not set
export ROS_MASTER_URI=${ROS_MASTER_URI:-http://192.168.1.123:11311}
export ROS_IP=${ROS_IP:-192.168.1.211}

echo "ROS_MASTER_URI is set to: $ROS_MASTER_URI"
echo "ROS_IP is set to: $ROS_IP"

#Start roscore
roscore &

#Wait for roscore
sleep 5

# Load the ROS parameters from bridge.yaml
if [ -f /bridge.yaml ]; then
    echo "Loading bridge parameters from /bridge.yaml..."
    rosparam load /bridge.yaml
    
    echo "--- Verified Parameters ---"
    # Show the keys 
    rosparam get /
else
    echo "Warning: /bridge.yaml not found!"
fi

# Execute any additional commands here if needed
# Example:
# roslaunch my_package my_launch_file.launch

# Keep the container running
exec "$@"

