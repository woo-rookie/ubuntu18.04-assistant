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

sudo apt-get install build-essential bc ca-certificates gnupg2 libssl-dev wget gawk flex bison
sudo apt-get install libncurses-dev
sudo apt-get install libncurses5-dev
sudo apt-get install libelf-dev

uname -r

mkdir -p ~/rt_kernel_build

cd ~/rt_kernel_build

wget https://www.kernel.org/pub/linux/kernel/v5.x/linux-5.4.109.tar.gz
wget https://www.kernel.org/pub/linux/kernel/projects/rt/5.4/patch-5.4.109-rt56.patch.xz
sudo wget https://xenomai.org/downloads/ipipe/v5.x/x86/ipipe-core-5.4.105-x86-4.patch
sudo ../xenomai-3.1/scripts/prepare-kernel.sh --arch=x86_64 --ipipe=ipipe-core-5.4.105-x86-4.patch
sudo apt install gcc libc6-dev libncurses5-dev libssl-dev build-essential bison flex
tar xzvf  linux-5.4.109.tar.gz
cd linux-5.4.109
xzcat ../patch-5.4.109-rt56.patch.xz | patch -p1

sudo make mrproper

sudo cp /boot/config-5.4.0-72-generic .config

sudo make menuconfig

make oldconfig
# make menuconfig

sudo make -j2
sudo make modules_install 
sudo make install
cd /boot
sudo mkinitramfs -k -o initrd.img-5.4.109-rt56 5.4.109-rt56

sudo apt install ../linux-headers-5.4.109-rt56_*.deb ../linux-image-5.4.109-rt56_*.deb

sudo groupadd realtime
sudo usermod -aG realtime $USER

sudo gedit /etc/default/grub
