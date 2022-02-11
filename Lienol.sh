#!/bin/bash
#=================================================
#   Description: DIY script
#   Lisence: MIT
#   Author: P3TERX
#   Blog: https://p3terx.com
#=================================================
#克隆源码
git clone -b 21.02 --single-branch https://github.com/Lienol/openwrt openwrt
#git clone -b openwrt-21.02 --single-branch https://github.com/immortalwrt/immortalwrt openwrt
#git clone -b main --single-branch https://github.com/Lienol/openwrt openwrt
[ -e files ] && mv files openwrt/files
cd openwrt
#添加passwall
#sed -i '$a src-git xiaorouji https://github.com/xiaorouji/openwrt-passwall.git' feeds.conf.default
#./scripts/feeds clean
#./scripts/feeds update -a
#./scripts/feeds install -a

#改qb版本为4.2.5
#rm -rf package/lean/qBittorrent/Makefile
#rm -rf package/lean/qBittorrent/patches
#cp -rf ../qb425 package/lean/qBittorrent/Makefile
#sed -i 's/1.1.13/1.2.6/g' package/lean/rblibtorrent/Makefile
#sed -i 's/6f1250c6535730897909240ea0f4f2a81937d21a/a9968916ca82366f1c236af59aaecb9bc94ffe73/g' package/lean/rblibtorrent/Makefile

#添加自己repo的插件的软连接或copy
#ln -s ../../luci-theme-argon-1.x ./package/
#cp -rf ../G-DOCK/luci-app-passwall package

##添加openwrt-usb-modeswitch-official
#git clone https://github.com/gzhechu/openwrt-usb-modeswitch-official.git package/openwrt-usb-modeswitch-official
#sed -i 's/2.2.0/2.6.0/g' package/openwrt-usb-modeswitch-official/Makefile
#sed -i 's/f323fe700edd6ea404c40934ddf32b22/be73dcc84025794081a1d4d4e5a75e4c/g' package/openwrt-usb-modeswitch-official/Makefile
#sed -i 's/20140529/20191128/g' package/openwrt-usb-modeswitch-official/Makefile
#sed -i 's/dff94177781298aaf0b3c2a3c3dea6b2/e8fce7eb949cbe16c61fb71bade4cc17/g' package/openwrt-usb-modeswitch-official/Makefile
##添加ZTE-MF832S网卡
#cp -rf ../ZTE-MF832S/* files/etc/
#添加usbwan(把txt文件的内容添加到zzz-default-settings文件)
#sed -i -e '/exit 0/{h;s/.*/cat ../G-DOCK/add-usbwan/e;G}' package/default-settings/files/zzz-default-settings或
#sed  -i -e '/exit 0/r ../G-DOCK/add-usbwan' -e 'x;$G' package/default-settings/files/zzz-default-settings

#添加主题
svn co https://github.com/kenzok8/openwrt-packages/trunk/luci-theme-edge package/luci-theme-edge
git clone -b 18.06 https://github.com/jerrykuku/luci-theme-argon.git package/luci-theme-argon-1.7.2
git clone https://github.com/jerrykuku/luci-theme-argon.git package/luci-theme-argon-2.2.9

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
#修改网络共享的位置
sed -i "/exit 0/i\sed -i 's/services/nas/g' /usr/lib/lua/luci/controller/samba4.lua" package/default-settings/files/zzz-default-settings
sed -i "/exit 0/i\sed -i 's/services/nas/g' /usr/share/luci/menu.d/luci-app-samba4.json" package/default-settings/files/zzz-default-settings

#修改aria2的位置
sed -i "/exit 0/i\sed -i 's/services/nas/g' /usr/lib/lua/luci/controller/aria2.lua" package/default-settings/files/zzz-default-settings
#修改oaf的位置
sed -i "/exit 0/i\sed -i 's/network/control/g' /usr/lib/lua/luci/controller/appfilter.lua" package/default-settings/files/zzz-default-settings
#添加简易网盘
sed -i '/exit 0/i\mkdir -pv /srv/webd/web/.Trash' package/default-settings/files/zzz-default-settings
sed -i '/exit 0/i\ln -sv /mnt/sda1 /srv/webd/web/U盘' package/default-settings/files/zzz-default-settings
sed -i '/exit 0/i\ln -sv /mnt/mmcblk0p1/all /srv/webd/web/SD卡' package/default-settings/files/zzz-default-settings
sed -i '/exit 0/i\chmod 775 /usr/bin/webd\n' package/default-settings/files/zzz-default-settings

#修改banner
rm -rf package/base-files/files/etc/banner
cp -f ../banner package/base-files/files/etc/
#mv -f ../G-DOCK/Lienol.default .config
mv -f ../G-DOCK/Lienol*.config .config
