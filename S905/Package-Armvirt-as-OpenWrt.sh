#!/bin/bash
#============================================================
# https://github.com/P3TERX/Actions-OpenWrt
# File name: diy-part2.sh
# Description: OpenWrt DIY script part 2 (After Update feeds)
# Lisence: MIT
# Author: P3TERX
# Blog: https://p3terx.com
#============================================================

svn co https://github.com/breakings/OpenWrt/trunk/opt/kernel/5.4.158 /opt/kernel
cd /opt
git clone https://github.com/unifreq/openwrt_packit
cd openwrt_packit
sed -i 's/5.15.1-flippy-67+/.4.158-flippy-67+o/g' make.env
wget https://github.com/vpei/openwrt-s905d-n1/releases/download/openwrt_s9xxx_lede_2021.11.11.0541/openwrt-armvirt-64-default-rootfs.tar.gz
sudo ./mk_s905_mxqpro+.sh
sudo mv /opt $GITHUB_WORKSPACE/

https://github.com/vpei/openwrt-s905d-n1.git
