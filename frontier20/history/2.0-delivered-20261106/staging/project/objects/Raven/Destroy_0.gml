// NTTE SOURCE LEAD RIBS BEFORE CHILD DEATH
if(hp<=0) scrNTTEFullLeadRibsDeath(id);
scrDrop(20, 0)

event_inherited()

repeat (6 + irandom(4)) {
    with (instance_create(x, y, Feather)) sprite_index = sprRavenFeather
}