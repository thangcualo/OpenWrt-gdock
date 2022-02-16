#!/bin/bash
#=================================================
#   Description: DIY script
#   Lisence: MIT
#   Author: P3TERX
#   Blog: https://p3terx.com
#=================================================
#克隆源码
#git clone -b gale --single-branch https://github.com/computersforpeace/openwrt openwrt
git clone -b main --single-branch https://github.com/Lienol/openwrt openwrt
rm -rf openwrt/target
svn checkout https://github.com/computersforpeace/openwrt/branches/gale/target/linux/ipq40xx openwrt/target
[ -e files ] && mv files openwrt/files
cd openwrt
#wget -O Add-support-for-Chromium-OS-and-Google-WiFi.patch http://patchwork.ozlabs.org/series/224800/mbox/
#patch -p1 < Add-support-for-Chromium-OS-and-Google-WiFi.patch
#添加passwall
sed -i '$a src-git xiaorouji https://github.com/xiaorouji/openwrt-passwall.git' feeds.conf.default
./scripts/feeds clean
./scripts/feeds update -a
./scripts/feeds install -a

#添加主题
git clone https://github.com/jerrykuku/luci-theme-argon.git package/luci-theme-argon-2.2.9

#添加自定义插件
git clone https://github.com/small-5/luci-app-adblock-plus.git package/luci-app-adblock-plus
git clone https://github.com/ntlf9t/luci-app-easymesh package/luci-app-easymesh
git clone https://github.com/KFERMercer/luci-app-tcpdump.git package/luci-app-tcpdump
wget -O target/linux/generic/hack-5.10/953-net-patch-linux-kernel-to-support-shortcut-fe.patch https://raw.githubusercontent.com/Lienol/openwrt/main/target/linux/generic/hack-5.10/953-net-patch-linux-kernel-to-support-shortcut-fe.patch
wget -O target/linux/generic/hack-5.4/953-net-patch-linux-kernel-to-support-shortcut-fe.patch https://raw.githubusercontent.com/Lienol/openwrt/main/target/linux/generic/hack-5.4/953-net-patch-linux-kernel-to-support-shortcut-fe.patch

#修改lan口地址
sed -i 's/192.168.1.1/192.168.10.1/g' package/base-files/files/bin/config_generate
#修改机器名称
sed -i 's/OpenWrt/Google/g' package/base-files/files/bin/config_generate
#修改wifi名称
sed -i 's/OpenWrt/Google/g' package/kernel/mac80211/files/lib/wifi/mac80211.sh
#默认打开WiFi
sed -i 's/disabled=1/disabled=0/g' package/kernel/mac80211/files/lib/wifi/mac80211.sh
#修改时区
sed -i "s/'UTC'/'CST-8'\n        set system.@system[-1].zonename='Asia\/Shanghai'/g" package/base-files/files/bin/config_generate
#更改主机型号，支持中文。 
sed -i "s/Google WiFi (Gale)/谷歌路由器/g" target/linux/ipq40xx/files/arch/arm/boot/dts/qcom-ipq4019-wifi.dts

#修改zzz-default-settings的配置
#修改网络共享的位置
sed -i "/exit 0/i\sed -i 's/services/nas/g' /usr/lib/lua/luci/controller/ksmbd.lua" package/default-settings/files/zzz-default-settings
sed -i "/exit 0/i\sed -i 's/services/nas/g' /usr/share/luci/menu.d/luci-app-ksmbd.json" package/default-settings/files/zzz-default-settings

#修改aria2的位置
#sed -i "/exit 0/i\sed -i 's/services/nas/g' /usr/lib/lua/luci/controller/aria2.lua" package/default-settings/files/zzz-default-settings

#添加简易网盘
#sed -i '/exit 0/i\mkdir -pv /srv/webd/web/.Trash' package/default-settings/files/zzz-default-settings
#sed -i '/exit 0/i\ln -sv /mnt/sda1 /srv/webd/web/U盘' package/default-settings/files/zzz-default-settings
#sed -i '/exit 0/i\ln -sv /mnt/mmcblk0p1/all /srv/webd/web/SD卡' package/default-settings/files/zzz-default-settings
#sed -i '/exit 0/i\chmod 775 /usr/bin/webd\n' package/default-settings/files/zzz-default-settings

##
rm -rf scripts/gen_image_vboot.sh
wget -P scripts https://raw.githubusercontent.com/computersforpeace/openwrt/gale/scripts/gen_image_vboot.sh
chmod +x scripts/gen_image_vboot.sh

rm -rf package/base-files/files/lib/upgrade/common.sh
wget -P package/base-files/files/lib/upgrade https://raw.githubusercontent.com/computersforpeace/openwrt/gale/package/base-files/files/lib/upgrade/common.sh
chmod +x package/base-files/files/lib/upgrade/common.sh

rm -rf include/image-commands.mk
wget -P include https://raw.githubusercontent.com/computersforpeace/openwrt/gale/include/image-commands.mk

rm -rf package/base-files/Makefile
wget -P package/base-files https://raw.githubusercontent.com/computersforpeace/openwrt/gale/package/base-files/Makefile

rm -rf package/base-files/files/lib/upgrade/emmc.sh
wget -P package/base-files/files/lib/upgrade https://raw.githubusercontent.com/computersforpeace/openwrt/gale/package/base-files/files/lib/upgrade/emmc.sh
chmod +x scripts/gen_image_vboot.sh package/base-files/files/lib/upgrade/emmc.sh

rm -rf scripts/target-metadata.pl
wget -P scripts https://raw.githubusercontent.com/computersforpeace/openwrt/gale/scripts/target-metadata.pl
chmod +x scripts/target-metadata.pl

rm -rf target/Config.in
wget -P target https://raw.githubusercontent.com/computersforpeace/openwrt/gale/target/Config.in

rm -rf target/linux/ipq40xx/image/generic.mk
wget -P target/linux/ipq40xx/image https://raw.githubusercontent.com/computersforpeace/openwrt/gale/target/linux/ipq40xx/image/generic.mk
##

#修改banner
#mv -f ../G-DOCK/Google.default .config
mv -f ../G-DOCK/Google_Lienol*.config .config
