# 源码分发 / Source distribution

公开 Git 分支和标签仅保留文本源码、工程声明、配置、语言文本及文档。所有游戏和 MOD 图片、贴图、音频、字体、图标、预编译库、游戏数据、安装包和压缩档均不放入 Git。保留原有许可证、鸣谢和第三方版权说明。

Public Git branches and tags contain text source, project declarations, configuration, localization, and documentation only. Game/MOD images, textures, audio, fonts, icons, precompiled libraries, compiled data, installers, and archives are excluded from Git. License texts, credits, and third-party notices remain.

素材需要另行合法取得。工程资源声明仍引用这些文件，因此空白检出不构成可直接编译的完整工程。`tools/prepare_project.py` 只准备本地工作副本；原版提取器不能生成缺失的 MOD 素材。

Required assets must be obtained separately from authorized sources. Resource declarations still reference those files, so a clean checkout is not a complete directly buildable game. `tools/prepare_project.py` prepares a local copy only; the base-game extractor does not reconstruct missing MOD assets.

2026-10-26 清理了所有公开分支及标签的历史。此前的提交哈希已改变，已有协作者应重新克隆；不要把旧分支合并回来，以免重新引入素材。

All public branch and tag histories were filtered on 2026-10-26. Commit hashes changed. Existing collaborators should re-clone and avoid merging old branches that reintroduce assets.

提交暂存区审核 / Audit staged source: `python tools/audit_source_only.py --index`

全部可达历史审核 / Audit reachable history: `python tools/audit_source_only.py --history`

本地发布使用 `.githooks/pre-push` 自动审核。其他克隆可运行 `git config core.hooksPath .githooks` 启用；需要可用的 Python 3。Our publication checkout enables `.githooks/pre-push`; other clones can opt in with `git config core.hooksPath .githooks` and Python 3 on PATH.
