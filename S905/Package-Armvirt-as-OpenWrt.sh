#!/bin/bash
#============================================================
# https://github.com/P3TERX/Actions-OpenWrt
# File name: diy-part2.sh
# Description: OpenWrt DIY script part 2 (After Update feeds)
# Lisence: MIT
# Author: P3TERX
# Blog: https://p3terx.com
#============================================================

svn co https://github.com/breakings/OpenWrt/trunk/opt/kernel/5.4.148 /opt/kernel
cd /opt
git clone https://github.com/unifreq/openwrt_packit
cd openwrt_packit
sed -i 's/5.14.8-flippy-65+/5.4.148-flippy-64+o' make.env
wget http://91io.cn/s/WOqVqF8/openwrt-armvirt-64-default-rootfs.tar.gz
sudo ./mk_s912_zyxq.sh
sudo ./mk_s905x2_x96max.sh
sudo ./mk_s905x3_multi.sh
