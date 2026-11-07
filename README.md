# Nuclear Throne: NTTE + Uncharted Frontier — Mobile Port

[简体中文](README.md) | [English](README.en.md)

NTTE 与 **Uncharted Frontier（NTUF）1.0.3.3** 的 Android／iOS 移植源码，
保留 Undergrowth、Details+ 和简体中文。当前版本 **2.0.2**，内部构建 **98**。

从 [MEGA 下载文件夹](https://mega.nz/folder/PfIDSaSZ#ZcRokP34or9J0JofsIgrEA) 获取 APK／IPA，并核对同目录的
`SHA256SUMS-NTTE-NTUF-2.0.2.txt`。GitHub 仅分发文本源码及版本说明；
iOS 安装包需要重新签名。见 [2.0.2 说明](docs/RELEASE-2.0.2.md)。

## 2.0.2 — 天气、移动陷阱和 NTUF 界面修复

当前重新编译的最终 Windows VM／输入通过 32 项明确列出的原生专项，
另有 118 项 Python 检查日志经哈希核验。旧 VM 的通过数不计入本次验收。
具体场景和结果见[本次验证摘要](docs/validation/2.0.2-development-regression.json)。

本轮修复极光读取背景色报错、天气兼容开销、风暴王冠锁定图标、宫殿移动陷阱、
Bubbles 无效存档起始武器、墙上大苍蝇落地、统计／鸣谢布局、自定义 NTUF 武器分类和 goto 区域名称。

Android versionCode 3000098，保留应用标识和签名，并核验 16KB 布局；
iOS build 98 需要重新签名。iOS 使用新编译游戏数据及保留的原生 Runner，
没有新的 Mac 原生编译。GAME_BUILD／存档协议仍为 3004。

持续低频／爆音仍未归因。后台静音桌面测试不能证明手机混音或帧率；
未进行 Android／iOS 真机、完整随机战役或所有设备帧率验收。

## 源码与构建

`project/` 是验收后的共用源码，`platforms/android/` 保存 Android 文本覆盖，
`frontier20/` 保存适配、离线依赖、汉化和原作者文本参考。图片、音频、字体、
图标、商业 Runner、预编译扩展和安装包不进入 Git，须另从作者或授权来源取得。
见[构建说明](docs/BUILDING.md)、[源码规则](docs/SOURCE_ONLY.md)和
[参考源码恢复](frontier20/SOURCE_REPRODUCTION.md)。

保留[许可证](LICENSE)和[第三方鸣谢](THIRD_PARTY_NOTICES.md)。本项目是非官方移植。
历史版本：[2.0.1](docs/RELEASE-2.0.1.md)、[2.0.0](docs/RELEASE-2.0.0.md)。
