#!/bin/bash
#=================================================
#   Description: DIY script
#   Lisence: MIT
#   Author: P3TERX
#   Blog: https://p3terx.com
#=================================================
#克隆源码
git clone -b openwrt-21.02 --single-branch https://github.com/immortalwrt/immortalwrt openwrt
cd openwrt
./scripts/feeds update -a && ./scripts/feeds install -a
git clone https://github.com/jerrykuku/luci-theme-argon.git package/luci-theme-argon-2.2.5
sed -i 's/192.168.1.1/192.168.10.1/g' package/base-files/files/bin/config_generate
sed -i 's/OpenWrt/G-DOCK/g' package/base-files/files/bin/config_generate
sed -i '/exit 0/i\mkdir -pv /srv/webd/web/.Trash' package/lean/default-settings/files/zzz-default-settings
sed -i '/exit 0/i\ln -sv /mnt/sda1 /srv/webd/web/U盘' package/lean/default-settings/files/zzz-default-settings
sed -i '/exit 0/i\ln -sv /mnt/mmcblk0p1/all /srv/webd/web/SD卡' package/lean/default-settings/files/zzz-default-settings
sed -i '/exit 0/i\chmod 775 /usr/bin/webd\n' package/lean/default-settings/files/zzz-default-settings
rm -rf package/base-files/files/etc/banner
cp -rf ../banner package/base-files/files/etc/
