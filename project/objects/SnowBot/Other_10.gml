event_inherited()

if walk > 0 {
    walk -= (1) * timescale
    // 逐帧**加速度**的正确帧率缩放 = ×ts²（不是 ×ts）：
    // 速度是「px/帧」量（×ts ✓）；每帧叠加的加速度要按真实时间还原需 ×ts²（30 帧 1.0 → 60 帧 0.25）。
    // 原式 ×ts 使 60 帧起步加速度约为 30 帧的 2.7 倍（实测：到顶速 0.06s vs 0.17s）。
    motion_add(gunangle, (1) * timescale * timescale)
    if sprite_index != spr_hurt and meleedamage != 0 {
        if random(2) < (1) * timescale instance_create(x + random(8) - 4, y + 4 + random(4), Dust) sprite_index = spr_fire
    }
}

if sprite_index = spr_fire {
    if speed > (8) * timescale speed = (8) * timescale
} else if speed > (3) * timescale speed = (3) * timescale