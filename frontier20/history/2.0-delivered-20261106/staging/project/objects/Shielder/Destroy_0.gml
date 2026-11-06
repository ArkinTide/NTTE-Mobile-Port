// NTTE SOURCE LEAD RIBS BEFORE CHILD DEATH
if(hp<=0) scrNTTEFullLeadRibsDeath(id);
scrDrop(20, 0)

event_inherited()

scrOnPopoKill()

with PopoShield {
    if creator == other.id {
        sprite_index = sprShielderShieldDisappear
        image_speed = (0.4) * timescale
        image_index = 0
    }
}

if GameCont.underwater {
    with (instance_create(x, y, AnimParticle)) sprite_index = sprPlayerBubblePop
}