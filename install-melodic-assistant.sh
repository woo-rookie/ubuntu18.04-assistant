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

# Setup your sources.list
sudo sh -c 'echo "deb http://packages.ros.org/ros/ubuntu $(lsb_release -sc) main" > /etc/apt/sources.list.d/ros-latest.list'
# Set up your keys
sudo apt-key adv --keyserver 'hkp://keyserver.ubuntu.com:80' --recv-key C1CF6E31E6BADE8868B172B4F42ED6FBAB17C654
# Installation
sudo apt update
sudo apt install ros-melodic-desktop-full
# Environment setup
echo "source /opt/ros/melodic/setup.bash" >> ~/.bashrc
source ~/.bashrc
# Dependencies for building packages
sudo apt install python-rosdep python-rosinstall python-rosinstall-generator python-wstool build-essential
# Initialize rosdep
# access ip from https://site.ip138.com/raw.githubusercontent.com/
sudo sh -c 'echo "185.199.111.133 raw.githubusercontent.com" >> /etc/hosts' && echo 0

sudo rosdep init
echo -e "${BRed}此后操作需要打开梯子！${Color_Off}"
read -r -p "是否已经打开梯子？[y/n]" response
if [[ "$response" =~ y ]];then
    rosdep update
else
    echo -e "${BRed}放弃配置此项${Color_Off}"
fi

echo -e "${BRed}提示：请新打开一个终端，运行${Color_Off}"
echo "roscore"
echo -e "${BRed}提示：请新打开一个终端，运行${Color_Off}"
echo "rosrun turtlesim turtlesim_node"
echo -e "${BRed}提示：请新打开一个终端，运行${Color_Off}"
echo "rosrun turtlesim turtle_teleop_key"


 
