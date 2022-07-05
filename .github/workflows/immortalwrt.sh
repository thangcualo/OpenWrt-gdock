#!/bin/bash
#=================================================
#   Description: DIY script
#   Lisence: MIT
#   Author: P3TERX
#   Blog: https://p3terx.com
#=================================================
git clone -b master --single-branch https://github.com/immortalwrt/immortalwrt openwrt
cd openwrt
./scripts/feeds clean
./scripts/feeds update -a
./scripts/feeds install -a
#移除不用软件包
rm -rf package/feeds/other/luci-app-mwan3helper
rm -rf package/feeds/luci/luci-app-smartdns
rm -rf feeds/luci/applications/luci-app-dockerman
rm -rf feeds/other/luci-app-dockerman
rm -rf feeds/other/lean/luci-app-wrtbwmon
rm -rf feeds/packages/net/smartdns

#add luci-app-dockerman
svn co https://github.com/lisaac/luci-app-dockerman/trunk/applications/luci-app-dockerman package/luci-app-dockerman
#添加argon主题
git clone https://github.com/jerrykuku/luci-theme-argon.git package/luci-theme-argon-2.2.9
svn co https://github.com/kenzok8/openwrt-packages/trunk/luci-theme-edge package/luci-theme-edge
git clone -b 18.06 https://github.com/jerrykuku/luci-theme-argon.git package/luci-theme-argon-1.7.2
git clone https://github.com/jerrykuku/luci-app-argon-config package/luci-app-argon-config
#添加简易网盘
svn checkout https://github.com/Hyy2001X/AutoBuild-Packages/trunk/luci-app-webd package/luci-app-webd
svn checkout https://github.com/Hyy2001X/AutoBuild-Packages/trunk/webd package/webd
sed -i '$a chmod 775 /usr/bin/webd\n' package/emortal/default-settings/files/99-default-settings
sed -i 's/20220127/20220327/g' package/webd/Makefile
sed -i 's/gwgw.ga/gwgw.ga\/fidx.html\\#/g' package/webd/Makefile

#[ -e ../S905/files ] && mv ../S905/files openwrt/files
#sed -i '/exit 0/i\mkdir -pv /srv/webd/web/.Trash' package/emortal/default-settings/files/99-default-settings
#sed -i '/exit 0/i\ln -sv /mnt/mmcblk1p4/All-in-one /srv/webd/web/SD卡' package/emortal/default-settings/files/99-default-settings
#sed -i '/exit 0/i\chmod 775 /usr/bin/webd\n' package/emortal/default-settings/files/99-default-settings
#修改Samba4d的位置
sed -i "/exit 0/i\sed -i 's/services/nas/g' /usr/lib/lua/luci/controller/samba4.lua" package/emortal/default-settings/files/99-default-settings
sed -i "/exit 0/i\sed -i 's/services/nas/g' /usr/share/luci/menu.d/luci-app-samba4.json" package/emortal/default-settings/files/99-default-settings
添加插件
#git clone https://github.com/small-5/luci-app-adblock-plus.git package/luci-app-adblock-plus
svn co https://github.com/small-5/Openwrt-Compile/trunk/Small_5/package/ipk/luci-app-adblock-plus package/luci-app-adblock-plus
svn co https://github.com/ophub/luci-app-amlogic/trunk/luci-app-amlogic package/luci-app-amlogic

[ -e ../S905/s905-Lienol.config ] && mv -f ../S905/s905-Lienol.config .config
#mv -f ../S905/arm64.config .config
