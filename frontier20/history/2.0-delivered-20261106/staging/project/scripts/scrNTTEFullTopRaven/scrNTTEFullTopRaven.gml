// tescrapyard2331..2468. Perched identity is a real enemy; after the actual
// TopObject lands it becomes native Raven without a kill, drops or corpse.
function scrNTTEFullTopRavenCreate() {
    spr_idle=sprRavenIdle; spr_walk=sprRavenWalk; spr_hurt=sprRavenHurt; spr_dead=sprRavenDead
    spr_lift=sprRavenLift; spr_land=sprRavenLand; spr_wing=sprRavenFly
    sprite_index=spr_idle; image_index=random(image_number); depth=object_get_depth(Raven)
    hitid=HitId.Raven; mask_index=object_get_mask(Raven); max_hp=10; raddrop=4; size=1
    top_object=noone; setup=true
}
function scrNTTEFullTopRavenAfterCreate() {
    spr_shadow=shd24; snd_hurt=sndRavenHit; snd_dead=sndRavenDie
}
function scrNTTEFullTopRavenSetup() {
    setup=false
    if (!instance_exists(top_object)) top_object=scrNTTEFullTopCreate(x,y,id,-1,-1)
    if (top_object.z>8) top_object.canmove=false
}
function scrNTTEFullTopRavenStep() {
    if (lockstep_stop) return;
    if (hp<=0) { instance_destroy(); return }
    if (setup) scrNTTEFullTopRavenSetup()
    var _end=image_index+image_speed>=image_number
    if (instance_exists(top_object)) {
        if (top_object.speed!=0 || (top_object.zspeed!=0 && spr_chrg!=spr_land)) {
            if (top_object.zspeed<0) {
                if (sprite_index!=spr_land) { image_index=max(2,image_index); if (_end) spr_chrg=spr_land }
            }
            else if (sprite_index!=spr_wing) {
                if (sprite_index!=spr_lift) {
                    spr_chrg=spr_lift
                    if (scrNTTEFullPortalPointSeen(x,y,-1)) {
                        snd_play(sndRavenLift)
                        repeat(6) {
                            var _dust=instance_create(x+orandom(8),y+random(16),Dust)
                            /* NTTE DUST LIFETIME top-raven-lift */ if(instance_exists(_dust)) {_dust.speed=random_range(3,4)*timescale; _dust.depth=depth }
                        }
                    }
                }
                else if (_end) spr_chrg=spr_wing
            }
            if (sprite_index!=spr_chrg) { sprite_index=spr_chrg; image_index=0 }
        }
        else if (sprite_index!=spr_chrg || _end) sprite_index=scrNTTEFullWorldEnemySprite()
    }
    else {
        if (sprite_index==spr_chrg) sprite_index=scrNTTEFullWorldEnemySprite()
        spr_chrg=-1; instance_destroy()
    }
}
function scrNTTEFullTopRavenDestroy() {
    if (hp<=0) {
        scrNTTEFullWorldPickupDrop(20,0)
        repeat(4) { var _f=instance_create(x,y,Feather); _f.sprite_index=sprRavenFeather }
        if (instance_exists(top_object)) instance_destroy(top_object)
        return false
    }
    var _native=instance_create(x,y,Raven),_fields=variable_instance_get_names(id)
    for(var _i=0;_i<array_length(_fields);++_i) {
        var _key=_fields[_i]
        if (_key!="id" && _key!="object_index" && _key!="name") variable_instance_set(_native,_key,variable_instance_get(id,_key))
    }
    var _builtins=["sprite_index","mask_index","image_index","image_speed","image_xscale","image_yscale","image_angle","image_blend","image_alpha","depth","hspeed","vspeed","friction","visible"]
    for(var _i=0;_i<array_length(_builtins);++_i) variable_instance_set(_native,_builtins[_i],variable_instance_get(id,_builtins[_i]))
// BEGIN NTTE PROTO STATUE ENTRY TEST TopRaven.Constructor constructor
if(os_type==os_windows && scrNTTEFullSmokeEnabled() && instance_exists(NTTEFullProtoStatueNaturalEntryTest)) scrNTTEFullProtoEntryTopRavenSuccessor(_native);
// END NTTE PROTO STATUE ENTRY TEST TopRaven.Constructor constructor
    scrNTTEFullParrotCharmRegisterCopy(_native)
    _native.alarm[1]=20+random(10)
    with (_native) {
        scrTarget()
        if (instance_exists(target) && sign(right)==sign(target.x-x) && scrNTTEFullWorldTargetVisible()) scrNTTEFullWorldLook(point_direction(x,y,target.x,target.y))
        instance_create(x+lengthdir_x(4,gunangle),y+lengthdir_y(4,gunangle),WepSwap); wkick=4
        if (scrNTTEFullPortalPointSeen(x,y,-1)) snd_play(sndRavenLand)
    }
    return true
}
function scrNTTEFullTopRavenSmoke() {
    var _snapshot=scrNTTEFullInstances(all),_kills=GameCont.kills,_r=instance_create(10240,10048,NTTEFullTopRaven)
    assert(_r.max_hp==10*(1+GameCont.loops/20) && _r.raddrop==4 && _r.mask_index==object_get_mask(Raven),"TopRaven source identity fields changed")
    var _top=scrNTTEFullTopCreate(_r.x,_r.y,_r,0,0)
    _r.top_object=_top
    with (_r) scrNTTEFullTopRavenSetup()
    assert(_r.mask_index==mskNone && _top.target_save.mask_index==object_get_mask(Raven),"TopRaven wrapper failed original airborne mask suspension")
    _top.zspeed=1; _top.zfriction=0.2
    with (_r) scrNTTEFullTopRavenStep()
    assert(_r.sprite_index==_r.spr_lift,"Perched TopRaven did not use original lift animation")
    _r.image_index=sprite_get_number(_r.spr_lift)-0.01
    with (_r) scrNTTEFullTopRavenStep()
    assert(_r.sprite_index==_r.spr_wing,"TopRaven lift did not transition to wing")
    _top.zspeed=-1; _r.image_index=sprite_get_number(_r.spr_wing)-0.01
    with (_r) scrNTTEFullTopRavenStep()
    assert(_r.sprite_index==_r.spr_land,"TopRaven descent did not use source landing animation")
    var _before=scrNTTEFullInstances(Raven),_hp=_r.hp,_rad=_r.raddrop
    instance_destroy(_top)
    with (_r) scrNTTEFullTopRavenStep()
    assert(!instance_exists(_r) && GameCont.kills==_kills,"TopRaven natural landing incorrectly awarded a kill")
    var _native=noone
    with (Raven) if (array_get_index(_before,id)<0) _native=id
    assert(instance_exists(_native) && _native.hp==_hp && _native.raddrop==_rad && _native.spr_chrg==-1 && _native.wkick==4
        && _native.alarm[1]>=20 && _native.alarm[1]<30,"TopRaven landing did not preserve state and initialize original native Raven decision timer/swap")
    var _new=scrNTTEFullInstances(all)
    for(var _i=0;_i<array_length(_new);++_i) if (array_get_index(_snapshot,_new[_i])<0) instance_destroy(_new[_i],false)
    scrNTTESmokeLog("FULL WORLD TOP RAVEN LIFT-WING-LAND/NATIVE RAVEN STATE TRANSFER/NO KILL/ORIGINAL DECISION TIMER AND SWAP OK; TOP FLIGHT LIFECYCLE SEPARATE")
}
