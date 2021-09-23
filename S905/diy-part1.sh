git clone -b main --single-branch https://github.com/Lienol/openwrt openwrt
sed -i 's/5.4/5.10/g' openwrt/target/linux/armvirt/Makefile
#添加passwall
sed -i '$a src-git xiaorouji https://github.com/xiaorouji/openwrt-passwall.git' openwrt/feeds.conf.default
