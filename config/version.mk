# Copyright (C) 2019 RevengeOS
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

REVENGEOS_CODENAME := Q
REVENGEOS_REVISION := 3
REVENGEOS_SUBREVISION := 0

ifndef REVENGEOS_BUILDTYPE
  REVENGEOS_BUILDTYPE := UNOFFICIAL
endif

TARGET_PRODUCT_SHORT := $(TARGET_PRODUCT)
TARGET_PRODUCT_SHORT := $(subst revengeos_,,$(TARGET_PRODUCT_SHORT))

REVENGEOS_VERSION := $(REVENGEOS_REVISION).$(REVENGEOS_SUBREVISION)-$(REVENGEOS_CODENAME)-$(REVENGEOS_BUILDTYPE)-$(TARGET_PRODUCT_SHORT)-$(shell date -u +%Y%m%d-%H%M)

PRODUCT_SYSTEM_DEFAULT_PROPERTIES += BUILD_DISPLAY_ID="$(BUILD_ID)-$(shell whoami)@$(shell hostname)"

# Apply it to build.prop
PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
    ro.revengeos.revision=$(REVENGEOS_REVISION).$(REVENGEOS_SUBREVISION)\
    ro.revengeos.version=RevengeOS-$(REVENGEOS_VERSION) \
    ro.ota.revengeos.version=$(REVENGEOS_VERSION)
