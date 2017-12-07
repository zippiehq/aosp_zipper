ORIG=$PWD
mkdir -p out
pushd emulator-kernel

make CROSS_COMPILE=$ORIG/emulator/prebuilts/gcc/linux-x86/x86/x86_64-linux-android-4.9/bin/x86_64-linux-android- KBUILD_OUTPUT=$ORIG/out/kernel-common-4.4-x86 ARCH=x86 \
     defconfig kvm_guest.config emulator.kernel.config
make -j$CORE_NUM CROSS_COMPILE=$ORIG/emulator/prebuilts/gcc/linux-x86/x86/x86_64-linux-android-4.9/bin/x86_64-linux-android- KBUILD_OUTPUT=$ORIG/out/kernel-common-4.4-x86 LD=$ORIG/emulator/prebuilts/gcc/linux-x86/x86/x86_64-linux-android-4.9/bin/x86_64-linux-android-ld.bfd ARCH=x86
popd
