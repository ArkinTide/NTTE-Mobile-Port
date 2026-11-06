event_inherited()

sprite_index = sprLightning
image_speed = 0.4 * timescale
depth = -3
mask_index = mskWepPickup
image_xscale = 0
image_yscale = 0
rotspeed = random_range(10, 20) * choose(-1, 1)
rotation = 0
radius = 12
charge = 1
charge_spd = 2
charge_timer = 0
typ = 0
shrink = 1 / 160
maxspeed = 2.5
stretch = 1
split_size = -1
creator_follow = true
primary = true
setup = true
zap_targets = []
zap_times = []
// Even if removed while charging, a ring must never create generic fade FX.
spr_fade = -1

// NTTE Coast constructor wading variables
scrNTTEFullCoastConstructWading();
