// NTTE SOURCE LEAD RIBS BEFORE CHILD DEATH
if(hp<=0) scrNTTEFullLeadRibsDeath(id);
event_inherited()
instance_create(x, y, MaggotExplosion)

scrDrop(0, 5)