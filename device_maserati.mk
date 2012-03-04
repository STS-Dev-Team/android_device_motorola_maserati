#
# This is the product configuration for a full maserati
#

# The gps config appropriate for this device
$(call inherit-product, device/common/gps/gps_us_supl.mk)

## (3)  Finally, the least specific parts, i.e. the non-GSM-specific aspects

# Device overlay
    DEVICE_PACKAGE_OVERLAYS += device/motorola/maserati/overlay

# high-density artwork where available
PRODUCT_AAPT_CONFIG := normal hdpi
PRODUCT_AAPT_PREF_CONFIG := hdpi

PRODUCT_PACKAGES := \
    charger \
    charger_res_images

# Audio
PRODUCT_COPY_FILES += \
    device/motorola/maserati/audio/acoustics.default.so:/system/lib/hw/acoustics.maserati.so \
    device/motorola/maserati/audio/alsa.omap4.so:/system/lib/hw/alsa.maserati.so \
    device/motorola/maserati/audio/libasound.so:/system/lib/libasound.so \
    device/motorola/maserati/audio/libaudio.so:/system/lib/libaudio.so \
    device/motorola/maserati/audio/libaudio_ext.so:/system/lib/libaudio_ext.so \
    device/motorola/maserati/audio/libaudiopolicy.so:/system/lib/libaudiopolicy.so \
    device/motorola/maserati/audio/liba2dp.so:/system/lib/liba2dp.so 

# Hardware HALs
PRODUCT_COPY_FILES += \
    device/motorola/maserati/prebuilt/imgtec/gralloc.omap4.so:system/lib/hw/gralloc.omap4.so \

# Hardware HALs
#PRODUCT_PACKAGES += \
#    lights.maserati \
#    sensors.maserati \

PRODUCT_PACKAGES += \
    camera.omap4

PRODUCT_PACKAGES += \
    audio.primary.maserati \
    audio_policy.maserati

# BlueZ a2dp Audio HAL module
PRODUCT_PACKAGES += \
    audio.a2dp.default

# BlueZ test tools
PRODUCT_PACKAGES += \
    hciconfig \
    hcitool

# Modem
PRODUCT_PACKAGES += \
    nc \
    Stk \
    libaudiomodemgeneric \
    libreference-cdma-sms \
    rild \
    radiooptions \
    sh 

# Wifi
PRODUCT_PACKAGES += \
    libCustomWifi \
    wlan_loader \
    wlan_cu \
    dhcpcd.conf \
    wpa_supplicant.conf 

# HotSpot
PRODUCT_PACKAGES += \
    tiap_loader \
    tiap_cu \
    hostap \
    hostapd.conf 

# Bluetooth
PRODUCT_PACKAGES += \
    bt_sco_app \
    uim-sysfs 

# FM Radio
#PRODUCT_PACKAGES += \
#    com.ti.fm.fmradioif.xml \
#    fmradioif \
#    FmRxApp \
#    FmTxApp \
#    FmService 

# Release utilities
PRODUCT_PACKAGES += \
    maserati_releaseutils-check_kernel \
    maserati_releaseutils-finalize_release \
    maserati_releaseutils-mke2fs \
    maserati_releaseutils-tune2fs

# Tests -- Can remove later
PRODUCT_PACKAGES += \
    d2c_test \
    memmgr_test \
    utils_test \
    tiler_ptest \
    overlay_test \
    omx_tests \
    evtest \
#    camera_test \
#    VideoEncTest 

PRODUCT_PACKAGES += \
    Camera \
    Superuser \
    su \
    Usb \
    DockAudio \


PRODUCT_PACKAGES += \
    librs_jni \
    com.android.future.usb.accessory \
    FileManager \
    MusicFX \
    libjni_pinyinime 

# WirelessTether
PRODUCT_COPY_FILES += \
    device/motorola/maserati/prebuilt/app/wifi_tether_v3_1-beta11.apk:system/app/wifi_tether_v3_1-beta11.apk \
    device/motorola/maserati/prebuilt/lib/libwtnativetask.so:system/lib/libwtnativetask.so \
    device/motorola/maserati/prebuilt/bin/bootsound:system/bin/bootsound \
