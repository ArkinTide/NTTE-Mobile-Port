event_inherited()

if walk {
    motion_add(direction, (0.8) * timescale * timescale)
    walk-= timescale
}

if speed > (4) * timescale speed = (4) * timescale
if speed < (1) * timescale speed = (1) * timescale

if dodge {
    move_contact_solid(direction, 6)
    dodge-= timescale
}

if instance_exists(Player) {
    if random(90) < (1) * timescale && instance_exists(target) {
        if point_distance(x, y, target.x, target.y) <= 64 {
            direction = mcr_target_direction
        }

        dodge = 4
        alarm[0] += 4
    }
}

if hp < max_hp / 2 && !sndhalfhp {
    snd_play(sndLilHunterHalfHP)
    sndhalfhp = 1
}

if !instance_exists(Player) && !sndtaunt {
    if tauntdelay > 50 {
        snd_play(sndLilHunterTaunt)
        sndtaunt = 1
    }

    tauntdelay+= timescale
}