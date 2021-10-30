#!/bin/bash
#=================================================
#   Description: DIY script
#   Lisence: MIT
#   Author: P3TERX
#   Blog: https://p3terx.com
#=================================================
#克隆源码
git clone https://github.com/x-wrt/x-wrt.git openwrt
rm -rf openwrt/tools
svn co https://github.com/coolsnowwolf/lede/trunk/tools openwrt/tools
[ -e files ] && mv files openwrt/files
cd openwrt
sed -i '/luci/d' feeds.conf.default
sed -i '1a\src-git luci https://git.openwrt.org/project/luci.git' feeds.conf.default
#添加passwall
sed -i '$a src-git xiaorouji https://github.com/xiaorouji/openwrt-passwall.git' feeds.conf.default
./scripts/feeds update -a
./scripts/feeds install -a

#添加自定义插件
svn co https://github.com/Lienol/openwrt-package/trunk/luci-app-fileassistant package/luci-app-fileassistan
svn co https://github.com/coolsnowwolf/lede/trunk/package/lean/luci-app-cpufreq package/luci-app-cpufreq
svn co https://github.com/coolsnowwolf/lede/trunk/package/lean/luci-app-netdata package/luci-app-netdata
svn co https://github.com/coolsnowwolf/lede/trunk/package/lean/luci-app-vlmcsd package/luci-app-vlmcsd
svn co https://github.com/coolsnowwolf/lede/trunk/package/lean/vlmcsd package/vlmcsd
git clone https://github.com/UnblockNeteaseMusic/luci-app-unblockneteasemusic.git package/luci-app-unblockneteasemusic
git clone https://github.com/jerrykuku/luci-theme-argon.git package/luci-theme-argon-2.2.9

#修改lan口地址
sed -i 's/192.168.15.1/192.168.10.1/g' package/base-files/files/bin/config_generate

#修改机器名称
sed -i 's/OpenWrt/G-DOCK/g' package/base-files/files/bin/config_generate

#修改wifi名称
sed -i 's/OpenWrt/FK20100010/g' package/kernel/mac80211/files/lib/wifi/mac80211.sh
#默认打开WiFi
sed -i 's/disabled=1/disabled=0/g' package/kernel/mac80211/files/lib/wifi/mac80211.sh

#修改时区
#sed -i "s/'UTC'/'CST-8'\n        set system.@system[-1].zonename='Asia\/Shanghai'/g" package/base-files/files/bin/config_generate

#添加简易网盘
svn co https://github.com/coolsnowwolf/lede/trunk/package/lean/default-settings package/default-settings
echo '#!/bin/sh' > package/default-settings/files/zzz-default-settings
echo "mkdir -pv /srv/webd/web/.Trash" >> package/default-settings/files/zzz-default-settings
echo "ln -sv /mnt/sda1 /srv/webd/web/U盘" >> package/default-settings/files/zzz-default-settings
echo "ln -sv /mnt/mmcblk0p1/all /srv/webd/web/SD卡" >> package/default-settings/files/zzz-default-settings
echo "chmod 775 /usr/bin/webd\n" >> package/default-settings/files/zzz-default-settings
echo 'exit 0' >> package/default-settings/files/zzz-default-settings

#修改banner
rm -rf package/base-files/files/etc/banner
cp -rf ../banner package/base-files/files/etc/
[ -e ../G-DOCK/default.config ] && mv -f ../G-DOCK/default.config .config
[ -e ../G-DOCK/x-wrt*.config ] && mv -f ../G-DOCK/x-wrt*.config .config