#    device/motorola/maserati/prebuilt/media/android_audio.mp3:system/media/android_audio.mp3 \
#    device/motorola/maserati/prebuilt/media/bootanimation.zip:system/media/bootanimation.zip \
    

# Rootfs files
PRODUCT_COPY_FILES += \
    out/target/product/maserati/root/init:system/etc/rootfs/init \
    out/target/product/maserati/root/sbin/adbd:system/etc/rootfs/sbin/adbd \
    device/motorola/maserati/root/default.prop:system/etc/rootfs/default.prop \
    device/motorola/maserati/root/init.rc:system/etc/rootfs/init.rc \
    device/motorola/maserati/root/init.mapphone_cdma.rc:system/etc/rootfs/init.mapphone_cdma.rc \
    device/motorola/maserati/root/init.mapphone_umts.rc:system/etc/rootfs/init.mapphone_umts.rc \
    device/motorola/maserati/root/usbcheck.sh:system/etc/rootfs/usbcheck.sh \
    device/motorola/maserati/root/ueventd.rc:system/etc/rootfs/ueventd.rc \

# Hijack files
PRODUCT_COPY_FILES += \
    device/motorola/maserati/root/default.prop:root/default.prop \
    device/motorola/maserati/root/init.rc:root/init.rc \
    device/motorola/maserati/root-hijack/init.mapphone_cdma.rc:root/init.mapphone_cdma.rc \
    device/motorola/maserati/root-hijack/init.mapphone_umts.rc:root/init.mapphone_umts.rc \
    device/motorola/maserati/root/usbcheck.sh:root/usbcheck.sh \
    device/motorola/maserati/root/ueventd.rc:root/ueventd.rc \


# Permissions files
PRODUCT_COPY_FILES += \
    frameworks/base/data/etc/android.hardware.camera.flash-autofocus.xml:/system/etc/permissions/android.hardware.camera.flash-autofocus.xml \
    frameworks/base/data/etc/android.hardware.camera.front.xml:/system/etc/permissions/android.hardware.camera.front.xml \
    frameworks/base/data/etc/android.hardware.camera.xml:/system/etc/permissions/android.hardware.camera.xml \
    frameworks/base/data/etc/android.hardware.location.gps.xml:/system/etc/permissions/android.hardware.location.gps.xml \
    frameworks/base/data/etc/android.hardware.sensor.accelerometer.xml:/system/etc/permissions/android.hardware.sensor.accelerometer.xml \
    frameworks/base/data/etc/android.hardware.sensor.compass.xml:/system/etc/permissions/android.hardware.sensor.compass.xml \
    frameworks/base/data/etc/android.hardware.sensor.light.xml:/system/etc/permissions/android.hardware.sensor.light.xml \
    frameworks/base/data/etc/android.hardware.sensor.proximity.xml:/system/etc/permissions/android.hardware.sensor.proximity.xml \
    frameworks/base/data/etc/android.hardware.telephony.cdma.xml:/system/etc/permissions/android.hardware.telephony.cdma.xml \
    frameworks/base/data/etc/android.hardware.telephony.gsm.xml:/system/etc/permissions/android.hardware.telephony.gsm.xml \
    frameworks/base/data/etc/android.hardware.touchscreen.multitouch.distinct.xml:/system/etc/permissions/android.hardware.touchscreen.multitouch.distinct.xml \
    frameworks/base/data/etc/android.hardware.touchscreen.multitouch.xml:/system/etc/permissions/android.hardware.touchscreen.multitouch.xml \
    frameworks/base/data/etc/android.hardware.wifi.xml:/system/etc/permissions/android.hardware.wifi.xml \
    frameworks/base/data/etc/handheld_core_hardware.xml:/system/etc/permissions/handheld_core_hardware.xml \
    frameworks/base/data/etc/android.hardware.usb.accessory.xml:system/etc/permissions/android.hardware.usb.accessory.xml \


