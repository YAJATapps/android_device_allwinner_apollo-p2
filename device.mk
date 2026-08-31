# Inherit common LineageOS
$(call inherit-product, vendor/lineage/config/common.mk)

# Packages
PRODUCT_PACKAGES += \
    vendor_compatibility_matrix.xml \
    vendor_manifest.xml

PRODUCT_SHIPPING_API_LEVEL := 36

PRODUCT_PROPERTY_OVERRIDES += \
    persist.sys.strictmode.disable=true \
    persist.sys.usb.config=adb \
    persist.service.adb.enable=1 \
    persist.service.debuggable=1

PRODUCT_OTA_ENFORCE_VINTF_KERNEL_REQUIREMENTS := false

PRODUCT_BUILD_VENDOR_BOOT_IMAGE := true

CONFIG_LOW_RAM_DEVICE := false
CONFIG_SUPPORT_GMS := false
CONFIG_OTA_FROM_10 := false
BOARD_HAS_SECURE_OS := true

#set speaker project(true: double speaker, false: single speaker)
#set default eq
PRODUCT_PROPERTY_OVERRIDES += \
    ro.vendor.spk_dul.used=false \
    ro.vendor.audio.eq=false

PRODUCT_PROPERTY_OVERRIDES += \
    ro.sf.lcd_density=120


PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
    ro.minui.default_rotation=ROTATION_NONE \
    ro.recovery.ui.touch_high_threshold=60

PRODUCT_HAS_UVC_CAMERA := true

PRODUCT_AAPT_CONFIG := ldpi mdpi xlarge hdpi xhdpi large

# Device identifier
TARGET_BOARD_IC := h618
PRODUCT_BOARD := p2
PRODUCT_DEVICE := apollo-p2
PRODUCT_BRAND := Allwinner
PRODUCT_MANUFACTURER := Allwinner
PRODUCT_PREBUILT_PATH := longan/out/$(TARGET_BOARD_IC)/$(PRODUCT_BOARD)/android
PRODUCT_MODEL := orangepizero2w

# Include prebuilt kernel
PRODUCT_COPY_FILES += $(PRODUCT_PREBUILT_PATH)/bImage:kernel

# Inherit prebuilt vendor blobs (Wi-Fi, Firmware, Kernel modules, Mesa3D)
$(call inherit-product, vendor/allwinner/apollo-p2/apollo-p2-vendor.mk)

# Include standard wireless configuration
include device/softwinner/common/config/wireless/wireless_config.mk



