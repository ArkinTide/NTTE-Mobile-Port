# 验证记录

[简体中文](VALIDATION.md) | [English](VALIDATION.en.md) | [返回首页](../README.md)

candidate73 的下列 10 项 Windows VM 回归均在 30/60 帧通过：

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

修复了水晶友军延迟弹幕缺少 accuracy 属性的报错；同一只非 Boss 连续作为最后一只敌人超过 60 秒后设为零血量并走正常死亡流程。暂停不计时，出现其他敌人、目标变化/变友方及换关会重置。

Android 共用源码和 iOS VM 导出已核对。两种安装包已通过资源/结构和对应签名兼容性检查。本轮尚未进行手机实测、全新 Mac 原生构建或完整 MOD 全流程验收。

最后交付的 candidate73 APK、IPA 及 SHA-256 校验文件通过 [GitHub Releases](https://github.com/ArkinTide/NTTE-Mobile-Port/releases/tag/candidate73) 提供。上传前已核对它们与 candidate73 交付记录的哈希一致。Git 源码目录不包含个人日志和构建产物。
