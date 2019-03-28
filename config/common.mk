PRODUCT_BRAND ?= RevengeOS
REVENGEOS_BUILD := true

ifeq ($(PRODUCT_GMS_CLIENTID_BASE),)
PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
    ro.com.google.clientidbase=android-google
else
PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
    ro.com.google.clientidbase=$(PRODUCT_GMS_CLIENTID_BASE)
endif

# Allow vendor/extra to override any property by setting it first
$(call inherit-product-if-exists, vendor/extra/product.mk)

# Fixes: terminate called after throwing an instance of 'std::out_of_range' what(): basic_string::erase
# error with prop override
PRODUCT_BUILD_PROP_OVERRIDES += BUILD_UTC_DATE=0

# general properties
PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
    ro.url.legal=http://www.google.com/intl/%s/mobile/android/basic/phone-legal.html \
    ro.com.android.wifi-watchlist=GoogleGuest \
    ro.setupwizard.enterprise_mode=1 \
    persist.sys.root_access=1 \
    ro.opa.eligible_device=true

PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
    ro.build.selinux=1

# Tethering - allow without requiring a provisioning app
# (for devices that check this)
PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
    net.tethering.noprovisioning=true

# Backup Tool
PRODUCT_COPY_FILES += \
    vendor/revengeos/prebuilt/bin/backuptool.sh:install/bin/backuptool.sh \
    vendor/revengeos/prebuilt/bin/backuptool.functions:install/bin/backuptool.functions \
    vendor/revengeos/prebuilt/bin/50-hosts.sh:system/addon.d/50-hosts.sh \
    vendor/revengeos/prebuilt/bin/blacklist:system/addon.d/blacklist

ifeq ($(AB_OTA_UPDATER),true)
PRODUCT_COPY_FILES += \
    vendor/revengeos/prebuilt/bin/backuptool_ab.sh:system/bin/backuptool_ab.sh \
    vendor/revengeos/prebuilt/bin/backuptool_ab.functions:system/bin/backuptool_ab.functions \
    vendor/revengeos/prebuilt/bin/backuptool_postinstall.sh:system/bin/backuptool_postinstall.sh
endif

# Backup Services whitelist
PRODUCT_COPY_FILES += \
    vendor/revengeos/config/permissions/backup.xml:system/etc/sysconfig/backup.xml

# init.d support
PRODUCT_COPY_FILES += \
    vendor/revengeos/prebuilt/etc/init.d/00banner:system/etc/init.d/00banner \
    vendor/revengeos/prebuilt/bin/sysinit:system/bin/sysinit \
    vendor/revengeos/prebuilt/etc/init/init.revengeos.rc:system/etc/init/init.revengeos.rc

# Enable SIP and VoIP on all targets
PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.software.sip.voip.xml:system/etc/permissions/android.software.sip.voip.xml

# Default notification/alarm sounds
PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
    ro.config.notification_sound=Popcorn.ogg \
    ro.config.alarm_alert=Bright_morning.ogg

# Do not include art debug targets
PRODUCT_ART_TARGET_INCLUDE_DEBUG_BUILD := false

# Strip the local variable table and the local variable type table to reduce
# the size of the system image. This has no bearing on stack traces, but will
# leave less information available via JDWP.
PRODUCT_MINIMIZE_JAVA_DEBUG_INFO := true

# Charging sounds
PRODUCT_COPY_FILES += \
    vendor/revengeos/prebuilt/media/audio/BatteryPlugged.ogg:system/media/audio/ui/BatteryPlugged.ogg \
    vendor/revengeos/prebuilt/media/audio/BatteryPlugged_48k.ogg:system/media/audio/ui/BatteryPlugged_48k.ogg

# Additional packages
-include vendor/revengeos/config/packages.mk

# SELinux Policy
-include vendor/revengeos/sepolicy/sepolicy.mk

# Add our overlays
DEVICE_PACKAGE_OVERLAYS += vendor/revengeos/overlay/common

# Don't compile SystemUITests
EXCLUDE_SYSTEMUI_TESTS := true

# include definitions for SDCLANG
include vendor/revengeos/build/sdclang/sdclang.mk

# GApps
include vendor/gapps/config.mk

# RevengeUI
include vendor/revengeui/config.mk

# Use release-keys with if possible
include vendor/revengeos/config/release_keys.mk
