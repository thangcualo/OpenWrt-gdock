#!/bin/bash
#============================================================
# https://github.com/P3TERX/Actions-OpenWrt
# File name: diy-part2.sh
# Description: OpenWrt DIY script part 2 (After Update feeds)
# Lisence: MIT
# Author: P3TERX
# Blog: https://p3terx.com
#============================================================

svn co https://github.com/breakings/OpenWrt/trunk/opt/kernel/5.4.149 /opt/kernel
mv /opt/kernel/5.4.149/* /opt/kernel
cd /opt
git clone https://github.com/unifreq/openwrt_packit
cd openwrt_packit
wget http://91io.cn/s/WOqVqF8/openwrt-armvirt-64-default-rootfs.tar.gz
./mk_s905d_n1.sh
mv /opt $GITHUB_WORKSPACE/
