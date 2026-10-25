# Nuclear Throne :Territorial Expansion — Mobile Port

[简体中文](README.md) | [English](README.en.md)

NTTE 移植版的 GameMaker 源码，包含 Android、iOS 适配和简体中文。
当前源码基线为 **candidate74（2026-10-25）**。

## 下载安装包

最后交付的 Android APK 和 iOS IPA 可在 [candidate74 发布页](https://github.com/ArkinTide/NTTE-Mobile-Port/releases/tag/candidate74) 下载：

- [Android APK](https://github.com/ArkinTide/NTTE-Mobile-Port/releases/download/candidate74/NuclearThrone.TerritorialExpansion-Android-crashfix-candidate74.apk)
- [iOS IPA](https://github.com/ArkinTide/NTTE-Mobile-Port/releases/download/candidate74/NuclearThrone.TerritorialExpansion-iOS-crashfix-candidate74.ipa)：安装前需要用自己的签名身份重新签名。
- [SHA-256 校验文件](https://github.com/ArkinTide/NTTE-Mobile-Port/releases/download/candidate74/SHA256SUMS.txt)

两平台使用独立标识 `com.arkintide.nuclearthronentte`。本轮验证范围见[验证记录](docs/VALIDATION.md)。
安装包作为 Releases 附件提供；Git 源码目录不包含安装包、签名密钥或个人存档。

## 游戏内更新

从 candidate74 开始，启动后会自动检查本仓库的最新正式版本，也可在 **设置 → NT:TE → 版本更新** 中手动检查或关闭自动检查。
Android 支持在游戏内下载、校验 APK 并打开系统安装确认；iOS 打开 IPA 下载链接，安装前仍需签名。
旧版需要先手动安装一次包含更新功能的版本。详见[更新使用与发布说明](docs/UPDATING.md)。

## 项目结构

- `project/`：共用 GameMaker 工程、NTTE 实现、触控/手柄输入和游戏内回归测试。
- `platforms/android/project/`：相对于共用工程的 Android 专用文件。
- `platforms/android/runner.patch`：针对 GameMaker 官方 Android Runner 的源代码差异。
- `tools/prepare_project.py`：准备独立的 Android/iOS/Windows 构建目录。
- `docs/BUILDING.md`：构建环境、原游戏素材提取和平台注意事项。
- `docs/VALIDATION.md`：本次验证范围与限制。
- `docs/LOCALIZATION.json`：现有汉化对照数据（candidate70 时导出）。

源码基于 NuclearThroneMobile:Epsilon，并将 NTTE MOD 内容适配为 GameMaker 原生实现。
保留上游 GPL-3.0 许可及第三方声明，参见 `LICENSE`、`THIRD_PARTY_NOTICES.md`。
这是非官方移植，与 Vlambeer 无隶属关系。

原游戏的受排除素材没有放进 Git 源码目录。构建前需要从自己的 Nuclear Throne 副本提取素材。
源码目录也不包含 GameMaker 商业运行库、签名证书、个人存档、SDK 和构建缓存。

## 开始构建

1. 安装 GameMaker LTS 和对应平台工具链；当前验证运行时为 `2026.0.0.23`。
2. 用 `python tools/prepare_project.py --platform android`（或 `ios`、`windows`）准备构建目录。
3. 在生成目录中按 `docs/BUILDING.md` 提取素材，再打开 `.yyp`。
4. 为自己的设备、签名身份和导出环境设置构建选项。

## 鸣谢

Original game by Vlambeer  
Android original version by toncho_  
Nuclear Throne Epsilon by kcd-shichen  
iOS port by ArkinTide

特殊感谢：kuzumi、Golden vegetable、Dinosaur leader。
另感谢原 NTTE MOD 作者、贡献者以及百科全书作者 ToD。
原 NTTE 工程：[Yokinman/NTTE](https://github.com/Yokinman/NTTE)。

上游工程：<https://github.com/kcd-shichen/NuclearThrone-Recreated-Epsilon>  
原 NTM 工程：<https://github.com/toarch7/nt-recreated-public>
