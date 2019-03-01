# Rules for MTK targets
include $(TOPDIR)vendor/revengeos/build/core/qcom_target.mk

# We modify several neverallows, so let the build proceed
SELINUX_IGNORE_NEVERALLOWS := true
