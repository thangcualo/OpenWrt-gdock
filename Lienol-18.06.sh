#!/bin/bash
#=================================================
#   Description: DIY script
#   Lisence: MIT
#   Author: P3TERX
#   Blog: https://p3terx.com
#=================================================
#git clone https://github.com/openwrt/openwrt.git
#git clone https://github.com/x-wrt/x-wrt.git
#git clone -b dev-master https://github.com/Lienol/openwrt lienol
#git clone https://github.com/coolsnowwolf/lede
#rm -rf lede/package/lean/luci-app-samba4
#rm -rf lede/package/lean/luci-app-frpc
#rm -rf openwrt/tools
#rm -rf openwrt/target/linux/ipq40xx/
#rm -rf openwrt/package/firmware/ipq-wifi/
#cp -rf lienol/tools openwrt
#cp -rf x-wrt/target/linux/ipq40xx/ openwrt/target/linux/
#cp -rf x-wrt/package/firmware/ipq-wifi/ openwrt/package/firmware/
#touch openwrt/target/linux/ipq40xx/
#touch openwrt/package/firmware/ipq-wifi/
#cp -rf lede/package/lean openwrt/package
#cp -rf files openwrt
#cd openwrt
#添加Lienol的插件包
#sed -i '/lienol/d' feeds.conf.default
#sed -i '$a src-git lienol https://github.com/Lienol/openwrt-package' feeds.conf.default
#sed -i '$a src-git lienol https://github.com/a736399919/lienol-openwrt-package' feeds.conf.default
#sed -i '$a src-git luci https://github.com/coolsnowwolf/luci' feeds.conf.default
#sed -i '$a src-git leanpackages https://github.com/coolsnowwolf/packages' feeds.conf.default
#./scripts/feeds clean
#./scripts/feeds update -a
#./scripts/feeds uninstall -a
#./scripts/feeds install -f -p lienol -a
#./scripts/feeds install -a
#克隆源码
git clone -b dev-master https://github.com/Lienol/openwrt
git clone https://github.com/coolsnowwolf/lede
rm -rf openwrt/package/lean/
cp -rf lede/package/lean/ openwrt/package/
cd openwrt
sed -i '/lienol/d' feeds.conf.default
sed -i '$a src-git lienol https://github.com/a736399919/lienol-openwrt-package' feeds.conf.default
sed -i '$a src-git leanpackages https://github.com/coolsnowwolf/packages' feeds.conf.default
./scripts/feeds clean
./scripts/feeds update -a
./scripts/feeds install -f -p lienol -a
./scripts/feeds install -a
#改qb版本为4.2.5
rm -rf package/lean/qBittorrent/Makefile
rm -rf package/lean/qBittorrent/patches
cp -rf ../qb425 package/lean/qBittorrent/Makefile
sed -i 's/1.1.13/1.2.6/g' package/lean/rblibtorrent/Makefile
sed -i 's/6f1250c6535730897909240ea0f4f2a81937d21a/a9968916ca82366f1c236af59aaecb9bc94ffe73/g' package/lean/rblibtorrent/Makefile

#主题
git clone -b 18.06 https://github.com/jerrykuku/luci-theme-argon.git package/luci-theme-argon-1.5.1
rm -rf package/luci-theme-argon-1.5.1/htdocs/luci-static/argon/head-icon.jpg
rm -rf package/luci-theme-argon-1.5.1/htdocs/luci-static/argon/img/
cp -rf ../luci-theme-argon-1.x/htdocs/luci-static/argon/head-icon.jpg package/luci-theme-argon-1.5.1/htdocs/luci-static/argon/
sed -i '/class="darkMask"/a \ \ \ <div class="login-bg" style="background-color: #5e72e4"></div>' package/luci-theme-argon-1.5.1/luasrc/view/themes/argon/header.htm
sed -i '/background-image/d' package/luci-theme-argon-1.5.1/luasrc/view/themes/argon/header.htm

git clone https://github.com/jerrykuku/luci-theme-argon.git package/luci-theme-argon-2.1
rm -rf package/luci-theme-argon-2.1/htdocs/luci-static/argon/head-icon.jpg
rm -rf package/luci-theme-argon-2.1/htdocs/luci-static/argon/img/
cp -rf ../luci-theme-argon-1.x/htdocs/luci-static/argon/head-icon.jpg package/luci-theme-argon-2.1/htdocs/luci-static/argon/
sed -i '/class="darkMask"/a \ \ \ <div class="login-bg" style="background-color: #5e72e4"></div>' package/luci-theme-argon-2.1/luasrc/view/themes/argon/header.htm
sed -i '/background-image/d' package/luci-theme-argon-2.1/luasrc/view/themes/argon/header.htm
#添加自己repo的插件的软连接
ln -s ../../luci-theme-argon-1.x ./package/
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


#修改zzz-default-settings的配置
#sed -i 's/services/nas/g' package/lean/luci-app-samba4/luasrc/controller/samba4.lua
#添加简易网盘
sed -i '/exit 0/i\mkdir -pv /srv/webd/web/.Trash\n' package/lean/default-settings/files/zzz-default-settings
sed -i '/exit 0/i\ln -sv /mnt/sda1 /srv/webd/web/U盘\n' package/lean/default-settings/files/zzz-default-settings
sed -i '/exit 0/i\ln -sv /mnt/mmcblk0p1/all /srv/webd/web/SD卡\n' package/lean/default-settings/files/zzz-default-settings
sed -i '/exit 0/i\chmod 775 /usr/bin/webd' package/lean/default-settings/files/zzz-default-settings

#修改banner
rm -rf package/base-files/files/etc/banner
cp -f ../banner package/base-files/files/etc/
[ -e ../G-DOCK/default.config ] && mv -f ../G-DOCK/default.config .config
#[ -e ../G-DOCK/Lienol-18.06*.config ] && mv -f ../G-DOCK/Lienol-18.06*.config .config
rm -rf .config
cp -rf ../5435 .config
cp -rf ../G-DOCK/zzz-default-settings package/default-settings/files/zzz-default-settings
