#!/bin/sh

echo "Setting up i2c group"
sudo addgroup i2c 
sudo usermod -aG i2c "$USER"


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
echo `export RMW_IMPLEMENTATION=rmw_cyclonedds_cpp` >> ~/bash.rc
echo `CYCLONEDDS_URI=/opt/cyclone_profile.xml` >> ~/bash.rc
echo `ROS_DOMAIN_ID=0` >> ~/bash.rc

echo "setting up service"
#service
sudo cp ./service/mandeye_robot.service /etc/systemd/system/
sudo systemctl daemon-reload
sudo systemctl enable mandeye_robot.service 
sudo systemctl status mandeye_robot.service
