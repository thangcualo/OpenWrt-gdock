#!/bin/bash
#=================================================
#   Description: DIY script
#   Lisence: MIT
#   Author: P3TERX
#   Blog: https://p3terx.com
#=================================================
#克隆源码
git clone -b dev-19.07 https://github.com/Lienol/openwrt
git clone https://github.com/coolsnowwolf/lede
git clone https://github.com/coolsnowwolf/luci.git
rm -rf lede/package/lean/default-settings
rm -rf lede/package/lean/openwrt-fullconenat
rm -rf openwrt/package/lean/
cp -rf lede/package/lean/ openwrt/package/
cd openwrt
#sed -i '$a src-git lienol https://github.com/a736399919/lienol-openwrt-package' feeds.conf.default
sed -i '$a src-git leanpackages https://github.com/coolsnowwolf/packages' feeds.conf.default
./scripts/feeds clean
./scripts/feeds update -a
./scripts/feeds install -a
rm -rf feeds/luci/applications/luci-app-aria2
cp -rf ../luci/applications/luci-app-aria2/ feeds/luci/applications/

#改qb版本为4.2.5
rm -rf package/lean/qBittorrent/Makefile
rm -rf package/lean/qBittorrent/patches
cp -rf ../qb425 package/lean/qBittorrent/Makefile
sed -i 's/1.1.13/1.2.6/g' package/lean/rblibtorrent/Makefile
sed -i 's/6f1250c6535730897909240ea0f4f2a81937d21a/a9968916ca82366f1c236af59aaecb9bc94ffe73/g' package/lean/rblibtorrent/Makefile

#添加自己repo的插件的软连接或copy
ln -s ../../luci-theme-argon1.x ./package/
cp -rf ../G-DOCK/luci-app-passwall package
#修改lan口地址
sed -i 's/192.168.1.1/192.168.10.1/g' package/base-files/files/bin/config_generate

#修改机器名称
sed -i 's/OpenWrt/G-DOCK/g' package/base-files/files/bin/config_generate

#修改wifi名称
sed -i 's/OpenWrt/FK20100010/g' package/kernel/mac80211/files/lib/wifi/mac80211.sh
#默认打开WiFi
sed -i 's/disabled=1/disabled=0/g' package/kernel/mac80211/files/lib/wifi/mac80211.sh

#修改时区
#sed -i "s/'UTC'/'CST-8'\n        set system.@system[-1].zonename='Asia\/Shanghai'/g" package/base-files/files/bin/config_generate

#修改zzz-default-settings的配置
#添加简易网盘
sed -i '/exit 0/i\mkdir -pv /srv/webd/web/.Trash\n' package/default-settings/files/zzz-default-settings
sed -i '/exit 0/i\ln -sv /mnt/sda1 /srv/webd/web/U盘\n' package/default-settings/files/zzz-default-settings
sed -i '/exit 0/i\ln -sv /mnt/mmcblk0p1/all /srv/webd/web/SD卡\n' package/default-settings/files/zzz-default-settings
sed -i '/exit 0/i\chmod 775 /usr/bin/webd' package/default-settings/files/zzz-default-settings

#修改banner
rm -rf package/base-files/files/etc/banner
cp -f ../banner package/base-files/files/etc/
[ -e ../G-DOCK/default.config ] && mv -f ../G-DOCK/default.config .config
#[ -e ../G-DOCK/Lienol-19.07*.config ] && mv -f ../G-DOCK/Lienol-18.06*.config .config
rm -rf .config
cp -rf ../5438 .config
cp -rf ../G-DOCK/zzz-default-settings package/default-settings/files/zzz-default-settings

