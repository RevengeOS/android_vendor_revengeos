# Written for UBER toolchains (UBERTC)
# Requires a Linux Host

UNAME := $(shell uname -s)
ifeq (Linux,$(UNAME))
  HOST_OS := linux
endif

ifeq (linux,$(HOST_OS))
ifeq (arm,$(TARGET_ARCH))
# ANDROIDEABI TOOLCHAIN INFO
AND_TC_PATH := prebuilts/gcc/$(HOST_PREBUILT_TAG)/arm/arm-linux-androideabi-$(TARGET_GCC_VERSION)
AND_TC_VERSION := $(shell $(AND_TC_PATH)/bin/arm-linux-androideabi-gcc --version 2>&1)
AND_TC_VERSION_NUMBER := $(shell $(AND_TC_PATH)/bin/arm-linux-androideabi-gcc -dumpversion 2>&1)
AND_TC_DATE := $(filter 20150% 20151% 20160% 20161%,$(AND_TC_VERSION))
ifneq ($(filter (UBERTC%),$(AND_TC_VERSION)),)
  AND_TC_NAME := UBERTC
else
  AND_TC_NAME := GCC
endif
ifeq (,$(AND_TC_DATE))
  ARM_AND_PROP := $(AND_TC_NAME)-$(AND_TC_VERSION_NUMBER)
else
  ARM_AND_PROP := ($(AND_TC_NAME)-$(AND_TC_VERSION_NUMBER))-$(AND_TC_DATE)
endif
ADDITIONAL_BUILD_PROPERTIES += \
    ro.uber.android=$(ARM_AND_PROP)

# ARM-EABI TOOLCHAIN INFO
ifneq ($(TARGET_GCC_VERSION_ARM),)
  KERNEL_TC_PATH := prebuilts/gcc/$(HOST_PREBUILT_TAG)/arm/arm-eabi-$(TARGET_GCC_VERSION_ARM)
else
  KERNEL_TC_PATH := prebuilts/gcc/$(HOST_PREBUILT_TAG)/arm/arm-eabi-$(TARGET_GCC_VERSION)
endif
KERNEL_TC_VERSION := $(shell $(KERNEL_TC_PATH)/bin/arm-eabi-gcc --version 2>&1)
KERNEL_TC_VERSION_NUMBER := $(shell $(KERNEL_TC_PATH)/bin/arm-eabi-gcc -dumpversion 2>&1)
KERNEL_TC_DATE := $(filter 20150% 20151% 20160% 20161%,$(KERNEL_TC_VERSION))
ifneq ($(filter (UBERTC%),$(KERNEL_TC_VERSION)),)
  KERNEL_TC_NAME := UBERTC
else
  KERNEL_TC_NAME := GCC
endif
ifeq (,$(KERNEL_TC_DATE))
  ARM_KERNEL_PROP := $(KERNEL_TC_NAME)-$(KERNEL_TC_VERSION_NUMBER)
else
  ARM_KERNEL_PROP := ($(KERNEL_TC_NAME)-$(KERNEL_TC_VERSION_NUMBER))-$(KERNEL_TC_DATE)
endif
ADDITIONAL_BUILD_PROPERTIES += \
    ro.uber.kernel=$(ARM_KERNEL_PROP)
endif

ifeq (arm64,$(TARGET_ARCH))
# AARCH64 ROM TOOLCHAIN INFO
UBER_AND_PATH := prebuilts/gcc/$(HOST_PREBUILT_TAG)/aarch64/aarch64-linux-android-4.9
UBER_AND := $(shell $(UBER_AND_PATH)/bin/aarch64-linux-android-gcc --version)
UBER_AND_VERSION_NUMBER := $(shell $(AND_TC_PATH)/bin/aarch64-linux-android-gcc -dumpversion 2>&1)
UBER_AND_DATE := $(filter 20150% 20151% 20160% 20161%,$(UBER_AND))
ifneq ($(filter (UBERTC%),$(UBER_AND)),)
  UBER_AND_NAME := UBERTC
else
  UBER_AND_NAME := GCC
endif
ifeq (,$(UBER_AND_DATE))
  AARCH64_AND_PROP := $(UBER_AND_NAME)-$(UBER_AND_VERSION_NUMBER)
else
  AARCH64_AND_PROP := ($(UBER_AND_NAME)-$(UBER_AND_VERSION_NUMBER))-$(UBER_AND_DATE)
endif
ADDITIONAL_BUILD_PROPERTIES += \
    ro.uber.android=$(AARCH64_AND_PROP)

# AARCH64 KERNEL TOOLCHAIN INFO
ifneq ($(TARGET_GCC_VERSION_ARM64),)
  UBER_TC_PATH := prebuilts/gcc/$(HOST_PREBUILT_TAG)/aarch64/aarch64-linux-android-$(TARGET_GCC_VERSION_ARM64)
else
  UBER_TC_PATH := prebuilts/gcc/$(HOST_PREBUILT_TAG)/aarch64/aarch64-linux-android-4.9
endif
UBER_TC_VERSION := $(shell $(UBER_TC_PATH)/bin/aarch64-linux-android-gcc --version)
UBER_TC_VERSION_NUMBER := $(shell $(UBER_TC_PATH)/bin/aarch64-linux-android-gcc -dumpversion 2>&1)
UBER_TC_DATE := $(filter 20150% 20151% 20160% 20161%,$(UBER_TC_VERSION))
ifneq ($(filter (UBERTC%),$(UBER_TC_VERSION)),)
  UBER_TC_NAME := UBERTC
else
  UBER_TC_NAME := GCC
endif
ifeq (,$(UBER_TC_DATE))
  AARCH64_KERNEL_PROP := $(UBER_TC_NAME)-$(UBER_TC_VERSION_NUMBER)
else
  AARCH64_KERNEL_PROP := ($(UBER_TC_NAME)-$(UBER_TC_VERSION_NUMBER))-$(UBER_TC_DATE)
endif
ADDITIONAL_BUILD_PROPERTIES += \
    ro.uber.kernel=$(AARCH64_KERNEL_PROP)
endif

# UBERTC OPTIMIZATIONS 
ifeq (true,$(STRICT_ALIASING))
  OPT1 := (strict)
endif
ifeq (true,$(GRAPHITE_OPTS))
  OPT2 := (graphite)
endif
ifeq (true,$(KRAIT_TUNINGS))
  OPT3 := ($(TARGET_CPU_VARIANT))
endif
ifeq (true,$(ENABLE_GCCONLY))
  OPT4 := (gcconly)
endif
ifeq (true,$(CLANG_O3))
  OPT5 := (clang_O3)
endif
GCC_OPTIMIZATION_LEVELS := $(OPT1)$(OPT2)$(OPT3)$(OPT4)$(OPT5)
ifneq (,$(GCC_OPTIMIZATION_LEVELS))
ADDITIONAL_BUILD_PROPERTIES += \
    ro.uber.flags=$(GCC_OPTIMIZATION_LEVELS)
endif
endif
