# 游戏更新

[简体中文](UPDATING.md) | [English](UPDATING.en.md) | [首页](../README.md)

## 玩家使用

从 candidate74 开始，游戏默认会在启动后进入主菜单时自动检查一次本仓库的最新正式 Release。
设置入口为 **设置 → NT:TE → 版本更新**，可关闭自动检查或手动检查、下载更新。
断网、超时或 GitHub 限流不会阻止启动；进行游戏时不会自动弹出更新对话框。

- **Android**：确认更新后在游戏内下载 APK，显示进度，支持取消和重新下载。下载完成后校验文件大小、SHA-256、包名及签名，再打开 Android 系统安装界面。首次可能需要允许本应用安装未知来源应用。由玩家确认覆盖安装，保留原有应用数据；不要先卸载旧版。
- **iOS**：确认更新后打开对应 IPA 的下载链接。侧载版本仍需使用自己的签名身份重新签名后安装。

尚未包含此功能的旧版，需要先手动安装 candidate74 或后续版本一次。
Android 下载器使用应用私有缓存，不需要为更新授予所有文件访问权限。

## 正式版本号策略

当前正式版为 **1.0.2**（内部构建 `candidate77`）。每次后续修复发布增加 **0.0.1**：`1.0.3`、`1.0.4`……，并同步更新游戏内版本、Android versionName 和 iOS CFBundleShortVersionString。

为兼容已安装的 candidate74 更新器，GitHub Release 标签及安装包后缀继续使用递增的 `candidateN`；Release 标题填写正式版本号（本版 `1.0.2`），新版游戏会显示该标题。可附加同提交的 `v1.0.2` Git 标签；不要另建缺少安装包的 Latest Release。

本版 Android versionCode 为 `3000077`，后续必须递增，不能采用较低的自动生成值；iOS CFBundleVersion 为 `77`，后续也递增。`GAME_BUILD` 只用于存档格式，保持不变。

## 发布新版本

1. 将 `project/scripts/scrNTTEUpdate/scrNTTEUpdate.gml` 中的 `NTTE_RELEASE_VERSION` 按上述规则递增，并将 `NTTE_RELEASE_NUMBER` 和 `NTTE_RELEASE_TAG` 一起递增；例如下一版为 `1.0.3`、`78` 与 `candidate78`。不要为此改动用于存档格式的 `GAME_BUILD`。
2. 编译并验证两平台的新安装包，Android 保持相同包名及签名身份，版本号不能降低。
3. 创建对应标签的正式 GitHub Release，并将其标记为 Latest。更新器读取 `https://api.github.com/repos/ArkinTide/NTTE-Mobile-Port/releases/latest`；草稿和预发布版本不会作为正式更新。
4. 上传安装包，再公开发布。文件名采用 `NuclearThrone.TerritorialExpansion-Android-<说明>-candidate77.apk` 和 `NuclearThrone.TerritorialExpansion-iOS-<说明>-candidate77.ipa`。GitHub 返回的 Android asset `digest` 必须包含 SHA-256（正常上传会自动提供）。
5. 在发布说明中写明改动及 iOS 签名要求，附上 SHA-256 校验文件。

更新器按数字比较 candidate 版本，拒绝降级及其他仓库的下载地址。缺少某平台安装包时，该平台不会提示下载其他平台的文件。每次启动自动检查一次，手动检查有冷却时间；收到限流响应后延长重试间隔。

Android 原生部分位于 `project/extensions/YYExtra/AndroidSource/`。重新构建时需要包含新增 Java 文件、`res/xml/ntte_update_paths.xml`、`REQUEST_INSTALL_PACKAGES` 权限以及扩展描述中的 FileProvider 声明。修改独立应用标识时也要同步修改 provider authority，保持为 `<包名>.ntteupdates`。更新仍需系统安装确认，不使用静默安装或动态代码替换。
