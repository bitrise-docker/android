#!/bin/bash
set -e

echo
echo '#'
echo '# This System Report was generated by: https://github.com/bitrise-docker/android/blob/master/system_report.sh'
echo '#  Pull Requests are welcome!'
echo '#'
echo

echo
echo "=== Revision / ID ======================"
echo "* BITRISE_DOCKER_REV_NUMBER_ANDROID: $BITRISE_DOCKER_REV_NUMBER_ANDROID"
echo "========================================"
echo

# Make sure that the reported version is only
#  a single line!
echo
echo "=== Pre-installed tool versions ========"

ver_line="$(gradle --version | grep 'Gradle ')" ;     echo "* Gradle: $ver_line"
ver_line="$(mvn --version | grep 'Apache Maven')" ;   echo "* Maven: $ver_line"
ver_line="$(fastlane --version | grep 'fastlane ')" ;   echo "* Fastlane: $ver_line"
ver_line="$( javac -version 2>&1 )" ;                 echo "* Java: $ver_line"

echo "========================================"
echo

echo
echo "=== Google Cloud SDK components ========"
if [[ "$BITRISE_DOCKER_REV_NUMBER_ANDROID_NDK_LTS" == "v2016_11_09_1" ]] ; then
    echo " (!) Not pre-installed on this Stack / in this image"
else
    gcloud version
fi
echo "========================================"
echo

echo
echo "=== Google Cloud Network Check ========="
if [[ "$BITRISE_DOCKER_REV_NUMBER_ANDROID_NDK_LTS" == "v2016_11_09_1" ]] ; then
    echo " (!) Not pre-installed on this Stack / in this image"
else
    gcloud info --run-diagnostics
fi
echo "========================================"
echo

echo
echo "=== Testing Android tools =============="
echo " * adb path:"
which adb
echo
echo " * adb version:"
adb version
echo "========================================"
echo

echo
echo "=== Android tools/dirs ================="
echo
echo "* ANDROID_HOME:"
ls -a1 ${ANDROID_HOME}
echo
echo "* platform-tools:"
ls -1 ${ANDROID_HOME}/platform-tools
echo
echo "* build-tools:"
ls -1 ${ANDROID_HOME}/build-tools
echo
echo "* extras:"
tree -L 2 ${ANDROID_HOME}/extras
echo
echo "* extra-android-support package version:"
cat $ANDROID_HOME/extras/android/support/source.properties | grep 'Pkg.Revision='
echo
echo "* platforms:"
ls -1 ${ANDROID_HOME}/platforms
echo
echo "* system-images:"
tree -L 3 ${ANDROID_HOME}/system-images
echo "========================================"
echo
