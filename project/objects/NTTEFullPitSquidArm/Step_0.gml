if (lockstep_stop) exit
if (hp<=0) { instance_destroy(); exit }
var _special=(sprite_index==ntte_full_appear || sprite_index==ntte_full_disappear),_sprite=sprite_index,_frame=image_index
event_inherited()
if (_special) { sprite_index=_sprite; image_index=_frame }
scrNTTEFullPitSquidArmStep()
