include vendor/revengeos/config/BoardConfigKernel.mk

ifeq ($(BOARD_USES_QCOM_HARDWARE),true)
include vendor/revengeos/config/BoardConfigQcom.mk
endif

include vendor/revengeos/config/BoardConfigSoong.mk

# Disable qmi EAP-SIM security
DISABLE_EAP_PROXY := true
