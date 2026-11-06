// NTTE SOURCE LEAD RIBS BEFORE CHILD DEATH
if(hp<=0) scrNTTEFullLeadRibsDeath(id);
event_inherited()

dir = random_angle
repeat(8) {
    dir += 45
    with instance_create(x, y, EnemyBullet2) {
        motion_add(other.dir, (4) * timescale)
        image_angle = direction
        creator = other.id
        team = other.team
        hitid = other.hitid
    }
    with instance_create(x, y, AcidStreak) {
        motion_add(other.dir, (8) * timescale)
        image_angle = direction
    }
}

BackCont.shake += 10

repeat(3) {
    with instance_create(x, y, ExploderExplo)
    motion_add(random_angle, (random(2) + 2) * timescale)
}

snd_play(sndFrogExplode)