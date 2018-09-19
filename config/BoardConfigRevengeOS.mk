ifeq ($(BOARD_USES_QCOM_HARDWARE),true)
    BOARD_USES_QTI_HARDWARE := true
endif

ifeq ($(BOARD_USES_QTI_HARDWARE),true)
include vendor/revengeos/config/BoardConfigQcom.mk
endif

-include vendor/revengeos/perf/BoardConfigVendor.mk

include vendor/aosp/config/BoardConfigKernel.mk

include vendor/aosp/config/BoardConfigSoong.mk
