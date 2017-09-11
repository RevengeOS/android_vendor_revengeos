# Copyright (C) 2017 Unlegacy-Android
# Copyright (C) 2017 The LineageOS Project
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

# -----------------------------------------------------------------

# Add colors
ifneq ($(BUILD_WITH_COLORS),0)
  CL_SGRY="\033[38;5;239m"
  CL_RST="\033[0m"
  CL_YLW="\033[33m"
  CL_BLU="\033[34m"
  CL_CYN="\033[36m"
endif

# Citrus-CAF OTA update package
CITRUS_TARGET_PACKAGE := $(PRODUCT_OUT)/$(CITRUS_MOD_VERSION).zip

.PHONY: bacon
bacon: $(INTERNAL_OTA_PACKAGE_TARGET)
	$(hide) ln -f $(INTERNAL_OTA_PACKAGE_TARGET) $(CITRUS_TARGET_PACKAGE)
	$(hide) $(MD5SUM) $(CITRUS_TARGET_PACKAGE) | sed "s|$(PRODUCT_OUT)/||" > $(CITRUS_TARGET_PACKAGE).md5sum
	@echo -e ${CL_BLU}${CL_CYN}"===============================-Package complete-==============================="${CL_RST}
	@echo -e ${CL_BLU}${CL_YLW}"Zip: "${CL_YLW} $(CITRUS_TARGET_PACKAGE)${CL_RST}
	@echo -e ${CL_BLU}${CL_YLW}"MD5: "${CL_YLW}" `cat $(CITRUS_TARGET_PACKAGE).md5sum | awk '{print $$1}' `"${CL_RST}
	@echo -e ${CL_BLU}${CL_YLW}"Size:"${CL_YLW}" `du -sh $(CITRUS_TARGET_PACKAGE) | awk '{print $$1}' `"${CL_RST}
	@echo -e ${CL_BLU}${CL_CYN}"================================================================================"${CL_RST}