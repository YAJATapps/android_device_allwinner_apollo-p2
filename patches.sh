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
