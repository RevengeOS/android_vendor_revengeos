# Charger
ifneq ($(WITH_CUSTOM_CHARGER),false)
    BOARD_HAL_STATIC_LIBRARIES := libhealthd.custom
endif
