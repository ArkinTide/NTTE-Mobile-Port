# Game updates

[简体中文](UPDATING.md) | [English](UPDATING.en.md) | [Home](../README.en.md)

## Players

The idle main menu checks once about 5 seconds after startup. Use **Settings → NT:TE → Updates** for manual checks or preferences. Offline operation, timeouts and rate limits do not block startup. Prompts are deferred during gameplay.

Upgrading from 1.0.2 or earlier to 1.0.3 requires one manual download and in-place installation because the older updater only recognizes historical candidate tags. Version 1.0.3 recognizes future official version tags. Do not uninstall first if you want to retain saves.

- Android downloads the APK in-game to private cache, verifies size, SHA-256, package and signer, then opens the system installer. Allow installation from this app when requested and confirm the in-place update.
- iOS opens the IPA download link. Sign or re-sign it with your own identity before installation.

## Versions and publishing

The current version is **1.2.0**. Add-on-series bugfixes increment to 1.2.1, 1.2.2. Version 1.0.4 and subsequent 1.0.x releases retain original NTTE content. Public tags and filenames use official version numbers only.

1. Update NTTE_RELEASE_VERSION, NTTE_RELEASE_TAG, GAME_VERSION and platform display versions together. Increment NTTE_RELEASE_NUMBER as an internal build serial: next version 1.2.1, serial 86. Do not change the save-format GAME_BUILD for a release.
2. Build, test and audit both installers. Retain the Android package and signing identity. Current Android versionCode is 3000085 and iOS CFBundleVersion is 85; both must increase.
3. Create a same-tag draft Release and upload `NuclearThrone.TerritorialExpansion-Android-1.2.0.apk`, `NuclearThrone.TerritorialExpansion-iOS-1.2.0.ipa` and SHA256SUMS.txt. Verify remote digests before publishing as Latest. Substitute the new version in future filenames.
4. Update both READMEs, validation records and release notes, including iOS signing requirements.

The updater reads this repository's releases/latest API, requires a stable published release and compares three numeric components. It rejects downgrades, foreign repository assets, tag/filename mismatches and invalid digests. Historical candidate tags cannot offer upgrades. A missing platform installer never selects another platform's file.

Android native downloads live in `project/extensions/YYExtra/AndroidSource/`. Include the Java implementation, res/xml/ntte_update_paths.xml, REQUEST_INSTALL_PACKAGES and FileProvider declaration. Its authority is `<package>.ntteupdates`. Installation requires system confirmation.