# Prebuilts
PRODUCT_COPY_FILES += \
    device/motorola/maserati/prebuilt/bin/battd:system/bin/battd \
    device/motorola/maserati/prebuilt/bin/hijack:system/bin/hijack \
    device/motorola/maserati/prebuilt/bin/hijack.log_dump:system/bin/hijack.log_dump \
    device/motorola/maserati/prebuilt/bin/mount_ext3.sh:system/bin/mount_ext3.sh \
    device/motorola/maserati/prebuilt/bin/strace:system/bin/strace \
    device/motorola/maserati/prebuilt/etc/TICameraCameraProperties.xml:system/etc/TICameraCameraProperties.xml \
    device/motorola/maserati/prebuilt/etc/gps.conf:system/etc/gps.conf \
    device/motorola/maserati/prebuilt/etc/media_profiles.xml:system/etc/media_profiles.xml \
    device/motorola/maserati/prebuilt/etc/vold.fstab:system/etc/vold.fstab \
    device/motorola/maserati/prebuilt/etc/wifi/tiwlan_ap.ini:system/etc/wifi/tiwlan_ap.ini \
    device/motorola/maserati/prebuilt/etc/wifi/tiwlan.ini:system/etc/wifi/tiwlan.ini \
    device/motorola/maserati/prebuilt/etc/hijack-boot.zip:system/etc/hijack-boot.zip \
    device/motorola/maserati/prebuilt/usr/idc/cpcap-key.idc:system/usr/idc/cpcap-key.idc \
    device/motorola/maserati/prebuilt/usr/idc/cy8c201xx.idc:system/usr/idc/cy8c201xx.idc \
    device/motorola/maserati/prebuilt/usr/idc/light-prox.idc:system/usr/idc/light-prox.idc \
    device/motorola/maserati/prebuilt/usr/idc/mapphone-switch.idc:system/usr/idc/mapphone-switch.idc \
    device/motorola/maserati/prebuilt/usr/idc/omap-keypad.idc:system/usr/idc/omap-keypad.idc \
    device/motorola/maserati/prebuilt/usr/idc/atmxt-i2c.idc:system/usr/idc/atmxt-i2c.idc \
    device/motorola/maserati/prebuilt/usr/keychars/cpcap-key.kcm:system/usr/keychars/cpcap-key.kcm \
    device/motorola/maserati/prebuilt/usr/keychars/cy8c201xx.kcm:system/usr/keychars/cy8c201xx.kcm \
    device/motorola/maserati/prebuilt/usr/keychars/light-prox.kcm:system/usr/keychars/light-prox.kcm \
    device/motorola/maserati/prebuilt/usr/keychars/mapphone-switch.kcm:system/usr/keychars/mapphone-switch.kcm \
    device/motorola/maserati/prebuilt/usr/keychars/omap-keypad.kcm:system/usr/keychars/omap-keypad.kcm \
    device/motorola/maserati/prebuilt/usr/keychars/atmxt-i2c.kcm:system/usr/keychars/atmxt-i2c.kcm \
    device/motorola/maserati/prebuilt/usr/keylayout/aev_abs.kl:system/usr/keylayout/aev_abs.kl \
    device/motorola/maserati/prebuilt/usr/keylayout/AVRCP.kl:system/usr/keylayout/AVRCP.kl \
    device/motorola/maserati/prebuilt/usr/keylayout/cpcap-key.kl:system/usr/keylayout/cpcap-key.kl \
    device/motorola/maserati/prebuilt/usr/keylayout/light-prox.kl:system/usr/keylayout/light-prox.kl \
    device/motorola/maserati/prebuilt/usr/keylayout/mapphone-switch.kl:system/usr/keylayout/mapphone-switch.kl \
    device/motorola/maserati/prebuilt/usr/keylayout/cy8c201xx.kl:system/usr/keylayout/cy8c201xx.kl \
    device/motorola/maserati/prebuilt/usr/keylayout/evfwd.kl:system/usr/keylayout/evfwd.kl \
    device/motorola/maserati/prebuilt/usr/keylayout/omap-keypad.kl:system/usr/keylayout/omap-keypad.kl \
    device/motorola/maserati/prebuilt/usr/keylayout/atmxt-i2c.kl:system/usr/keylayout/atmxt-i2c.kl \

