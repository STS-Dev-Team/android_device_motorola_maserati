# Inherit AOSP device configuration for maserati.
$(call inherit-product, device/motorola/maserati/full_maserati.mk)

# Inherit common product files.
$(call inherit-product, vendor/aokp/configs/common_phone.mk)

# Inherit GSM common stuff
#$(call inherit-product, vendor/aokp/configs/gsm.mk)

# Common overlay
DEVICE_PACKAGE_OVERLAYS += device/motorola/maserati/overlay/aokp

# Setup device specific product configuration.
PRODUCT_NAME := aokp_maserati
PRODUCT_BRAND := verizon
PRODUCT_DEVICE := maserati
PRODUCT_DEVICE_PREFIX := cdma
PRODUCT_MODEL := XT894
PRODUCT_MANUFACTURER := Motorola
PRODUCT_RELEASE_NAME := Droid4
PRODUCT_SFX := vzw

DATE := $(shell date +%Y%m%d)

PRODUCT_BUILD_PROP_OVERRIDES += \
    PRODUCT_NAME=${PRODUCT_DEVICE}_${PRODUCT_SFX} \
    BUILD_FINGERPRINT=${PRODUCT_BRAND}/${PRODUCT_DEVICE}_${PRODUCT_SFX}/${PRODUCT_DEVICE_PREFIX}_${PRODUCT_DEVICE}:${PLATFORM_VERSION}/${BUILD_ID}/${DATE}:user/release-keys \
    PRIVATE_BUILD_DESC="${PRODUCT_DEVICE_PREFIX}_${PRODUCT_DEVICE}-user ${PLATFORM_VERSION} ${BUILD_ID} ${DATE} release-keys" \

# Copy maserati specific prebuilt files
PRODUCT_COPY_FILES +=  \
    vendor/aokp/prebuilt/bootanimation/bootanimation_540_960.zip:system/media/bootanimation.zip

