# Validation notes

[简体中文](VALIDATION.md) | [English](VALIDATION.en.md) | [Home](../README.en.md)

## 1.1.0

21 selected Windows VM cases passed at 30/60 FPS. Coverage includes new entities/weapons/terrain, bidirectional fusion, native collision and terminal callbacks, 1.0.x continuation-handle migration, a scheduled Scrap3-3 entrance→Undergrowth→Jungle route, a 10-second combat soak, chest-first entrance closure and Last Wish refund. Retained regressions cover Pizza shadow pixels, localized menus, drop pools, updates and related continuation paths.

The Android downloader passed 31 Java checks. Both installers passed frozen-source binding, version/signature/structure and compiled-function preservation audits. Android versionCode is 3000083; iOS CFBundleVersion is 83.

No physical-phone acceptance or fresh native Mac build was performed; these tests are not full-campaign acceptance. iOS uses newly compiled VM data with the retained native runner and requires re-signing. [Downloads](https://github.com/ArkinTide/NTTE-Mobile-Port/releases/tag/1.1.0).


## 1.0.4

9 selected Windows VM cases passed at 30/60 FPS: `PizzaShadow104Tests`, `PizzaShadow104NaturalTests`, `PizzaShadow78Tests`, `OptionalShadowNativeTests`, `IOSShadowPresentTests`, `TopShadowNativeDrawTests`, `SewerPizzaNaturalEntryTests`, `UpdateCheckTests`, `UpdateStartupMenuTests`.

New pixel regressions cover six intact/broken-floor, corner and empty-floor configurations. Unclipped original shadows provide a negative control; every pixel preserves valid interior coverage while excluding exterior wall-shadow pixels. Actor shadows are compared exactly. Three naturally generated Pizza seeds cover complete shadow surfaces at both rates and exercise native wall-side/top draw calls for exception safety. Existing iOS-compatible shadow presentation, optional/top shadows, actual Sewer-to-Pizza entry and updater prompts also pass.

The shared repair is synchronized to Android. The native downloader passed 31 Java checks; both installers passed compiled-function preservation, version, structure and signing audits. Android versionCode is 3000081 and iOS CFBundleVersion is 81, with game version 1.0.4.

No physical-phone acceptance or fresh native Mac compilation was performed. iOS uses freshly compiled VM data with the retained runner and requires re-signing. [Downloads](https://github.com/ArkinTide/NTTE-Mobile-Port/releases/tag/1.0.4).


## 1.0.3

19 selected Windows VM cases passed at 30/60 FPS: `CatWarning78Tests`, `GatorStatueNativeTests`, `SecretWeapon78Tests`, `PizzaSpawn78Tests`, `PizzaShadow78Tests`, `MergedChinese78Tests`, `PizzaPropHurt78Tests`, `QuestDrop78Tests`, `RoadmapLoop78Tests`, `RoadmapNativeTests`, `RoadmapPlayerIconsTests`, `ChestDropNativeTests`, `InitialChestsNativeTests`, `BeetleMenuTests`, `Followup69PresentationNativeTests`, `OptionalShadowNativeTests`, `UpdateCheckTests`, `UpdateStartupMenuTests`, `SewerPizzaNaturalEntryTests`.

Coverage includes actual telegraph/shadow/fusion-name pixels and glyph ranges, blessing callbacks, native chest and pickup collision ordering, preview rollback, 16 actual Pizza generations, furniture hurt animations, secret-component exclusion, and loop 1/2 roadmap rendering. The real Sewer→Pizza route uses native firing, explosion, Portal collision, room restart and destination Draw events. Its former straight-line launch planner rejected the same seed at 60 FPS with both old and repaired sources. Only the test's natural launch-angle search was expanded; terrain and transition assertions were preserved, as were the original failure records.

Official semantic versions and title-screen prompts were checked in the VM. The changed native Android downloader policy passed 31 fresh Java host checks for version/URL rules, streaming hash, truncation, corruption and cancellation. Shared Android source is synchronized. Final installers passed compiled-function preservation, metadata, signing and structure audits. Android retains its signer and 16 KB ZIP alignment. iOS uses a freshly compiled VM export and verified retained runner; re-signing is required.

Installers: [1.0.3 release](https://github.com/ArkinTide/NTTE-Mobile-Port/releases/tag/1.0.3). No physical Android/iPhone acceptance, fresh native Mac compilation or full-MOD end-to-end acceptance was performed.


## 1.0.2 (candidate77)

Fourteen selected Windows VM tests passed at both 30 and 60 FPS: `UpdateStartupMenuTests`, `UpdateCheckTests`, `SealKingMusicTests`, `PitSquidMusicPhaseTests`, `MusicBossRoutingTests`, `GoldenLoadoutDisplayTests`, `WeaponLoadoutNativeTests`, `LanguagePreferencePersistenceTests`, `PortalSelectionTransitionTests`, `RoadmapPlayerIconsTests`, `ParrotPerchShadowTests`, `DummyAmbushMusicTests`, `WorldEventsDummyWorldTests`, `BossClassificationNativeTests`.

The update prompt, both boss music issues and golden loadout preview reproduced failures before repair. Music tests enable real audio and execute Palanking phase5, PitSquid clear-room Step, first-rise decision and emergence Step, and native MusCont.Alarm2. They assert playing voice handles and stable repeated requests. Golden loadout tests compare the real collapsed menu pixels against the correctly supplied native renderer for three NTTE golden modules and a golden fusion. Existing language persistence, mutation selection and stored-weapon regressions were also checked. Added native roadmap/default-icon pixel comparisons, both Parrot skins perched on a real shell, displaced-Dummy/missing-spawn-wall music tests, a naturally generated complete ambush/death sequence, and Boss classification checks. The user clarified that no Boss actually died; only victory music played. An early observer detected normal pet damage and was corrected to isolate it, not counted as a bug reproduction.

Final compiled functions, metadata and installer checks passed on both platforms. Android retains its signing identity and passes 16 KB ZIP alignment. The unchanged native updater policy retains its 20-check passing record with the same source hash. iOS packages a new VM export with the verified retained runner and requires re-signing.

Installers are on the [1.0.2 release page](https://github.com/ArkinTide/NTTE-Mobile-Port/releases/tag/candidate77). Physical Android/iPhone acceptance, a fresh native Mac compilation and full-MOD end-to-end acceptance were not performed.

## 1.0.1 (candidate76)

Eight selected Windows VM tests passed at both 30 and 60 FPS: `PortalSelectionTransitionTests`, `LanguagePreferencePersistenceTests`, `LastEnemyHiddenTimeoutTests`, `LastEnemyTimeoutNativeTests`, `WorldCompletionNativeTests`, `UpdateCheckTests`, `MenuReminderPersistenceNativeTests`, `MenuNativeTests`.

Both new regressions reproduced failures before the fixes. Portal tests exercise the real mutation controller, two native selections and generation, queued corpse callbacks, paused/ended/generation phases, and legitimate empty-combat portals. Language tests click the actual menu row and check immediate disk writes, independent save reloads and locale reinitialization in normal and practice save branches; unrelated progress remains intact.

The full menu image regression first exceeded a 120-second deadline. The identical build passed both rates when run alone with a 360-second deadline; the initial timeout evidence is retained.

Changed compiled functions were checked in both final installers. Android signing, 16 KB ZIP alignment, version and updater entry checks passed. The Java updater policy source is unchanged; its 20-check passing record is reused with the same source hash. iOS VM export, retained-runner compatibility, Payload and version checks passed.

Installers are on the [1.0.1 release page](https://github.com/ArkinTide/NTTE-Mobile-Port/releases/tag/candidate76). Physical Android/iPhone acceptance, a fresh native Mac compilation and full-MOD end-to-end acceptance were not performed this round.

## 1.0.0 (candidate75)

Nine selected Windows VM tests passed at both 30 and 60 FPS: `CrystalWaterLightningTests`, `RavenLiftTargetTests`, `BubbleMergeColdStartTests`, `LastEnemyHiddenTimeoutTests`, `LastEnemyTimeoutNativeTests`, `UpdateCheckTests`, `MergedLightningUnitTests`, `BubbleWeaponTests`, and `MenuNativeTests`.

Desert/Jungle tests cover real flying Ravens, dormant assassins, zero-HP remnants, the full one-minute threshold, pauses, native death/drop/corpse callbacks, and native empty-room portal retries with no allies or corpse. Bosses and generic spawn transitions are protected. No wall-position removal rule is used. Crystal tests exercise actual ambient/attack events and child arcs in Oasis/Trench while retaining ordinary weapon conduction.

All 20 Android native updater policy checks passed. Final APK signing, 16 KB ZIP alignment, updater entry points, version, and package identity were verified. The iOS VM export, retained-runner registrations, Payload, and version checks passed. Changed compiled functions were compared with the final game data in both installers.

Installers are on the [1.0.0 release page](https://github.com/ArkinTide/NTTE-Mobile-Port/releases/tag/candidate75). These are targeted automated regressions. Physical Android/iPhone acceptance, a fresh native Mac compilation, and full-MOD end-to-end acceptance have not been performed this round.

## candidate74: updater

- `UpdateCheckTests`, `MenuNativeTests`, and `MenuReminderPersistenceNativeTests` passed in Windows VM at 30 and 60 FPS.
- The native Android updater compiled successfully. Twenty Java policy checks cover streaming, length/SHA-256 verification, corruption, cancellation, and URL/redirect rules.
- All 84 Chinese characters used by the updater exist in the current body font. The iOS VM export and retained-runner function-registration compatibility audit passed.
- This round did not include physical Android/iPhone downloads or in-place installation, or a fresh native Mac build. Installation permission and sideload signing still require device-side action.

The candidate74 APK, IPA, and SHA-256 checksums are on the [release page](https://github.com/ArkinTide/NTTE-Mobile-Port/releases/tag/candidate74). Final package updater code was compared function-by-function with the compiled exports. Android installation permission, scoped FileProvider paths, signing, and 16 KB ZIP alignment checks passed.

## candidate73: preceding repair baseline

The following 10 candidate73 Windows VM regression cases passed at both 30 and 60 FPS:

- `CrystalWaveAccuracyNativeTests`
- `LastEnemyTimeoutNativeTests`
- `ActorFireTests`
- `ActorMountTests`
- `CrystalCloneNativeTests`
- `ActorBirthCaptureNativeTests`
- `BossClassificationNativeTests`
- `GroundEnemyNoKillNativeTests`
- `WorldKillEnemiesTests`
- `TrenchCompletionPreventNativeTests`

This candidate repairs a missing `accuracy` property in delayed Crystal Ally projectile bursts.
It also sets the same remaining non-Boss enemy's health to zero after it has continuously been the sole enemy for more than 60 gameplay seconds, allowing the normal death flow to run.
Paused time does not count. Additional enemies, a changed target, conversion to an ally, or a room change reset the timer.

Shared Android source and the iOS VM export were checked.
Both installers passed resource/structure and relevant signing-compatibility checks.
This round did not include physical-phone testing, a fresh native Mac build, or complete end-to-end acceptance of every MOD feature.

The historical candidate73 APK, IPA, and SHA-256 checksums remain available through [GitHub Releases](https://github.com/ArkinTide/NTTE-Mobile-Port/releases/tag/candidate73).
Before upload, both installer hashes were checked against the candidate73 delivery record.
Personal logs and build artifacts are excluded from the Git source tree.
