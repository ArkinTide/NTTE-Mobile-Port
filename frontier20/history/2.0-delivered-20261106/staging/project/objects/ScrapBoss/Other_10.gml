event_inherited()

if speed > (3) * timescale speed = (3) * timescale

if walk {
    if speed > (2) * timescale speed = (2) * timescale

    walk--motion_add(direction, (0.5) * timescale * timescale)

    if target {
        motion_add(mcr_target_direction, (0.5) * timescale * timescale)

        if sprite_index != spr_hurt sprite_index = spr_walk
    }

    if round(walk / 10) == walk / 10 {
        snd_play(sndBigDogWalk)
    }

    if !walk {
        if sprite_index != spr_hurt
            sprite_index = spr_idle
    }
}

if ammo > 0 {
    if sprite_index != spr_fire && sprite_index != spr_hurt {
        sprite_index = spr_idle
        speed = 0
    }

    speed = (1) * timescale
}

if hp < max_hp / 2 && !sndhalfhp {
    snd_play(sndBigDogHalfHP)
    sndhalfhp = 1
}

if !instance_exists(Player) && !sndtaunt {
    tauntdelay+= timescale

    if tauntdelay > 50 {
        snd_play(sndBigDogTaunt)
        sndtaunt = 1
    }
}