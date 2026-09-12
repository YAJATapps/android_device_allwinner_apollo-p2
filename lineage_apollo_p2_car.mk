# Inherit from device.
$(call inherit-product, device/allwinner/apollo-p2/device.mk)

PRODUCT_AAPT_PREF_CONFIG := mdpi
PRODUCT_CHARACTERISTICS := automotive,nosdcard

# Inherit Lineage automotive common (overlays, user whitelist)
$(call inherit-product, vendor/lineage/config/common_car.mk)

# Inherit native AOSP Automotive partition images
$(call inherit-product, packages/services/Car/car_product/build/car_generic_system.mk)
$(call inherit-product, packages/services/Car/car_product/build/car_system_ext.mk)
$(call inherit-product, packages/services/Car/car_product/build/car_product.mk)

PRODUCT_BROKEN_SUBOPTIMAL_ORDER_OF_SYSTEM_SERVER_JARS := true

PRODUCT_ENFORCE_RRO_TARGETS :=

# Modern AIDL Automotive HALs
PRODUCT_PACKAGES += \
    android.hardware.automotive.vehicle@V4-default-service \
    android.hardware.automotive.audiocontrol-service.example \
    android.hardware.broadcastradio-service.default \
    android.hardware.automotive.can-service

# Automotive permissions & init scripts
PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/car_core_hardware.xml:system/etc/permissions/car_core_hardware.xml \
    frameworks/native/data/etc/android.hardware.type.automotive.xml:system/etc/permissions/android.hardware.type.automotive.xml \
    frameworks/native/data/etc/android.hardware.screen.landscape.xml:system/etc/permissions/android.hardware.screen.landscape.xml \
    packages/services/Car/car_product/init/init.bootstat.rc:root/init.bootstat.rc \
    packages/services/Car/car_product/init/init.car.rc:root/init.car.rc

# Device tree path.
PRODUCT_PLATFORM_PATH := device/softwinner/apollo
$(call inherit-product, $(PRODUCT_PLATFORM_PATH)/apollo-p2/camera/config.mk)
$(call inherit-product, $(PRODUCT_PLATFORM_PATH)/common/*/config.mk)

PRODUCT_NAME := lineage_apollo_p2_car


