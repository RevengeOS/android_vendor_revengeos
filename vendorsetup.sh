supported_devices=(
  'mido'
  'santoni'
  'tissot'
  'vince'
  'X00TD'
  'x2'
)

for device in ${supported_devices[@]}; do
    add_lunch_combo revengeos_${device}-user
    add_lunch_combo revengeos_${device}-userdebug
done
