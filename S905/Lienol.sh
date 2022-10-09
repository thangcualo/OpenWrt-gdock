#!/bin/bash
#=================================================
#   Description: DIY script
#   Lisence: MIT
#   Author: P3TERX
#   Blog: https://p3terx.com
#=================================================
#git clone -b main --single-branch https://github.com/Lienol/openwrt openwrt
#git clone -b master --single-branch https://github.com/openwrt/openwrt openwrt
git clone -b openwrt-22.03 --single-branch https://github.com/openwrt/openwrt openwrt
cd openwrt
#添加passwall
sed -i '$a src-git xiaorouji https://github.com/xiaorouji/openwrt-passwall.git' feeds.conf.default
sed -i '$a src-git xiaorouji1 https://github.com/xiaorouji/openwrt-passwall.git;luci' feeds.conf.default
sed -i '$a src-git-full x https://github.com/x-wrt/com.x-wrt.git' feeds.conf.default

./scripts/feeds clean
./scripts/feeds update -a
./scripts/feeds install -a

cp /usr/bin/upx staging_dir/host/bin
cp /usr/bin/upx-ucl staging_dir/host/bin
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
#添加插件
svn co https://github.com/Lienol/openwrt-package/trunk/luci-app-fileassistant package/luci-app-fileassistan
svn co https://github.com/coolsnowwolf/lede/trunk/package/lean/luci-app-cpufreq package/luci-app-cpufreq
svn co https://github.com/coolsnowwolf/lede/trunk/package/lean/luci-app-netdata package/luci-app-netdata
git clone https://github.com/ssuperh/luci-app-vlmcsd-new.git package/luci-app-vlmcsd-new
git clone https://github.com/flytosky-f/openwrt-vlmcsd.git package/openwrt-vlmcsd
git clone https://github.com/UnblockNeteaseMusic/luci-app-unblockneteasemusic.git package/luci-app-unblockneteasemusic
svn checkout https://github.com/Hyy2001X/AutoBuild-Packages/trunk/luci-app-webd package/luci-app-webd
svn checkout https://github.com/Hyy2001X/AutoBuild-Packages/trunk/webd package/webd
git clone https://github.com/small-5/luci-app-adblock-plus.git package/luci-app-adblock-plus
git clone https://github.com/ntlf9t/luci-app-easymesh package/luci-app-easymesh
git clone https://github.com/KFERMercer/luci-app-tcpdump.git package/luci-app-tcpdump
git clone https://github.com/dazhaolear/luci-app-autorebootnew.git package/luci-app-autorebootnew
git clone https://github.com/sbwml/luci-app-alist package/alist
svn co https://github.com/small-5/Openwrt-Compile/trunk/Small_5/package/ipk/luci-app-adblock-plus package/luci-app-adblock-plus
svn co https://github.com/ophub/luci-app-amlogic/trunk/luci-app-amlogic package/luci-app-amlogic

#[ -e ../S905/files ] && mv ../S905/files openwrt/files
#sed -i '/exit 0/i\mkdir -pv /srv/webd/web/.Trash' package/default-settings/files/zzz-default-settings
#sed -i '/exit 0/i\ln -sv /mnt/mmcblk1p4/All-in-one /srv/webd/web/SD卡' package/default-settings/files/zzz-default-settings
#sed -i '/exit 0/i\chmod 775 /usr/bin/webd\n' package/default-settings/files/zzz-default-settings
#修改Samba4d的位置
sed -i "/exit 0/i\sed -i 's/services/nas/g' /usr/lib/lua/luci/controller/samba4.lua" package/default-settings/files/zzz-default-settings
sed -i "/exit 0/i\sed -i 's/services/nas/g' /usr/share/luci/menu.d/luci-app-samba4.json" package/default-settings/files/zzz-default-settings


#[ -e ../S905/s905-Lienol.config ] && mv -f ../S905/s905-Lienol.config .config
#mv -f ../S905/arm64.config .config
mv -f ../S905/s905-op.config .config
