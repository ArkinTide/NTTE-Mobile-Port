image_angle = direction

if speed < (6) * timescale && sprite_index != spr_fade {
    sprite_index = spr_fade
    image_speed = (0.4) * timescale
    image_index = 0
}