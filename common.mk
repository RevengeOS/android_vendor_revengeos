PRODUCT_BUILD_PROP_OVERRIDES += BUILD_UTC_DATE=0

PRODUCT_PROPERTY_OVERRIDES += \
    keyguard.no_require_sim=true \
    ro.com.google.clientidbase=android-google \
    ro.url.legal=http://www.google.com/intl/%s/mobile/android/basic/phone-legal.html \
    ro.url.legal.android_privacy=http://www.google.com/intl/%s/mobile/android/basic/privacy.html \
    ro.com.android.wifi-watchlist=GoogleGuest \
    ro.setupwizard.enterprise_mode=1 \
    ro.com.android.dateformat=MM-dd-yyyy \
    ro.com.android.dataroaming=false

PRODUCT_PROPERTY_OVERRIDES += \
    ro.build.selinux=1

# Mark as eligible for Google Assistant
PRODUCT_PROPERTY_OVERRIDES += ro.opa.eligible_device=true

# Thank you, please drive thru!
PRODUCT_PROPERTY_OVERRIDES += persist.sys.dun.override=0

PRODUCT_COPY_FILES += \
    vendor/citrus/prebuilt/bin/sysinit:system/bin/sysinit \
    vendor/citrus/prebuilt/etc/init.citrus.rc:root/init.citrus.rc

# Backup Tool
PRODUCT_COPY_FILES += \
    vendor/citrus/prebuilt/common/bin/backuptool.sh:install/bin/backuptool.sh \
    vendor/citrus/prebuilt/common/bin/backuptool.functions:install/bin/backuptool.functions \
    vendor/citrus/prebuilt/common/bin/blacklist:system/addon.d/blacklist \
    vendor/citrus/prebuilt/common/bin/whitelist:system/addon.d/whitelist \

# Boot animation include
ifneq ($(TARGET_SCREEN_WIDTH) $(TARGET_SCREEN_HEIGHT),$(space))

# determine the smaller dimension
TARGET_BOOTANIMATION_SIZE := $(shell \
  if [ $(TARGET_SCREEN_WIDTH) -lt $(TARGET_SCREEN_HEIGHT) ]; then \
    echo $(TARGET_SCREEN_WIDTH); \
  else \
    echo $(TARGET_SCREEN_HEIGHT); \
  fi )

# get a sorted list of the sizes
bootanimation_sizes := $(subst .zip,, $(shell ls vendor/citrus/prebuilt/common/bootanimation))
bootanimation_sizes := $(shell echo -e $(subst $(space),'\n',$(bootanimation_sizes)) | sort -rn)

# find the appropriate size and set
define check_and_set_bootanimation
$(eval TARGET_BOOTANIMATION_NAME := $(shell \
  if [ -z "$(TARGET_BOOTANIMATION_NAME)" ]; then
    if [ $(1) -le $(TARGET_BOOTANIMATION_SIZE) ]; then \
      echo $(1); \
      exit 0; \
    fi;
  fi;
  echo $(TARGET_BOOTANIMATION_NAME); ))
endef
$(foreach size,$(bootanimation_sizes), $(call check_and_set_bootanimation,$(size)))

PRODUCT_COPY_FILES += \
    vendor/citrus/prebuilt/common/bootanimation/$(TARGET_BOOTANIMATION_NAME).zip:system/media/bootanimation.zip
endif

# init.d support
PRODUCT_COPY_FILES += \
    vendor/citrus/prebuilt/common/bin/sysinit:system/bin/sysinit \
    vendor/citrus/prebuilt/common/etc/init.d/00banner:system/etc/init.d/00banner \
    vendor/citrus/prebuilt/common/etc/init.d/90userinit:system/etc/init.d/90userinit

# Init file
PRODUCT_COPY_FILES += \
    vendor/citrus/prebuilt/common/etc/init.local.rc:root/init.local.rc

# Bring in camera effects
PRODUCT_COPY_FILES +=  \
    vendor/citrus/prebuilt/common/media/LMprec_508.emd:system/media/LMprec_508.emd \
    vendor/citrus/prebuilt/common/media/PFFprec_600.emd:system/media/PFFprec_600.emd

# Enable SIP+VoIP on all targets
PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.software.sip.voip.xml:system/etc/permissions/android.software.sip.voip.xml

# Enable wireless Xbox 360 controller support
PRODUCT_COPY_FILES += \
    frameworks/base/data/keyboards/Vendor_045e_Product_028e.kl:system/usr/keylayout/Vendor_045e_Product_0719.kl

# Misc packages
PRODUCT_PACKAGES += \
    BluetoothExt \
    libemoji \
    libsepol \
    e2fsck \
    mke2fs \
    tune2fs \
    bash \
    powertop \
    mount.exfat \
    fsck.exfat \
    mkfs.exfat \
    mkfs.f2fs \
    fsck.f2fs \
    fibmap.f2fs \
    mkfs.ntfs \
    fsck.ntfs \
    mount.ntfs \
    gdbserver \
    micro_bench \
    oprofiled \
    sqlite3 \
    strace \
    Terminal \
    ThemeInterfacer \
    libbthost_if \
    WallpaperPicker

# Stagefright FFMPEG plugin
PRODUCT_PACKAGES += \
    libffmpeg_extractor \
    libffmpeg_omx \
    media_codecs_ffmpeg.xml

PRODUCT_PROPERTY_OVERRIDES += \
    media.sf.omx-plugin=libffmpeg_omx.so \
    media.sf.extractor-plugin=libffmpeg_extractor.so

