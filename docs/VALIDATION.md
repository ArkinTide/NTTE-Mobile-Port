# 验证记录

[简体中文](VALIDATION.md) | [English](VALIDATION.en.md) | [返回首页](../README.md)

## 1.2.2

32 项选定 Windows VM 回归在最终 1.2.2 / 内部 90 冻结构建的 30/60 帧下通过。覆盖藤蔓武器箱、3-3 入口清场守卫、马陆自然退场、丛林刺客、尸体倒计时、真实 Undergrowth 连续路线，以及水晶蜘蛛真实墙体生成、破墙出现、拾取、JSON 续关和两次真实传送门跨关。还复查了更新器、语言持久化、Details+、黄金武器保存、治疗/爆炸及披萨生成路径。

Android 更新器通过 31 项 Java 检查；APK/IPA 通过版本、包标识、编译函数和结构校验，Android 保留原签名并通过 16 KB 对齐检查。GAME_BUILD 3004 保持。未进行手机真机、完整战役或新 Mac 原生编译验收；iOS 使用新 VM 数据和保留 runner，需自行重签。

## 1.2.1

15 项选定 Windows VM 回归在实际 30/60 帧通过。覆盖猪笼草真实治疗/爆炸与特效生命周期，三种 NTTE 黄金武器的真实写盘重载，Details+ 批次和独立回退相对于原生精灵绘制的严格像素一致性，以及真实核弹和独立原版破墙实现的几何/RNG对照。披萨测试覆盖晚生成墙、不可见墙、中立老鼠转换和16组真实生成；猫井盖测试覆盖地图外/晚生成墙和真实披萨至巢穴入口生成（两档各19个井盖）。

最终构建另覆盖固定 MEGA 下载页解析、提示及确认/取消流程。更早的内部构建87另有37项30/60回归记录，不能混作最终构建结果。

Android 更新器通过 31 项 Java 检查。两平台安装包通过版本、签名、结构及编译函数保留审核；内部构建序号89。电脑计时显示相关 CPU 开销下降，不代表手机实测帧数。未进行手机真机验收、完整战役或新 Mac 原生重建。iOS 使用新VM数据和保留runner，需重新签名。

## 1.2.0

26 项选定 Windows VM 测试在 30/60 帧通过。Details+ 覆盖原生视频开关、普通及练习/控制台模式的真实写盘重载、开关后的贴图恢复、重复应用的数量上限、地板/焦痕对应、六区域雕像销毁/尸体生命周期、几何数量与游戏随机种子保留，以及开启/关闭的离屏绘制截图。40 张精灵的 76 帧逐像素核对了源图、分帧、尺寸和原点。

回归还包括实际关卡地形、自然王冠雕像入口、Undergrowth 新内容与路线、披萨阴影、菜单、融合武器、更新器和最后敌人规则。Android 更新器通过 31 项 Java 检查。安装包通过冻结源码绑定、版本、签名、结构及 Details+/Undergrowth 编译函数保留审核。Android versionCode 3000085，iOS CFBundleVersion 85。

