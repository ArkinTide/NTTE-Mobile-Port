// NTTE SOURCE LEAD RIBS BEFORE CHILD DEATH
if(hp<=0) scrNTTEFullLeadRibsDeath(id);
givekill = 0
event_inherited()
scrDrop(20, 0)

with instance_create(x, y, AcidStreak) {
    motion_add(other.direction, (8) * timescale)
    image_angle = direction
}