LOCAL_PATH := $(call my-dir)
splash_local_path := $(LOCAL_PATH)

splash_sources := \
    splashmenu.c \
    default_splashmenu_ui.c \
    ui.c \

LOCAL_PATH := $(splash_local_path)

include $(CLEAR_VARS)

LOCAL_MODULE := safestrapmenu
LOCAL_MODULE_TAGS := optional

LOCAL_SRC_FILES := $(splash_sources)

LOCAL_CFLAGS += -DMAX_ROWS=40 -DMAX_COLS=96

BOARD_SPLASHSCREEN_DEFINES := BOARD_HAS_VIRTUAL_KEYS BOARD_MAX_TOUCH_X BOARD_MAX_TOUCH_Y BOARD_VIRTUAL_KEY_HEIGHT

$(foreach board_define,$(BOARD_SPLASHSCREEN_DEFINES), \
  $(if $($(board_define)), \
    $(eval LOCAL_CFLAGS += -D$(board_define)=\"$($(board_define))\") \
  ) \
  )

LOCAL_STATIC_LIBRARIES := libminui_bm libpixelflinger_static libpng libz libstdc++ libc libcutils

LOCAL_FORCE_STATIC_EXECUTABLE := true

LOCAL_MODULE_PATH := $(PRODUCT_OUT)/safestrap

include $(BUILD_EXECUTABLE)

include $(call all-makefiles-under,$(splash_local_path))

