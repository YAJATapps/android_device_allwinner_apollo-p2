# Get a list of languages.
$(call inherit-product, $(SRC_TARGET_DIR)/product/languages_full.mk)

# Get everything else from the parent package
$(call inherit-product, $(SRC_TARGET_DIR)/product/generic_no_telephony.mk)