#!/sbin/sh
#
# /system/addon.d/72-mixplorer.sh
# During a upgrade, this script backs up MiXplorer,
# /system is formatted and reinstalled, then the MiXplorer apk will be restored.
#
# script made by Adarsh-MR

list_files() {
cat <<EOF
addon.d/72-mixplorer.sh
app/MiXplorer/mixplorer.apk

EOF
}

case "$1" in
  backup)
    list_files | while read FILE DUMMY; do
      backup_file $S/$FILE
    done
  ;;
  restore)
    list_files | while read FILE REPLACEMENT; do
      R=""
      [ -n "$REPLACEMENT" ] && R="$S/$REPLACEMENT"
      [ -f "$C/$S/$FILE" ] && restore_file $S/$FILE $R
    done
  ;;
  pre-backup)
    # Stub
  ;;
  post-backup)
    # Stub
  ;;
  pre-restore)
    # Stub
  ;;
  post-restore)
    # Stub
  ;;
esac
