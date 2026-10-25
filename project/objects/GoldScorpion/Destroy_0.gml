// NTTE SOURCE LEAD RIBS BEFORE CHILD DEATH
if(hp<=0) scrNTTEFullLeadRibsDeath(id);
scrDrop(100, 10)

event_inherited()


dir = random_angle
repeat(5) {
    with instance_create(x, y, AcidStreak) {
        motion_add(other.dir, (8) * timescale)
        image_angle = direction
    }
    dir += 72
}

repeat(60) {
    with instance_create(x, y, EnemyBullet2) {
        creator = other.id
        motion_add(random_angle, (3 + random(2)) * timescale)
        image_angle = direction
        team = other.team
    }
}