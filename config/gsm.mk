# Sensitive Phone Numbers list
PRODUCT_COPY_FILES += \
    vendor/revengeos/prebuilt/etc/sensitive_pn.xml:system/etc/sensitive_pn.xml

# GSM APN list
PRODUCT_COPY_FILES += \
    vendor/revengeos/prebuilt/etc/apns-conf.xml:system/etc/apns-conf.xml

PRODUCT_COPY_FILES += \
    vendor/revengeos/prebuilt/etc/selective-spn-conf.xml:system/etc/selective-spn-conf.xml

# Default ringtone
PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
    ro.config.ringtone=The_big_adventure.ogg

# SIM Toolkit
PRODUCT_PACKAGES += \
    PrebuiltBugle \
    Stk \
    CellBroadcastReceiver

IS_PHONE := true

#RCS
PRODUCT_PACKAGES += \
    rcs_service_aidl \
    rcs_service_aidl.xml \
    rcs_service_aidl_static \
    rcs_service_api \
    rcs_service_api.xml
