# Game updates

[简体中文](UPDATING.md) | [English](UPDATING.en.md) | [Home](../README.en.md)

## Downloads and installation

Installers are distributed through the [MEGA folder](https://mega.nz/folder/PfIDSaSZ#ZcRokP34or9J0JofsIgrEA). GitHub Releases provide release notes and asset-free text source, with no installer attachments.

The updater in 1.2.0 and older depends on GitHub assets and may report an unpublished installer. Download the current version manually from the folder above. Starting with 1.2.1, version checks still use stable GitHub tags, while the download action opens the fixed MEGA folder instead of promising an in-game APK download.

Install Android updates over the existing app to retain saves. iOS requires signing or re-signing the IPA. A folder URL has no single-file size, digest, or direct APK endpoint, so it is never passed to the native APK downloader.

## Checking for updates

The idle main menu checks once about 5 seconds after startup. Manual checks are available at **Settings → NT:TE → Updates**. Offline requests, timeouts, and rate limits do not block startup, and gameplay is not interrupted. Version components are compared numerically; drafts, prereleases, and downgrades are rejected. Only the fixed download page is recognized from release notes.

## Publishing policy

Current version: **1.2.2**, internal build90 (Android versionCode3000090; iOS build90). Next fix:1.2.3, internal build91. Subsequent fixes increment 0.0.1. Version 1.0.4 and subsequent 1.0.x retain original NTTE content. Keep the save-format `GAME_BUILD` unchanged.

Synchronize game, updater, and platform versions and complete validation. Before publishing, run `python tools/audit_source_only.py --index` and `--history`. Never upload artwork, audio, fonts, runtimes, installers, signing data, or personal saves to Git. Publish the official version tag and bilingual notes with the same MEGA link and third-party credits.