未进行手机真机验收、新 Mac 原生构建或完整战役验收。iOS 使用新编译 VM 数据与保留 runner，安装前需重新签名。[下载](https://github.com/ArkinTide/NTTE-Mobile-Port/releases/tag/1.2.0)。


## 1.1.0

21 项选定 Windows VM 测试在 30/60 帧通过，包括新增实体/武器/地形、双向融合、原生碰撞及销毁回调、1.0.x 续关编号迁移、自然 3-3 入口→新区域→丛林路线、10 秒战斗观察、先开箱关闭入口和 Last Wish 返还。保留披萨阴影像素回归、菜单汉化、掉落池、更新器与相关续关验证。

Android 下载器通过 31 项 Java 检查。两端安装包经过源码冻结绑定、版本/签名/结构及编译函数保留审核。Android versionCode 3000083，iOS CFBundleVersion 83。

未完成手机真机验收或新 Mac 原生构建；测试不代表完整战役验收。iOS 使用新编译 VM 数据及保留的原生 runner，安装前需重新签名。[下载](https://github.com/ArkinTide/NTTE-Mobile-Port/releases/tag/1.1.0)。


## 1.0.4

9 项选定 Windows VM 测试在 30/60 帧通过：`PizzaShadow104Tests`, `PizzaShadow104NaturalTests`, `PizzaShadow78Tests`, `OptionalShadowNativeTests`, `IOSShadowPresentTests`, `TopShadowNativeDrawTests`, `SewerPizzaNaturalEntryTests`, `UpdateCheckTests`, `UpdateStartupMenuTests`。

新增像素回归覆盖六种完整地板、炸开地面、墙角和无地板情况。使用未裁剪的原始阴影作为负对照，逐像素确认墙外无阴影、地板上的阴影保留，并比较角色阴影完全一致。三个真实披萨关卡种子在两档帧率下检查完整阴影表面，并调用原生墙侧面、墙顶绘制链路检查无报错。另验证 iOS 阴影兼容路径、正常可选阴影、墙顶阴影，以及真实下水道进入披萨关卡和更新提示。

共享修复已同步 Android。Android 原生下载策略通过 31 项 Java 检查；两平台包经编译函数保留、版本、结构和签名审核。Android versionCode 3000081，iOS CFBundleVersion 81；游戏版本为 1.0.4。

未进行手机真机验收或新的 Mac 原生编译。iOS 使用新编译的 VM 数据和保留运行库，安装前需要重新签名。[下载](https://github.com/ArkinTide/NTTE-Mobile-Port/releases/tag/1.0.4)。


## 1.0.3

19项选定Windows VM回归在30/60帧通过：`CatWarning78Tests`, `GatorStatueNativeTests`, `SecretWeapon78Tests`, `PizzaSpawn78Tests`, `PizzaShadow78Tests`, `MergedChinese78Tests`, `PizzaPropHurt78Tests`, `QuestDrop78Tests`, `RoadmapLoop78Tests`, `RoadmapNativeTests`, `RoadmapPlayerIconsTests`, `ChestDropNativeTests`, `InitialChestsNativeTests`, `BeetleMenuTests`, `Followup69PresentationNativeTests`, `OptionalShadowNativeTests`, `UpdateCheckTests`, `UpdateStartupMenuTests`, `SewerPizzaNaturalEntryTests`。

测试覆盖真实预警线/阴影/融合名称绘制像素、字形范围、雕像赐福回调、原生箱子与拾取碰撞顺序、箱子预览回滚、16个真实披萨关卡生成、家具受击动画、秘密组件掉落排除和循环1/2路线图。实际Sewer→Pizza流程通过原生开火、爆炸、传送门碰撞、房间重启及目标关卡绘制。原测试只沿一条直线寻找发射位置，在修复前后均会于60帧拒绝同一种子；本次仅扩大测试的自然发射角度搜索，未改变游戏地形或放宽进入目标的断言，原失败记录保留。

正式版本比较及启动提示经实际VM流程检查；原生Android下载策略重新通过31项Java检查，涵盖版本/地址校验及流式哈希、截断、损坏、取消。Android共享源码已同步。最终安装包通过编译函数保留、版本、签名和结构审核；Android签名身份保留并验证16KB ZIP对齐。iOS使用新编译VM数据和已验证保留运行库，需重新签名。

安装包：[1.0.3发布页](https://github.com/ArkinTide/NTTE-Mobile-Port/releases/tag/1.0.3)。未进行Android/iPhone真机验收、全新Mac原生编译或完整MOD全流程验收。


## 1.0.2（candidate77）

14 项选定 Windows VM 测试在 30/60 帧通过：`UpdateStartupMenuTests`, `UpdateCheckTests`, `SealKingMusicTests`, `PitSquidMusicPhaseTests`, `MusicBossRoutingTests`, `GoldenLoadoutDisplayTests`, `WeaponLoadoutNativeTests`, `LanguagePreferencePersistenceTests`, `PortalSelectionTransitionTests`, `RoadmapPlayerIconsTests`, `ParrotPerchShadowTests`, `DummyAmbushMusicTests`, `WorldEventsDummyWorldTests`, `BossClassificationNativeTests`。

更新提示、两项 Boss 音乐及黄金武器预览均在修复前复现失败。音乐测试启用真实音频，运行海豹王的 phase5 回调、幽灵蛸的清场 Step、首次浮出决策、完成浮出 Step 及 MusCont.Alarm2，检查实际播放句柄和重复请求不重启；黄金武器测试逐像素对照真实收起菜单的绘制，覆盖三个 NTTE 黄金模块和黄金融合武器。另复查语言持久化、变异选择及存储武器的原有回归。新增路线图真实绘制与默认图标像素对照、鹦鹉停靠大海螺的双皮肤像素对照、稻草人偏移及缺少生成墙的失败重试音频测试，并运行实际生成关卡中的完整稻草人召唤与死亡流程和 Boss 分类回归。用户已澄清没有大匪实际死亡，仅误播音乐；观察测试早期发现的 5 点扣血来自未隔离的宠物攻击，未作为 bug 复现。

两平台最终编译函数、元数据和安装包检查通过。Android 保留签名身份并验证 16 KB ZIP 对齐；未改动的原生更新策略沿用同源码哈希下 20 项通过记录。iOS 使用新 VM 导出及已验证的保留运行库封装，需要重新签名。

安装包见 [1.0.2 发布页](https://github.com/ArkinTide/NTTE-Mobile-Port/releases/tag/candidate77)。未进行 Android/iPhone 真机验收、全新 Mac 原生编译或完整 MOD 全流程验收。

## 1.0.1（candidate76）

8 项选定的 Windows VM 测试均在 30/60 帧通过：`PortalSelectionTransitionTests`, `LanguagePreferencePersistenceTests`, `LastEnemyHiddenTimeoutTests`, `LastEnemyTimeoutNativeTests`, `WorldCompletionNativeTests`, `UpdateCheckTests`, `MenuReminderPersistenceNativeTests`, `MenuNativeTests`。

新增回归在修复前均复现失败。传送门测试运行真实变异选择控制器、连续两次原生选择及下一关生成，并检查已排队的尸体回调、暂停/结束/生成阶段和正常空场传送门。语言测试点击真实语言菜单，在普通和练习模式保存分支检查即时磁盘写入、独立存档重新读取及语言表重建；无关进度值保持不变。

完整菜单图像回归首次超过 120 秒时限；同一构建单独复查，在 360 秒时限内完成两档并通过。首次超时记录保留。

两平台最终安装包逐函数核对通过。Android APK 签名、16 KB ZIP 对齐、版本与更新安装入口检查通过；更新策略 Java 源码未变，沿用同一源码哈希下的 20 项通过记录。iOS VM 导出、保留运行库兼容性及 Payload/版本检查通过。

安装包见 [1.0.1 发布页](https://github.com/ArkinTide/NTTE-Mobile-Port/releases/tag/candidate76)。本轮未进行 Android/iPhone 真机验收、全新 Mac 原生编译或完整 MOD 全流程验收。

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
