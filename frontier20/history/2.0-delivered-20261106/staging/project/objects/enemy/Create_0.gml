event_inherited()
// NTT CustomEnemy.Create VA00e9841d..00e9845d initializes contact damage to0.
// Child-authored damage, including native enemies, always takes priority.
if (!variable_instance_exists(id,"meleedamage")) meleedamage=0
wkick = 0
image_speed = (0.4) * timescale
friction = (0.4) * timescale * timescale
right = choose(1, -1)

max_hp *= 1 + GameCont.loops / 20
hp = max_hp

gunangle = 0

canmelee = 1

scrEnemyApplyCreationEffects()

target = noone
team = team_enemy

givekill = true
corpse = true

snd_hurt = sndHitFlesh
snd_dead = sndEnemyDie
snd_mele = sndMaggotBite

dropseed = rng_next_int(RNGStates.WeaponDrops)

busycollisions = GameCont.loops <= 3
// NTTE Coast constructor wading variables
scrNTTEFullCoastConstructWading();

// BEGIN NTTE PROTO STATUE ENTRY TEST Enemy.Create after
if(os_type==os_windows && scrNTTEFullSmokeEnabled() && instance_exists(NTTEFullProtoStatueNaturalEntryTest)) scrNTTEFullProtoEntryProbe("Enemy.Create.after");
// END NTTE PROTO STATUE ENTRY TEST Enemy.Create after
// BEGIN NTTE CUZ CONNECTED TEST Enemy.Create
if(os_type==os_windows && scrNTTEFullSmokeEnabled() && instance_exists(NTTEFullCuzConnectedTest)) try { scrNTTEFullCuzConnectedProbe("Enemy.Create",id); }
catch(_ntte_cuz_connected_error) { scrNTTEFullCuzConnectedAbort(_ntte_cuz_connected_error); }
// END NTTE CUZ CONNECTED TEST Enemy.Create