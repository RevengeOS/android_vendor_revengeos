# Set device-specific HALs into project pathmap
define set-device-specific-path
$(if $(USE_DEVICE_SPECIFIC_$(1)), \
    $(if $(DEVICE_SPECIFIC_$(1)_PATH), \
        $(eval path := $(DEVICE_SPECIFIC_$(1)_PATH)), \
        $(eval path := $(TARGET_DEVICE_DIR)/$(2))), \
    $(eval path := $(3))) \
$(call project-set-path,qcom-$(2),$(strip $(path)))
endef

ifeq ($(BOARD_USES_QCOM_HARDWARE),true)
$(call set-device-specific-path,AUDIO,audio,hardware/qcom-caf/$(QCOM_HARDWARE_VARIANT)/audio)
$(call set-device-specific-path,DISPLAY,display,hardware/qcom-caf/$(QCOM_HARDWARE_VARIANT)/display)
$(call set-device-specific-path,MEDIA,media,hardware/qcom-caf/$(QCOM_HARDWARE_VARIANT)/media)

ifdef TARGET_OVERRIDE_BT_VENDOR
$(call set-device-specific-path,BT_VENDOR,bt-vendor,hardware/qcom-caf/$(TARGET_OVERRIDE_BT_VENDOR))
else
$(call set-device-specific-path,BT_VENDOR,bt-vendor,hardware/qcom-caf/bt)
endif

ifdef TARGET_OVERRIDE_DATA_IPA_CFG_MGR
$(call set-device-specific-path,DATA_IPA_CFG_MGR,data-ipa-cfg-mgr,vendor/qcom/opensource/$(TARGET_OVERRIDE_DATA_IPA_CFG_MGR))
else
$(call set-device-specific-path,DATA_IPA_CFG_MGR,data-ipa-cfg-mgr,vendor/qcom/opensource/data-ipa-cfg-mgr)
endif

ifdef TARGET_OVERRIDE_DATASERVICES
$(call set-device-specific-path,DATASERVICES,dataservices,vendor/qcom/opensource/$(TARGET_OVERRIDE_DATASERVICES))
else
$(call set-device-specific-path,DATASERVICES,dataservices,vendor/qcom/opensource/dataservices)
endif

ifdef TARGET_OVERRIDE_POWER
$(call set-device-specific-path,POWER,power,hardware/qcom-caf/$(TARGET_OVERRIDE_POWER))
else
$(call set-device-specific-path,POWER,power,hardware/qcom-caf/power)
endif

ifdef TARGET_OVERRIDE_THERMAL
$(call set-device-specific-path,THERMAL,thermal,hardware/qcom-caf/$(TARGET_OVERRIDE_THERMAL))
else
$(call set-device-specific-path,THERMAL,thermal,hardware/qcom-caf/thermal)
endif

ifdef TARGET_OVERRIDE_VR
$(call set-device-specific-path,VR,vr,hardware/qcom-caf/$(TARGET_OVERRIDE_VR))
else
$(call set-device-specific-path,VR,vr,hardware/qcom-caf/vr)
endif

ifdef TARGET_OVERRIDE_WLAN
$(call set-device-specific-path,WLAN,wlan,hardware/qcom-caf/$(TARGET_OVERRIDE_WLAN))
else
$(call set-device-specific-path,WLAN,wlan,hardware/qcom-caf/wlan)
endif

PRODUCT_CFI_INCLUDE_PATHS += \
    hardware/qcom-caf/wlan/qcwcn/wpa_supplicant_8_lib
endif
