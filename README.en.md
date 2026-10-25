# Nuclear Throne :Territorial Expansion — Mobile Port

[简体中文](README.md) | [English](README.en.md)

GameMaker source for the NTTE mobile port, with Android and iOS adaptations and Simplified Chinese localization.
The current source baseline is **candidate73 (2026-10-25)**.

## Downloads

The latest delivered Android APK and iOS IPA are available on the [candidate73 release page](https://github.com/ArkinTide/NTTE-Mobile-Port/releases/tag/candidate73):

- [Android APK](https://github.com/ArkinTide/NTTE-Mobile-Port/releases/download/candidate73/NuclearThrone.TerritorialExpansion-Android-crashfix-candidate73.apk)
- [iOS IPA](https://github.com/ArkinTide/NTTE-Mobile-Port/releases/download/candidate73/NuclearThrone.TerritorialExpansion-iOS-crashfix-candidate73.ipa): sign or re-sign with your own signing identity before installing.
- [SHA-256 checksums](https://github.com/ArkinTide/NTTE-Mobile-Port/releases/download/candidate73/SHA256SUMS.txt)

Both platforms use the separate application identifier `com.arkintide.nuclearthronentte`.
See the [validation notes](docs/VALIDATION.en.md) for the scope of verification.
Installers are distributed as release assets; the Git source tree contains no installers, signing keys, or personal saves.

## Repository layout

- `project/`: shared GameMaker project, NTTE implementation, touch/controller input, and in-game regression tests.
- `platforms/android/project/`: Android-specific files applied over the shared project.
- `platforms/android/runner.patch`: source changes against the official GameMaker Android Runner.
- `tools/prepare_project.py`: prepares separate Android, iOS, and Windows build directories.
- [docs/BUILDING.en.md](docs/BUILDING.en.md): build environment, original-asset extraction, and platform notes.
- [docs/VALIDATION.en.md](docs/VALIDATION.en.md): verification scope and limitations.
- `docs/LOCALIZATION.json`: the existing localization reference data, exported at candidate70.

The source is based on NuclearThroneMobile:Epsilon and adapts the NTTE MOD as a native GameMaker implementation.
The upstream GPL-3.0 license and third-party notices are preserved; see [LICENSE](LICENSE) and [THIRD_PARTY_NOTICES.md](THIRD_PARTY_NOTICES.md).
This is an unofficial port with no affiliation to Vlambeer.

Excluded original-game assets are not included in the Git source tree. Before building, extract the required assets from your own copy of Nuclear Throne.
The source tree also excludes the commercial GameMaker runtime, signing certificates, personal saves, SDKs, and build caches.

## Building

1. Install GameMaker LTS and the tools for your target platform. The currently verified runtime is `2026.0.0.23`.
2. Run `python tools/prepare_project.py --platform android`, or choose `ios` or `windows`, to prepare a build directory.
3. Follow [docs/BUILDING.en.md](docs/BUILDING.en.md) to extract assets in that directory, then open the `.yyp` project.
4. Configure the build for your own device, signing identity, and export environment.

## Credits

- Original game by Vlambeer
- Android original version by toncho_
- Nuclear Throne Epsilon by kcd-shichen
- iOS port by ArkinTide

Special thanks: kuzumi, Golden vegetable, Dinosaur leader.
Thanks also to the original NTTE MOD authors and contributors, and to ToD for the NTTE encyclopedia.

- Original NTTE project: [Yokinman/NTTE](https://github.com/Yokinman/NTTE)
- Upstream Epsilon project: [kcd-shichen/NuclearThrone-Recreated-Epsilon](https://github.com/kcd-shichen/NuclearThrone-Recreated-Epsilon)
- Original NTM project: [toarch7/nt-recreated-public](https://github.com/toarch7/nt-recreated-public)
