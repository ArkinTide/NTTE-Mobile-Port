if(lockstep_stop) exit;
if(instance_exists(creator)) {creator.speed=speed;creator.direction=direction;}
time-=timescale;if(time<=0 || !instance_exists(creator)) instance_destroy();
