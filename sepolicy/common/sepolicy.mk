#
# This policy configuration will be used by all products that
# inherit from Lineage
#

BOARD_PLAT_PUBLIC_SEPOLICY_DIR += \
    vendor/revengeos/sepolicy/common/public

BOARD_PLAT_PRIVATE_SEPOLICY_DIR += \
    vendor/revengeos/sepolicy/common/private

BOARD_SEPOLICY_DIRS += \
    vendor/revengeos/sepolicy/common/vendor
