// NTTE SOURCE LEAD RIBS BEFORE CHILD DEATH
if(hp<=0) scrNTTEFullLeadRibsDeath(id);
if (hp<=0) { if (ntte_full_type<=2) scrNTTEFullPickupDropBody(50,2,0); else scrNTTEFullPickupDropBody(100,10,0) }
event_inherited()
