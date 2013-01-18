#
# This is the product configuration for a full maserati
#
$(call inherit-product, device/motorola/common/common.mk)

DEVICE_FOLDER := device/motorola/maserati
COMMON_FOLDER := device/motorola/common

# Device overlay
    DEVICE_PACKAGE_OVERLAYS += $(DEVICE_FOLDER)/overlay/aosp

# Hardware HALs
PRODUCT_PACKAGES += \
    camera.maserati \

#    hwcomposer.maserati \

# Audio
PRODUCT_COPY_FILES += \
    $(DEVICE_FOLDER)/audio/alsa.omap4.so:/system/lib/hw/alsa.omap4.so \
    $(DEVICE_FOLDER)/audio/audio.primary.omap4.so:/system/lib/hw/audio.primary.maserati.so \
    $(DEVICE_FOLDER)/audio/libaudio_ext.so:/system/lib/libaudio_ext.so

PRODUCT_PACKAGES += \
    audio_policy.maserati \
    libasound

# Modem
PRODUCT_PACKAGES += \
    nc \
    Stk \
    libreference-cdma-sms

# Kexec files and ti ducati or rootfs files
ifeq ($(BOARD_USES_KEXEC),true)
ifeq ($(TARGET_PRODUCT),full_maserati)
PRODUCT_COPY_FILES += $(COMMON_FOLDER)/prebuilt/etc/rootfs/init:root/init
endif
PRODUCT_COPY_FILES += \
    $(DEVICE_FOLDER)/prebuilt/etc/firmware/ducati-m3.bin:system/etc/firmware/ducati-m3.bin \
    $(DEVICE_FOLDER)/kexec/devtree:system/etc/kexec/devtree \
    $(OUT)/ramdisk.img:system/etc/kexec/ramdisk.img \
    $(OUT)/kernel:system/etc/kexec/kernel
else
ifeq ($(TARGET_PRODUCT),full_maserati)
PRODUCT_COPY_FILES += $(COMMON_FOLDER)/prebuilt/etc/rootfs/init:system/etc/rootfs/init
else
PRODUCT_COPY_FILES += $(OUT)/root/init:system/etc/rootfs/init
endif
endif

# Prebuilts
PRODUCT_COPY_FILES += \
    $(DEVICE_FOLDER)/prebuilt/bin/battd:system/bin/battd \
    $(DEVICE_FOLDER)/prebuilt/bin/mount_ext3.sh:system/bin/mount_ext3.sh \
    $(DEVICE_FOLDER)/prebuilt/etc/media_codecs.xml:system/etc/media_codecs.xml \
    $(DEVICE_FOLDER)/prebuilt/etc/media_profiles.xml:system/etc/media_profiles.xml \
    $(DEVICE_FOLDER)/prebuilt/etc/audio_policy.conf:system/etc/audio_policy.conf \
    $(DEVICE_FOLDER)/prebuilt/etc/vold.fstab:system/etc/vold.fstab \
    $(DEVICE_FOLDER)/prebuilt/usr/idc/omap4-keypad.idc:system/usr/idc/omap4-keypad.idc \
    $(DEVICE_FOLDER)/prebuilt/usr/keychars/omap4-keypad.kcm:system/usr/keychars/omap4-keypad.kcm \
    $(DEVICE_FOLDER)/prebuilt/usr/keylayout/omap4-keypad.kl:system/usr/keylayout/omap4-keypad.kl

# copy all kernel modules under the "modules" directory to system/lib/modules
ifneq ($(BOARD_USES_KEXEC),true)
PRODUCT_COPY_FILES += $(shell \
    find device/motorola/maserati/modules -name '*.ko' \
    | sed -r 's/^\/?(.*\/)([^/ ]+)$$/\1\2:system\/lib\/modules\/\2/' \
    | tr '\n' ' ')
endif

$(call inherit-product-if-exists, vendor/motorola/common/proprietary/vzw/verizon.mk)
$(call inherit-product-if-exists, vendor/motorola/maserati/maserati-vendor.mk)
ifneq ($(BOARD_USES_KEXEC),true)
$(call inherit-product-if-exists, vendor/motorola/maserati/maserati-vendor-pvr.mk)
$(call inherit-product-if-exists, vendor/motorola/maserati/maserati-vendor-stock-camera.mk)
$(call inherit-product-if-exists, vendor/motorola/maserati/maserati-vendor-stock-ducati.mk)
endif
