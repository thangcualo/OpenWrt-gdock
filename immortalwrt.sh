#!/bin/bash
#=================================================
#   Description: DIY script
#   Lisence: MIT
#   Author: P3TERX
#   Blog: https://p3terx.com
#=================================================
#克隆源码
git clone -b 22.03 --single-branch https://github.com/Lienol/openwrt openwrt
#git clone -b main --single-branch https://github.com/Lienol/openwrt openwrt
cd openwrt
./scripts/feeds clean
./scripts/feeds update -a
./scripts/feeds install -a

#添加主题
git clone https://github.com/jerrykuku/luci-theme-argon.git package/luci-theme-argon-2.2.9

#修改机器名称
sed -i 's/OpenWrt/K2P/g' package/base-files/files/bin/config_generate
#修改wifi名称
sed -i 's/OpenWrt/K2P/g' package/kernel/mac80211/files/lib/wifi/mac80211.sh
#默认打开WiFi
sed -i 's/disabled=1/disabled=0/g' package/kernel/mac80211/files/lib/wifi/mac80211.sh
#修改时区
#sed -i "s/'UTC'/'CST-8'\n        set system.@system[-1].zonename='Asia\/Shanghai'/g" package/base-files/files/bin/config_generate
mv -f ../G-DOCK/k2p.config .config


