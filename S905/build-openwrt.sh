#!/bin/bash
#============================================================
# https://github.com/P3TERX/Actions-OpenWrt
# File name: diy-part2.sh
# Description: OpenWrt DIY script part 2 (After Update feeds)
# Lisence: MIT
# Author: P3TERX
# Blog: https://p3terx.com
#============================================================

git clone  https://github.com/vpei/openwrt-s905d-n1.git openwrt
wget https://github.com/vpei/openwrt-s905d-n1/releases/download/openwrt_s9xxx_lede_2021.11.11.0541/openwrt-armvirt-64-default-rootfs.tar.gz
