#!/bin/bash
ORIG=$PWD

if [ x$AOSP_MIRROR = x ]; then
   AOSP_MIRROR=https://android.googlesource.com/platform/manifest
fi

mkdir -p emulator
pushd emulator

repo init -u $AOSP_MIRROR -b android-7.1.1_r22 --reference=$AOSP_MIRROR --depth=1
mkdir -p .repo/local_manifests
cp $ORIG/local_manifest.xml .repo/local_manifests/emulator.xml

repo sync -j4 -c

pushd device/linaro/generic
git fetch robherring
git checkout 306887c7212a8f4dcd6244bda49c1f7f1ab1275a
popd

popd

git clone https://android.googlesource.com/kernel/common emulator-kernel
pushd emulator-kernel
git checkout android-4.4
cp $ORIG/emulator.kernel.config kernel/configs
bash android/configs/android-fetch-configs.sh
cat android-base.cfg android-recommended.cfg >> kernel/configs/emulator.kernel.config
popd

