// NTTE SOURCE LEAD RIBS BEFORE CHILD DEATH
if(hp<=0) scrNTTEFullLeadRibsDeath(id);
scrDrop(30, 0)

event_inherited()

dir = random_angle

repeat 3 {
    with instance_create(x, y, AcidStreak) {
        motion_add(other.dir, (8) * timescale)
        image_angle = direction
    }

    dir += 120
}