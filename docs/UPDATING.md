# 游戏更新

[简体中文](UPDATING.md) | [English](UPDATING.en.md) | [首页](../README.md)

## 玩家使用

启动后进入主菜单约5秒会自动检查一次最新正式版本；也可使用 **设置 → NT:TE → 版本更新**。断网、超时或限流不会阻止启动，战斗时不自动弹出提示。

从 1.0.2 或更早版本升级到 1.0.3，需要手动下载并覆盖安装一次：旧更新器只识别历史 candidate 标签。1.0.3 起恢复按正式版本号检查后续更新。不要先卸载，以免丢失存档。

- Android：在游戏内下载APK，校验大小、SHA-256、包名和签名，然后打开系统安装确认；需要时允许本应用安装未知来源应用。下载缓存仅在应用私有目录。
- iOS：打开对应IPA下载链接，仍需用自己的签名身份重新签名后安装。

## 版本及发布策略

当前版本 **1.2.0**；附加 MOD 系列后续修复递增为 1.2.1、1.2.2。1.0.4 及后续 1.0.x 保留原 NTTE 内容。公开标签和文件名只使用正式版本号。

1. 同步修改 `NTTE_RELEASE_VERSION`、`NTTE_RELEASE_TAG`、游戏版本和平台显示版本；`NTTE_RELEASE_NUMBER`作为内部构建序号递增。下一版为版本 1.2.1、内部序号 86。`GAME_BUILD`用于存档格式，不随发布修改。
2. 编译、测试并审核两平台安装包。Android包名及签名身份保持一致；versionCode本版为3000085。iOS CFBundleVersion本版为85。后续两个数值均递增。
3. 创建同名标签的草稿Release，上传 `NuclearThrone.TerritorialExpansion-Android-1.2.0.apk`、`NuclearThrone.TerritorialExpansion-iOS-1.2.0.ipa` 和SHA256SUMS.txt；核验远端摘要后公开并设为Latest。下一版替换文件名中的版本号。
4. 更新双语README、验证记录和发布说明，注明iOS签名要求。

更新器读取本仓库 `releases/latest` API，只接受正式发布，逐段比较三个数字，拒绝降级、跨仓库地址、标签与文件名不匹配及无效摘要。旧candidate标签只可能被识别为历史版本，不会提供升级。缺少某平台安装包时该平台提示尚未上传，不会下载另一平台文件。

原生Android下载器位于 `project/extensions/YYExtra/AndroidSource/`。构建需包含Java实现、`res/xml/ntte_update_paths.xml`、REQUEST_INSTALL_PACKAGES权限及FileProvider声明；authority为 `<包名>.ntteupdates`。更新保留系统安装确认。
