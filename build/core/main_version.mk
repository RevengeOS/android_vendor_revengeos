# Citrus sprcific build properties
ADDITIONAL_BUILD_PROPERTIES += \
    BUILD_DISPLAY_ID=$(BUILD_ID) \
    citrus.ota.version=$(CITRUS_MOD_VERSION) \
    ro.caf.revision=$(CAF_REVISION) \
    ro.citrus.buildtype=$(CITRUS_BUILD_TYPE) \
    ro.citrus.flavour=$(CITRUS_VERSION_FLAVOUR) \
    ro.citrus.version=$(CITRUS_VERSION_CODENAME)-$(CITRUS_VERSION_FLAVOUR) \
    ro.custom.fingerprint=$(CUSTOM_FINGERPRINT) \
    ro.modversion=$(CITRUS_MOD_VERSION)