# Insert new variables inside the Citrus structure
citrus_soong:
	$(hide) mkdir -p $(dir $@)
	$(hide) (\
	echo '{'; \
	echo '"Citrus": {'; \
	echo '},'; \
	echo '') > $(SOONG_VARIABLES_TMP)
