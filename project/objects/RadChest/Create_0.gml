if GameCont.area == 0 {instance_destroy(id, 0); exit}

friction = (0.4) * timescale * timescale

team = 0
size = 2

max_hp = 4

spr_idle = sprRadChest
spr_hurt = sprRadChestHurt
spr_dead = sprRadChestCorpse

event_inherited()
image_speed = 0

snd_hurt = sndHitMetal

hp = max_hp
raddrop = 25



// NTTE Coast constructor wading variables
scrNTTEFullCoastConstructWading();

// BEGIN NTTE PROTO STATUE ENTRY TEST RadChest.Create after
if(os_type==os_windows && scrNTTEFullSmokeEnabled() && instance_exists(NTTEFullProtoStatueNaturalEntryTest)) scrNTTEFullProtoEntryProbe("RadChest.Create.after");
// END NTTE PROTO STATUE ENTRY TEST RadChest.Create after