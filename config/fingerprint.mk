# Build fingerprint
ifneq ($(BUILD_FINGERPRINT),)
PRODUCT_PRODUCT_PROPERTIES += \
    ro.build.fingerprint=$(BUILD_FINGERPRINT)
endif
