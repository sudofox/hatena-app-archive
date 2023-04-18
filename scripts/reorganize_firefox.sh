#!/bin/bash

# sudofox/hatena-app-archive
# reorganize XPIs based on package ID and version

DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd)"
FIREFOX_DIR="$DIR/../firefox"
XPIS=$(find -type f -name \*.xpi)

get_extension_data() {
    # first argument is the extension file, second is the file to look for
    XPI_PATH=$1
    FILE_TO_LOOK_FOR=$2

    # if we're pulling from a manifest.json file, we need to pull the name and version
    if [[ $FILE_TO_LOOK_FOR == "manifest.json" ]]; then
        MANIFEST_JSON=$(unzip -p $XPI_PATH $FILE_TO_LOOK_FOR)
        # check which version of the manifest we're dealing with
        MANIFEST_VERSION=$(echo "$MANIFEST_JSON" | jq -r '.manifest_version')
        # TODO this barely works for most...some dont even have an id even under browser_specific_settings.gecko.id
        # try .applications.gecko.id first, then .browser_specific_settings.gecko.id
        EXT_ID=$(echo "$MANIFEST_JSON" | jq -r '.applications.gecko.id')
        if [[ $EXT_ID == "null" ]]; then
            EXT_ID=$(echo "$MANIFEST_JSON" | jq -r '.browser_specific_settings.gecko.id')
        fi
        # if still null, we might have to do more work
        if [[ $EXT_ID == "null" ]]; then
            # do nothing
            :
            #EXT_ID=$(unzip -p $XPI_PATH META-INF/mozilla.rsa | openssl pkcs7 -print -inform der -in -|grep -Po "subject: .+?(?=CN)CN=\{\K.+?(?=\})")
        fi
        # if it's still null, print an error
        if [[ $EXT_ID == "null" ]]; then
            echo "Error: could not find extension ID for $XPI_PATH" >&2
            #return
        fi

        # strip leading and trailing curly braces if they exist
        EXT_ID=$(echo $EXT_ID | sed 's/^{//' | sed 's/}$//')

        EXT_VERSION=$(echo "$MANIFEST_JSON" | jq -r '.version')
    elif [[ $FILE_TO_LOOK_FOR == "install.rdf" ]]; then
        INSTALL_RDF=$(unzip -p $XPI_PATH $FILE_TO_LOOK_FOR)
        EXT_ID=$(echo "$INSTALL_RDF" | grep -Po "em:id='\K.+?(?=')")
        EXT_VERSION=$(echo "$INSTALL_RDF" | grep -Po "em:version='\K.+?(?=')")
    fi

    # return json array of ID and version
    DATA=$(jq -n --arg id "$EXT_ID" --arg version "$EXT_VERSION" '{"id":$id,"version":$version}')
    echo $DATA
}

for extension in $XPIS; do

    # get a list of what files we can pull version info from with `unzip -l` (looking for manifest.json and install.rdf)
    POSSIBLE_MANIFESTS=$(unzip -Z1 $extension | grep -E "manifest.json|install.rdf")

    # iterate through the list of possible manifests and use the first one we find
    for manifest in $POSSIBLE_MANIFESTS; do
        # get the extension ID and version from the manifest
        EXTENSION_DATA=$(get_extension_data $extension $manifest)

        # if we got data back, break out of the loop
        if [ ! -z "$EXTENSION_DATA" ]; then
            break
        fi
    done

    # unpack the extension ID and version from the json
    EXTENSION_ID=$(echo $EXTENSION_DATA | jq -r '.id')
    EXTENSION_VERSION=$(echo $EXTENSION_DATA | jq -r '.version')

    echo "Extension: $extension"
    echo "Extension ID: $EXTENSION_ID"
    echo "Extension Version: $EXTENSION_VERSION"

    # if the extension folder doesn't exist; create it

    if [ ! -d $FIREFOX_DIR/$EXTENSION_ID ]; then
        echo "Creating $FIREFOX_DIR/$EXTENSION_ID"
        mkdir -p $FIREFOX_DIR/$EXTENSION_ID
    fi

    # assemble the new filename

    new_filename="$EXTENSION_ID-$EXTENSION_VERSION.xpi"
    new_path="$FIREFOX_DIR/$EXTENSION_ID/$new_filename"

    # if the new path already exists, skip it
    if [ -f $new_path ]; then
        echo "Skipping $new_path"
        continue
    fi

    # move the app to the new path

    echo mv $extension $FIREFOX_DIR/$EXTENSION_ID/$new_filename
    # mv $extension $FIREFOX_DIR/$EXTENSION_ID/$new_filename
done
