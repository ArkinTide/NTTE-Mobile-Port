# 验证记录

[简体中文](VALIDATION.md) | [English](VALIDATION.en.md) | [返回首页](../README.md)

## 1.0.0（candidate75）

9 项选定的 Windows VM 测试均在 30/60 帧通过：`CrystalWaterLightningTests`、`RavenLiftTargetTests`、`BubbleMergeColdStartTests`、`LastEnemyHiddenTimeoutTests`、`LastEnemyTimeoutNativeTests`、`UpdateCheckTests`、`MergedLightningUnitTests`、`BubbleWeaponTests`、`MenuNativeTests`。

沙漠/丛林测试覆盖实际飞行乌鸦、潜伏刺客、零血量残留、完整一分钟阈值、暂停、正常死亡/掉落/尸体回调，以及无友军、无尸体空场的原生传送门重试。Boss 和通用生成过渡不清除；没有基于墙体位置的清除机制。闪电测试覆盖绿洲/海沟水晶待机与攻击闪电的原生事件及子段，同时检查普通武器导电保留。

Android 原生更新策略 20 项检查通过；最终 APK 签名、16 KB ZIP 对齐、更新安装入口、版本与包名均已核对。iOS VM 导出、保留运行库注册兼容性、Payload 及版本检查通过。本轮改动的编译代码与两平台最终安装包逐函数比对通过。

安装包见 [1.0.0 发布页](https://github.com/ArkinTide/NTTE-Mobile-Port/releases/tag/candidate75)。这些是针对性自动回归，尚无本轮 Android/iPhone 真机验收，也未进行全新 Mac 原生编译或完整 MOD 全流程验收。

## candidate74：更新功能

- `UpdateCheckTests`、`MenuNativeTests`、`MenuReminderPersistenceNativeTests` 在 Windows VM 30/60 帧下通过。
- Android 原生更新模块编译通过；20 项 Java 策略测试覆盖流式下载、长度与 SHA-256 校验、文件损坏、取消及 URL/重定向规则。
- 更新模块 84 个汉字均在现有正文字体中。iOS VM 导出和保留运行库的函数注册兼容性检查通过。
- 本轮没有 Android/iPhone 真机下载或覆盖安装实测，也未进行全新 Mac 原生构建；系统安装授权和侧载签名仍需设备端操作。

candidate74 APK、IPA 和 SHA-256 校验文件见 [发布页](https://github.com/ArkinTide/NTTE-Mobile-Port/releases/tag/candidate74)。最终包中的更新逻辑与编译输出已逐函数核对；Android 安装权限、受限 FileProvider 路径、签名和 16 KB ZIP 对齐检查通过。

## candidate73：之前的修复基线

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

历史 candidate73 APK、IPA 及 SHA-256 校验文件通过 [GitHub Releases](https://github.com/ArkinTide/NTTE-Mobile-Port/releases/tag/candidate73) 提供。上传前已核对它们与 candidate73 交付记录的哈希一致。Git 源码目录不包含个人日志和构建产物。
