// NTTE SOURCE LEAD RIBS BEFORE CHILD DEATH
if(hp<=0) scrNTTEFullLeadRibsDeath(id);
if (hp<=0 && instance_exists(GameCont)) {
    snd_play(sndScorpionFireStart,1.2)
    scrDrop(60,5)
}
event_inherited()
