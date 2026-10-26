# Details+ 1.1 / 细节增强

Original MOD / 原作：wigglercola — [https://wigglercola.itch.io/detailsplus](https://wigglercola.itch.io/detailsplus)

Toggle / 开关：Settings → Video → DETAILS+ / 设置 → 视频 → DETAILS+ 细节增强。Enabled by default, preference is saved. 默认开启，保存选择；关闭恢复原有外观。

Includes detail clusters, floor-specific scorch pairs, statue/dead-statue decals and desert/oasis transitions. Uses 40 original sprites / 76 frames. 包含装饰聚簇、焦痕、雕像装饰及沙漠/绿洲地板过渡。

The reference MOD's commented-out explosion scorches and mud-shadow pass stay inactive. Its optional `cove` adjustment has no matching registered area in this port. 源 MOD 注释关闭的内容保持关闭；本移植未注册 `cove` 区域，因此没有对应调整。

Native implementation / 实现：`scrDetailsPlus`、`DPStaticDecor`、`DPStatueDecor`。Static decorations have no Step event. Floor/decor processing runs once per generation, first resume or explicit toggle; scorch matching runs on creation. Gameplay geometry and RNG are preserved. 静态装饰无逐帧事件；不改变战斗几何或随机序列。
