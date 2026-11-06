event_inherited()


if hspeed > 0 right = 1
else if hspeed < 0 right = -1

if walk > 0 {
    if sprite_index != spr_hurt motion_add(direction, (0.6) * timescale * timescale)
}


if speed > (3) * timescale speed = (3) * timescale

if instance_exists(target) {
    if instance_exists(target) mp_potential_step(target.x, target.y, (1) * timescale, 0)
}