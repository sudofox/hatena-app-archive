# sudofox/hatena-app-archive

An archive of all versions of any and all mobile apps created by Hatena (unfortunately, there is no way to get iPhone .ipa's that I'm aware of)

Downloading unlisted ones requires already having a copy in your Google Play library

# Support

If you have old apps in your Google Play library and can download them, that'd be great. You might have to do some enumeration to guess the old version codes when downloading.

Ko-Fi info is attached to the GitHub repository, this does cost me a bit of money each month since I'm storing all these APKs in Git LFS.

# Requirements

- [googleplay](https://github.com/89z/googleplay)
  - Something happened to the library and its author -- may have to switch away from it at some point since it seems to have disappeared
  - You can use a [Google App Password](https://myaccount.google.com/apppasswords) instead of your main Google account password
- aapt (via your favorite package manager)

# Scripts

- `./scripts/download.sh <apk package name> <version to download>` - download an APK, version 0 prints out app information
- `./scripts/reorganize.sh` - searches for any loose apks anywhere and puts them into the ./android/ folder with relevant filenames.
- `./scripts/check_for_updates.sh` - does what it says on the tin. Don't forget to check for version codes you might've missed, this doesn't auto-enumerate all versions

# Currently preserved

I'm preserving anything with the `com.hatena.android` or `jp.ne.hatena` namespace.

```
com.hatena.android.accounts
com.hatena.android.bkuma.girls
com.hatena.android.bookmark
com.hatena.android.coco
com.hatena.android.fotolife
com.hatena.android.monolith
com.hatena.android.space
jp.ne.hatena.blog
```

While previously included, these have been removed as they're probably not by Hatena:

```
jp.ne.hatena.neetlabo.GpsStatus
jp.ne.hatena.neetlabo.InfoWidget2
jp.ne.hatena.neetlabo.SimpleBookmarks
jp.ne.hatena.neetlabo.TalkRec
jp.ne.hatena.neetlabo.voicemush
```

# Additional apps

Kondasha comicdays: https://hatena.co.jp/press/release/entry/2019/05/13/180000

# WIP

- Firefox extensions -- a bit difficult to auto-organize due to changes in .xpi format
- Chrome extensions
  - Missing hcgdahkjfcpndfngokmijdopnjnjfgak (Hatena Space)
  - Also need to auto-organize/get old versions
- iOS apps - don't have any way to get these yet
