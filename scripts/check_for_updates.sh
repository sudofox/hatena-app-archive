#!/bin/bash

# check if there are newer versions of any of the apps

DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd)"

package_list=$(ls -1 $DIR/../android)

for package in $package_list; do
    # echo "Checking for updates for $package"
    latest_data=$($DIR/../lib/googleplay_go/cmd/googleplay/googleplay -a $package -p 2 -v 0 2>/dev/null)
    # Version Code: 123
    latest_version_code=$(echo "$latest_data" | grep -Po "Version Code: \K[0-9]+")
    latest_version=$(echo "$latest_data" | grep -Po "Version: \K[0-9\.]+")
    # build package name
    package_name="$package-$latest_version_code-$latest_version.apk"
    # does the file exist?
    if [ -f "$DIR/../android/$package/$package_name" ]; then
        echo "Already have latest version of $package"
    else
      echo "Need update(s) for $package - latest version is $latest_version_code / $latest_version"
    fi
done