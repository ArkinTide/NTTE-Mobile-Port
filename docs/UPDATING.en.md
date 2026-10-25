# Game updates

[简体中文](UPDATING.md) | [English](UPDATING.en.md) | [Home](../README.en.md)

## For players

Starting with candidate74, the game checks this repository's latest stable GitHub Release once after reaching the main menu.
Open **Settings → NT:TE → UPDATES** to disable automatic checks, check manually, or download an update.
Offline connections, timeouts, and GitHub rate limits do not block startup. Automatic update dialogs do not interrupt a run.

- **Android**: after confirmation, the game downloads the APK internally, displays progress, and supports cancellation and retry. It verifies file size, SHA-256, package name, and signing identity before opening Android's system installer. You may first need to allow this app to install unknown apps. Confirm installation over the existing app to retain its data; do not uninstall the old version first.
- **iOS**: confirmation opens the matching IPA download link. Sideloaded updates still need signing or re-signing with your own signing identity before installation.

Older builds without the updater need one manual installation of candidate74 or later.
The Android downloader uses private app cache storage and does not require all-files access for updates.

## Official version policy

The current stable version is **1.0.0** (internal build `candidate75`). Every subsequent bugfix release increases the visible version by **0.0.1**: `1.0.1`, `1.0.2`, and so on. Keep the in-game version, Android versionName, and iOS CFBundleShortVersionString in sync.

To remain compatible with installed candidate74 updaters, keep increasing `candidateN` GitHub Release tags and installer suffixes. Set the Release title to the official version (`1.0.0` here); newer games display this title. An additional `v1.0.0` Git tag may point to the same commit. Do not create a separate Latest Release without installers.

This APK uses Android versionCode `3000075`; subsequent builds must increase it rather than use a lower automatically generated value. The iOS CFBundleVersion is `75` and must also increase. Keep the save-format `GAME_BUILD` unchanged.

## Publishing a new version

1. Increase `NTTE_RELEASE_VERSION` using the policy above and increment both `NTTE_RELEASE_NUMBER` and `NTTE_RELEASE_TAG` in `project/scripts/scrNTTEUpdate/scrNTTEUpdate.gml`, for example `1.0.1`, `76`, and `candidate76` next. Do not change the save-format `GAME_BUILD` just to publish an update.
2. Build and verify both installers. Retain the Android package name and signing identity, and do not lower its version code.
3. Create a matching stable GitHub Release and mark it Latest. The updater reads `https://api.github.com/repos/ArkinTide/NTTE-Mobile-Port/releases/latest`. Drafts and prereleases are not treated as stable updates.
4. Upload installers before publishing. Use `NuclearThrone.TerritorialExpansion-Android-<description>-candidate75.apk` and `NuclearThrone.TerritorialExpansion-iOS-<description>-candidate75.ipa`. The Android asset's GitHub `digest` must contain its SHA-256; normal uploads supply this automatically.
5. Describe the changes and iOS signing requirement in the release notes, and attach SHA-256 checksums.

The updater compares candidate numbers numerically, rejects downgrades, and accepts installer URLs only from this repository. A missing platform asset does not cause another platform's installer to be offered. Automatic checks run once per launch. Manual checks have a cooldown, with longer backoff after rate-limit responses.

The Android native implementation is under `project/extensions/YYExtra/AndroidSource/`. Rebuilds must include the new Java files, `res/xml/ntte_update_paths.xml`, the `REQUEST_INSTALL_PACKAGES` permission, and the extension's FileProvider declaration. If changing the application identifier, also change the provider authority to `<package>.ntteupdates`. Installation requires system confirmation; the updater does not perform silent installs or replace executable code dynamically.
