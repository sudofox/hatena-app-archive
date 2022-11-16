#!/bin/bash

# sudofox/hatena-app-archive
# reorganize APKs based on package name, versionCode and versionName

DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd)"
ANDROID_DIR="$DIR/../android"

APKS=$(find -type f -name \*.apk)

for app in $APKS; do

    # package: name='com.package.name' versionCode='10' versionName='1.2' platformBuildVersionName='5.0.1-1624448'
    details=$(aapt dump badging $app | grep "^package: ")

    # com.package.name
    package_name=$(echo "$details" | grep -Po " name='\K.+?(?=')")
    # 10
    version_code=$(echo "$details" | grep -Po " versionCode='\K.+?(?=')")
    # version 1.2
    version_name=$(echo "$details" | grep -Po " versionName='\K.+?(?=')")

    # if the app folder doesn't exist; create it

    if [ ! -d $ANDROID_DIR/$package_name ]; then
        echo "Creating $ANDROID_DIR/$package_name"
        mkdir -p $ANDROID_DIR/$package_name
    fi

    # assemble the new filename

    new_filename="$package_name-$version_code-$version_name.apk"
    new_path="$ANDROID_DIR/$package_name/$new_filename"

    # if the new path already exists, skip it
    if [ -f $new_path ]; then
        echo "Skipping $new_path"
        continue
    fi

    # move the app to the new path

    echo mv $app $ANDROID_DIR/$package_name/$new_filename
    mv $app $ANDROID_DIR/$package_name/$new_filename
done
