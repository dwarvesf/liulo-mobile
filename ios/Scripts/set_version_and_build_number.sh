#!/bin/bash

# NOTE: set this file executable by running command "chmod +x set_version_and_build_number.sh"

### get ios version and build from app.json
# https://stackoverflow.com/questions/10929453/read-a-file-line-by-line-assigning-the-value-to-a-variable
# https://stackoverflow.com/questions/229551/string-contains-in-bash
# https://stackoverflow.com/questions/428109/extract-substring-in-bash
app_info_file="../app.json"
version_number="x.y.z"
build_number="xyz"
while IFS='' read -r line || [[ -n "$line" ]]; do
	if [[ $line == *"\"iosVersion\":"* ]]; then
		tmp=${line:17}
		version_number=${tmp%\"*}
	fi
	if [[ $line == *"\"iosBuild\":"* ]]; then
		tmp=${line:15}
		build_number=${tmp%\"*}
	fi
done < "$app_info_file"

### write app version and build number to Info.plist
# http://www.mokacoding.com/blog/automatic-xcode-versioning-with-git/
# http://www.danandcheryl.com/2012/10/automatic-build-numbers-for-ios-apps-using-xcode
target_plist="$TARGET_BUILD_DIR/$INFOPLIST_PATH"
dsym_plist="$DWARF_DSYM_FOLDER_PATH/$DWARF_DSYM_FILE_NAME/Contents/Info.plist"
for plist in "$target_plist" "$dsym_plist"; do
  if [ -f "$plist" ]; then
    /usr/libexec/PlistBuddy -c "Set :CFBundleVersion $build_number" "$plist"
    /usr/libexec/PlistBuddy -c "Set :CFBundleShortVersionString $version_number" "$plist"
  fi
done
