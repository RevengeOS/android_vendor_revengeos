# Citrus sprcific build properties
ADDITIONAL_BUILD_PROPERTIES += \
    BUILD_DISPLAY_ID=$(BUILD_ID) \
    ro.citrus.buildtype=$(CITRUS_BUILD_TYPE) \
    ro.citrus.flavour=$(CITRUS_VERSION_FLAVOUR) \
    ro.citrus.version=$(CITRUS_VERSION_CODENAME)-$(CITRUS_VERSION_FLAVOUR) \
    citrus.ota.version=$(CITRUS_MOD_VERSION) \
    ro.modversion=$(CITRUS_MOD_VERSION)
