#!/bin/bash
#=================================================
# Description: DIY script for Lean's LEDE
# Author: eSirPlayground & Gemini Adaptive
#=================================================

# 1. 修改預設 IP 為 192.168.50.1
sed -i 's/192.168.1.1/192.168.50.1/g' openwrt/package/base-files/files/bin/config_generate

# 2. 清除登入密碼
sed -i 's/$1$V4UetPzk$CYXluq4wUazHjmCDBCqXF.//g' openwrt/package/lean/default-settings/files/zzz-default-settings

# 3. 徹底解決 Error 255 衝突 (移除原版 dnsmasq)
# 因為 OpenClaw 和 OpenClash 需要 dnsmasq-full，我們直接刪除源碼中的基礎版
rm -rf openwrt/package/network/services/dnsmasq

# 4. 更換為 JerryKuKu 的 Argon 主題
# 先刪除 Lean 內建的舊版 Argon，再複製新版
rm -rf openwrt/package/lean/luci-theme-argon
git clone -b 18.06 https://github.com/jerrykuku/luci-theme-argon.git openwrt/package/lean/luci-theme-argon
git clone -b 18.06 https://github.com/jerrykuku/luci-app-argon-config.git openwrt/package/lean/luci-app-argon-config

# 5. 強制下載 OpenClaw (龍蝦 AI)
# 直接將插件下載到 package 資料夾，確保編譯時一定能找到
rm -rf openwrt/package/luci-app-openclaw
git clone --depth=1 https://github.com/10000ge10000/luci-app-openclaw.git openwrt/package/luci-app-openclaw

# 6. 強制下載 OpenClash
rm -rf openwrt/package/luci-app-openclash
git clone --depth=1 https://github.com/vernesong/OpenClash.git openwrt/package/luci-app-openclash
