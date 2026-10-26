# Nuclear Throne :Territorial Expansion — Mobile Port

[简体中文](README.md) | [English](README.en.md)

GameMaker source for the NTTE mobile port, with Android and iOS adaptations and Simplified Chinese localization.
The current source baseline is **1.0.3 (2026-10-26)**.

## Downloads

The latest delivered Android APK and iOS IPA are available on the [1.0.3 release page](https://github.com/ArkinTide/NTTE-Mobile-Port/releases/tag/1.0.3):

- [Android APK](https://github.com/ArkinTide/NTTE-Mobile-Port/releases/download/1.0.3/NuclearThrone.TerritorialExpansion-Android-1.0.3.apk)
- [iOS IPA](https://github.com/ArkinTide/NTTE-Mobile-Port/releases/download/1.0.3/NuclearThrone.TerritorialExpansion-iOS-1.0.3.ipa): sign or re-sign with your own signing identity before installing.
- [SHA-256 checksums](https://github.com/ArkinTide/NTTE-Mobile-Port/releases/download/1.0.3/SHA256SUMS.txt)

Both platforms use the separate application identifier `com.arkintide.nuclearthronentte`.
See the [validation notes](docs/VALIDATION.en.md) for the scope of verification.
Installers are distributed as release assets; the Git source tree contains no installers, signing keys, or personal saves.

## Changes in 1.0.3

- Restored the Pizza Sewer Cat boss gas telegraph above the floor overlay.
- Fixed an uninitialized PopupText message in Gator Statue blessings.
- Restored the original secret-entry weapon guarantees: explosive drops in 2-1 and the screwdriver guarantee after the first chest in 3-1.
- Corrected initial Pizza watcher spawns outside the floor and exterior-void shadows. Intended wall enemies remain; no terrain-based kill mechanism was added.
- Completed Chinese dynamic and nested fusion names, including the corrected Pop Gun and Pop Rifle terminology.
- Fixed Pizza furniture remaining solid white after being hit.
- Excluded secret components from ordinary random fusion rewards and desert wall weapon pools while retaining authored locations and valid quest fusions.
- Fixed a cross-loop roadmap connector coloring the entire next loop yellow.
- Migrated update checks and installer URLs to official version tags and filenames, with component-wise semantic version comparison.

Upgrading from 1.0.2 or earlier to 1.0.3 requires one manual download and in-place installation because the older updater only recognizes historical candidate tags. Version 1.0.3 recognizes future official version tags. Do not uninstall first if you want to retain saves.

## Changes in 1.0.2

- Prevented loading-roadmap crashes from unavailable character-skin icons by rendering that character's default icon.
- Fixed premature Boss victory music from an intact or unsuccessfully triggered Dummy ambush; failed spawns retain the event for retry.
- Removed the stray ground-shadow stripe drawn over a shell or other host while a Parrot pet is perched; grounded shadows remain.
- Fixed available-update prompts being blocked on the startup title screen, including the Android download-to-install handoff there.
- Fixed Seal King retaining the area track after its introduction.
- Restored the original MOD conditions for Pit Squid pre-emergence and battle music; repeated introduction callbacks no longer restart a playing track or intro.
- Fixed the collapsed character-selection loadout preview showing the ordinary starter instead of the selected NTTE golden weapon or golden fusion.

## Changes in 1.0.1

- Fixed repeated mutation selection and skipped stages by restricting portal recovery and queued corpse callbacks to valid combat phases.
- Fixed the selected language reverting to English on restart. Language changes save immediately, persist through practice/console saves, and reactivate after locale tables reload.
- Preserved the same-sole-non-Boss timeout of more than 60 gameplay seconds and legitimate empty-combat portal recovery.

## Changes in 1.0.0

- Fixed first-use BubbleBomb fusion and Raven takeoff/landing crashes.
- Fixed Desert/Jungle softlock paths involving flying or dormant enemies and empty-room portal retries.
- Kept the same-sole-non-Boss rule: removal occurs only after more than 60 gameplay seconds. Pauses do not count; changing targets or additional enemies reset the timer. Wall placement is not a removal criterion.
- Lightning Crystal ambient and attack arcs no longer discharge the entire water area in Oasis or Trench. Local arc damage and ordinary weapon conduction remain.
- The official version is **1.0.0**. Each subsequent bugfix update increases it by **0.0.1**, starting with **1.0.1**.

## In-game updates

The game automatically checks this repository's latest stable release after startup. Open **Settings → NT:TE → UPDATES** to check manually or disable automatic checks.
Android downloads and verifies the APK in-game, then opens the system installation confirmation. iOS opens the IPA download link and still requires signing before installation.
Upgrading from 1.0.2 or earlier to 1.0.3 requires one manual download and in-place installation because the older updater only recognizes historical candidate tags. Version 1.0.3 recognizes future official version tags. Do not uninstall first if you want to retain saves. See [using and publishing updates](docs/UPDATING.en.md).

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
