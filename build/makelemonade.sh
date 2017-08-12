#!/bin/bash

# Colorize and add text parameters
red=$(tput setaf 1)             #  red
grn=$(tput setaf 2)             #  green
blu=$(tput setaf 4)             #  blue
txtbld=$(tput bold)             #  bold
bldgrn=${txtbld}$(tput setaf 1) #  bold red
bldgrn=${txtbld}$(tput setaf 2) #  bold green
bldblu=${txtbld}$(tput setaf 4) #  bold blue
txtrst=$(tput sgr0)             #  reset

DEVICE="$1"
SYNC="$2"
CLEAN="$3"
LOG="$4"
SHUTDOWN="$5"

ROOT_PATH=$PWD
BUILD_PATH="$ROOT_PATH/out/target/product/$DEVICE"

# Start tracking time
echo -e ${bldblu}
echo -e "---------------------------------------"
echo -e "SCRIPT STARTING AT $(date +%D\ %r)"
echo -e "---------------------------------------"
echo -e ${txtrst}

START=$(date +%s)

# Sync with latest sources
if [ "$SYNC" == "sync" ]
then
   echo -e "${bldblu}Syncing latest sources ${txtrst}"
   repo sync -c --no-tags --no-clone-bundle -j8
fi

# Setup environment
echo -e "${bldblu}Setting up build environment ${txtrst}"
export KBUILD_BUILD_USER=$USER
export KBUILD_BUILD_HOST=$HOST
. build/envsetup.sh

# Setup ccache
export USE_CCACHE=1
export CCACHE_DIR="~/.ccache"
/usr/bin/ccache -M 25G

# Set the device
echo -e "Setting the device... ${txtrst}"
breakfast "$DEVICE-userdebug"

# Clean out folder
if [ "$CLEAN" == "clean" ]
then
  echo -e "${bldblu}Cleaning up the OUT folder with make clobber ${txtrst}"
  make clean;
else
  echo -e "${bldblu}No make clobber so just make installclean ${txtrst}"
  make installclean;
fi

# Start compilation with or without log
if [ "$LOG" == "log" ]
then
   echo -e "${bldblu}Compiling for $DEVICE and saving a build log file ${txtrst}"
   mka lemonade 2>&1 | tee build.log;
else
   echo -e "${bldblu}Compiling for $DEVICE without saving a build log file ${txtrst}"
   mka lemonade;
fi

# If the above was successful
if [ `ls $BUILD_PATH/CitrusCAF-*.zip 2>/dev/null | wc -l` != "0" ]
then
   BUILD_RESULT="Build successful"

    # Copy the device ROM.zip to root (and before doing this, remove old device builds but not the last one of them, adding an OLD_tag to it)
    echo -e "${bldblu}Copying zip to $ROOT_PATH ${txtrst}"

    if [ `ls $ROOT_PATH/OLD_CitrusCAF-$DEVICE-*.zip 2>/dev/null | wc -l` != "0" ]
    then
    rm OLD_CitrusCAF-$DEVICE-*.zip
    fi

    if [ `ls $ROOT_PATH/CitrusCAF-$DEVICE-*.zip 2>/dev/null | wc -l` != "0" ]
    then
    for file in CitrusCAF-$DEVICE-*.zip
    do
        mv -f "${file}" "${file/CitrusCAF/OLD_CitrusCAF}"
    done
    fi

    cp $BUILD_PATH/CitrusCAF-*.zip $ROOT_PATH

    # If the build failed
else
   BUILD_RESULT="Build failed"
fi

# back to root dir
cd $ROOT_PATH

# Stop tracking time
END=$(date +%s)
echo -e ${bldblu}
echo -e "-------------------------------------"
echo -e "SCRIPT ENDING AT $(date +%D\ %r)"
echo -e ""
echo -e "${BUILD_RESULT}!"
echo -e "TIME: $(echo $((${END}-${START})) | awk '{print int($1/60)" MINUTES AND "int($1%60)" SECONDS"}')"
echo -e "-------------------------------------"
echo -e ${txtrst}

BUILDTIME="Build time: $(echo $((${END}-${START})) | awk '{print int($1/60)" minutes and "int($1%60)" seconds"}')"

#kill java if it's hanging on
pkill java

# Shutdown the system if required by the user
if [ "$SHUTDOWN" == "off" ]
then
  qdbus org.kde.ksmserver /KSMServer logout 0 2 2
fi