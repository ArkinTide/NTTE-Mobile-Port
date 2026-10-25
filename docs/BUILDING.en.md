# Building

[简体中文](BUILDING.md) | [English](BUILDING.en.md) | [Home](../README.en.md)

## Environment and assets

The current delivery uses GameMaker LTS runtime `2026.0.0.23`, targeting the VM.
You need your own GameMaker installation, platform export entitlement, and copy of Nuclear Throne.
The upstream asset-extraction scripts use Node.js 20+; project preparation uses Python 3.

Start with:

```sh
python tools/prepare_project.py --platform android
```

Replace `android` with `ios` or `windows` to prepare another platform.
The output is `.local/<platform>/project`; this mutable build copy is excluded from Git.
Then, from the generated project's `node-scripts` directory, run:

```sh
npm ci
npm run regen -- --game-path="/path/to/your/Nuclear Throne"
```

The extractor looks for a Steam installation by default and also accepts the explicit path above.
Do not use `--force` to overwrite NTTE custom artwork. Back up and compare changes before refreshing original-game assets.
The upstream extraction scripts, resource declarations, and asset-ignore rules remain in the project.

## Android

Project preparation copies the shared project, then applies the Android-specific overlay from `platforms/android/project`.
Supported ABIs are `arm64-v8a` and `armeabi-v7a`. The package name is `com.arkintide.nuclearthronentte`.
Configure your own Android SDK, NDK, JDK, and signing key in GameMaker.
Do not commit keystores, passwords, or local SDK configuration.

The delivered build also includes native adaptations for controller input queues/hot-plugging, render-thread scheduling, and volume keys in the official Runner.
`platforms/android/runner.patch` contains the changes against the runtime version above.
Its target is a Java source tree whose package name has already been replaced with `com.arkintide.nuclearthronentte`.
Use `git apply --check` before applying it to your local Runner. Other runtime versions require manual merging.
Exporting the GameMaker project alone does not automatically apply these native changes.

## iOS

On a Mac, configure GameMaker, Xcode, the iOS SDK, and your own developer signing identity, then export a complete Xcode project from the prepared project.
Set the separate Bundle ID to `com.arkintide.nuclearthronentte`.
For access through the Files app, enable `UIFileSharingEnabled` and `LSSupportsOpeningDocumentsInPlace`.
Use landscape orientation and retain the pixel-art sampling settings.

The current GameMaker `.yy` export template may still contain an upstream placeholder Bundle Name.
Set the final Bundle ID above in GameMaker/Xcode instead of using that placeholder for signing.
The commercial Runner is not included in the source tree.

The delivered IPA combines a retained Runner previously launched on a device with newly compiled VM data.
This repository has not verified the entire process of rebuilding an equivalent IPA natively on a fresh Mac.
Package checks on an existing IPA do not establish a fresh Xcode build or physical-device acceptance.
The downloadable IPA requires signing or re-signing with your own signing identity before installation.

## Windows and tests

Open the prepared `.yyp` project in GameMaker and select Windows VM.
Internal tests require the explicit `--ntte-full-smoke` argument; normal startup does not activate them.
The existing base smoke arguments are also required. See the `scrNTTESmoke` and `scrNTTEFullSmoke` entry points.
The source repository does not include a compiler, entitlement files, platform certificates, or compiled development runtimes.
