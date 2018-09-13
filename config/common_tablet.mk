# Common settings and files
-include vendor/revengeos/config/common.mk

# Add tablet overlays
DEVICE_PACKAGE_OVERLAYS += vendor/revengeos/overlay/common_tablet

PRODUCT_CHARACTERISTICS := tablet
