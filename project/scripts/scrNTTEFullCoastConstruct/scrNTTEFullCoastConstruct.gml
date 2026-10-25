// coast.area461..588 constructor callbacks. Unregistered maintenance batch.
function scrNTTEFullCoastConstructActive() {
    // Routing area/lastarea can already point to a Vault while the departing
    // Coast is still visible. The nonpersistent sea controller belongs to the
    // actual generated scene; history alone must not apply offshore relocation
    // to the CrownPickup's type=3 Portal after a real Vault reconstruction.
    return instance_exists(GameCont) && scrNTTEFullCoastActive() && GameCont.subarea>0
        && instance_exists(NTTEFullCoastSea)
}
function scrNTTEFullCoastConstructWading() {
    if(scrNTTEFullCoastConstructActive()) scrNTTEFullCoastWadingSetup()
}
function scrNTTEFullCoastConstructUnwall() {
    if(!scrNTTEFullCoastConstructActive()) return;
    if(scrNTTEFullValue(id,"area",-1)==scrNTTEFullAreaId("coast") && (visible || !instance_is(id,FloorExplo))) instance_destroy(id,false)
    with(Wall) if(!visible) visible=true
}
function scrNTTEFullCoastWaterFX(_x,_y,_speed) {
    var _fx=scrNTTEFullSystemsCreate("WaterStreak",_x,_y)
    with(_fx) motion_set(random(360),_speed*timescale)
    return _fx
}
function scrNTTEFullCoastConstructDust() {
    if(!scrNTTEFullCoastConstructActive() || position_meeting(x,y,Floor)) return;
    var _water
    if(random(10+instance_number(AcidStreak))<1) {
        snd_play_hit(sndOasisCrabAttack,0.1); _water=scrNTTEFullCoastWaterFX(x,y,2)
        _water.hspeed+=hspeed/2; _water.vspeed+=vspeed/2
    }
    else {
        if(random(5)<1 && scrNTTEFullPortalPointSeen(x,y,0)) snd_play_hit(choose(sndOasisChest,sndOasisMelee),0.2)
        _water=instance_create(x,y,NTTEFullSweat); _water.hspeed=hspeed/2; _water.vspeed=vspeed/2
    }
    instance_destroy()
}
function scrNTTEFullCoastConstructExplosion() {
    if(scrNTTEFullCoastConstructActive() && !position_meeting(x,y,Floor)) {
        var _sound=snd_play_hit(sndOasisExplosion,0.2)
        audio_sound_gain(_sound,5*UberCont.opt_sndvol,0)
    }
}
function scrNTTEFullCoastConstructMeltSplat() {
    if(!scrNTTEFullCoastConstructActive() || position_meeting(x,y,Floor)) return;
    var _sound=snd_play_hit(sndOasisExplosionSmall,0.2)
    audio_sound_gain(_sound,5*UberCont.opt_sndvol,0)
    repeat(sprite_index==sprMeltSplatBig ? 16:8) {
        if(random(6)<1) scrNTTEFullCoastWaterFX(x,y,4)
        else instance_create(x,y,NTTEFullSweat)
    }
    instance_destroy()
}
function scrNTTEFullCoastPortalFloorPosition() {
    // Original NTT9940 Portal Alarm0,00aa591c..00aa5ef6. Data constants
    // 01d27220=Floor92 and01d27230=Wall90. Move only if outside both families.
    if(place_meeting(x,y,Floor) || place_meeting(x,y,Wall)) return;
    var _floor=instance_nearest(x,y,Floor)
    if(instance_exists(_floor)) { x=(_floor.bbox_left+_floor.bbox_right)/2; y=(_floor.bbox_top+_floor.bbox_bottom)/2 }
}
function scrNTTEFullCoastConstructPortal() {
    if(!scrNTTEFullCoastConstructActive()) return;
    if(type==1 && endgame==100 && image_alpha==1) {
        visible=false; snd_stop(sndPortalOpen)
        var _sea=instance_find(NTTEFullCoastSea,0)
        if(instance_exists(_sea)) _sea.flash=0
        // The original constructor armed Alarm0 for2ticks. Epsilon removed that
        // native event; preserve the exact original position operation here.
        scrNTTEFullCoastPortalFloorPosition()
        if(instance_exists(Floor)) {
            var _floor_x=0,_floor_y=0
            with(Floor) { _floor_x+=(bbox_left+bbox_right)/2; _floor_y+=(bbox_top+bbox_bottom)/2 }
            _floor_x/=instance_number(Floor); _floor_y/=instance_number(Floor)
            var _dir=point_direction(_floor_x,_floor_y,x,y),_tries=4096
            while(distance_to_object(Floor)<120 && _tries-->0) { x+=lengthdir_x(8,_dir); y+=lengthdir_y(8,_dir) }
            if(_tries<=0) throw "Coast original Portal could not leave island floors"
        }
        var _shock=instance_nearest(xstart,ystart,PortalShock)
        if(instance_exists(_shock)) { _shock.x=x; _shock.y=y }
        repeat(5) {
            var _light=instance_nearest(xstart,ystart,PortalL)
            if(instance_exists(_light)) { _light.x=x; _light.y=y }
        }
        xstart=x; ystart=y; xprevious=x; yprevious=y
    }
    alarm[0]=-1
}
