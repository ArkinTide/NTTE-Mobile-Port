if (lockstep_stop) exit
life-=timescale
if (!instance_exists(target)) { instance_destroy(); exit }
if (life<=0 || !instance_exists(creator)) { target.hp=0; instance_destroy() }
