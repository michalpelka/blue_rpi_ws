#! /bin/sh

. /opt/ros/humble/setup.sh
. /home/robot/colcon_ws/install/setup.sh
export RMW_IMPLEMENTATION=rmw_cyclonedds_cpp
export ROS_DOMAIN_ID=0
export CYCLONEDDS_URI=/opt/cyclone_profile.xml
ros2 launch /home/robot/colcon_ws/src/scripts/system.launch.py

