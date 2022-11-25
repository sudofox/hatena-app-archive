# sudofox/hatena-app-archive

An archive of all versions of any and all mobile apps created by Hatena (unfortunately, there is no way to get iPhone .ipa's that I'm aware of)

Downloading unlisted ones requires already having a copy in your Google Play library

# Support

If you have old apps in your Google Play library and can download them, that'd be great. You might have to do some enumeration to guess the old version codes when downloading.

Ko-Fi info is attached to the GitHub repository, this does cost me a bit of money each month since I'm storing all these APKs in Git LFS.

# Requirements

- [googleplay](https://github.com/89z/googleplay)
  - You can use a [Google App Password](https://myaccount.google.com/apppasswords) instead of your main Google account password
- aapt (via your favorite package manager)

# Scripts

- `./scripts/download.sh <apk package name> <version to download>` - download an APK, version 0 prints out app information
- `./scripts/reorganize.sh` - searches for any loose apks anywhere and puts them into the ./android/ folder with relevant filenames.
- `./scripts/check_for_updates.sh` - does what it says on the tin. Don't forget to check for version codes you might've missed, this doesn't auto-enumerate all versions

# Currently preserved

I'm preserving anything with the `com.hatena.android` or `jp.ne.hatena` namespace.

Currently uncertain about the history the "neetlabo" ones -- if I find out that they weren't actually made at Hatena or by an employee there, I might remove them.

```
com.hatena.android.accounts
com.hatena.android.bkuma.girls
com.hatena.android.bookmark
com.hatena.android.coco
com.hatena.android.fotolife
com.hatena.android.monolith
com.hatena.android.space
jp.ne.hatena.blog
jp.ne.hatena.neetlabo.GpsStatus
jp.ne.hatena.neetlabo.InfoWidget2
jp.ne.hatena.neetlabo.SimpleBookmarks
jp.ne.hatena.neetlabo.TalkRec
jp.ne.hatena.neetlabo.voicemush
```

