// NTTE SOURCE LEAD RIBS BEFORE CHILD DEATH
if(hp<=0) scrNTTEFullLeadRibsDeath(id);
event_inherited()
scrDrop(100, 0)
snd_play(sndExplosion)
instance_create(x, y, Explosion)