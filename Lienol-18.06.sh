#!/bin/bash
#=================================================
#   Description: DIY script
#   Lisence: MIT
#   Author: P3TERX
#   Blog: https://p3terx.com
#=================================================
#克隆源码
git clone -b dev-master https://github.com/Lienol/openwrt
cd openwrt
./scripts/feeds clean
./scripts/feeds update -a
./scripts/feeds install -a
#修改qb版本为421
#rm -rf package/lean/qBittorrent/Makefile
#rm -rf package/lean/qBittorrent/patches
#cp -f ../qb421 package/lean/qBittorrent/Makefile

#添加自己repo的插件的软连接
ln -s ../../luci-theme-argon1.5 ./package/

#修改lan口地址
sed -i 's/192.168.1.1/192.168.10.1/g' package/base-files/files/bin/config_generate

#修改机器名称
sed -i 's/OpenWrt/G-DOCK/g' package/base-files/files/bin/config_generate

#修改wifi名称
sed -i 's/OpenWrt/FK20100010/g' package/kernel/mac80211/files/lib/wifi/mac80211.sh

#修改时区
#sed -i "s/'UTC'/'CST-8'\n        set system.@system[-1].zonename='Asia\/Shanghai'/g" package/base-files/files/bin/config_generate

#修改zzz-default-settings的配置
#添加简易网盘
sed -i '/exit 0/i\mkdir -pv /srv/webd/web/.Trash\n' package/default-settings/files/zzz-default-settings
sed -i '/exit 0/i\ln -sv /mnt/sda /srv/webd/web/U盘\n' package/default-settings/files/zzz-default-settings
sed -i '/exit 0/i\ln -sv /mnt/mmcblk0p1/all /srv/webd/web/SD卡\n' package/default-settings/files/zzz-default-settings
sed -i '/exit 0/i\chmod 775 /usr/bin/webd' package/default-settings/files/zzz-default-settings

#修改banner
rm -rf package/base-files/files/etc/banner
cp -f ../banner package/base-files/files/etc/
[ -e ../G-DOCK/default.config ] && mv -f ../G-DOCK/default.config .config
[ -e ../G-DOCK/Lienol-18.06*.config ] && mv -f ../G-DOCK/Lienol-18.06*.config .config
