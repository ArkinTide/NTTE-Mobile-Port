// NTTE SOURCE LEAD RIBS BEFORE CHILD DEATH
if(hp<=0) scrNTTEFullLeadRibsDeath(id);
if (hp<=0 && instance_exists(GameCont)) { scrDrop(80,0); scrDrop(80,20) }
event_inherited()
