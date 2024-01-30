# Inherit common AOSP
$(call inherit-product, $(SRC_TARGET_DIR)/product/full_base.mk)

# Inherit common OmniROM
$(call inherit-product, vendor/omni/config/common.mk)


