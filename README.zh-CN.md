# Nuclear Throne: NTTE + Uncharted Frontier — Mobile Port

[简体中文](README.md) | [English](README.en.md)

NTTE 与 **Uncharted Frontier（NTUF）1.0.3.3** 的 Android／iOS 移植源码，
保留 Undergrowth、Details+ 和简体中文适配。当前版本 **2.0.1**，内部构建 **97**。

## 下载

从 [MEGA 下载文件夹](https://mega.nz/folder/PfIDSaSZ#ZcRokP34or9J0JofsIgrEA) 获取 APK／IPA，核对同目录的
`SHA256SUMS-NTTE-NTUF-2.0.1.txt`。GitHub 仅分发纯文本源码及版本说明。
Android 保留应用标识与签名；iOS 需要自行重新签名。
见 [2.0.1 说明](docs/RELEASE-2.0.1.md)。

## 2.0.1 修复

- 修复重试、选人、返回主菜单时内容注册表及回调生命周期导致的崩溃。
- 加固原初箱子的融合武器持久化，保留组成和物理状态，防止旧数字句柄冒充武器。
- 修复小鱼泡泡 Ultra 错误处理同队弹幕，并统一凶恶面容的初始化／复活路径。
- 保留墙体、天气、交互和汉化适配；补齐汉化 TSV 原始输入。

最终新 VM 通过 **14 项原生专项**，Python **112 项检查**日志已核验。
Bubbles 两皮肤 30／60 帧完成实际死亡重试和真实触摸攻击伤害验证；
完整范围、不同 VM 的历史证据和限制见[验证记录](docs/VALIDATION.md)。
手机持续杂音仍未归因。未进行 Android／iOS 真机或完整随机战役验收，
不能承诺所有手机帧率；已丢失组成的旧融合武器存档也无法凭空恢复。

## 源码与构建

`project/` 是已验收共用源码，`platforms/android/` 保存两项 Android 文本覆盖，
`frontier20/` 保存适配、离线依赖、汉化和原作者文本参考。图片、音频、字体、图标、
商业 Runner、预编译扩展和安装包均不进入 Git，须从作者或授权来源另行取得。
参见[构建说明](docs/BUILDING.md)、[源码规则](docs/SOURCE_ONLY.md)和
[参考源码恢复](frontier20/SOURCE_REPRODUCTION.md)。

保留[许可证](LICENSE)和[第三方鸣谢](THIRD_PARTY_NOTICES.md)。本项目是非官方移植。
原作与模组：[NTTE](https://github.com/Yokinman/NTTE) ·
[Uncharted Frontier](https://wigglercola.itch.io/uncharted-frontier) ·
[Undergrowth](https://attfooy.itch.io/undergrowth) · [Details+](https://wigglercola.itch.io/detailsplus)

## 历史版本

[2.0.0 发布记录](docs/RELEASE-2.0.0.md)保留当时构建及测试范围。