# Telephony packages
PRODUCT_PACKAGES += \
    messaging \
    CellBroadcastReceiver \
    Stk \
    telephony-ext \
    rcscommon

PRODUCT_BOOT_JARS += \
    telephony-ext \
    rcscommon

#RCS //Needed for Contacts and Mms Apps
PRODUCT_PACKAGES += \
    rcs_service_aidl \
    rcs_service_aidl.xml \
    rcs_service_aidl_static \
    rcs_service_api \
    rcs_service_api.xml \
    rcscommon.xml

# Include librsjni explicitly to workaround GMS issue
PRODUCT_PACKAGES += \
    libprotobuf-cpp-full \
    librsjni

# TCP Connection Management
PRODUCT_PACKAGES += tcmiface
PRODUCT_BOOT_JARS += tcmiface

# World APN list
PRODUCT_COPY_FILES += \
    vendor/citrus/prebuilt/common/etc/apns-conf.xml:system/etc/apns-conf.xml

# Selective SPN list for operator number who has the problem.
PRODUCT_COPY_FILES += \
    vendor/citrus/prebuilt/common/etc/selective-spn-conf.xml:system/etc/selective-spn-conf.xml

# Overlays & Include LatinIME dictionaries
PRODUCT_PACKAGE_OVERLAYS += \
	vendor/citrus/overlay/common \
	vendor/citrus/overlay/dictionaries

# Proprietary latinime libs needed for Keyboard swyping
ifneq ($(filter arm64,$(TARGET_ARCH)),)
PRODUCT_COPY_FILES += \
    vendor/citrus/prebuilt/common/lib/libjni_latinime.so:system/lib/libjni_latinime.so
else
PRODUCT_COPY_FILES += \
    vendor/citrus/prebuilt/common/lib64/libjni_latinime.so:system/lib64/libjni_latinime.so
endif

# by default, do not update the recovery with system updates
PRODUCT_PROPERTY_OVERRIDES += persist.sys.recovery_update=false

ifneq ($(TARGET_BUILD_VARIANT),eng)
# Enable ADB authentication
ADDITIONAL_DEFAULT_PROPERTIES += ro.adb.secure=1
endif

PLATFORM_SECURITY_PATCH := ""

$(call inherit-product-if-exists, vendor/extra/product.mk)

# Versioning System
# Citrus-CAF first version.
PRODUCT_VERSION_FLAVOUR = TANGERINE
PRODUCT_VERSION = 3.5
ifdef CITRUS_BUILD_EXTRA
    CITRUS_POSTFIX := -$(CITRUS_BUILD_EXTRA)
endif
ifndef CITRUS_BUILD_TYPE
ifeq ($(CITRUS_RELEASE),true)
    CITRUS_BUILD_TYPE := OFFICIAL
    PLATFORM_VERSION_CODENAME := OFFICIAL
    CITRUS_POSTFIX := -$(shell date +"%Y%m%d")
else
    CITRUS_BUILD_TYPE := UNOFFICIAL
    PLATFORM_VERSION_CODENAME := UNOFFICIAL
    CITRUS_POSTFIX := -$(shell date +"%Y%m%d")
endif
endif

ifeq ($(CITRUS_BUILD_TYPE),DM)
    CITRUS_POSTFIX := -$(shell date +"%Y%m%d")
endif

ifndef CITRUS_POSTFIX
    CITRUS_POSTFIX := -$(shell date +"%Y%m%d")
endif

PLATFORM_VERSION_CODENAME := $(CITRUS_BUILD_TYPE)

# Set all versions
CITRUS_VERSION := CitrusCAF-$(PRODUCT_VERSION)-$(PRODUCT_VERSION_FLAVOUR)-$(CITRUS_BUILD_TYPE)$(CITRUS_POSTFIX)
CITRUS_MOD_VERSION := CitrusCAF-$(CITRUS_BUILD)-$(PRODUCT_VERSION)-$(PRODUCT_VERSION_FLAVOUR)-$(CITRUS_BUILD_TYPE)$(CITRUS_POSTFIX)
PRODUCT_PROPERTY_OVERRIDES += \
    BUILD_DISPLAY_ID=$(BUILD_ID) \
    citrus.ota.version=$(CITRUS_MOD_VERSION) \
    ro.citrus.version=$(PRODUCT_VERSION)-$(PRODUCT_VERSION_FLAVOUR) \
    ro.modversion=$(CITRUS_MOD_VERSION) \
    ro.citrus.buildtype=$(CITRUS_BUILD_TYPE) \
    ro.citrus.flavour=$(PRODUCT_VERSION_FLAVOUR)


# Citrus Bloats
PRODUCT_PACKAGES += \
MusicFX \
audio_effects.conf \
libcyanogen-dsp \
Camera2 \
Gallery2 \
Launcher3 \
LatinIME \
LiveWallpapersPicker \
AboutCitrus \
CitrusHeaders \
CTRWalls \
Recorder \
MargaritaTheme

#Themes
# include vendor/citrus/config/themes_common.mk


# DU Utils Library
PRODUCT_PACKAGES += \
    org.dirtyunicorns.utils

PRODUCT_BOOT_JARS += \
    org.dirtyunicorns.utils

# Custom off-mode charger
ifneq ($(WITH_OWN_CHARGER),true)
PRODUCT_PACKAGES += \
    charger_res_images \
    cm_charger_res_images \
    font_log.png \
    libhealthd.cm
endif

PRODUCT_PACKAGES += \
   OmniStyle \
   OmniJaws
