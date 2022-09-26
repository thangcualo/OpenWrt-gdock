#!/bin/bash
#=================================================
#   Description: DIY script
#   Lisence: MIT
#   Author: P3TERX
#   Blog: https://p3terx.com
#=================================================
#克隆源码
#git clone -b openwrt-21.02 --single-branch https://github.com/immortalwrt/immortalwrt openwrt
git clone -b master --single-branch https://github.com/immortalwrt/immortalwrt openwrt
[ -e files ] && mv files openwrt/files
cd openwrt
./scripts/feeds update -a && ./scripts/feeds install -a

#添加主题
git clone https://github.com/jerrykuku/luci-theme-argon.git package/luci-theme-argon-2.2.9

#添加自定义插件
git clone https://github.com/small-5/luci-app-adblock-plus.git package/luci-app-adblock-plus
git clone https://github.com/ntlf9t/luci-app-easymesh package/luci-app-easymesh
git clone https://github.com/KFERMercer/luci-app-tcpdump.git package/luci-app-tcpdump

svn checkout https://github.com/Hyy2001X/AutoBuild-Packages/trunk/luci-app-webd package/luci-app-webd
svn checkout https://github.com/Hyy2001X/AutoBuild-Packages/trunk/webd package/webd
#sed -i '$a chmod 775 /usr/bin/webd\n' package/emortal/default-settings/files/99-default-settings

#修改lan口地址
sed -i 's/192.168.1.1/192.168.5.1/g' package/base-files/files/bin/config_generate
#修改机器名称
sed -i 's/ImmortalWrt/GDOCK/g' package/base-files/files/bin/config_generate
#修改wifi名称
sed -i 's/OpenWrt/GDOCK/g' package/kernel/mac80211/files/lib/wifi/mac80211.sh
#默认打开WiFi
sed -i 's/disabled=1/disabled=0/g' package/kernel/mac80211/files/lib/wifi/mac80211.sh
#修改时区
sed -i "s/'UTC'/'CST-8'\n        set system.@system[-1].zonename='Asia\/Shanghai'/g" package/base-files/files/bin/config_generate
#更改主机型号，支持中文。 
sed -i "s/P&W R619AC 128M/竞斗云2.0/g" target/linux/ipq40xx/files/arch/arm/boot/dts/qcom-ipq4019-r619ac-128m.dts

#修改zzz-default-settings的配置
#删除包含"exit 0"的行
sed -i '/exit 0/d' package/emortal/default-settings/files/99-default-settings
#添加LingMaxDNS
#chmod +x files/etc/LingMaxDns_linux_arm
#chmod +x files/etc/init.d/LingMaxDns
#sed -i '$a ln -s /etc/init.d/LingMaxDns /etc/rc.d/S999LingMaxDns' package/emortal/default-settings/files/99-default-settings
#sed -i '$a sed -i '\''$a iptables -t nat -A PREROUTING -p udp --dport 53 -j REDIRECT --to-ports 8287'\'' /etc/firewall.user' package/emortal/default-settings/files/99-default-settings

#修改网络共享的位置
sed -i '$a sed -i '\''s/services/nas/g'\'' /usr/lib/lua/luci/controller/samba4.lua' package/emortal/default-settings/files/99-default-settings
sed -i '$a\sed -i '\''s/services/nas/g'\'' /usr/share/luci/menu.d/luci-app-samba4.json' package/emortal/default-settings/files/99-default-settings
sed -i '$a\sed -i '\''s/services/nas/g'\'' /usr/lib/lua/luci/controller/ksmbd.lua' package/emortal/default-settings/files/99-default-settings
sed -i '$a\sed -i '\''s/services/nas/g'\'' /usr/share/luci/menu.d/luci-app-ksmbd.json' package/emortal/default-settings/files/99-default-settings

#修改aria2的位置
#sed -i '$a sed -i '\''s/services/nas/g'\'' /usr/lib/lua/luci/controller/aria2.lua' package/emortal/default-settings/files/99-default-settings
#修改oaf的位置
#sed -i '$a sed -i '\''s/network/control/g'\'' /usr/lib/lua/luci/controller/appfilter.lua' package/emortal/default-settings/files/99-default-settings
#添加包含"exit 0"的行
sed -i '$a\exit 0' package/emortal/default-settings/files/99-default-settings

rm -rf package/base-files/files/etc/banner
cp -rf ../banner package/base-files/files/etc/
#mv -f ../G-DOCK/immortalwrt.default .config
mv -f ../G-DOCK/immortalwrt-*.config .config
