# Inherit some common CM stuff.
$(call inherit-product, vendor/cm/config/common_full_phone.mk)

# Boot animation
TARGET_SCREEN_WIDTH := 480
TARGET_SCREEN_HEIGHT := 800
TARGET_BOOTANIMATION_NAME := 480

# Release name
PRODUCT_RELEASE_NAME := OptimusL7II
PRODUCT_NAME := cm_p715

$(call inherit-product, device/lge/p715/full_lg.mk)

PRODUCT_BUILD_PROP_OVERRIDES += \
    PRODUCT_NAME=LGE \
    PRODUCT_BRAND=LGE \
    BUILD_PRODUCT=msm8626_p715
#   BUILD_FINGERPRINT=qcom/msm8625/msm8625:4.1.2/JZO54K/eng.ZYC.20140213.151118:eng/test-keys
