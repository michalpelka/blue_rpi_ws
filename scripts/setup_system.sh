#!/bin/sh

echo "Setting up i2c group"
sudo addgroup i2c 
sudo addgroup dialout
sudo usermod -aG i2c "$USER"
sudo usermod -aG dialout "$USER"

sudo apt-get install ros-humble-rmw-cyclonedds-cpp ros-humble-demo-nodes-cpp  libi2c-dev

echo "Copying dds config to /opt"
sudo cp cyclone_profile.xml /opt/


echo "Copying livox config to /opt"
sudo cp mid360_config_lio.json /opt/

echo "Copying ROS 2 entry to /opt"
sudo cp entry.sh /opt/

echo "Netplan to set static IP"
sudo cp 01-netcfg.yaml /etc/netplan/
sudo netplan apply

echo "Setting up bash.rc, really not needed"
echo 'export RMW_IMPLEMENTATION=rmw_cyclonedds_cpp' >> ~/.bashrc
echo 'export CYCLONEDDS_URI=file:///opt/cyclone_profile.xml' >> ~/.bashrc
echo 'export ROS_DOMAIN_ID=0' >> ~/.bashrc
echo 'alias b='colcon build  --cmake-args -DCMAKE_BUILD_TYPE=Release'' >> ~/.bashrc
echo "setting up service"
#service
sudo cp ./service/mandeye_robot.service /etc/systemd/system/
sudo systemctl daemon-reload
sudo systemctl enable mandeye_robot.service 
sudo systemctl status mandeye_robot.service
