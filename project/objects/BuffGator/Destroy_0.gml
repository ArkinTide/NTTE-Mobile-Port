// NTTE SOURCE LEAD RIBS BEFORE CHILD DEATH
if(hp<=0) scrNTTEFullLeadRibsDeath(id);
scrDrop(32, 0)
ang = random_angle
repeat(18) {
    with instance_create(x, y, Shell) {
        sprite_index = sprShotShell
        motion_add(other.ang, (4 + random(2)) * timescale)
    }

    ang += 90
}

event_inherited()