// NTTE SOURCE LEAD RIBS BEFORE CHILD DEATH
if(hp<=0) scrNTTEFullLeadRibsDeath(id);
scrNTTECatStopLoop()
if (hp<=0 && instance_exists(GameCont)) scrDrop(20,0)
event_inherited()
