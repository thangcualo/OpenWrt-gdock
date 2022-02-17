#!/bin/bash
#=================================================
#   Description: DIY script
#   Lisence: MIT
#   Author: P3TERX
#   Blog: https://p3terx.com
#=================================================
#克隆源码
git clone -b master --single-branch https://github.com/immortalwrt/immortalwrt
[ -e files ] && mv files immortalwrt/files
cd immortalwrt
./scripts/feeds update -a && ./scripts/feeds install -a

#添加主题
#git clone https://github.com/jerrykuku/luci-theme-argon.git package/luci-theme-argon-2.2.9

#添加自定义插件
git clone https://github.com/small-5/luci-app-adblock-plus.git package/luci-app-adblock-plus
git clone https://github.com/ntlf9t/luci-app-easymesh package/luci-app-easymesh
git clone https://github.com/KFERMercer/luci-app-tcpdump.git package/luci-app-tcpdump

#修改lan口地址
sed -i 's/192.168.1.1/192.168.10.1/g' package/base-files/files/bin/config_generate
#修改机器名称
sed -i 's/OpenWrt/Gdock/g' package/base-files/files/bin/config_generate
#修改wifi名称
sed -i 's/OpenWrt/Gdock/g' package/kernel/mac80211/files/lib/wifi/mac80211.sh
#默认打开WiFi
sed -i 's/disabled=1/disabled=0/g' package/kernel/mac80211/files/lib/wifi/mac80211.sh
#修改时区
sed -i "s/'UTC'/'CST-8'\n        set system.@system[-1].zonename='Asia\/Shanghai'/g" package/base-files/files/bin/config_generate
#更改主机型号，支持中文。 
sed -i "s/P&W R619AC 128M/竞斗云2.0/g" target/linux/ipq40xx/files/arch/arm/boot/dts/qcom-ipq4019-r619ac-128m.dts

#修改zzz-default-settings的配置
#修改网络共享的位置
sed -i "/exit 0/i\sed -i 's/services/nas/g' /usr/lib/lua/luci/controller/ksmbd.lua" package/emortal/default-settings/files/99-default-settings
sed -i "/exit 0/i\sed -i 's/services/nas/g' /usr/share/luci/menu.d/luci-app-ksmbd.json" package/emortal/default-settings/files/99-default-settings

#修改aria2的位置
#sed -i "/exit 0/i\sed -i 's/services/nas/g' /usr/lib/lua/luci/controller/aria2.lua" package/emortal/default-settings/files/99-default-settings
#添加简易网盘
sed -i '/exit 0/i\mkdir -pv /srv/webd/web/.Trash' package/emortal/default-settings/files/99-default-settings
sed -i '/exit 0/i\ln -sv /mnt/sda1 /srv/webd/web/U盘' package/emortal/default-settings/files/99-default-settings
sed -i '/exit 0/i\ln -sv /mnt/mmcblk0p1/all /srv/webd/web/SD卡' package/emortal/default-settings/files/99-default-settings
sed -i '/exit 0/i\chmod 775 /usr/bin/webd\n' package/emortal/default-settings/files/99-default-settings

rm -rf package/base-files/files/etc/banner
cp -rf ../banner package/base-files/files/etc/
#mv -f ../G-DOCK/immortalwrt.config .config
mv -f ../G-DOCK/immortalwrt*.config .config
