# Device tree path.
DEVICE_PATH := device/allwinner/apollo-p2

# Inherit from device.
$(call inherit-product, $(DEVICE_PATH)/device.mk)

# 1080p boot animation.
TARGET_BOOTANIMATION_SIZE := 1080p

# Inherit common.
$(call inherit-product, vendor/omni/config/common.mk)

# Overlays. TODO
# DEVICE_PACKAGE_OVERLAYS += $(DEVICE_PATH)/overlay

# Device identifier. This must come after all inclusions.
PRODUCT_DEVICE := apollo-p2
PRODUCT_NAME := omni_apollo_p2
PRODUCT_BRAND := Allwinner
PRODUCT_MODEL := orangepizero2w
PRODUCT_MANUFACTURER := Allwinner
