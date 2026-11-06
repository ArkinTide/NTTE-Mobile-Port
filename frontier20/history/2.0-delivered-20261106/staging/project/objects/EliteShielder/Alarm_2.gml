if ammo > 0 {
    snd_play_hit_big(sndEliteShielderFire, 0.2)
    wkick = 8
    motion_add(gunangle + 180, (0.5) * timescale)

    with instance_create(x, y, PopoPlasma) {
        hitid = other.hitid
        motion_add(other.gunangle + random_range(-10, 10), (1.5) * timescale)
        image_angle = direction
        team = other.team
    }

    alarm[2] = 4
    ammo--
}