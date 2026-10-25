# Nuclear Throne :Territorial Expansion — Mobile Port

NTTE 移植版的 GameMaker 源码，包含 Android、iOS 适配和简体中文。
当前源码基线为 **candidate73（2026-10-25）**。

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

原游戏的受排除素材没有放进仓库。构建前需要从自己的 Nuclear Throne 副本提取素材。
本仓库也不包含 GameMaker 商业运行库、签名证书、个人存档、SDK 和构建缓存。

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

上游工程：<https://github.com/kcd-shichen/NuclearThrone-Recreated-Epsilon>  
原 NTM 工程：<https://github.com/toarch7/nt-recreated-public>
