# Nuclear Throne :Territorial Expansion — Mobile Port

[简体中文](README.md) | [English](README.en.md)

NTTE 移植版的 GameMaker 源码，包含 Android、iOS 适配和简体中文。
当前源码基线为 **1.2.1（2026-10-26）**。

## 纯源码发布

本仓库仅提供程序源码、工程资源声明、配置、汉化文本和文档，不包含任何游戏图片、贴图、音频、字体、图标、第三方二进制库或已编译游戏数据。原游戏、NTTE、Undergrowth、Details+ 及移植专用美术也全部排除。

2026-10-26 已清理公开分支与所有标签的历史，并加入素材忽略规则和发布前审核。历史提交哈希已改变，已有克隆请重新克隆。素材仍由各自作者保有权利，构建时须自行从合法来源取得；详见[构建说明](docs/BUILDING.md)和[源码分发规则](docs/SOURCE_ONLY.md)。

## 下载安装包

安装包统一从 [MEGA 下载文件夹](https://mega.nz/folder/PfIDSaSZ#ZcRokP34or9J0JofsIgrEA) 获取。GitHub Releases 仅发布版本说明和不含素材的文本源码，不再附带 APK、IPA 或游戏资产。

Android 请覆盖安装以保留存档；iOS IPA 需先使用自己的签名身份重新签名。当前版本和验证范围见 [发布页](https://github.com/ArkinTide/NTTE-Mobile-Port/releases/latest)及[验证记录](docs/VALIDATION.md)。

1.2.0 及更早版本需手动从上述链接获取更新；1.2.1 起游戏内“下载更新”会打开该文件夹。


> 从 1.1.0 更新开始，将会加入一些别的 MOD 的内容。想要玩到原版 NTTE，请下载 1.0.4 以及后续 1.0.x 版本。

## 1.2.1 更新内容

- 修复 Undergrowth 猪笼草治疗触发未定义 `FrogHeal` 的崩溃，并补齐巨型榴弹反弹的原生近战依赖。
- 修复 NTTE 黄金武器随过关重建状态后反复提示保存；仅在持久武器组成真正改变时保存并通知。
- Details+ 静态新增装饰采用独立图集和顶点批次绘制；保留装饰数量、图案、分帧与顺序，关闭开关或清理关卡时释放批次。
- 核弹/破墙只刷新爆点附近的墙体，保留原有伤害、特效、墙体形状和随机序列。
- 修复披萨下水道电视旁老鼠被后生成墙体或推挤卡住的路径，使用无伤害的位置恢复。
- 检查猫井盖的完整地板范围及墙体碰撞，出井前重新确认位置；地图外、后生成墙体覆盖和原地板消失时寻找可站立位置，不增加墙内杀怪机制。
- 游戏内继续通过 GitHub 检查版本；下载更新改为打开固定 MEGA 文件夹，适配不附带安装包的发布方式。

## 1.2.0 更新内容

- 整合 Details+ 1.1：增加地面装饰聚簇、分地板爆炸焦痕、王冠雕像及碎裂装饰、沙漠泥地与绿洲地板过渡。
- 新增 **设置 → 视频 → DETAILS+ 细节增强** 开关，默认开启并保存选择；关闭会移除新增装饰并恢复原贴图，随时可以重新开启。
- 保留原 MOD 的 40 张精灵资源（76 帧）；适配 NTTE 海滩、海沟和绿洲区域编号。
- 装饰在关卡生成或开关变化时应用，焦痕在创建时匹配，避免每帧扫描所有焦痕；反复开关不累积装饰，并保留战斗随机序列。
- Android/iOS 同步为 1.2.0；保留 Undergrowth 及先前修复，统一游戏内版本与更新器显示。

Details+: [https://wigglercola.itch.io/detailsplus](https://wigglercola.itch.io/detailsplus)

## 1.1.0 更新内容

- 整合 Undergrowth v1.0.3：新增隐藏区域、敌人、场景物件、原作贴图、光效和音乐。
- 在废车场 3-3 箱子附近保留藤蔓入口；先开箱会关闭入口。通过新区域后返回丛林。
- 加入循环中的捕蝇草、马陆和黄金猪笼草，以及五把武器：化石手枪、化石枪、化石加农炮、化石锤、巨型榴弹发射器。
- 新内容提供简体中文；其他语言显示英文。补齐所需中文字形，并适配融合武器及旧版续关中的武器编号。
- Android/iOS 同步更新为 1.1.0，保留 1.0.4 的披萨下水道墙外阴影修复。

Undergrowth: [https://attfooy.itch.io/undergrowth](https://attfooy.itch.io/undergrowth)

## 1.0.4 更新内容

- 进一步修复披萨下水道墙角、地板边缘和炸开地面附近的墙外黑影。
- 墙体阴影只绘制在真实地板范围内，保留地板上的阴影和角色、怪物、道具阴影；不修改墙体碰撞、敌人或传送门规则。
- Android 和 iOS 同步此修复，版本更新为 1.0.4。

## 1.0.3 更新内容

- 修复披萨下水道大猫的长条毒气预警线被地板遮盖。
- 修复鳄鱼雕像赐福文字未初始化引起的 PopupText 报错。
- 按原 MOD 补齐进入隐藏区域的武器保障：2-1 武器掉落可提供爆炸武器，3-1 保留首箱后的螺丝刀保障。
- 修复披萨下水道守候小怪生成在墙外及外侧虚空阴影；保留正常墙上敌人，不增加墙内击杀机制。
- 补齐动态、嵌套融合武器的中文名称；使用“砰砰枪”和“砰砰步枪”。
- 修复披萨下水道家具受击后持续变白。
- 修复秘密组件进入普通随机融合掉落和沙漠插墙武器池，保留隐藏地点和合法解密合成。
- 修复新循环开头路线图被跨循环连线整体染黄。
- 更新器改用正式版本标签和文件名，按主版本、次版本、修订号比较版本。

从 1.0.2 或更早版本升级到 1.0.3，需要手动下载并覆盖安装一次：旧更新器只识别历史 candidate 标签。1.0.3 起恢复按正式版本号检查后续更新。不要先卸载，以免丢失存档。

## 1.0.2 更新内容

- 修复加载路线图遇到无效角色皮肤图标时的崩溃，回退显示该角色的默认图标。
- 修复稻草人未被打碎或未成功召唤大匪时误播 Boss 胜利音乐；召唤失败会保留事件并重试。
- 去掉鹦鹉宠物停在大海螺等对象上时盖在宿主身上的黑色阴影条，保留落地阴影。
- 修复启动主界面已发现新版却不弹出更新提示的问题，并修复该界面上的 Android 下载完成安装交接。
- 修复海豹王出场后仍播放关卡音乐的问题。
- 按原 MOD 条件切换幽灵蛸的出场前与战斗音乐，重复出场回调不再重启正在播放的曲目或前奏。
- 修复选人界面收起武器栏后仍显示普通武器的问题，正确预览已选择的 NTTE 黄金武器及黄金融合武器。

## 1.0.1 更新内容

- 修复选择变异时反复重选、跳过关卡的问题：传送门恢复逻辑和已排队的尸体回调只在有效战斗阶段运行。
- 修复重启游戏后语言回到英文：语言选项立即保存，练习模式/控制台保存也保留语言；重新载入语言表后恢复玩家选择。
- 保留“同一只非 Boss 连续作为最后一只敌人超过 60 秒才清除”的规则及正常空场传送门恢复。

## 1.0.0 更新内容

- 修复气泡融合武器首次使用、乌鸦起飞/落地的报错。
- 修复沙漠、丛林飞行/潜伏敌人及空场传送门相关卡关路径。
- 保留“同一只非 Boss 连续作为最后一只敌人超过 60 秒才清除”的规则；暂停不计时，换目标或出现其他敌人重新计时，墙内位置不作为清除依据。
- 闪电水晶在绿洲、海沟的待机与攻击闪电不再造成全水域伤害；局部闪电伤害及普通武器导电保留。
- 版本号正式定为 **1.0.0**。此后每次修复更新递增 **0.0.1**，下一版为 **1.0.1**。

## 游戏内更新

启动后会自动检查本仓库的最新正式版本，也可在 **设置 → NT:TE → 版本更新** 中手动检查或关闭自动检查。
1.2.1 起，Android 和 iOS 的“下载更新”均打开固定 MEGA 文件夹。Android 下载后覆盖安装；iOS 安装前仍需签名。
从 1.0.2 或更早版本升级到 1.0.3，需要手动下载并覆盖安装一次：旧更新器只识别历史 candidate 标签。1.0.3 起恢复按正式版本号检查后续更新。不要先卸载，以免丢失存档。详见[更新使用与发布说明](docs/UPDATING.md)。

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

Undergrowth — matt / attfooy: [https://attfooy.itch.io/undergrowth](https://attfooy.itch.io/undergrowth)

Details+ — wigglercola: [https://wigglercola.itch.io/detailsplus](https://wigglercola.itch.io/detailsplus)
