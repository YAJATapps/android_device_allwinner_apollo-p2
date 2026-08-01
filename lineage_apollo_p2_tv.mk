# Inherit from device.
$(call inherit-product, device/allwinner/apollo-p2/device.mk)

PRODUCT_AAPT_PREF_CONFIG := tvdpi

$(call inherit-product, device/google/atv/products/atv_base.mk)

# Android TV
PRODUCT_PACKAGES += \
    LeanbackIME \
    TvProvision \
    TvSampleLeanbackLauncher \
    TvSettingsTwoPanel

PRODUCT_NAME := lineage_apollo_p2_tv

# Device tree path.
PRODUCT_PLATFORM_PATH := device/softwinner/apollo
$(call inherit-product, $(PRODUCT_PLATFORM_PATH)/apollo-p2/camera/config.mk)
$(call inherit-product, $(PRODUCT_PLATFORM_PATH)/common/*/config.mk)

