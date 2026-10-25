if (lockstep_stop) exit
ntte_bat_age+=timescale
if (ntte_bat_age>=20) instance_destroy()
