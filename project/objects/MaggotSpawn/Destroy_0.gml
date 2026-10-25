// NTTE SOURCE LEAD RIBS BEFORE CHILD DEATH
if(hp<=0) scrNTTEFullLeadRibsDeath(id);
scrNTTEFullMaggotBabyDeath();
instance_create(x, y, MaggotExplosion)

speed /= 5

event_inherited()

scrDrop(100, 0)
scrDrop(0, 35)
// NTTE USER NEST BONE: after all original death/drop callbacks.
scrNTTEFullSkeletonBoneDropNative()
