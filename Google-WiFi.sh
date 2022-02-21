#!/bin/bash
#=================================================
#   Description: DIY script
#   Lisence: MIT
#   Author: P3TERX
#   Blog: https://p3terx.com
#=================================================
#克隆源码
git clone -b gale --single-branch https://github.com/computersforpeace/openwrt openwrt
[ -e files ] && mv files openwrt/files
cd openwrt
#添加passwall&other
sed -i '$a src-git xiaorouji https://github.com/xiaorouji/openwrt-passwall.git;dev' feeds.conf.default
sed -i '$a src-git lienol https://github.com/Lienol/openwrt-package.git;main' feeds.conf.default
sed -i '$a src-git other https://github.com/Lienol/openwrt-package.git;other' feeds.conf.default
./scripts/feeds clean
./scripts/feeds update -a
./scripts/feeds install -a

#添加主题
svn checkout https://github.com/Lienol/openwrt/branches/main/package/default-settings package/default-settings
svn checkout https://github.com/Lienol/openwrt-luci/branches/main/themes/luci-theme-argon package/luci-theme-argon
svn checkout https://github.com/Lienol/openwrt-luci/branches/main/themes/luci-theme-material package/luci-theme-material
#git clone https://github.com/jerrykuku/luci-theme-argon.git package/luci-theme-argon-2.2.9

#添加自定义插件
svn checkout https://github.com/immortalwrt/luci/trunk/applications/luci-app-cpufreq package/luci-app-cpufreq
git clone https://github.com/small-5/luci-app-adblock-plus.git package/luci-app-adblock-plus
git clone https://github.com/ntlf9t/luci-app-easymesh package/luci-app-easymesh
git clone https://github.com/KFERMercer/luci-app-tcpdump.git package/luci-app-tcpdump


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
#sed -i "/exit 0/i\sed -i 's/services/nas/g' /usr/lib/lua/luci/controller/samba4.lua" package/default-settings/files/zzz-default-settings
#sed -i "/exit 0/i\sed -i 's/services/nas/g' /usr/share/luci/menu.d/luci-app-samba4.json" package/default-settings/files/zzz-default-settings
sed -i "/exit 0/i\sed -i 's/services/nas/g' /usr/lib/lua/luci/controller/ksmbd.lua" package/default-settings/files/zzz-default-settings
sed -i "/exit 0/i\sed -i 's/services/nas/g' /usr/share/luci/menu.d/luci-app-ksmbd.json" package/default-settings/files/zzz-default-settings


#修改aria2的位置
#sed -i "/exit 0/i\sed -i 's/services/nas/g' /usr/lib/lua/luci/controller/aria2.lua" package/default-settings/files/zzz-default-settings

#添加简易网盘
#sed -i '/exit 0/i\mkdir -pv /srv/webd/web/.Trash' package/default-settings/files/zzz-default-settings
#sed -i '/exit 0/i\ln -sv /mnt/sda1 /srv/webd/web/U盘' package/default-settings/files/zzz-default-settings
#sed -i '/exit 0/i\ln -sv /mnt/mmcblk0p1/all /srv/webd/web/SD卡' package/default-settings/files/zzz-default-settings
#sed -i '/exit 0/i\chmod 775 /usr/bin/webd\n' package/default-settings/files/zzz-default-settings

#修改banner
#mv -f ../G-DOCK/Google.default .config
mv -f ../G-DOCK/Google_gale*.config .config

rm -rf package/kernel/mac80211
rm -rf package/network 
rm -rf package/system
svn checkout https://github.com/Lienol/openwrt/branches/main/package/kernel/mac80211 package/kernel/mac80211
svn checkout https://github.com/Lienol/openwrt/branches/main/package/kernel/shortcut-fe package/kernel/shortcut-fe
svn checkout https://github.com/Lienol/openwrt/branches/main/package/network package/network 
svn checkout https://github.com/Lienol/openwrt/branches/main/package/system package/system

wget -O target/linux/generic/hack-5.10/601-netfilter-export-udp_get_timeouts-function.patch https://raw.githubusercontent.com/Lienol/openwrt/main/target/linux/generic/hack-5.10/601-netfilter-export-udp_get_timeouts-function.patch

wget -O target/linux/generic/hack-5.10/952-net-conntrack-events-support-multiple-registrant.patch https://raw.githubusercontent.com/Lienol/openwrt/main/target/linux/generic/hack-5.10/952-net-conntrack-events-support-multiple-registrant.patch

wget -O target/linux/generic/hack-5.10/953-net-patch-linux-kernel-to-support-shortcut-fe.patch https://raw.githubusercontent.com/Lienol/openwrt/main/target/linux/generic/hack-5.10/953-net-patch-linux-kernel-to-support-shortcut-fe.patch

wget -O target/linux/ipq40xx/patches-5.10/999-ipq40xx-unlock-cpu-frequency.patch https://raw.githubusercontent.com/immortalwrt/immortalwrt/master/target/linux/ipq40xx/patches-5.10/999-ipq40xx-unlock-cpu-frequency.patch
