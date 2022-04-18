#!/bin/bash
#============================================================
# https://github.com/P3TERX/Actions-OpenWrt
# File name: diy-part2.sh
# Description: OpenWrt DIY script part 2 (After Update feeds)
# Lisence: MIT
# Author: P3TERX
# Blog: https://p3terx.com
#============================================================

svn co https://github.com/kissyouhunter/kernel_N1/trunk/kernel/5.17.3 /opt/kernel
cd /opt
git clone https://github.com/unifreq/openwrt_packit
cd openwrt_packit
sed -i 's/5.17.3-flippy-71+/5.17.3-kissyouhunter/g' make.env
sed -i 's/R22.4.1/OpenWrt_22.03/g' make.env
sed -i 's/ENABLE_WIFI_K510=1/ENABLE_WIFI_K510=0/g' make.env
sed -i 's/SW_FLOWOFFLOAD=1/SW_FLOWOFFLOAD=0/g' make.env
sed -i 's/SFE_FLOW=0/SFE_FLOW=1/g' make.env
wget -O  "openwrt-armvirt-64-default-rootfs.tar.gz" https://tmp-reach.vx-cdn.com/file-625d2f772979e/openwrt-armvirt-64-default-rootfs.tar.gz
sudo ./mk_s905_mxqpro+.sh
sudo cp -rf /opt $GITHUB_WORKSPACE/
