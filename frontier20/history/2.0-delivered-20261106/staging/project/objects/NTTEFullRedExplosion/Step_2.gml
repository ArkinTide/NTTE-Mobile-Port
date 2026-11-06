if(lockstep_stop) exit
if(instance_exists(target)) { x=target.x; y=target.y }
// Original clears Explosion descendants; MeatExplosion remains a separate family.
with(Explosion) if(place_meeting(x,y,other.id)) instance_destroy()
