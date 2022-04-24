#!/bin/bash
#=================================================
#   Description: DIY script
#   Lisence: MIT
#   Author: P3TERX
#   Blog: https://p3terx.com
#=================================================
#克隆源码
git clone https://github.com/coolsnowwolf/lede openwrt
cd openwrt
./scripts/feeds update -a && ./scripts/feeds install -a

#添加主题
git clone https://github.com/thinktip/luci-theme-neobird.git package/luci-theme-neobird
svn co https://github.com/kenzok8/openwrt-packages/trunk/luci-theme-edge package/luci-theme-edge
git clone https://github.com/jerrykuku/luci-theme-argon.git package/luci-theme-argon-1.7.2
git clone https://github.com/jerrykuku/luci-theme-argon.git package/luci-theme-argon-2.2.9

#修改机器名称
sed -i 's/OpenWrt/K2P/g' package/base-files/files/bin/config_generate
#修改wifi名称
sed -i 's/OpenWrt/K2P/g' package/kernel/mac80211/files/lib/wifi/mac80211.sh
#默认打开WiFi
sed -i 's/disabled=1/disabled=0/g' package/kernel/mac80211/files/lib/wifi/mac80211.sh
#修改时区
sed -i "s/'UTC'/'CST-8'\n        set system.@system[-1].zonename='Asia\/Shanghai'/g" package/base-files/files/bin/config_generate
#更改主机型号，支持中文。 
#sed -i "s/P&W R619AC 128M/竞斗云2.0/g" target/linux/ipq40xx/files/arch/arm/boot/dts/qcom-ipq4019-r619ac-128m.dts

mv -f ../temp-k2p.config .config
