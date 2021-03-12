#!/bin/bash

Color_Off='\033[0m'       # Text Reset

# Regular Colors
Black='\033[0;30m'        # Black
Red='\033[0;31m'          # Red
Green='\033[0;32m'        # Green
Yellow='\033[0;33m'       # Yellow
Blue='\033[0;34m'         # Blue
Purple='\033[0;35m'       # Purple
Cyan='\033[0;36m'         # Cyan
White='\033[0;37m'        # White

# Bold
BBlack='\033[1;30m'       # Black
BRed='\033[1;31m'         # Red
BGreen='\033[1;32m'       # Green
BYellow='\033[1;33m'      # Yellow
BBlue='\033[1;34m'        # Blue
BPurple='\033[1;35m'      # Purple
BCyan='\033[1;36m'        # Cyan
BWhite='\033[1;37m'       # White

# Underline
UBlack='\033[4;30m'       # Black
URed='\033[4;31m'         # Red
UGreen='\033[4;32m'       # Green
UYellow='\033[4;33m'      # Yellow
UBlue='\033[4;34m'        # Blue
UPurple='\033[4;35m'      # Purple
UCyan='\033[4;36m'        # Cyan
UWhite='\033[4;37m'       # White

cd ~
sudo apt install git

echo -e "${BRed}需要删除catkin_ws文件夹！${Color_Off}"
read -r -p "是否删除catkin_ws文件夹？[y/n]" response
if [[ "$response" =~ y ]];then
    sudo rm -r catkin_ws

    # source global ros
    source /opt/ros/melodic/setup.bash
    # create a catkin workspace
    mkdir -p catkin_ws/src && cd catkin_ws
    # clone the driver
    # git clone https://gitee.com/woo-rookie/Universal_Robots_ROS_Driver.git src/Universal_Robots_ROS_Driver
    git clone https://gitee.com/woo-rookie/ur_modern_driver.git src/ur_modern_driver
    # clone fork of the description. This is currently necessary, until the changes are merged upstream.
    git clone -b calibration_devel https://gitee.com/woo-rookie/universal_robot.git src/universal_robot
    # git clone -b melodic-devel https://github.com/ros-industrial/universal_robot.git src/universal_robot
    # install dependencies
    sudo apt update -qq
    rosdep update
    # rosdep install --from-paths src --ignore-src -y
    rosdep install --rosdistro melodic --ignore-src --from-paths src

    # build the workspace. We need an isolated build because of the non-catkin library package.
    catkin_make
    # activate the workspace (ie: source it)
    source devel/setup.bash
else
    echo -e "${BRed}放弃安装ur驱动${Color_Off}"
fi


 
