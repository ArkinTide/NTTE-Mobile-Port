# Nuclear Throne: NTTE + Uncharted Frontier — Mobile Port

[简体中文](README.md) | [English](README.en.md)

Android/iOS port source for NTTE and **Uncharted Frontier (NTUF) 1.0.3.3**,
retaining Undergrowth, Details+, and Simplified Chinese support.
Current source version: **2.0.0 (2026-11-06)**, internal build 96.

## Downloads

Get installers from the [MEGA download folder](https://mega.nz/folder/PfIDSaSZ#ZcRokP34or9J0JofsIgrEA).
GitHub Releases contain notes and text source only, with no APK, IPA, or game
assets attached. Android retains the existing application identity and signing
certificate. The iOS IPA requires re-signing with your own signing identity.
See the [2.0.0 release](https://github.com/ArkinTide/NTTE-NTUF-Mobile-Port/releases/tag/2.0.0).

Platform packages and the official tag use `2.0.0`; the game corner retains
the shorthand `2.0`, while settings show installed version `2.0.0`. This
normalization changes platform-version metadata only. The game VM, native
libraries and assets retain the exact verified bytes; no new VM test run is
claimed.

## Version 2.0.0

- Integrates Uncharted Frontier areas, weather events, interactions, enemies,
  bosses, weapons, mutations, and Bubbles, with Simplified Chinese presentation.
- Fixes weather, Millipede chain and Bubbles new-game errors; restores toolkit
  drops, interaction prompts, weather banners, and the 0-1 police/boss sequence.
- Fixes exterior-wall colors, local area-orb recoloring, hidden-room roof
  visibility and wall enemy placement, plus packed-wall player contact and
  excessive ejection of weapons dropped during an exchange.
- Restores damage attribution for Wormhole's NTTE projectiles while preserving
  native Disc and Explosion damage identities.
- Reduces repeated entity queries, library reads, and full-screen Deep Labs
  turret composites, preserving authored combat, artwork, and collision.
- Chooses fonts from visible text, preserving icon/ASCII metrics and covering
  all required NTUF Chinese characters.

The reported disappearing replacement weapon has one confirmed repaired path:
a live dropped pickup was pushed too far along a packed wall. Actual exchange
and re-pickup tests now pass. Generic weapon deletion was not reproduced, so
this does not establish that every possible disappearance cause is resolved.

## Validation scope

**88 regression cases** passed on the same final Windows VM/input, along with
**94 Python checks**. Coverage includes four genuine Bubbles new games across
A/B skins, English/Chinese and 30/60 FPS modes, actual weapon exchange/recovery,
weather, areas, walls, projectiles, cold Continue, and image comparisons.
Tests use isolated saves and muted background processes.

These are isolated desktop regressions, not physical Android/iOS testing or a
complete random campaign. No particular phone frame rate is promised. Saved
Bubbles screenshots show the world only; GUI evidence comes from actual draw
callbacks. See [validation details](docs/VALIDATION.en.md).

## Source and building

Images, audio, fonts, icons, commercial runtimes, precompiled extensions and
installers are excluded. Project declarations still reference those resources;
obtain them separately from their authors or other authorized sources. A clean
checkout cannot directly build the complete game. See [building](docs/BUILDING.en.md)
and [source distribution](docs/SOURCE_ONLY.md).

- `project/`: accepted shared GameMaker source and resource declarations.
- `platforms/android/`: Android text overlays and retained Runner patch notes.
- `frontier20/`: NTUF compiler, native adapters, localization, offline libraries,
  source inventory, and historical text snapshots.
- [NTUF source reconstruction](frontier20/SOURCE_REPRODUCTION.md): restore
  image-bearing source from your own inputs without putting artwork or the
  obsolete online loader's credentials into Git.

Existing licenses and third-party notices remain; see [LICENSE](LICENSE) and
[credits](THIRD_PARTY_NOTICES.md). This is an unofficial port, unaffiliated with
Vlambeer.

Original projects: [NTTE](https://github.com/Yokinman/NTTE) ·
[Uncharted Frontier](https://wigglercola.itch.io/uncharted-frontier) ·
[Undergrowth](https://attfooy.itch.io/undergrowth) ·
[Details+](https://wigglercola.itch.io/detailsplus)

## Changes in 1.2.7

- Fixed Lab/HQ delayed chamber planning treating packed exterior fill as native obstacles, restoring doors, access routes and the native clear/exit lifecycle.
- Checked packed-wall interaction with hidden rooms, buried objects, wall chests, sewer entrances, path grids, wide collision masks, projectiles, melee and portals. Local carving/contact handling retains distant collision walls.
- Reduced repeated updates and rendering work for sparse exterior walls and static objects, addressing costs present both on entry and during combat.
- Optimized Coast swimming composition around each swimmer instead of repeatedly copying transparent full-screen surfaces. Preserved waterlines, sinking, layers and original artwork, with full-frame fallbacks for long sights, special Draw behavior, screen edges and iOS.
- Retained previous fusion effects, 3-3 vine, Red secret corridor, audio and frame-pacing fixes.

## Changes in 1.2.6

- Fixed the missing effect-provider exception on the first merged Hyper Bubbler shot.
- Enabled production fusion collision/destruction callbacks, restoring Ultra Crossbow wall piercing, bouncer reflection and other hit/destruction effects. Fixed native sticky follow/release and Gun Gun physical-weapon inheritance. Audited all77 original specialized callbacks and44 effect lifecycle routes, with actual firing checks across18 effect families.
- Added sparse packed solid exterior walls to land areas while retaining authored edges/transitions. Plain exterior rendering supports local destruction/carving without scanning vast empty rectangles between distant rooms. Marine, abyss and platform spaces retain their terrain behavior.
- Fixed ordinary Player wall handling ejecting players from or destroying the Red Caves secret corridor disguise. Preserved original gradual reveal, masks and hidden-room access.
- Prevented opening unrelated weapon chests from withering the3-3 entrance vine; retained30000HP and clear-before-entry rules.

## Changes in 1.2.5

- Fixed dormant police-van reservations being counted as enemies, which could prevent an empty Desert from opening its exit and interrupt the sole non-Boss one-minute timeout. Armed reinforcements and Boss guards remain active.
- Optimized Android Coast swimmer compositing by folding the per-entity full-screen gradient scratch pass into the top-layer draw. Waterlines, sinking, weapon rendering and the original shader fallback are preserved; iOS retains its verified compositor.
- Fixed Big Bat morph-cloud and smoke callbacks accessing effects already destroyed during creation, including disabled particles and underwater replacements.
- Removed the extra fivefold ocean-explosion amplification, guarded invalid playback handles and coalesced repeated splash triggers to address low-frequency rumble or clipping while preserving visual effects and RNG order.

## Changes in 1.2.4

- Fixed touch interaction labels being drawn by both the HUD and touch controls with different alignment, producing overlapping translated text. Each label is now drawn once with its own alignment.
- Raised the 3-3 Undergrowth entrance Vine to 30,000 HP. Living entrances in older continuations retain prior damage; ordinary Vine props and the level-clear entrance requirement are unchanged.
- Restored the original MOD's cap cleanup at new blast-floor origins and repaired collision-mask restoration when a TopTiny reorder is interrupted. Destroyed walls no longer leave orphan caps; wall-dwelling creatures are preserved.
- Verified the original Cursed Crystal Spider mechanism through a real Caves nest, wall-break release, adoption, native portals into Cursed Caves, automatic conversion, JSON continuation and departure. No separate cursed nest was added.

## Changes in 1.2.3

- Fixed Undergrowth loop clusters creating uninitialized, invisible 1-HP enemies that blocked level-clear portals.
- Fixed the periodic decoration cleanup deleting the Crystal Spider's special nest on an intact wall; normal wall-break release, pickup, continuation and level transitions are preserved.
- Fixed exterior shadows in the Pizza Sewer's Lair branch. Active Cats validate their completed movement against walkable floor without changing hidden manhole travel or perching behavior.
- Normal clear portals now use the last hostile death point in the current level instead of an older corpse. Allied deaths and room cleanup do not replace it; missing floor falls back to valid ground.
- Preserved authored special-portal positions, existing portal guards, and the same-sole-non-Boss 60-second timeout. No wall-position enemy-kill rule is restored.

## Changes in 1.2.2

- Fixed Undergrowth Vine chest drops displaying screwdriver artwork by refreshing weapon sprites, names and ammo types.
- Require all hostile units to be cleared before using the Scrapyards 3-3 Vine entrance. Allies do not block it; opening its chest first still closes the entrance.
- Fixed allies blocking Millipede departure and dormant Jungle Assassins from waking up, preventing related level-clear stalls.
- Fixed corpse animation completions repeatedly resetting an existing portal countdown after enemies were cleared.
- Verified Crystal Spider release from its broken nest wall, visibility, pickup, continuation restoration and retention across levels; original spawn behavior is preserved.
- Retained the timeout for the same sole non-Boss enemy surviving over 60 seconds. No wall-position enemy-kill rule is added.

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
