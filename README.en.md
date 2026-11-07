# Nuclear Throne: NTTE + Uncharted Frontier — Mobile Port

[简体中文](README.md) | [English](README.en.md)

Android/iOS source port of NTTE with **Uncharted Frontier (NTUF) 1.0.3.3**,
Undergrowth, Details+ and Simplified Chinese support. Current version: **2.0.1**,
internal build **97**.

## Downloads

Get APK/IPA from the [MEGA download folder](https://mega.nz/folder/PfIDSaSZ#ZcRokP34or9J0JofsIgrEA) and verify
`SHA256SUMS-NTTE-NTUF-2.0.1.txt`. GitHub distributes text source and release notes.
Android retains the application identifier/signing identity; iOS requires your
own re-signing. See the [2.0.1 notes](docs/RELEASE-2.0.1.md).

## Changes in 2.0.1

- Repair registry/callback lifecycle crashes during retry, character selection and menus.
- Preserve proto-chest fusion composition/physics, guarding stale numeric handles.
- Preserve friendly projectiles in Bubbles Ultra and unify Scary Face initialization/revival.
- Retain wall/weather/interaction/localization adaptations and include TSV translation inputs.

The newly compiled final VM passed **14 selected native cases**; a Python log
records **112 passing checks**. Bubbles A/B completed actual death-to-Retry
and real touch-produced damage at 30/60 FPS. See [validation](docs/VALIDATION.en.md)
for exact scope, historical VM separation and limitations. Persistent phone audio
noise is unresolved. No physical Android/iOS or complete random campaign was
tested; no universal FPS guarantee or recovery of already-lost fusion data is claimed.

## Source and building

`project/` is the accepted common source, `platforms/android/` has two text
overlays, and `frontier20/` holds adapters, offline dependencies, localization and
upstream text references. Artwork, audio, fonts, icons, commercial Runners,
compiled extensions and installers are absent from Git and must be obtained
separately. See [building](docs/BUILDING.en.md), [source policy](docs/SOURCE_ONLY.md)
and [source restoration](frontier20/SOURCE_REPRODUCTION.md).

[License](LICENSE) and [third-party notices](THIRD_PARTY_NOTICES.md) are retained.
This is an unofficial port. Upstream: [NTTE](https://github.com/Yokinman/NTTE) ·
[Uncharted Frontier](https://wigglercola.itch.io/uncharted-frontier) ·
[Undergrowth](https://attfooy.itch.io/undergrowth) · [Details+](https://wigglercola.itch.io/detailsplus).

## History

[2.0.0 release notes](docs/RELEASE-2.0.0.md) retain the prior build/test scope.
