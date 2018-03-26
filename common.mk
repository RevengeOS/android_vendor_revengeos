PRODUCT_BUILD_PROP_OVERRIDES += BUILD_UTC_DATE=0

PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
    keyguard.no_require_sim=true \
    ro.com.google.clientidbase=android-google \
    ro.url.legal=http://www.google.com/intl/%s/mobile/android/basic/phone-legal.html \
    ro.url.legal.android_privacy=http://www.google.com/intl/%s/mobile/android/basic/privacy.html \
    ro.com.android.wifi-watchlist=GoogleGuest \
    ro.setupwizard.enterprise_mode=1 \
    ro.com.android.dateformat=MM-dd-yyyy \
    ro.com.android.dataroaming=false \
    ro.setupwizard.rotation_locked=true


# RecueParty? No thanks.
PRODUCT_SYSTEM_DEFAULT_PROPERTIES += persist.sys.enable_rescue=false

PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
    ro.build.selinux=1

# Mark as eligible for Google Assistant
PRODUCT_SYSTEM_DEFAULT_PROPERTIES += ro.opa.eligible_device=true

ifneq ($(TARGET_BUILD_VARIANT),user)
# Thank you, please drive thru!
PRODUCT_SYSTEM_DEFAULT_PROPERTIES += persist.sys.dun.override=0
endif

# enable ADB authentication if not on eng build
ifneq ($(TARGET_BUILD_VARIANT),eng)
PRODUCT_DEFAULT_PROPERTY_OVERRIDES += ro.adb.secure=1
endif

# Tethering - allow without requiring a provisioning app
# (for devices that check this)
PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
    net.tethering.noprovisioning=true

# Media
PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
    media.recorder.show_manufacturer_and_model=true

ifeq ($(BOARD_CACHEIMAGE_FILE_SYSTEM_TYPE),)
  PRODUCT_DEFAULT_PROPERTY_OVERRIDES  += \
    ro.device.cache_dir=/data/cache
else
  PRODUCT_DEFAULT_PROPERTY_OVERRIDES  += \
    ro.device.cache_dir=/cache
endif

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

# Signature compatibility validation
PRODUCT_COPY_FILES += \
    vendor/citrus/prebuilt/common/bin/otasigcheck.sh:install/bin/otasigcheck.sh

# Clean up packages cache to avoid wrong strings and resources
PRODUCT_COPY_FILES += \
    vendor/citrus/prebuilt/common/bin/clean_cache.sh:system/bin/clean_cache.sh

# Changelog
ifeq ($(CITRUS_RELEASE),true)
PRODUCT_COPY_FILES +=  \
    vendor/citrus/prebuilt/common/etc/Changelog.txt:system/etc/Changelog.txt
else
GENERATE_CHANGELOG := true
endif

# Dialer fix
PRODUCT_COPY_FILES +=  \
    vendor/citrus/prebuilt/common/etc/sysconfig/dialer_experience.xml:system/etc/sysconfig/dialer_experience.xml

# init.d support
PRODUCT_COPY_FILES += \
    vendor/citrus/prebuilt/common/bin/sysinit:system/bin/sysinit \
    vendor/citrus/prebuilt/common/etc/init.d/00banner:system/etc/init.d/00banner \
    vendor/citrus/prebuilt/common/etc/init.d/90userinit:system/etc/init.d/90userinit

