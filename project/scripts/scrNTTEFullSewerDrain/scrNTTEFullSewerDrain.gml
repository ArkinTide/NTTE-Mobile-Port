// tesewers:5408..5954. Original inclusive bbox right/bottom normalized once.
function scrNTTEFullSewerDrainCreate() {
    spr_idle=scrNTTERefSprite("SewerDrainIdle"); spr_walk=spr_idle
    spr_hurt=scrNTTERefSprite("SewerDrainHurt"); spr_dead=scrNTTERefSprite("SewerDrainDead")
    ntte_full_floor_sprite=scrNTTERefSprite("FloorSewerDrain")
    spr_shadow=-1; sprite_index=spr_idle; image_speed=0.4*timescale
    image_xscale=choose(-1,1); depth=-1; snd_hurt=sndHitMetal; snd_dead=sndStatueDead
    mask_index=scrNTTERefSprite("msk.SewerDrain"); hp=40; max_hp=40; team=team_none; size=3
    area=area_sewers; subarea=1; ntte_full_loops=GameCont.loops
    styleb=0; ntte_full_hallway_size=160; ntte_full_my_floor=noone
    var _kinds=[WeaponChest,AmmoChest,"Backpack",HealthChest,"LairChest","Pizza","GatorStatue","RedSpider",FrogQueen]
    var _weights=[4,4,4,3,3*scrNTTEFullUnlockGet("crown:crime"),2,2*(scr_skill_get(mut_shotgun_shoulders)<=0),2,1]
    var _total=0
    for(var _i=0;_i<array_length(_weights);++_i) _total+=_weights[_i]
    var _pick=random(_total); type=_kinds[array_length(_kinds)-1]
    for(var _i=0;_i<array_length(_kinds);++_i) { _pick-=_weights[_i]; if (_pick<0) { type=_kinds[_i]; break } }
    var _floor=scrNTTEFullWorldNearestRectBBox(x-16,y,x-16,y,Floor)
    if (instance_exists(_floor)) _floor.image_index=3
}

function scrNTTEFullPizzaDrainCreate(_x,_y) {
    var _drain=instance_create(_x,_y,NTTEFullSewerDrain)
    with (_drain) {
        spr_idle=scrNTTERefSprite("PizzaDrainIdle"); spr_walk=spr_idle
        spr_hurt=scrNTTERefSprite("PizzaDrainHurt"); spr_dead=scrNTTERefSprite("PizzaDrainDead")
        sprite_index=spr_idle; ntte_full_floor_sprite=-1; type="area"
        area=scrNTTEFullAreaId("lair"); styleb=1; ntte_full_hallway_size=320
    }
    return _drain
}

function scrNTTEFullSewerDrainHold() {
    x=round(xstart/16)*16-16; y=round(ystart/16)*16; speed=0
}

function scrNTTEFullSewerDrainWallProjectiles() {
    var _touch=scrNTTEFullRectInstances(bbox_left,bbox_top,bbox_right-1,bbox_bottom-1,projectile)
    for(var _i=0;_i<array_length(_touch);++_i) with (_touch[_i]) {
        if (place_meeting(x,y,other.id) && place_meeting(x+hspeed,y+vspeed,Wall)) event_perform(ev_collision,hitme)
    }
}

