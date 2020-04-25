#!/bin/bash
#=================================================
#   Description: DIY script
#   Lisence: MIT
#   Author: P3TERX
#   Blog: https://p3terx.com
#=================================================
cd ../
rm -rf openwrt
git clone https://github.com/openwrt/openwrt.git
git clone https://github.com/x-wrt/x-wrt.git
git clone -b dev-master https://github.com/Lienol/openwrt lienol
git clone https://github.com/coolsnowwolf/lede
rm -rf openwrt/tools
rm -rf openwrt/target/linux/ipq40xx/
rm -rf openwrt/package/firmware/ipq-wifi/
cp -rf lienol/tools openwrt
cp -rf x-wrt/target/linux/ipq40xx/ openwrt/target/linux/
cp -rf x-wrt/package/firmware/ipq-wifi/ openwrt/package/firmware/
touch openwrt/target/linux/ipq40xx/
touch openwrt/package/firmware/ipq-wifi/
cp -rf lede/package/lean openwrt/package
cd openwrt
#添加Lienol的插件包
#sed -i '$a src-git lienol https://github.com/Lienol/openwrt-package' feeds.conf.default
sed -i '$a src-git lienol https://github.com/a736399919/lienol-openwrt-package' feeds.conf.default
./scripts/feeds update -a
./scripts/feeds install -a
#添加自定义插件
#git clone https://github.com/Ameykyl/luci-app-koolproxyR.git package/luci-app-koolproxyR
#git clone https://github.com/tty228/luci-app-serverchan.git package/luci-app-serverchan
#git clone https://github.com/maxlicheng/luci-app-unblockmusic.git package/luci-app-unblockmusic
git clone https://github.com/jerrykuku/luci-theme-argon.git package/luci-theme-argon-2.1

git clone -b 18.06 https://github.com/jerrykuku/luci-theme-argon.git package/luci-theme-argon-1.5.1
rm -rf package/luci-theme-argon-2.1/htdocs/luci-static/argon/head-icon.jpg
rm -rf package/luci-theme-argon-2.1/htdocs/luci-static/argon/img/
cp -rf ../luci-theme-argon-1.x/htdocs/luci-static/argon/head-icon.jpg package/luci-theme-argon-2.1/htdocs/luci-static/argon/
sed -i '/class="darkMask"/a \ \ \ <div class="login-bg" style="background-color: #5e72e4"></div>' package/luci-theme-argon-2.1/luasrc/view/themes/argon/header.htm
sed -i '/background-image/d' package/luci-theme-argon-2.1/luasrc/view/themes/argon/header.htm

#添加自己repo的插件的软连接
ln -s ../../luci-theme-argon1.x ./package/
#cp -rf ../G-DOCK/luci-app-passwall package

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

#改4.19内核
#sed -i 's/4.14/4.19/g' target/linux/ipq40xx/Makefile
#修改zzz-default-settings的配置
#sed -i 's/services/nas/g' package/lean/luci-app-samba4/luasrc/controller/samba4.lua
#sed -i 's/samba.lua/samba4.lua/g' package/lean/default-settings/files/zzz-default-settings
#sed -i '/exit 0/i\chmod 755 /etc/init.d/serverchan' package/lean/default-settings/files/zzz-default-settings
#sed -i '/exit 0/i\chmod 755 /usr/bin/serverchan/serverchan' package/lean/default-settings/files/zzz-default-settings
#sed -i '/exit 0/i\echo 0xDEADBEEF > /etc/config/google_fu_mode\n' package/lean/default-settings/files/zzz-default-settings

#添加简易网盘
sed -i '/exit 0/i\mkdir -pv /srv/webd/web/.Trash\n' package/lean/default-settings/files/zzz-default-settings
sed -i '/exit 0/i\ln -sv /mnt/sda1 /srv/webd/web/U盘\n' package/lean/default-settings/files/zzz-default-settings
sed -i '/exit 0/i\ln -sv /mnt/mmcblk0p1/all /srv/webd/web/SD卡\n' package/lean/default-settings/files/zzz-default-settings
sed -i '/exit 0/i\chmod 775 /usr/bin/webd' package/lean/default-settings/files/zzz-default-settings

#修改banner
rm -rf package/base-files/files/etc/banner
cp -f ../banner package/base-files/files/etc/
