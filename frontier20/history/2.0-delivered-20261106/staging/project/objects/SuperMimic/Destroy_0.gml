// NTTE SOURCE LEAD RIBS BEFORE CHILD DEATH
if(hp<=0) scrNTTEFullLeadRibsDeath(id);
scrDrop(200, 0)
scrDrop(200, 0)
instance_create(x + random(4) - 2, y + random(4) - 2, HPPickup)
event_inherited()