if (lockstep_stop) exit
ntte_sweat_timer-=timescale
if (ntte_sweat_timer<=0) instance_destroy()
