// NTTE SOURCE LEAD RIBS BEFORE CHILD DEATH
if(hp<=0) scrNTTEFullLeadRibsDeath(id);
scrDrop(60, 0)
instance_create(x, y, Explosion)

event_inherited()