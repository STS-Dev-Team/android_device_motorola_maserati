PRODUCT_MAKEFILES := $(LOCAL_DIR)/full_maserati.mk
ifeq ($(TARGET_PRODUCT),aokp_maserati)
    PRODUCT_MAKEFILES += $(LOCAL_DIR)/aokp.mk
endif
ifeq ($(TARGET_PRODUCT),cna_maserati)
    PRODUCT_MAKEFILES += $(LOCAL_DIR)/cna.mk
endif
