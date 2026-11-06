// NTTE SOURCE LEAD RIBS BEFORE CHILD DEATH
if(hp<=0) scrNTTEFullLeadRibsDeath(id);
instance_create(x, y, PortalClear)

raddrop += 25

event_inherited()

if instance_exists(Player) && hp <= 0 {
    scrRaceUnlock(Race.Horror)
}