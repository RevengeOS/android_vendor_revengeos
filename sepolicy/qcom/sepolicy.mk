#
# This policy configuration will be used by all qcom products
# that inherit from Lineage
#

BOARD_SEPOLICY_DIRS += \
    vendor/revengeos/sepolicy/qcom/common \
    vendor/revengeos/sepolicy/qcom/$(TARGET_BOARD_PLATFORM)
