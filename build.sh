#!/bin/bash
ORIG=$PWD
if [ x$CORE_NUM = x ]; then
  CORE_NUM=8
fi

mkdir -p out
pushd emulator
export OUT_DIR_COMMON_BASE=$ORIG/out/emulator-x86_64/
. build/envsetup.sh
lunch linaro_x86_64-userdebug
make -j$CORE_NUM

popd

pushd emulator-kernel

make CROSS_COMPILE=$ORIG/emulator/prebuilts/gcc/linux-x86/x86/x86_64-linux-android-4.9/bin/x86_64-linux-android- KBUILD_OUTPUT=$ORIG/out/emulator-kernel-4.4-x86_64-x86 ARCH=x86 \
     defconfig kvm_guest.config emulator.kernel.config
make -j$CORE_NUM CROSS_COMPILE=$ORIG/emulator/prebuilts/gcc/linux-x86/x86/x86_64-linux-android-4.9/bin/x86_64-linux-android- KBUILD_OUTPUT=$ORIG/out/emulator-kernel-4.4-x86_64-x86 LD=$ORIG/emulator/prebuilts/gcc/linux-x86/x86/x86_64-linux-android-4.9/bin/x86_64-linux-android-ld.bfd ARCH=x86
popd
