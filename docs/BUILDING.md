# 构建说明

## 环境与素材

当前交付使用 GameMaker LTS runtime `2026.0.0.23`，VM 目标。
需要你自己的 GameMaker 安装、平台导出权限及 Nuclear Throne 副本。
Node.js 20+ 用于上游素材提取脚本，Python 3 用于工程准备。

先运行：

```sh
python tools/prepare_project.py --platform android
```

将 `android` 换成 `ios` 或 `windows` 可以准备其他平台。
输出目录为 `.local/<platform>/project`；这份可变构建副本不会提交到 Git。
然后进入输出工程的 `node-scripts` 目录执行：

```sh
npm ci
npm run regen -- --game-path="/path/to/your/Nuclear Throne"
```

提取程序默认寻找 Steam 目录，也支持上面的显式路径。不要使用 `--force`
覆盖 NTTE 自定义美术；升级原版素材前应先备份并核对差异。
上游提取脚本、资源声明和素材忽略规则均保留在工程中。

## Android

准备工程时会先复制共用工程，再应用 `platforms/android/project` 的专用覆盖文件。
支持的 ABI 为 arm64-v8a / armeabi-v7a，包名为 `com.arkintide.nuclearthronentte`。
在 GameMaker 中配置自己的 Android SDK、NDK、JDK 和签名密钥。
请勿提交 keystore、密码或本地 SDK 配置。

现有交付还包含官方 Runner 的手柄输入队列/热插拔、渲染线程调度、
音量键等原生适配。`platforms/android/runner.patch` 是针对上述版本 Runner
的差异，应用目标是包名已替换为 `com.arkintide.nuclearthronentte` 的 Java 源码树。
在构建本地 Runner 前先用 `git apply --check` 检查该补丁；其他 runtime
版本需要人工合并。单独重新导出 GameMaker 工程不会自动应用这些原生修改。

## iOS

在 Mac 上配置 GameMaker/Xcode、iOS SDK 和自己的开发者签名，然后从准备好的
工程导出完整 Xcode 工程。设置独立 Bundle ID `com.arkintide.nuclearthronentte`。
需要“文件”应用访问时启用 `UIFileSharingEnabled` 和
`LSSupportsOpeningDocumentsInPlace`。横屏，保持像素画的采样设置。

GameMaker 当前 `.yy` 导出模板仍可能带上游占位 Bundle Name，不能直接用作最终
签名标识；应在 GameMaker/Xcode 中设为上述 Bundle ID。商业 Runner 不包含在源码中。
之前交付的 IPA 使用已在设备上启动过的保留 Runner 与本轮新编译 VM 数据组合。
此仓库尚未验证“从全新 Mac 环境原生重建等价 IPA”的整条流程，不能把旧 IPA
打包校验视为新 Xcode 编译或真机验收。

## Windows 与测试

在 GameMaker 中打开准备好的 `.yyp`，选择 Windows VM 构建。
内部测试由 `--ntte-full-smoke` 显式开启，普通启动不会激活。
还需同时传入现有基础 smoke 启动参数，入口见 `scrNTTESmoke` / `scrNTTEFullSmoke`。
本仓库不附带编译器、授权文件、平台证书或已编译运行库。
