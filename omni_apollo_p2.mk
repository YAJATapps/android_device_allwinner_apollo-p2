PRODUCT_PLATFORM_PATH := device/softwinner/apollo

PRODUCT_OTA_ENFORCE_VINTF_KERNEL_REQUIREMENTS := false

# Device tree path.
DEVICE_PATH := device/allwinner/apollo-p2

# Inherit from device.
$(call inherit-product, $(DEVICE_PATH)/device.mk)

# Device identifier
TARGET_BOARD_IC := h618
PRODUCT_BOARD := p2
PRODUCT_DEVICE := apollo-p2
PRODUCT_NAME := omni_apollo_p2
PRODUCT_BRAND := Allwinner
PRODUCT_MODEL := orangepizero2w
PRODUCT_MANUFACTURER := Allwinner

PRODUCT_PREBUILT_PATH := longan/out/$(TARGET_BOARD_IC)/$(PRODUCT_BOARD)/android

PRODUCT_BUILD_VENDOR_BOOT_IMAGE := true

CONFIG_LOW_RAM_DEVICE := false
CONFIG_SUPPORT_GMS := false
CONFIG_OTA_FROM_10 := false
BOARD_HAS_SECURE_OS := true

PRODUCT_COPY_FILES += $(PRODUCT_PREBUILT_PATH)/bImage:kernel

#set speaker project(true: double speaker, false: single speaker)
#set default eq
PRODUCT_PROPERTY_OVERRIDES += \
    ro.vendor.spk_dul.used=false \
    ro.vendor.audio.eq=false

PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
    persist.sys.timezone=America/Toronto \
    persist.sys.country=CA \
    persist.sys.language=en

PRODUCT_PROPERTY_OVERRIDES += \
    ro.sf.lcd_density=160

PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
    ro.minui.default_rotation=ROTATION_NONE \
    ro.recovery.ui.touch_high_threshold=60

PRODUCT_HAS_UVC_CAMERA := true

PRODUCT_AAPT_CONFIG := mdpi xlarge hdpi xhdpi large
PRODUCT_AAPT_PREF_CONFIG := mdpi

$(call inherit-product, $(PRODUCT_PLATFORM_PATH)/apollo-p2/camera/config.mk)
$(call inherit-product, $(PRODUCT_PLATFORM_PATH)/common/*/config.mk)
