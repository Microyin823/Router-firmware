#!/bin/bash

#
#Copyright 2021 yangxu52<https://github.com/yangxu52>
#
#Licensed under the Apache License, Version 2.0 (the "License");
#you may not use this file except in compliance with the License.
#You may obtain a copy of the License at
#
#    http://www.apache.org/licenses/LICENSE-2.0
#
#Unless required by applicable law or agreed to in writing, software
#distributed under the License is distributed on an "AS IS" BASIS,
#WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
#See the License for the specific language governing permissions and
#limitations under the License.
#

#echo '添加SSRPLUS软件源'
#sed -i "/helloworld/d" "feeds.conf.default"
#echo "src-git helloworld https://github.com/fw876/helloworld.git" >> "feeds.conf.default"
#echo '=========Add feed source OK!========='

echo '添加Passwall软件源'
sed -i '$a src-git passwall https://github.com/xiaorouji/openwrt-passwall' feeds.conf.default
echo '=========Add feed source OK!========='

echo '添加openwrt-packages软件源'
sed -i '1i src-git haibo https://github.com/haiibo/openwrt-packages' feeds.conf.default
echo '=========Add openwrt-packages OK!========='

echo '添加jerrykuku的argon-mod主题'
rm -rf package/lean/luci-theme-argon  
git clone -b 18.06 https://github.com/jerrykuku/luci-theme-argon package/lean/luci-theme-argon
echo '=========Add argon-mod OK!========='

echo '添加lwz322的K3屏幕插件'
rm -rf package/lean/luci-app-k3screenctrl
git clone https://github.com/yangxu52/luci-app-k3screenctrl.git package/lean/luci-app-k3screenctrl
echo '=========Add k3screen plug OK!========='

echo '替换lwz322的K3屏幕驱动插件'
rm -rf package/lean/k3screenctrl
git clone https://github.com/yangxu52/k3screenctrl_build.git package/lean/k3screenctrl/
echo '=========Replace k3screen drive plug OK!========='

# echo '修改5.4分支为5.4.150'
# sed -i '/^LINUX_VERSION-5.4/c LINUX_VERSION-5.4 = .150' include/kernel-version.mk
# sed -i '/^LINUX_KERNEL_HASH-5.4/c LINUX_KERNEL_HASH-5.4.150 = f424a9bbb05007f04c17f96a2e4f041a8001554a9060d2c291606e8a97c62aa2' include/kernel-version.mk
# wget -nv https://github.com/yangxu52/OP-old-kernel-target/raw/main/target-5.4.150.tar.gz
# rm -rf ./target/
# tar -zxf ./target-5.4.150.tar.gz
# rm -rf ./target-5.4.150.tar.gz
# echo '=========Alert kernel to 5.4.150 OK!========='

echo '移除bcm53xx中的其他机型'
sed -i '421,453d' target/linux/bcm53xx/image/Makefile
sed -i '140,412d' target/linux/bcm53xx/image/Makefile
sed -i 's/$(USB3_PACKAGES) k3screenctrl/luci-app-k3screenctrl/g' target/linux/bcm53xx/image/Makefile
# sed -n '140,146p' target/linux/bcm53xx/image/Makefile
echo '=========Remove other devices of bcm53xx OK!========='

#1.'asus_dhd24' 2.'ac88u_20' 3.'69027'
echo '替换K3的无线驱动为asus-dhd24'
wget -nv https://github.com/Hill-98/phicommk3-firmware/raw/master/brcmfmac4366c-pcie.bin.asus-dhd24 -O package/lean/k3-brcmfmac4366c-firmware/files/lib/firmware/brcm/brcmfmac4366c-pcie.bin
#echo '替换K3的无线驱动为ac86u'
#wget -nv https://github.com/Hill-98/phicommk3-firmware/raw/master/brcmfmac4366c-pcie.bin.ac88u -O package/lean/k3-brcmfmac4366c-firmware/files/lib/firmware/brcm/brcmfmac4366c-pcie.bin
#echo '替换K3的无线驱动为69027'
#wget -nv https://github.com/Hill-98/phicommk3-firmware/raw/master/brcmfmac4366c-pcie.bin.69027 -O package/lean/k3-brcmfmac4366c-firmware/files/lib/firmware/brcm/brcmfmac4366c-pcie.bin
#echo '=========Replace k3 wireless firmware OK!========='
#firmware='ac88u_20'
#echo '替换无线驱动'
#wget -nv https://github.com/yangxu52/Phicomm-k3-Wireless-Firmware/raw/master/brcmfmac4366c-pcie.bin.${firmware} -O package/lean/k3-brcmfmac4366c-firmware/files/lib/firmware/brcm/brcmfmac4366c-pcie.bin
echo '=========Replace k3 wireless firmware OK!========='
