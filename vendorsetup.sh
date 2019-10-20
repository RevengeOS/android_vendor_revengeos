for device in $(cat $(gettop)/vendor/revengeos/revenge.devices | sed -e 's/#.*$//' | awk '{printf "revengeos_%s-userdebug\n", $1}{printf "revengeos_%s-user\n", $1}'); do
    add_lunch_combo $device;
done;
