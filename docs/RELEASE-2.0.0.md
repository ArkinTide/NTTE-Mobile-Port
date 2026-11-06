NTTE + Uncharted Frontier（NTUF）2.0.0

安装包 / Installers:
https://mega.nz/folder/PfIDSaSZ#ZcRokP34or9J0JofsIgrEA

平台安装包与正式标签使用 2.0.0，保留内部构建 96。游戏角落显示简写 2.0，
设置中的已安装版本为 2.0.0。正规化只改变平台版本元数据；游戏 VM、素材与
原生库逐成员字节保留，同源证明另行核验。本次沿用同一 VM 的实际 88 项选定
回归与 94 项 Python 检查，不宣称重跑新 VM 或所有保留的历史测试。

Platform packages and the official tag use 2.0.0, internal build 96. The game
corner retains shorthand 2.0 and settings show installed version 2.0.0. Only
platform-version metadata is normalized; game VM, assets and native libraries
retain identical member bytes. The same VM's 88 selected regressions and 94
Python checks are retained, with a separate provenance verification. This does
not claim a new VM test run or every retained historical test.

- 整合 Uncharted Frontier 1.0.3.3，并提供简体中文；保留 NTTE、Undergrowth、Details+ 内容。
- 修复天气事件、马陆链节、Bubbles 新游戏、交互提示、工具箱和 0-1 出场顺序。
- 修复外围墙体颜色、区域球局部变色、秘密房间墙顶、墙上敌人及分块墙接触；修复墙边换枪时掉落物被推远的已确认路径。
- 修复 Wormhole 的 NTTE 弹丸伤害归属，保留圆盘／爆炸原生标识。
- 优化查询、库读取和 Deep Labs 炮塔绘制，补齐并检查 NTUF 中文字体与图标排版。

88 项同一最终 Windows VM／输入回归及 94 项 Python 检查通过。包括四次真实 Bubbles 新游戏和 12 次实际手动换枪／拾回场景。没有复现通用武器删除；截图不包含 Bubbles GUI，相关证据来自实际绘制回调。桌面测试不代表手机真机、完整随机战役或所有设备 60 帧验收。

Android 保留应用标识、签名及 16KB 对齐。iOS IPA 使用新编译游戏数据和保留的原生 Runner，需要重新签名；没有进行新的 Mac 原生编译或手机真机测试。版本 2.0.0，内部构建 96，Android versionCode 3000096，存档协议 GAME_BUILD 3004。

GitHub 仅发布不含素材的文本源码与说明。安装包、字体、图片、音频和预编译库不作为 GitHub 附件或源码内容。旧版本安装包保留于 MEGA。

Integrates Uncharted Frontier 1.0.3.3 with Simplified Chinese, retaining NTTE,
Undergrowth and Details+. Fixes weather/Millipede/Bubbles startup errors,
interactions, toolkit drops, 0-1 progression, wall colors and local orb effects,
hidden-room roofs, packed-wall contact and confirmed ground-weapon ejection,
and Wormhole NTTE damage attribution. Optimizes repeated queries/library reads
and Deep Labs turret rendering.

88 cases passed on one final Windows VM/input, plus 94 Python checks, including
four genuine Bubbles starts and 12 actual manual weapon exchanges/recoveries.
Generic weapon deletion was not reproduced. World screenshots do not include
the Bubbles GUI; GUI evidence is actual draw callbacks. No physical-phone,
complete random-campaign, or universal 60 FPS claim is made.

Android retains application/signing identity and 16KB alignment. The iOS IPA
combines newly compiled game data with a retained native Runner, requires
re-signing, and is not a fresh native Mac build or device test. Public version/tag 2.0.0,
internal 96, Android code 3000096, save protocol GAME_BUILD 3004.

GitHub hosts text source/notes only. Installers and assets are available only
through the owner-selected MEGA folder; previous installers are preserved.

Original NTTE: https://github.com/Yokinman/NTTE
Uncharted Frontier: https://wigglercola.itch.io/uncharted-frontier
Undergrowth: https://attfooy.itch.io/undergrowth
Details+: https://wigglercola.itch.io/detailsplus

Earlier 1.0.4 and subsequent 1.0.x builds remain the versions without later
Undergrowth/Details+/Frontier integrations.

SHA256 (full package bytes):

`7a968a2073be3ad9ae2aaf3dffe9fc4a9d50f3ae54404d83071a38a5406a85b8`  NuclearThrone.NTTE-NTUF-Android-2.0.0.apk (304278355 bytes)

`a438f5d479137c6a30067aedbe87db36492d79b7039a1a4c5aa093f8f16d06e3`  NuclearThrone.NTTE-NTUF-iOS-2.0.0.ipa (212641722 bytes)

The same SHA256SUMS-NTTE-NTUF-2.0.0.txt is distributed in the MEGA folder.
