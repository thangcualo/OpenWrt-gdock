#!/bin/bash
#============================================================
# https://github.com/P3TERX/Actions-OpenWrt
# File name: diy-part2.sh
# Description: OpenWrt DIY script part 2 (After Update feeds)
# Lisence: MIT
# Author: P3TERX
# Blog: https://p3terx.com
#============================================================

svn co https://github.com/kissyouhunter/kernel_N1/trunk/kernel/5.15.2 /opt/kernel
cd /opt
git clone https://github.com/unifreq/openwrt_packit
cd openwrt_packit
sed -i 's/5.15.2-flippy-67+/5.15.2-kissyouhunter/g' make.env
wget https://hk.91io.cn/s/myxwyiO/openwrt-armvirt-64-default-rootfs.tar.gz
sudo ./mk_s905_mxqpro+.sh
sudo mv /opt $GITHUB_WORKSPACE/
