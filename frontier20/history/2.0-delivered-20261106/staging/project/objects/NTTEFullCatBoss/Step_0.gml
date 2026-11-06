if (lockstep_stop) exit
if (hp<=0) { instance_destroy(); exit }
var _charging=(sprite_index==spr_chrg),_frame=image_index
event_inherited()
if (_charging) { sprite_index=spr_chrg; image_index=_frame }
scrNTTEFullCatBossStep()
