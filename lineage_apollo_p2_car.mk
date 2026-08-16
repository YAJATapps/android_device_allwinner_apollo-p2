# Inherit from device.
$(call inherit-product, device/allwinner/apollo-p2/device.mk)

PRODUCT_AAPT_PREF_CONFIG := ldpi
PRODUCT_CHARACTERISTICS := automotive,nosdcard

$(call inherit-product, vendor/lineage/config/common_car.mk)

PRODUCT_NAME := lineage_apollo_p2_car

# Device tree path.
PRODUCT_PLATFORM_PATH := device/softwinner/apollo
$(call inherit-product, $(PRODUCT_PLATFORM_PATH)/apollo-p2/camera/config.mk)
$(call inherit-product, $(PRODUCT_PLATFORM_PATH)/common/*/config.mk)

# Inherit from car
$(call inherit-product, device/google_car/common/pre_google_car.mk)
$(call inherit-product, packages/services/Car/car_product/build/car.mk)
$(call inherit-product, device/google_car/common/post_google_car.mk)

