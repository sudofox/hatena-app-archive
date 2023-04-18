#!/bin/bash

# check if there are newer versions of any of the apps

DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd)"

package_list=$(ls -1 $DIR/../android)

# whats the length of the longest package name?
max_length=0
for package in $package_list; do
  if [ ${#package} -gt $max_length ]; then
    max_length=${#package}
  fi
done

log_package() {
  # space pad to longest package name in format "[$1] $2"
  pad_length=$((max_length - ${#1} + 1))
  printf "[%s]%${pad_length}s%s\\n" "$1" "" "$2"
}

for package in $package_list; do
  latest_data=$($DIR/../lib/googleplay_go/cmd/googleplay/googleplay -a $package -p 2 -v 0 2>/dev/null)
  # Version Code: 123
  latest_version_code=$(echo "$latest_data" | grep -Po "Version Code: \K[0-9]+")
  latest_version=$(echo "$latest_data" | grep -Po "Version: \K[0-9\.]+")
  # did we get a version code?
  if [ -z "$latest_version_code" ]; then
    log_package $package "Couldn't get version information"
    continue
  fi
  # build package name
  package_name="$package-$latest_version_code-$latest_version.apk"
  # does the file exist?
  if [ -f "$DIR/../android/$package/$package_name" ]; then
    log_package $package "Already have latest version"
  else
    log_package $package "Need update(s) - latest version is $latest_version_code / $latest_version"
  fi
done
