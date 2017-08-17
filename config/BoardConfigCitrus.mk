# Charger
ifneq ($(WITH_OWN_CHARGER),false)
    BOARD_HAL_STATIC_LIBRARIES := libhealthd.cm
endif

ifeq ($(BOARD_CACHEIMAGE_FILE_SYSTEM_TYPE),)
  PRODUCT_DEFAULT_PROPERTY_OVERRIDES  += \
    ro.device.cache_dir=/data/cache
else
  PRODUCT_DEFAULT_PROPERTY_OVERRIDES  += \
    ro.device.cache_dir=/cache
endif
