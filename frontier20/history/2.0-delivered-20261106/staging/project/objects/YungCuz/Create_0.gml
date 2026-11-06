image_speed = (0.4) * timescale
depth = -2
spr_idle = sprCuzIdle
spr_to = sprCuzInteractTo
spr_from = sprCuzInteractFrom
spr_heya = sprCuzInteract
wepsound = 0
chestsound = 0
lastsnd = -1
alarm[2] = 90
// BEGIN NTTE CUZ CONNECTED TEST Yung.Create
if(os_type==os_windows && scrNTTEFullSmokeEnabled() && instance_exists(NTTEFullCuzConnectedTest)) try { scrNTTEFullCuzConnectedProbe("Yung.Create",id); }
catch(_ntte_cuz_connected_error) { scrNTTEFullCuzConnectedAbort(_ntte_cuz_connected_error); }
// END NTTE CUZ CONNECTED TEST Yung.Create