function scrNTTEFullSewerDrainStep() {
    if (lockstep_stop) return;
    scrNTTEFullSewerDrainWallProjectiles(); scrNTTEFullSewerDrainHold()
    if (!instance_exists(GenCont)) {
        if (!instance_exists(ntte_full_my_floor)) {
            scrNTTEFullFloorSetAlign(16,16,x)
            var _clear=scrNTTEFullRectInstances(x-32,y-32,x+31,y-1,[Floor,TopPot,Bones])
            for(var _i=0;_i<array_length(_clear);++_i) instance_destroy(_clear[_i],false)
            for(var _xx=x-32;_xx<x+32;_xx+=16) scrNTTEFullFloorSet(_xx,y-16,2)
            scrNTTEFullFloorSetStyle(styleb,area)
            ntte_full_my_floor=scrNTTEFullFloorSet(x-16,y-32,true)
            if (instance_exists(ntte_full_my_floor) && sprite_exists(ntte_full_floor_sprite)) ntte_full_my_floor.sprite_index=ntte_full_floor_sprite
            scrNTTEFullFloorResetAlign(); scrNTTEFullFloorResetStyle()
            for(var _xx=x-32;_xx<x+32;_xx+=16) for(var _yy=y-32;_yy<y;_yy+=16) instance_create(_xx,_yy,Wall)
        }
        if (place_meeting(x,y,Wall)) {
            var _left=scrNTTEFullWorldNearestRectBBox(bbox_left-8,y-8,bbox_left-8,y-8,Wall)
            var _right=scrNTTEFullWorldNearestRectBBox(bbox_right-1+8,y-8,bbox_right-1+8,y-8,Wall)
            if (instance_exists(_left)) _left.outindex=0
            if (instance_exists(_right)) _right.outindex=0
            while (place_meeting(x,y,Wall)) {
                var _walls=scrNTTEFullRectInstances(bbox_left,bbox_top,bbox_right-1,bbox_bottom-1,Wall)
                for(var _i=0;_i<array_length(_walls);++_i) with (_walls[_i]) {
                    if (!place_meeting(x,y,other.id)) continue
                    instance_create(x,y,InvisiWall)
                    sprite_index=scrNTTEFullAreaWallSprite(GameCont.area,"Trans"); visible=true; topspr=-1; outspr=-1; y-=16
                }
            }
        }
    }
    var _touch=scrNTTEFullRectInstances(bbox_left,bbox_top,bbox_right-1,bbox_bottom-1,hitme)
    for(var _i=0;_i<array_length(_touch);++_i) {
        var _v=_touch[_i]
        if (_v!=id && !instance_is(_v,prop) && place_meeting(x,y,_v)) with (_v)
            motion_add(y<=other.y-8 ? 270:point_direction(other.x,other.y-8,x,y),0.6*timescale)
    }
    if (sprite_index==spr_idle) {
        if (image_index<1) image_index-=image_speed*random_range(0.98,1)
    }
    else if (image_index>=image_number-image_speed) { sprite_index=spr_idle; image_index=0 }
    if (place_meeting(x,y,Explosion)) hp=0
    if (type=="area") with (FloorExplo) if (y<=other.y-other.ntte_full_hallway_size) {
        instance_create(clamp(other.x,bbox_left,bbox_right),y,PortalClear); other.hp=0
    }
    var _broken=scrNTTEFullRectInstances(bbox_left-16,y-ntte_full_hallway_size,bbox_right-1+16,bbox_top-16,FloorExplo,true)
    for(var _i=0;_i<array_length(_broken);++_i) with (_broken[_i]) {
        instance_create(clamp(other.x,bbox_left,bbox_right),y,PortalClear); other.hp=0
    }
    if (hp<=0) instance_destroy()
}

function scrNTTEFullDrainWallClearStep() {
    scrNTTEFullWallDelete(x1,y1,x2,y2)
    ntte_full_clear_ticks-=1
    if (ntte_full_clear_ticks<=0) instance_destroy()
}

function scrNTTEFullSewerDrainDeath() {
    snd_play(snd_dead,1-random(0.3))
    var _player=instance_nearest(x,y,Player)
    if (instance_exists(_player)) snd_play(_player.snd_chst,1,0.9)
    with (NTTEFullTurtleCool) if (ntte_full_notice_delay<1) ntte_full_notice_delay=1
    var _clear=instance_create(0,0,NTTEFullDrainWallClear)
    _clear.x1=bbox_left; _clear.y1=bbox_top-16*(type=="area"); _clear.x2=bbox_right-1; _clear.y2=bbox_bottom-1
    _clear.ntte_full_clear_ticks=2
    with (_clear) scrNTTEFullWallDelete(x1,y1,x2,y2)
    var _corpse=instance_create(x,y,Corpse)
    _corpse.sprite_index=spr_dead; _corpse.image_xscale=image_xscale; _corpse.image_yscale=image_yscale; _corpse.size=size
    repeat(6) { var _d=instance_create(x+orandom(8),y+orandom(8),Debris); _d.direction+=angle_difference(90,_d.direction)/4 }
    if (type=="area") scrNTTEFullSewerDrainArea()
    else if (instance_exists(ntte_full_my_floor)) scrNTTEFullSewerDrainRoom(type,ntte_full_my_floor)
    if (instance_exists(enemy)) scrNTTEFullPortalPoof()
}
