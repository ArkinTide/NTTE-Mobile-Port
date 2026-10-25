event_inherited()

if walk > 0 {
    motion_add(direction, (0.8) * timescale * timescale)
    walk -= (1) * timescale
}

if speed > (4.5) * timescale {
    speed = (4.5) * timescale
}

if ammo {
    if instance_exists(target) {
        gunangle = mcr_target_direction + gunoffset
    }

    if raddrop >= round(charge + 1) {
        raddrop -= round(charge + 1)

        repeat round(charge + 1) {
            with instance_create(x + random(2 + charge) * choose(1, -1), y + random(2 + charge) * choose(1, -1), HorrorBullet) {
                motion_add(other.gunangle, (12) * timescale)
                image_angle = direction
                hitid = other.hitid
                team = other.team
            }
        }

        charge += (0.1) * timescale
    }

    ammo-= timescale
} else charge = 0