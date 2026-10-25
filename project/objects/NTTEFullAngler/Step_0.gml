if (lockstep_stop) exit
if (hp<=0) { instance_destroy(); exit }
var _appear=(sprite_index==ntte_full_appear),_frame=image_index
event_inherited()
if (_appear) { sprite_index=ntte_full_appear; image_index=_frame }
scrNTTEFullAnglerStep()
