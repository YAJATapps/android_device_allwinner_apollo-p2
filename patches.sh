#!/bin/bash
set -e

# Determine Android build root
SCRIPT_DIR="$(cd "$(dirname "$(readlink -f "${BASH_SOURCE[0]}")")" && pwd)"
TOP="${ANDROID_BUILD_TOP:-$(cd "$SCRIPT_DIR/../../.." && pwd)}"

# system/core
if [ -f "$TOP/system/core/libcutils/ashmem-dev.cpp" ]; then
    echo "Patching system/core: enabling native memfd support in libcutils..."
    sed -i '/\/\/ Check that the kernel supports the ashmem ioctls on a memfd\./,/^    }/c\    // Legacy ashmem ioctl check on memfd is not present in GKI kernels;\n    // native memfd_create, fcntl, and ftruncate are sufficient for ashmem emulation.' "$TOP/system/core/libcutils/ashmem-dev.cpp"
fi

# external/dng_sdk
if [ -f "$TOP/external/dng_sdk/Android.bp" ]; then
    echo "Patching external/dng_sdk: removing vendor_available..."
    sed -i '/vendor_available: true,/d' "$TOP/external/dng_sdk/Android.bp"
fi

# external/libjxl
if [ -f "$TOP/external/libjxl/Android.bp" ]; then
    echo "Patching external/libjxl: removing vendor_available..."
    sed -i '/vendor_available: true,/d' "$TOP/external/libjxl/Android.bp"
fi

# external/libudev-zero
if [ -f "$TOP/external/libudev-zero/Android.bp" ]; then
    echo "Patching external/libudev-zero: adding vendor_available and public visibility..."
    if ! grep -q "vendor_available: true," "$TOP/external/libudev-zero/Android.bp"; then
        sed -i 's/name: "libudev_zero_copy_headers",/name: "libudev_zero_copy_headers",\n    vendor_available: true,/' "$TOP/external/libudev-zero/Android.bp"
        sed -i 's/name: "libudev-zero",/name: "libudev-zero",\n    vendor_available: true,/' "$TOP/external/libudev-zero/Android.bp"
    fi
    sed -i '/\/\/external\/igt-gpu-tools/,/\/\/vendor:__subpackages__/c\        "\/\/visibility:public",' "$TOP/external/libudev-zero/Android.bp"
fi

# device/softwinner
# Note: external/ffmpeg and external/ffmpeg_codec2 need to be cloned if you want better performance with FFmpeg Codec2
if [ -f "$TOP/device/softwinner/apollo/common/media/config.mk" ]; then
    echo "Patching device/softwinner: setting TARGET_USES_FFMPEG_CODEC2 to false..."
    sed -i 's/TARGET_USES_FFMPEG_CODEC2 ?= true/TARGET_USES_FFMPEG_CODEC2 ?= false/' "$TOP/device/softwinner/apollo/common/media/config.mk"
fi

# device/lineage/sepolicy
if [ -f "$TOP/device/lineage/sepolicy/atv/vendor/gmscore_app.te" ]; then
    echo "Patching device/lineage/sepolicy: guarding apk_verity_prop with until_board_api..."
    sed -i 's/^get_prop(gmscore_app, apk_verity_prop)/until_board_api(202604, `get_prop(gmscore_app, apk_verity_prop)\x27)/' "$TOP/device/lineage/sepolicy/atv/vendor/gmscore_app.te"
fi

# bootable/recovery (C++23 missing headers)
if [ -f "$TOP/bootable/recovery/volume_manager/PublicVolume.cpp" ]; then
    if ! grep -q "<algorithm>" "$TOP/bootable/recovery/volume_manager/PublicVolume.cpp"; then
        echo "Patching bootable/recovery: adding <algorithm> to PublicVolume.cpp..."
        sed -i '/#include "PublicVolume.h"/a #include <algorithm>' "$TOP/bootable/recovery/volume_manager/PublicVolume.cpp"
    fi
fi
if [ -f "$TOP/bootable/recovery/volume_manager/include/volume_manager/VolumeManager.h" ]; then
    if ! grep -q "<vector>" "$TOP/bootable/recovery/volume_manager/include/volume_manager/VolumeManager.h"; then
        echo "Patching bootable/recovery: adding <vector> to VolumeManager.h..."
        sed -i '/#include <string>/a #include <vector>' "$TOP/bootable/recovery/volume_manager/include/volume_manager/VolumeManager.h"
    fi
fi

# system/vold (C++23 missing header)
if [ -f "$TOP/system/vold/model/PublicVolume.cpp" ]; then
    if ! grep -q "<algorithm>" "$TOP/system/vold/model/PublicVolume.cpp"; then
        echo "Patching system/vold: adding <algorithm> to PublicVolume.cpp..."
        sed -i '/#include <utils\/Timers.h>/a #include <algorithm>' "$TOP/system/vold/model/PublicVolume.cpp"
    fi
fi

# longan
if [ -d "$TOP/longan" ]; then
    echo "Patching longan: creating .find-ignore and accepting disclaimer..."
    touch "$TOP/longan/.find-ignore"
    touch "$TOP/longan/.disclaimer_accpet"
fi

# frameworks/base: NotificationAttentionHelper NPE when mLineageNotificationLights is null
NMS_ATTENTION_HELPER="$TOP/frameworks/base/services/core/java/com/android/server/notification/NotificationAttentionHelper.java"
if [ -f "$NMS_ATTENTION_HELPER" ] && ! grep -q "mLineageNotificationLights != null && !mLineageNotificationLights.showLightsScreenOn()" "$NMS_ATTENTION_HELPER"; then
    echo "Patching frameworks/base: fixing mLineageNotificationLights NPE in NotificationAttentionHelper..."
    sed -i 's/if (!mLineageNotificationLights\.showLightsScreenOn())/if (mLineageNotificationLights != null \&\& !mLineageNotificationLights.showLightsScreenOn())/g' "$NMS_ATTENTION_HELPER"
fi



