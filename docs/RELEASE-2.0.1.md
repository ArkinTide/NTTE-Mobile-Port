# NTTE + Uncharted Frontier 2.0.1

修复重试、选人和主菜单之间的内容注册表与回调清理，防止相关崩溃。
加固原初箱子的融合武器存档与取出，保留组成和物理状态，防止旧数字句柄被误认。
修复小鱼泡泡 Ultra 对同队弹幕的处理，并统一凶恶面容的初始化与复活路径。
保留 NTUF 区域、天气、墙体、交互及简体中文适配，公开补齐汉化 TSV 输入。

This release repairs registry/callback lifecycle during retry, selection and menus,
hardens proto-chest fusion persistence and stale-reference handling, preserves friendly
projectiles in Bubbles Ultra, and unifies Scary Face initialization/revival.
NTUF content, weather, walls, interactions and Chinese adaptation are retained.

14 selected native cases passed on the newly compiled final 2.0.1 VM. The verified
Python log records 112 passing checks; its receipt binds the log/count without a
historical source snapshot. Bubbles A/B at 30/60 FPS completed real new games and
actual death-to-Retry: 8 trials with 24 real desktop/touch-produced damage hits.
Other coverage includes actual proto-chest save/retrieve/fire, damaged references,
console, menu/retry cleanup, weather, Captain's chair, friendly projectiles, continue
and Scary Face. The earlier 20 native cases remain historical evidence for their
earlier VM. See the repository validation and source-baseline records for exact hashes.

Persistent phone low-frequency/popping audio remains unresolved. Desktop silent
audio-ownership tests do not establish correct phone mixing. No physical Android/iOS,
full random campaign, fresh Mac native build or universal FPS acceptance is claimed.
Already-lost historical fusion composition cannot be recovered from numeric IDs alone.

Android versionCode 3000097 retains the signing identity and checked 16KB alignment.
iOS build 97 uses newly compiled game data and a retained native Runner; re-signing
is required. GAME_BUILD/save protocol remains 3004.

Installers / 安装包：[MEGA download folder](https://mega.nz/folder/PfIDSaSZ#ZcRokP34or9J0JofsIgrEA).
GitHub distributes text-only source and release notes, with no binary or artwork assets.

Credits: [NTTE](https://github.com/Yokinman/NTTE),
[Uncharted Frontier](https://wigglercola.itch.io/uncharted-frontier),
[Undergrowth](https://attfooy.itch.io/undergrowth),
[Details+](https://wigglercola.itch.io/detailsplus). Existing licenses and attribution remain.

SHA256 (full package bytes):

`e2c5ba1c4c005737a250cee2bcb96dbcc6cd926dfc89d4c8ae4725eef281838f`  NuclearThrone.NTTE-NTUF-Android-2.0.1.apk (304416079 bytes)

`31415658ef7fa2e66a327db01478a84270b29edaa7de793683525e783e5cb8b1`  NuclearThrone.NTTE-NTUF-iOS-2.0.1.ipa (212688703 bytes)

The same SHA256SUMS-NTTE-NTUF-2.0.1.txt is distributed in the MEGA folder.
