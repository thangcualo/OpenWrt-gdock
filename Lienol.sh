#!/bin/bash
#=================================================
#   Description: DIY script
#   Lisence: MIT
#   Author: P3TERX
#   Blog: https://p3terx.com
#=================================================
#克隆源码
git clone -b main --single-branch https://github.com/Lienol/openwrt openwrt
[ -e files ] && mv files openwrt/files
cd openwrt
#添加passwall
sed -i '$a src-git xiaorouji https://github.com/xiaorouji/openwrt-passwall.git' feeds.conf.default
./scripts/feeds clean
./scripts/feeds update -a
./scripts/feeds install -a

#改qb版本为4.2.5
#rm -rf package/lean/qBittorrent/Makefile
#rm -rf package/lean/qBittorrent/patches
#cp -rf ../qb425 package/lean/qBittorrent/Makefile
#sed -i 's/1.1.13/1.2.6/g' package/lean/rblibtorrent/Makefile
#sed -i 's/6f1250c6535730897909240ea0f4f2a81937d21a/a9968916ca82366f1c236af59aaecb9bc94ffe73/g' package/lean/rblibtorrent/Makefile

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
#git clone -b 18.06 https://github.com/jerrykuku/luci-theme-argon.git package/luci-theme-argon-1.7.2
#rm -rf package/luci-theme-argon-1.5.1/htdocs/luci-static/argon/head-icon.jpg
#rm -rf package/luci-theme-argon1.5/htdocs/luci-static/argon/img/
#cp -rf package/luci-theme-argon-1.x/htdocs/luci-static/argon/head-icon.jpg package/luci-theme-argon-1.5.1/htdocs/luci-static/argon/
#sed -i '/class="darkMask"/a \ \ \ <div class="login-bg" style="background-color: #5e72e4"></div>' package/luci-theme-argon-1.5.1/luasrc/view/themes/argon/header.htm
#sed -i '/background-image/d' package/luci-theme-argon-1.5.1/luasrc/view/themes/argon/header.htm

#修改banner
rm -rf package/base-files/files/etc/banner
cp -f ../banner package/base-files/files/etc/
[ -e ../G-DOCK/default.config ] && mv -f ../G-DOCK/default.config .config
[ -e ../G-DOCK/Lienol*.config ] && mv -f ../G-DOCK/Lienol*.config .config
