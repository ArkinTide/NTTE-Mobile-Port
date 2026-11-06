// tesewers5193..5213,5377..5407. The watching turtles retain a real TV parent.
function scrNTTEFullPizzaTVAfterCreate() {
    // Original PizzaTV_create constructs TV itself, whose object resource
    // supplies sprTV. The native child has no resource sprite of its own;
    // inherit the actual TV cabinet explicitly before its unchanged Draw runs.
    sprite_index=spr_idle
    spr_hurt=scrNTTERefSprite("TVHurt"); spr_dead=spr_hurt; max_hp=15; hp=max_hp
}
function scrNTTEFullPizzaTVEndStep() {
    if(lockstep_stop) return;
    x=xstart; y=ystart; depth=0
    if(hp>0) return;
    var _corpse=instance_create(x,y,Corpse)
    _corpse.sprite_index=spr_dead; _corpse.image_xscale=image_xscale; _corpse.image_yscale=image_yscale; _corpse.size=size
    snd_play(sndPlantPotBreak,1.6); snd_play(sndLightningHit,1,2)
    repeat(2) instance_create(x,y,PortalL)
    instance_destroy(id,false)
}
function scrNTTEFullPizzaTVAlarm() {
    // Menu is not instantiated during the native mobile gameplay room.
    if(!instance_exists(Menu) || Menu.race!=Race.Chicken) {
        switch(tv) {
            case 1:myscreen=choose(sprTV1A,sprTV1B,sprTV1C); break
            case 2:myscreen=choose(sprTV2A,sprTV2B,sprTV2C); break
            case 3:myscreen=choose(sprTV3A,sprTV3B,sprTV3C); break
            case 4:myscreen=choose(sprTV4A,sprTV4B,sprTV4C); break
        }
    }
    alarm[0]=30+random(90)
}
function scrNTTEFullPizzaManholeCoverCreate() {
    repeat(2+irandom(2)) with(instance_create(x+orandom(20),y+orandom(20),GroundFlame)) {
        sprite_index=random(3)<1 ? sprGroundFlameBig:sprGroundFlame
        alarm[0]=ceil(random(alarm[0])); image_blend=c_ltgray
    }
    sprite_index=scrNTTERefSprite("Manhole"); image_angle=180+irandom_range(-3,3)*10
    image_speed=0; depth=6; x+=orandom(8); y+=orandom(8)
}
function scrNTTEFullPizzaHealthSetup() {
    // Concrete Pizza/PizzaChest children already perform this conversion after
    // native construction. Bind the source only to native-family constructors.
    if(object_index!=HPPickup && object_index!=HealthChest) return;
    if(!scrNTTEFullValue(GameCont,"ntte_full_active_pizza",false)) return;
    if(GameCont.area!=scrNTTEFullAreaId("pizza") && GameCont.lastarea!=scrNTTEFullAreaId("pizza")) return;
    if(instance_is(id,HPPickup) && sprite_index==sprHP) { sprite_index=sprSlice; num=ceil(num/2) }
    if(instance_is(id,HealthChest) && sprite_index==sprHealthChest) {
        sprite_index=choose(sprPizzaChest1,sprPizzaChest2); spr_dead=sprPizzaChestOpen; num=ceil(num/2)
    }
}
