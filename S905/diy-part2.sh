复制files文件夹到openwrt目录
[ -e ../S905/files ] && mv ../S905/files files

#移除不用软件包    
rm -rf package/lean/luci-app-dockerman
rm -rf package/lean/luci-app-wrtbwmon
rm -rf feeds/packages/net/smartdns

#add luci-app-dockerman
svn co https://github.com/lisaac/luci-app-dockerman/trunk/applications/luci-app-dockerman package/luci-app-dockerman
#添加argon主题
svn co https://github.com/kenzok8/openwrt-packages/trunk/luci-theme-edge package/luci-theme-edge
git clone -b 18.06 https://github.com/jerrykuku/luci-theme-argon.git package/luci-theme-argon-1.7.2
git clone https://github.com/jerrykuku/luci-app-argon-config package/luci-app-argon-config
#添加简易网盘
#Lienol
sed -i '/exit 0/i\mkdir -pv /srv/webd/web/.Trash' package/default-settings/files/zzz-default-settings
sed -i '/exit 0/i\chmod 775 /usr/bin/webd\n' package/default-settings/files/zzz-default-settings
#Lean
sed -i '/exit 0/i\mkdir -pv /srv/webd/web/.Trash' package/lean/default-settings/files/zzz-default-settings
sed -i '/exit 0/i\chmod 775 /usr/bin/webd\n' package/lean/default-settings/files/zzz-default-settings
