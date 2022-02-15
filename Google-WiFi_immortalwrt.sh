#!/bin/bash
#=================================================
#   Description: DIY script
#   Lisence: MIT
#   Author: P3TERX
#   Blog: https://p3terx.com
#=================================================
#克隆源码
#git clone -b gale --single-branch https://github.com/computersforpeace/openwrt openwrt
git clone -b master --single-branch https://github.com/immortalwrt/immortalwrt openwrt
rm -rf openwrt/target
svn checkout https://github.com/computersforpeace/openwrt/branches/gale/target openwrt/target
[ -e files ] && mv files openwrt/files
cd openwrt
./scripts/feeds clean
./scripts/feeds update -a
./scripts/feeds install -a
wget -P scripts https://raw.githubusercontent.com/computersforpeace/openwrt/gale/scripts/gen_image_vboot.sh
chmod 755 scripts/gen_image_vboot.sh

#添加主题
git clone https://github.com/jerrykuku/luci-theme-argon.git package/luci-theme-argon-2.2.9
#添加自定义插件
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

#修改aria2的位置
#sed -i "/exit 0/i\sed -i 's/services/nas/g' /usr/lib/lua/luci/controller/aria2.lua" package/default-settings/files/zzz-default-settings

#添加简易网盘
#sed -i '/exit 0/i\mkdir -pv /srv/webd/web/.Trash' package/default-settings/files/zzz-default-settings
#sed -i '/exit 0/i\ln -sv /mnt/sda1 /srv/webd/web/U盘' package/default-settings/files/zzz-default-settings
#sed -i '/exit 0/i\ln -sv /mnt/mmcblk0p1/all /srv/webd/web/SD卡' package/default-settings/files/zzz-default-settings
#sed -i '/exit 0/i\chmod 775 /usr/bin/webd\n' package/default-settings/files/zzz-default-settings

#修改banner
#mv -f ../G-DOCK/Google_immortalwrt.default .config
mv -f ../G-DOCK/Google_immortalwrt*.config .config
