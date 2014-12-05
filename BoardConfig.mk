#
# Copyright (C) 2014 The CyanogenMod Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

#
# This file sets variables that control the way modules are built
# thorughout the system. It should not be used to conditionally
# disable makefiles (the proper mechanism to control what gets
# included in a build is to use PRODUCT_PACKAGES in a product
# definition file).
#

# inherit from the proprietary version
-include vendor/lge/p715/BoardConfigVendor.mk

TARGET_SPECIFIC_HEADER_PATH := device/lge/p715/include

COMMON_GLOBAL_CFLAGS += -DQCOM_BSP_ABI_HACK -DUSE_MDP3
COMMON_GLOBAL_CFLAGS += -DLPA_DEFAULT_BUFFER_SIZE=480
TARGET_GLOBAL_CFLAGS += -mfpu=neon -mfloat-abi=softfp
TARGET_GLOBAL_CPPFLAGS += -mfpu=neon -mfloat-abi=softfp

TARGET_NO_BOOTLOADER := true
TARGET_NO_RADIOIMAGE := true
# Try to use ASHMEM if possible (when non-MDP composition is used)
TARGET_GRALLOC_USES_ASHMEM := true

# Arch related defines and optimizations
TARGET_ARCH := arm
TARGET_CPU_ABI  := armeabi-v7a
TARGET_CPU_ABI2 := armeabi
TARGET_CPU_VARIANT := cortex-a5
TARGET_ARCH_VARIANT := armv7-a-neon
TARGET_BOARD_PLATFORM := msm7x27a
TARGET_BOOTLOADER_BOARD_NAME := 7х27
TARGET_CPU_SMP := true

TARGET_CORTEX_CACHE_LINE_32 := true
TARGET_USE_QCOM_BIONIC_OPTIMIZATION := true

TARGET_BOARD_PLATFORM_GPU := qcom-adreno203
BOARD_USES_ADRENO_200 := true

# Inline kernel building
TARGET_KERNEL_SOURCE := kernel/lg/p715/kernel
TARGET_KERNEL_CONFIG := Cyanogenmod_11_vee7_defconfig
BOARD_KERNEL_BASE    :=  0x00200000
BOARD_MKBOOTIMG_ARGS := --ramdisk_offset  0x01200000
BOARD_KERNEL_PAGESIZE := 4096
#Spare size is (BOARD_KERNEL_PAGESIZE>>9)*16

KERNEL_EXTERNAL_MODULES:
	mkdir -p $(KERNEL_MODULES_OUT)/volans
	rm -rf $(TARGET_OUT_INTERMEDIATES)/prebuilts
	cp -a /lib/modules/volans/WCN1314_rf.ko $(TARGET_OUT_INTERMEDIATES)/
	$(MAKE) -C $(TARGET_OUT_INTERMEDIATES)/prebuilts/WCN1314_rf KERNEL_OUT=$(KERNEL_OUT) ARCH="arm" CROSS_COMPILE="arm-eabi-" modules
	$(MAKE) -C $(TARGET_OUT_INTERMEDIATES)/prebuilts/WCN1314_rf_ftm KERNEL_OUT=$(KERNEL_OUT) ARCH="arm" CROSS_COMPILE="arm-eabi-" modules
	$(TARGET_OBJCOPY) --strip-unneeded $(TARGET_OUT_INTERMEDIATES)/prebuilts/WCN1314_rf/WCN1314_rf.ko $(TARGET_ROOT_OUT)/lib/modules/volans/WCN1314_rf.ko
TARGET_KERNEL_MODULES += PREBUILT_WLAN_MODULES

TARGET_USERIMAGES_USE_EXT4 := true
BOARD_CACHEIMAGE_FILE_SYSTEM_TYPE := ext4
TARGET_USES_UNCOMPRESSED_KERNEL := false

BOARD_KERNEL_CMDLINE :=  androidboot.hardware=vee7 msm_cpr.enable=0
ARCH_ARM_HAVE_TLS_REGISTER := true
BOARD_EGL_CFG := device/lge/p715/config/egl.cfg

BOARD_SYSTEMIMAGE_PARTITION_SIZE := 487136952
BOARD_USERDATAIMAGE_PARTITION_SIZE := 2920577761
BOARD_RECOVERYIMAGE_PARTITION_SIZE := 8388608
BOARD_CACHEIMAGE_PARTITION_SIZE := 41943040
BOARD_FLASH_BLOCK_SIZE := 131072 # (BOARD_KERNEL_PAGESIZE * 64)
TARGET_NO_RECOVERY := true
TARGET_USERIMAGES_USE_EXT4 := true

