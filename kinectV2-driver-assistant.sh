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
cd catkin_ws/src
sudo apt install git

# Download libfreenect2 source
git clone https://gitee.com/woo-rookie/libfreenect2.git
cd libfreenect2
# Install build tools
sudo apt-get install build-essential cmake pkg-config
# Install libusb. The version must be >= 1.0.20
sudo apt-get install libusb-1.0-0-dev
# Install TurboJPEG
sudo apt-get install libturbojpeg0-dev
# Install OpenGL
sudo apt-get install libglfw3-dev
# Build
mkdir build && cd build
cmake .. -DCMAKE_INSTALL_PREFIX=$HOME/freenect2
make
make install
sudo cp ../platform/linux/udev/90-kinect2.rules /etc/udev/rules.d/
echo -e "${BRed}提示：请重新插入Kinect，在'~/catkin_ws/src/libfreenect2/build'文件夹下运行测试程序${Color_Off}"
echo "./bin/Protonect"


 
