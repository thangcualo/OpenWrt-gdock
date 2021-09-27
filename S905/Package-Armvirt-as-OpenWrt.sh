#!/bin/bash
#============================================================
# https://github.com/P3TERX/Actions-OpenWrt
# File name: diy-part2.sh
# Description: OpenWrt DIY script part 2 (After Update feeds)
# Lisence: MIT
# Author: P3TERX
# Blog: https://p3terx.com
#============================================================

svn co https://github.com/breakings/OpenWrt/trunk/opt/kernel/5.10.69 /opt/kernel
cd /opt
git clone https://github.com/unifreq/openwrt_packit
cd openwrt_packit
sed -i 's/5.14.8-flippy-65+/5.10.69-65+/g' make.env
wget http://91io.cn/s/WOqVqF8/openwrt-armvirt-64-default-rootfs.tar.gz
sudo ./mk_s905_mxqpro+.sh
sudo mv /opt $GITHUB_WORKSPACE/
