git clone -b main --single-branch https://github.com/Lienol/openwrt openwrt
#git clone https://github.com/coolsnowwolf/lede openwrt
#添加passwall
sed -i '$a src-git xiaorouji https://github.com/xiaorouji/openwrt-passwall.git' openwrt/feeds.conf.default
