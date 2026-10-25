if (lockstep_stop) exit
life-=timescale
if (place_meeting(x+hspeed,y+vspeed,Wall)) speed=0
if (speed>0) image_angle+=spin*timescale
image_alpha=min(1,life/30)
if (life<=0) instance_destroy()
