# Charger
ifneq ($(WITH_OWN_CHARGER),false)
    BOARD_HAL_STATIC_LIBRARIES := libhealthd.cm
endif
