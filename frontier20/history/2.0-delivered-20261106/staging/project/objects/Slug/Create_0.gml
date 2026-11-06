event_inherited()
damage = 22
friction = (0.8) * timescale * timescale
spr_fade = sprSlugHit
knockback_speed = 10 * timescale
wallbounce = 0

if instance_exists(Player) {
    // 需要 * timescale：
    // 60 帧下否则每次撞墙 speed += 4（应为 2）→ 反弹增速 2 倍。
    if scr_skill_get(mut_shotgun_shoulders) wallbounce = 4 * timescale
}

typ = 1

bonus = true
alarm[2] = 2

// NTTE Coast constructor wading variables
scrNTTEFullCoastConstructWading();
