# inherit from common
-include device/motorola/common/BoardConfigCommon.mk

# inherit from the proprietary version
-include vendor/motorola/maserati/BoardConfigVendor.mk


# Processor
TARGET_BOOTLOADER_BOARD_NAME := maserati

# Kernel
BOARD_KERNEL_CMDLINE := root=/dev/ram0 rw mem=1024M@0x80000000 console=ttyO2,115200n8 init=/init ip=off mmcparts=mmcblk1:p7(pds),p8(utags),p14(boot),p15(recovery),p16(cdrom),p17(misc),p18(cid),p19(kpanic),p20(system),p21(cache),p22(preinstall),p23(webtop),p24(userdata),p25(emstorage) mot_sst=1 androidboot.bootloader=0x0A72

# Kernel Build
TARGET_KERNEL_SOURCE := kernel/motorola/mapphone
TARGET_KERNEL_CONFIG := mapphone_maserati_defconfig

# Recovery
BOARD_HAS_WEBTOP := true
BOARD_NONSAFE_SYSTEM_DEVICE := /dev/block/mmcblk1p20

BOARD_HAS_VIRTUAL_KEYS := true
BOARD_VIRTUAL_KEY_HEIGHT := 64
BOARD_MAX_TOUCH_X := 1024
BOARD_MAX_TOUCH_Y := 1024


# Misc.
BOARD_USES_KEYBOARD_HACK := true
BOARD_HAS_MAPPHONE_SWITCH := true
