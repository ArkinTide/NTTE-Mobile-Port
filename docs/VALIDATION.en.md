# Validation notes

[简体中文](VALIDATION.md) | [English](VALIDATION.en.md) | [Home](../README.en.md)

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
