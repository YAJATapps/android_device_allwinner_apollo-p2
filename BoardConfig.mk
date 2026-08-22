# Enable sparse on all filesystem images
TARGET_USERIMAGES_SPARSE_EROFS_DISABLED := false
TARGET_USERIMAGES_SPARSE_EXT_DISABLED := false
TARGET_USERIMAGES_SPARSE_F2FS_DISABLED := false
TARGET_USERIMAGES_SPARSE_SQUASHFS_DISABLED := false

BOARD_KERNEL_IMAGE_NAME := bImage

include device/softwinner/common/BoardConfigCommon.mk
include device/softwinner/apollo/BoardConfig.mk

# must include common BoardConfig.mk in the end
BOARD_KERNEL_CMDLINE += androidboot.selinux=permissive
BOARD_KERNEL_CMDLINE += androidboot.dtbo_idx=0,1,2
BOARD_KERNEL_CMDLINE += firmware_class.path=/vendor/etc/firmware


# Wireless Board Configuration
BOARD_HOSTAPD_DRIVER        := NL80211
BOARD_WPA_SUPPLICANT_DRIVER := NL80211
WPA_SUPPLICANT_VERSION      := VER_0_8_X
$(call soong_config_set,wpa_supplicant_8,wifi_hidl_unified_supplicant_service_rc_entry,true)
BOARD_HAVE_BLUETOOTH        := true
BOARD_BLUETOOTH_CONFIG_DIR  ?= device/softwinner/apollo/common/wireless/bluetooth
BOARD_BLUETOOTH_BDROID_BUILDCFG_INCLUDE_DIR := $(BOARD_BLUETOOTH_CONFIG_DIR)


