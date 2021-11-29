#!/bin/bash
#=================================================
#   Description: DIY script
#   Lisence: MIT
#   Author: P3TERX
#   Blog: https://p3terx.com
#=================================================
git clone -b main --single-branch https://github.com/Lienol/openwrt openwrt
#添加passwall
sed -i '$a src-git xiaorouji https://github.com/xiaorouji/openwrt-passwall.git' openwrt/feeds.conf.default

cd openwrt
./scripts/feeds update -a
./scripts/feeds install -a
#移除不用软件包
rm -rf package/lean/luci-app-dockerman
rm -rf package/lean/luci-app-wrtbwmon
rm -rf feeds/packages/net/smartdns

#add luci-app-dockerman
svn co https://github.com/lisaac/luci-app-dockerman/trunk/applications/luci-app-dockerman package/luci-app-dockerman
#添加argon主题
git clone https://github.com/jerrykuku/luci-theme-argon.git package/luci-theme-argon-2.2.9
svn co https://github.com/kenzok8/openwrt-packages/trunk/luci-theme-edge package/luci-theme-edge
git clone -b 18.06 https://github.com/jerrykuku/luci-theme-argon.git package/luci-theme-argon-1.7.2
git clone https://github.com/jerrykuku/luci-app-argon-config package/luci-app-argon-config
#添加简易网盘
[ -e ../S905/files ] && mv ../S905/files openwrt/files
sed -i '/exit 0/i\mkdir -pv /srv/webd/web/.Trash' package/default-settings/files/zzz-default-settings
sed -i '/exit 0/i\ln -sv /mnt/mmcblk1p4/All-in-one /srv/webd/web/SD卡' package/default-settings/files/zzz-default-settings
sed -i '/exit 0/i\chmod 775 /usr/bin/webd\n' package/default-settings/files/zzz-default-settings
#修改Samba4d的位置
sed -i "/exit 0/i\sed -i 's/services/nas/g' /usr/lib/lua/luci/controller/samba4.lua" package/default-settings/files/zzz-default-settings
sed -i "/exit 0/i\sed -i 's/services/nas/g' /usr/share/luci/menu.d/luci-app-samba4.json" package/default-settings/files/zzz-default-settings
#添加自定义插件
#rm -rf package/lean/luci-app-turboacc
#svn co https://github.com/coolsnowwolf/lede/trunk/package/lean/luci-app-turboacc package/lean/luci-app-turboacc
#svn co https://github.com/coolsnowwolf/lede/trunk/package/lean/dnsforwarder package/lean/dnsforwarder
#svn co https://github.com/coolsnowwolf/lede/trunk/package/lean//shortcut-fe/simulated-driver package/lean//shortcut-fe/simulated-driver
添加插件
git clone https://github.com/small-5/luci-app-adblock-plus.git package/luci-app-adblock-plus
svn co https://github.com/ophub/luci-app-amlogic/trunk/luci-app-amlogic package/luci-app-amlogic
#
sed -i 's/4.14.7/4.15.2/g' package/feeds/packages/samba4/Makefile
sed -i 's/6f50353f9602aa20245eb18ceb00e7e5ec793df0974aebd5254c38f16d8f1906/6281d7c6a8c49f7990a9f249a66784b35180fe249557ef1147cd8a6d166a2113/g' package/feeds/packages/samba4/Makefile


[ -e ../S905/s905-Lienol.config ] && mv -f ../S905/s905-Lienol.config .config