# Phone settings
PRODUCT_COPY_FILES += \
    device/sample/etc/apns-conf_verizon.xml:system/etc/apns-conf.xml \
    vendor/cm/prebuilt/common/etc/spn-conf.xml:system/etc/spn-conf.xml \


# Graphics
PRODUCT_COPY_FILES += \
    device/motorola/maserati/prebuilt/imgtec/pvrsrvinit:system/bin/pvrsrvinit \
    device/motorola/maserati/prebuilt/imgtec/libEGL_POWERVR_SGX540_120.so:system/lib/egl/libEGL_POWERVR_SGX540_120.so \
    device/motorola/maserati/prebuilt/imgtec/libGLESv1_CM_POWERVR_SGX540_120.so:system/lib/egl/libGLESv1_CM_POWERVR_SGX540_120.so \
    device/motorola/maserati/prebuilt/imgtec/libGLESv2_POWERVR_SGX540_120.so:system/lib/egl/libGLESv2_POWERVR_SGX540_120.so \
    device/motorola/maserati/prebuilt/imgtec/libglslcompiler.so:system/lib/libglslcompiler.so \
    device/motorola/maserati/prebuilt/imgtec/libIMGegl.so:system/lib/libIMGegl.so \
    device/motorola/maserati/prebuilt/imgtec/libpvr2d.so:system/lib/libpvr2d.so \
    device/motorola/maserati/prebuilt/imgtec/libpvrANDROID_WSEGL.so:system/lib/libpvrANDROID_WSEGL.so \
    device/motorola/maserati/prebuilt/imgtec/libPVRScopeServices.so:system/lib/libPVRScopeServices.so \
    device/motorola/maserati/prebuilt/imgtec/libsrv_init.so:system/lib/libsrv_init.so \
    device/motorola/maserati/prebuilt/imgtec/libsrv_um.so:system/lib/libsrv_um.so \
    device/motorola/maserati/prebuilt/imgtec/libusc.so:system/lib/libusc.so \
    device/motorola/maserati/prebuilt/imgtec/libdrm.so:system/lib/libdrm.so \

# we have enough storage space to hold precise GC data
PRODUCT_TAGS += dalvik.gc.type-precise

# still need to set english for audio init
PRODUCT_LOCALES += en_US


# copy all kernel modules under the "modules" directory to system/lib/modules
PRODUCT_COPY_FILES += $(shell \
    find device/motorola/maserati/modules -name '*.ko' \
    | sed -r 's/^\/?(.*\/)([^/ ]+)$$/\1\2:system\/lib\/modules\/\2/' \
    | tr '\n' ' ')

ifeq ($(TARGET_PREBUILT_KERNEL),)
LOCAL_KERNEL := device/motorola/maserati/kernel
else
LOCAL_KERNEL := $(TARGET_PREBUILT_KERNEL)
endif

PRODUCT_COPY_FILES += \
    $(LOCAL_KERNEL):kernel

# stuff specific to ti OMAP4 hardware
$(call inherit-product, hardware/ti/omap4xxx/omap4.mk)
$(call inherit-product, hardware/ti/camera/camera.mk)
$(call inherit-product, hardware/ti/wpan/ti-wpan-products.mk)
#$(call inherit-product-if-exists, vendor/google/google-vendor.mk)
$(call inherit-product-if-exists, vendor/verizon/maserati-verizon-vendor.mk)


$(call inherit-product-if-exists, vendor/motorola/maserati/maserati-vendor.mk)


# stuff common to all Motorola phones -- disabled for Sandbox
#$(call inherit-product, device/motorola/common/common_hijack.mk)

$(call inherit-product, build/target/product/full_base_telephony.mk)

PRODUCT_NAME := full_maserati
PRODUCT_DEVICE := maserati
