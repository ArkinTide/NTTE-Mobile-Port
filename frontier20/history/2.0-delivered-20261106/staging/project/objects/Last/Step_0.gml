if lockstep_stop
	exit

event_inherited()
if (charge == 1) {
    instance_create(((x + random(8)) - 4), ((y + 4) + random(4)), Dust)
    motion_add(gunangle, (6) * timescale)
    speed = (14) * timescale
} else {
    if (walk > 0) {
        walk -= (1) * timescale
        motion_add(direction, (2) * timescale * timescale)
        motion_add(gunangle, (1) * timescale * timescale)
    }
    if (speed > (3) * timescale) speed = (3) * timescale
}
if ((hp < (max_hp / 2)) && (sndhalfhp == 0)) {
    snd_play(sndLastHalfHP)
    sndhalfhp = 1
}
if ((!instance_exists(Player)) && (sndtaunt == 0)) {
    tauntdelay += (1) * timescale
    if (tauntdelay > 50) {
        snd_play(sndLastTaunt)
        sndtaunt = 1
    }
}