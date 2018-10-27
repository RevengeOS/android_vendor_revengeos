# Whether using or not release-keys for building
# Copyright (C) 2019 RevengeOS
# SPDX-License-Identifier: Apache-2.0

# Don't modify; path where release-keys are hosted
RELEASE_KEYS_PATH := vendor/revengeos/keys

# Make sure we're building Official
ifeq ($(REVENGEOS_BUILDTYPE),OFFICIAL)
    # Whether release-keys path is exist or not
    ifneq ($(wildcard $(RELEASE_KEYS_PATH)),)
        # Exists, use them
        USE_RELEASE_KEYS := true
    else
        # Doesn't exist, fall back to test-keys
        $(warn $(RELEASE_KEYS_PATH) doesn't exist. Continuing with test-keys...)
    endif
endif
