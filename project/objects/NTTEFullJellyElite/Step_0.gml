if (lockstep_stop) exit
if (hp<=0) { instance_destroy(); exit }
event_perform_object(enemy,ev_step,ev_step_normal)
scrNTTEFullJellyStep()
