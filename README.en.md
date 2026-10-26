# Nuclear Throne :Territorial Expansion — Mobile Port

[简体中文](README.md) | [English](README.en.md)

GameMaker source for the NTTE mobile port, with Android and iOS adaptations and Simplified Chinese localization.
The current source baseline is **1.2.1 (2026-10-26)**.

## Source-only distribution

This repository contains program source, resource declarations, configuration, localization text, and documentation only. It excludes all images, textures, audio, fonts, icons, third-party binary libraries, and compiled game data, including assets specific to the original game, NTTE, Undergrowth, Details+, and this port.

On 2026-10-26, public branch and tag histories were rewritten to remove these files. Asset ignore rules and a pre-push source audit prevent reintroduction. Commit hashes changed; re-clone existing checkouts. Obtain required assets separately from authorized sources; see [Building](docs/BUILDING.en.md) and the [source distribution policy](docs/SOURCE_ONLY.md).

## Downloads

Download installers from the [MEGA download folder](https://mega.nz/folder/PfIDSaSZ#ZcRokP34or9J0JofsIgrEA). GitHub Releases provide release notes and asset-free text source only; no APK, IPA, or game assets are attached.

Install Android updates in place to retain saves. Sign or re-sign the iOS IPA with your own identity before installation. See the [latest release](https://github.com/ArkinTide/NTTE-Mobile-Port/releases/latest) and [validation notes](docs/VALIDATION.en.md).

Version 1.2.0 and older need one manual update from the folder above. From 1.2.1, the in-game download action opens that folder.


> Starting with 1.1.0, content from other MODs is being added. To play the original NTTE content, download 1.0.4 or a subsequent 1.0.x release.

## Changes in 1.2.1

- Fixed the undefined `FrogHeal` crash from Undergrowth Pitcher Plant healing and corrected Mega Grenade's native melee reflection dependency.
- Fixed repeated NTTE golden-weapon save notices after level-state reconstruction. Only durable loadout changes trigger a new save/notice.
- Batch immutable Details+ additions using a dedicated atlas and vertex buffers, preserving decoration counts, frames, artwork and ordering. Disabling the option or clearing terrain releases batches.
- Restrict blast wall refreshes to the blast neighborhood while preserving original damage, effects, geometry and gameplay RNG.
- Recover Pizza TV spectators and their Rat conversions from late walls or impacts without damaging them.
- Validate CatHole floor footprints and wall collisions, then recheck Cat emergence. Outside covers, late walls and missing home floors use valid ground; no wall-based enemy-kill mechanism is added.
- Continue checking versions through GitHub and open the fixed MEGA folder for downloads, supporting releases without installer attachments.

## Changes in 1.2.0

- Integrated Details+ 1.1: detail clusters, floor-specific explosion scorch marks, crown-statue and broken-statue decorations, desert mud and oasis floor transitions.
- Added **Settings → Video → DETAILS+**, enabled by default with a saved preference. Disabling removes added decorations and restores original artwork; it can be re-enabled at any time.
- Retained 40 original sprite resources (76 frames) and adapted NTTE Coast, Trench and Oasis area identifiers.
- Apply decorations on generation or option changes and match scorch artwork on creation, avoiding per-frame scorch scans. Repeated toggles do not accumulate decorations or consume gameplay RNG.
- Updated Android/iOS to 1.2.0, retaining Undergrowth and earlier repairs, and synchronized the in-game and updater version labels.

Details+: [https://wigglercola.itch.io/detailsplus](https://wigglercola.itch.io/detailsplus)

## Changes in 1.1.0

- Integrated Undergrowth v1.0.3: a secret area, enemies, props, original artwork, lighting and music.
- Preserved the Vine entrance near a chest in Scrapyards 3-3; opening the chest first closes it. The new area exits to Jungle.
- Added loop Flytraps, Millipedes and Golden Pitcher Plants, plus Fossil Pistol, Fossil Gun, Fossil Cannon, Fossil Hammer and Mega Grenade Launcher.
- Added Simplified Chinese text and glyphs; other languages retain English. Adapted fusion weapons and migrated legacy continuation weapon handles.
- Updated Android/iOS to 1.1.0, retaining the 1.0.4 Pizza exterior-shadow repair.

Undergrowth: [https://attfooy.itch.io/undergrowth](https://attfooy.itch.io/undergrowth)

## Changes in 1.0.4

- Fixed remaining exterior wall-shadow artifacts at Pizza Sewer corners, floor edges and destroyed-floor boundaries.
- Wall shadows are clipped to actual floor footprints. Interior and actor/item shadows remain; wall collisions, enemy behavior and portal rules are unchanged.
- Synchronized the repair to Android and iOS and updated the version to 1.0.4.

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
From 1.2.1, DOWNLOAD UPDATE opens the fixed MEGA folder on Android and iOS. Install the Android APK in place; the iOS IPA still requires signing.
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

All game assets, including MOD and port-specific artwork/audio/fonts, are excluded from Git. Obtain them separately from authorized sources before building.
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

Undergrowth — matt / attfooy: [https://attfooy.itch.io/undergrowth](https://attfooy.itch.io/undergrowth)

Details+ — wigglercola: [https://wigglercola.itch.io/detailsplus](https://wigglercola.itch.io/detailsplus)
