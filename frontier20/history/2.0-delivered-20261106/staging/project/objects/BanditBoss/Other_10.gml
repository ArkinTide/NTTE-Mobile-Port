event_inherited()

if charge {
    instance_create(x + random(8) - 4, y + 4 + random(4), Dust)
    motion_add(direction, (2) * timescale * timescale)
    motion_add(gunangle, (2) * timescale * timescale)
    if (speed > (5) * timescale) speed = (5) * timescale
	nexthurt = 0
}
else {
    if walk > 0 {
        motion_add(direction, (2) * timescale * timescale)
        motion_add(gunangle, (1) * timescale * timescale)
        walk -= timescale
    }

    if (speed > (3) * timescale) speed = (3) * timescale
}

if hp < max_hp / 2 && !sndhalfhp {
    snd_play(sndBigBanditHalfHP)
    sndhalfhp = true
}

if !instance_exists(Player) and sndtaunt = 0 {
    tauntdelay += (1) * timescale
    if tauntdelay > 50 {
        snd_play(sndBigBanditTaunt)
        sndtaunt = 1
    }
}