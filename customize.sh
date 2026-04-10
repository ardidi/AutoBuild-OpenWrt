#!/bin/bash
#=================================================
# Description: DIY script for Lean's LEDE
# Author: eSirPlayground & Gemini Adaptive
#=================================================

# 1. 修改預設 IP 為 192.168.50.1
sed -i 's/192.168.1.1/192.168.50.1/g' openwrt/package/base-files/files/bin/config_generate

# 2. 清除登入密碼
sed -i 's/$1$V4UetPzk$CYXluq4wUazHjmCDBCqXF.//g' openwrt/package/lean/default-settings/files/zzz-default-settings

# 3. 解決 Samba 檔案衝突 (重要！)
# 這是為了解決你之前的 "Package samba4-server wants to install file... provided by autosamba" 報錯
# 我們刪除 Lean 源中舊的 autosamba，確保使用強大的 Samba4
rm -rf openwrt/package/lean/autosamba

# 4. 更換為 JerryKuKu 的 Argon 主題
rm -rf openwrt/package/lean/luci-theme-argon
git clone -b 18.06 https://github.com/jerrykuku/luci-theme-argon.git openwrt/package/lean/luci-theme-argon
git clone -b 18.06 https://github.com/jerrykuku/luci-app-argon-config.git openwrt/package/lean/luci-app-argon-config

# 5. 強制下載 OpenClaw (龍蝦 AI)
rm -rf openwrt/package/luci-app-openclaw
git clone --depth=1 https://github.com/10000ge10000/luci-app-openclaw.git openwrt/package/luci-app-openclaw

# 6. 強制下載 OpenClash
rm -rf openwrt/package/luci-app-openclash
git clone --depth=1 https://github.com/vernesong/OpenClash.git openwrt/package/luci-app-openclash