# Copy all Citrus-specific init rc files
$(foreach f,$(wildcard vendor/citrus/prebuilt/common/etc/init/*.rc),\
	$(eval PRODUCT_COPY_FILES += $(f):system/etc/init/$(notdir $f)))

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
    libbthost_if \
    WallpaperPicker

# Telephony packages
PRODUCT_PACKAGES += \
    messaging \
    CellBroadcastReceiver \
    Stk \
    telephony-ext

PRODUCT_BOOT_JARS += \
    telephony-ext

#RCS
PRODUCT_PACKAGES += \
    rcs_service_aidl \
    rcs_service_aidl.xml \
    rcs_service_aidl_static \
    rcs_service_api \
    rcs_service_api.xml

# Include librsjni explicitly to workaround GMS issue
PRODUCT_PACKAGES += \
    libprotobuf-cpp-full \
    librsjni

# Themes
PRODUCT_PACKAGES += \
    Margarita \
    PixelTheme \
    Stock

# World APN list
PRODUCT_COPY_FILES += \
    vendor/citrus/prebuilt/common/etc/apns-conf.xml:system/etc/apns-conf.xml

# Overlays
PRODUCT_PACKAGE_OVERLAYS += \
	vendor/citrus/overlay/common

# Proprietary latinime libs needed for Keyboard swyping
ifneq ($(filter arm64,$(TARGET_ARCH)),)
PRODUCT_COPY_FILES += \
    vendor/citrus/prebuilt/common/lib/libjni_latinime.so:system/lib/libjni_latinime.so \
    vendor/citrus/prebuilt/common/lib/libjni_latinimegoogle.so:system/lib/libjni_latinimegoogle.so
else
PRODUCT_COPY_FILES += \
    vendor/citrus/prebuilt/common/lib64/libjni_latinime.so:system/lib64/libjni_latinime.so \
    vendor/citrus/prebuilt/common/lib64/libjni_latinimegoogle.so:system/lib64/libjni_latinimegoogle.so
endif

$(call inherit-product-if-exists, vendor/extra/product.mk)

# include sounds from pixel
$(call inherit-product-if-exists, vendor/citrus/google/sounds/PixelSounds.mk)

# build official builds with private keys
ifeq ($(CITRUS_RELEASE),true)
include vendor/citrus-priv/keys.mk
endif

# include definitions for SDCLANG
include vendor/citrus/build/sdclang/sdclang.mk

# Versioning System
# Citrus-CAF first version.
CITRUS_VERSION_FLAVOUR = KeyLime
CITRUS_VERSION_CODENAME = 4.0
ifndef CITRUS_BUILD_TYPE
ifeq ($(CITRUS_RELEASE),true)
    CITRUS_BUILD_TYPE := OFFICIAL
    CITRUS_POSTFIX := -$(shell date +"%Y%m%d")
else
    CITRUS_BUILD_TYPE := UNOFFICIAL
endif
endif

ifdef CITRUS_BUILD_EXTRA
    CITRUS_POSTFIX := -$(CITRUS_BUILD_EXTRA)
endif

ifndef CITRUS_POSTFIX
    CITRUS_POSTFIX := -$(shell date +"%Y%m%d-%H%M")
endif

# Set all versions
CITRUS_VERSION := CitrusCAF-$(CITRUS_VERSION_CODENAME)-$(CITRUS_VERSION_FLAVOUR)-$(CITRUS_BUILD_TYPE)$(CITRUS_POSTFIX)
CITRUS_MOD_VERSION := CitrusCAF-$(CITRUS_VERSION_CODENAME)-$(CITRUS_VERSION_FLAVOUR)-$(CITRUS_BUILD)-$(CITRUS_BUILD_TYPE)$(CITRUS_POSTFIX)
PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
    BUILD_DISPLAY_ID=$(BUILD_ID) \
    citrus.ota.version=$(CITRUS_MOD_VERSION) \
    ro.citrus.version=$(CITRUS_VERSION_CODENAME)-$(CITRUS_VERSION_FLAVOUR) \
    ro.modversion=$(CITRUS_MOD_VERSION) \
    ro.citrus.buildtype=$(CITRUS_BUILD_TYPE) \
    ro.citrus.flavour=$(CITRUS_VERSION_FLAVOUR)

# Citrus Bloats
PRODUCT_PACKAGES += \
Camera2 \
Launcher3 \
LatinIME \
LiveWallpapersPicker \
AboutCitrus \
SnapdragonGallery \
MusicFX \
CitrusHeaders \
Calendar \
LighteningBrowser

# DU Utils Library
PRODUCT_PACKAGES += \
    org.dirtyunicorns.utils

PRODUCT_BOOT_JARS += \
    org.dirtyunicorns.utils

PRODUCT_PACKAGES += \
   OmniStyle \
   OmniJaws
