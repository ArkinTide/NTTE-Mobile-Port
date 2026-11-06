if lockstep_stop
	exit

var dmg = 1 + skill_get(20)

if size >= other.size - 1 && speed > (2) * timescale && !other.inframes {
    with other {
        hp -= round(dmg + other.speed / 5)

        sprite_index = spr_hurt
        image_index = 0

        motion_add(other.direction, other.speed / 2)
        snd_play_hit(snd_hurt, 0.2)

        inframes = 5
    }

    if skill_get(20) {
        instance_create(x, y, ImpactWrists)

        snd_play_hit(sndImpWristHit, 0.2)

        if !other.hp {
            snd_play_hit(sndImpWristKill, 0.2)
        }
    }

    //sleep(2 * size * size)

    // 撞墙/命中类阻尼改为按 30Hz 逻辑帧结算（60 帧下重叠帧数翻倍 → 会多算约 2 倍）
    if (current_frame_active) speed /= 2
}