BOARD_HAVE_QCOM_FM := true
COMMON_GLOBAL_CFLAGS += -DQCOM_FM_ENABLED

# Audio
TARGET_QCOM_AUDIO_VARIANT := caf
TARGET_PROVIDES_LIBAUDIO := true
BOARD_QCOM_VOIP_ENABLED := true
BOARD_USES_LEGACY_ALSA_AUDIO := true
TARGET_HAS_QACT := true

# Bluetooth
BOARD_HAVE_BLUETOOTH := true
BOARD_BLUETOOTH_BDROID_BUILDCFG_INCLUDE_DIR := device/lge/p715/bluetooth

# Dalvik
TARGET_ARCH_LOWMEM := true

 # QCOM  display stuffs
BOARD_USES_QCOM_HARDWARE := true
BOARD_USES_QCOM_LIBS := true
BOARD_USE_QCOM_PMEM := true
TARGET_USES_OVERLAY := false
TARGET_HAVE_BYPASS  := false
TARGET_USES_C2D_COMPOSITION := true
TARGET_USES_GENLOCK := true
TARGET_USES_ION := true
TARGET_USES_QCOM_BSP := true
TARGET_QCOM_DISPLAY_VARIANT := legacy
TARGET_FORCE_CPU_UPLOAD := true
BOARD_ADRENO_DECIDE_TEXTURE_TARGET := true
USE_OPENGL_RENDERER := true
QCOM_BSP_WITH_GENLOCK := true
TARGET_DISPLAY_USE_RETIRE_FENCE := true


# EGL
BOARD_EGL_WORKAROUND_BUG_10194508 := true
BOARD_EGL_CFG := device/lge/p715/config/egl.cfg

# Media
TARGET_QCOM_MEDIA_VARIANT := caf
COMMON_GLOBAL_CFLAGS += -DQCOM_NO_SECURE_PLAYBACK
COMMON_GLOBAL_CFLAGS += -DQCOM_NO_SECURE_PLAYBACK

# Storage / Sharing
BOARD_VOLD_EMMC_SHARES_DEV_MAJOR := true
TARGET_USE_CUSTOM_LUN_FILE_PATH := /sys/class/android_usb/android0/f_mass_storage/lun%d/file

# GPS
QCOM_GPS_PATH := hardware/qcom/gps
BOARD_USES_QCOM_LIBRPC := true
BOARD_USES_QCOM_GPS := true
BOARD_VENDOR_QCOM_GPS_LOC_API_AMSS_VERSION := 50000
BOARD_VENDOR_QCOM_GPS_LOC_API_HARDWARE := $(TARGET_BOARD_PLATFORM)

# Camera
USE_CAMERA_STUB := true
COMMON_GLOBAL_CFLAGS += -DQCOM_BSP_WITH_GENLOCK -DNEEDS_VECTORIMPL_SYMBOLS

# Webkit
ENABLE_WEBGL := true
# PRODUCT_PREBUILT_WEBVIEWCHROMIUM := yes

BOARD_HAS_QCOM_WLAN              := true
BOARD_HAS_QCOM_WLAN_SDK          := true
BOARD_WLAN_DEVICE                := qcwcn
WPA_SUPPLICANT_VERSION           := VER_0_8_X
BOARD_WPA_SUPPLICANT_DRIVER      := NL80211
BOARD_WPA_SUPPLICANT_PRIVATE_LIB := lib_driver_cmd_$(BOARD_WLAN_DEVICE)
BOARD_HOSTAPD_DRIVER             := NL80211
BOARD_HOSTAPD_PRIVATE_LIB        := lib_driver_cmd_$(BOARD_WLAN_DEVICE)
TARGET_CUSTOM_WIFI := ../../device/lge/p715/libhardware_legacy/wifi/wifi.c
WIFI_EXT_MODULE_PATH             := "/system/lib/modules/librasdioif.ko"
WIFI_DRIVER_MODULE_PATH          := "/system/lib/modules/wlan.ko"
WIFI_EXT_MODULE_NAME             := "librasdioif"
WIFI_DRIVER_MODULE_NAME          := "wlan"
WIFI_DRIVER_FW_PATH_STA          := "sta"
WIFI_DRIVER_FW_PATH_AP           := "ap"
WIFI_DRIVER_FW_PATH_P2P          := "p2p"
WIFI_DRIVER_FW_PATH_PARAM        := "/data/misc/wifi/fwpath"

# Recovery
TW_BOARD_CUSTOM_GRAPHICS := ../../../device/lge/p715/recovery/tw_graphics.c
