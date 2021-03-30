#!/bin/bash
#=================================================
#   Description: DIY script
#   Lisence: MIT
#   Author: P3TERX
#   Blog: https://p3terx.com
#=================================================
#克隆源码
git clone -b openwrt-18.06 --single-branch https://github.com/immortalwrt/immortalwrt && cd immortalwrt
./scripts/feeds update -a && ./scripts/feeds install -a
