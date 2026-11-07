# Nuclear Throne: NTTE + Uncharted Frontier — Mobile Port

[简体中文](README.md) | [English](README.en.md)

Android/iOS source port of NTTE with **Uncharted Frontier (NTUF) 1.0.3.3**,
Undergrowth, Details+ and Simplified Chinese support. Current version **2.0.2**,
internal build **98**.

Get APK/IPA from the [MEGA download folder](https://mega.nz/folder/PfIDSaSZ#ZcRokP34or9J0JofsIgrEA) and verify
`SHA256SUMS-NTTE-NTUF-2.0.2.txt`. GitHub distributes text source and release notes;
iOS requires re-signing. See the [2.0.2 notes](docs/RELEASE-2.0.2.md).

## 2.0.2 — Weather, moving traps and NTUF interface repairs

The newly compiled final Windows VM/input passed 32 explicitly selected native
cases. A hash-verified Python log records 118 passing checks. Earlier VM passes
are not inherited. See the [current validation summary](docs/validation/2.0.2-development-regression.json)
for exact cases and evidence.

This round repairs Aurora background-colour access, weather compatibility cost,
the locked Storm Crown icon, Palace moving traps, invalid saved Bubbles starters, wall-spawned JungleFly landing,
statistics/credits layout, a separate NTUF custom-weapon section and goto area labels.

Android versionCode is 3000098, retaining application/signing identities and checked
16KB layout. iOS build 98 requires re-signing; new game data uses a retained native
Runner without a fresh Mac native build. GAME_BUILD/save protocol remains 3004.

Persistent audio noise remains unresolved. Silent background desktop tests do not
establish phone mixing or frame rates. No physical Android/iOS, complete random
campaign or universal FPS acceptance is claimed.

## Source and building

`project/` is the accepted common source, `platforms/android/` holds Android text
overlays, and `frontier20/` holds adapters, offline dependencies, localization and
upstream text references. Artwork, audio, fonts, icons, commercial Runners, compiled
extensions and installers are absent from Git and must be obtained separately.
See [building](docs/BUILDING.en.md), [source policy](docs/SOURCE_ONLY.md) and
[source restoration](frontier20/SOURCE_REPRODUCTION.md).

[License](LICENSE) and [third-party notices](THIRD_PARTY_NOTICES.md) are retained.
This is an unofficial port. History: [2.0.1](docs/RELEASE-2.0.1.md),
[2.0.0](docs/RELEASE-2.0.0.md).
