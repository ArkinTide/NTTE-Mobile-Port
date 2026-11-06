image_speed = (0.4) * timescale

dir = random_angle
repeat(6) {
    with instance_create(x, y, Smoke)
    motion_add(other.dir, (4 + random(1)) * timescale)
    dir += 360 / 6
}

/*snd_play(sndExplosion)
snd_play(sndMeatExplo)*/

BackCont.shake += 6

/* */
/*  */