#
# This policy configuration will be used by all qcom products
# that inherit from Lineage
#

BOARD_SEPOLICY_DIRS += \
    vendor/citrus/sepolicy/qcom/common \
    vendor/citrus/sepolicy/qcom/$(TARGET_BOARD_PLATFORM)