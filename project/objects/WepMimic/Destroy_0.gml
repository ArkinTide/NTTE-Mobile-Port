// NTTE SOURCE LEAD RIBS BEFORE CHILD DEATH
if(hp<=0) scrNTTEFullLeadRibsDeath(id);
scrDrop(200, 0)
scrDrop(200, 0)

scrWeaponPickupCreate(x, y, scrDecideWep(1), true)

event_inherited()

if (GameCont.underwater) {
    with (instance_create(x, y, AnimParticle)) sprite_index = sprPlayerBubblePop
}