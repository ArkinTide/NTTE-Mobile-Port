// tesewers:4587..4875 and5215..5370. Original inclusive bbox edges use edge-1.
function scrNTTEFullLairBorderCreate() {
    image_blend=scrAreaGetBackroundColor(GameCont.area); depth=1000; mask_index=mskNone; sprite_index=-1
    area=GameCont.area; ntte_full_cavein=0; ntte_full_cavein_distance=800
    ntte_full_cavein_pan=0; ntte_full_cavein_saved=[]
}

// Shared terrain Create hooks may call this immediately after native setup.
// The per-Step reconciliation also handles terrain created by delayed effects.
function scrNTTEFullLairBorderSetupInstance(_created) {
    if (!instance_exists(_created)) return;
    with (NTTEFullLairBorder) {
        if (_created.y<y) continue
        var _object=_created.object_index,_sprite=-1
        if (instance_is(_created,Debris)) {
            if (_created.sprite_index!=scrNTTEFullAreaWallSprite(GameCont.area,"Debris")) continue
            _sprite=scrNTTEFullAreaWallSprite(area,"Debris")
        }
        else {
            if (!variable_instance_exists(_created,"area") || _created.area!=GameCont.area) continue
            if (instance_is(_created,Wall)) {
                _created.sprite_index=scrNTTEFullAreaWallSprite(area,"Bot")
                _created.topspr=scrNTTEFullAreaWallSprite(area,"Top")
                _created.outspr=scrNTTEFullAreaWallSprite(area,"Out")
                _created.area=area
                continue
            }
            if (instance_is(_created,TopSmall)) _sprite=scrNTTEFullAreaWallSprite(area,"Trans")
            else if (instance_is(_created,FloorExplo)) _sprite=scrNTTEFullAreaFloorSprite(area,false,true)
        }
        if (sprite_exists(_sprite)) { _created.sprite_index=_sprite; _created.area=area }
    }
}

function scrNTTEFullLairBorderFloorSet(_below,_top=undefined) {
    var _floors=scrNTTEFullInstances(Floor),_out=[]
    for(var _i=0;_i<array_length(_floors);++_i) {
        var _f=_floors[_i]
        if (_f.bbox_bottom-1>_below && (is_undefined(_top) || _f.bbox_top<_top)) array_push(_out,_f)
    }
    return _out
}

function scrNTTEFullLairBorderStep() {
    if (lockstep_stop) return;
    var _terrain=scrNTTEFullInstances([Wall,TopSmall,FloorExplo,Debris])
    for(var _i=0;_i<array_length(_terrain);++_i) scrNTTEFullLairBorderSetupInstance(_terrain[_i])
    if (ntte_full_cavein==0) {
        with (Player) if (y<other.y) { other.ntte_full_cavein=1; break }
        if (ntte_full_cavein==1) snd_play(sndStatueXP,0.2+random(0.2),3)
        return;
    }
    if (ntte_full_cavein<0) return;
    for(var _i=array_length(ntte_full_cavein_saved)-1;_i>=0;--_i)
        if (!instance_exists(ntte_full_cavein_saved[_i])) array_delete(ntte_full_cavein_saved,_i,1)
    if (ntte_full_cavein_distance>0) {
        var _below_player=false
        with (Player) if (y>other.y-64) { _below_player=true; break }
        var _spd=max(4,random(_below_player ? 12:18))
        ntte_full_cavein_distance=max(0,ntte_full_cavein_distance-_spd*timescale)
        if (current_frame_active) {
            var _floors=scrNTTEFullLairBorderFloorSet(y)
            for(var _i=0;_i<array_length(_floors);++_i) with (_floors[_i]) {
                if (!scrNTTEFullPortalPointSeen(x,y)) continue
                if (object_index!=FloorExplo || random(10)<1) {
                    var _lower=0
                    for(var _j=0;_j<array_length(_floors);++_j) if (_floors[_j].bbox_bottom>bbox_bottom) _lower+=1
                    if (random(2*_lower)<1) {
                        var _d=instance_create(choose(bbox_left+4,bbox_right-1-3),choose(bbox_top+4,bbox_bottom-1-3),Debris)
                        with (_d) motion_set(90+orandom(90),(4+random(4))*timescale)
                    }
                }
            }
            for(var _i=0;_i<array_length(_floors);++_i) with (_floors[_i]) if (bbox_bottom-1>other.y+other.ntte_full_cavein_distance) {
                repeat(choose(1,choose(1,2))) {
                    var _d=instance_create(random_range(bbox_left-12,bbox_right-1+13),bbox_bottom,Dust)
                    /* NTTE LAIR EFFECT LIFETIME lair-cavein-dust */ if(instance_exists(_d)) {_d.image_xscale*=2; _d.image_yscale*=2; _d.depth=-8; _d.vspeed-=5*timescale
                    snd_play_hit(choose(sndWallBreak,sndWallBreakBrick),0.3) }
                }
            }
        }
        ntte_full_cavein_pan=min(1,ntte_full_cavein_pan+timescale/20)
        // Native one shared camera follows the current local player. Original
        // view_shift temporarily forces opt_shake=1, then weapon_post(pan*ts).
        with (BackCont) shake=max(shake,5)
        var _player=noone
        with (Player) if (index==global.index) { _player=id; break }
        if (instance_exists(_player)) {
            scrNTTEFullTrenchShake(_player.x,y+ntte_full_cavein_distance,20,true)
            var _pan=clamp(_player.y-(y-64),0,min(20,ntte_full_cavein_distance/10))*ntte_full_cavein_pan
            scrNTTEFullViewShift(global.index,270,_pan)
        }
        if (ntte_full_cavein_distance<400) {
            var _instances=scrNTTEFullNativeGameObjects()
            for(var _i=0;_i<array_length(_instances);++_i) {
                var _v=_instances[_i]
                if (!instance_exists(_v) || _v.y<=y+ntte_full_cavein_distance || _v.object_index==Dust) continue
                if (_v.y>y+64 && instance_is(_v,hitme) && _v.hp>0) {
                    _v.hp=0
                    if (variable_instance_exists(_v,"lasthit")) _v.lasthit=[sprTurtleDead,"CAVE IN"]
                }
                else if (_v.persistent || instance_is(_v,chestprop)
                    || (scrNTTEFullIsPickup(_v) && _v.object_index!=Rad && _v.object_index!=BigRad)
                    || (instance_is(_v,Corpse) && _v.y<y+240) || instance_is(_v,NTTEFullPet)) {
                    if (array_get_index(ntte_full_cavein_saved,_v)<0) array_push(ntte_full_cavein_saved,_v)
                }
                else instance_destroy(_v)
            }
            with (Wall) if (bbox_bottom-1>other.y+other.ntte_full_cavein_distance-32) outspr=-1
        }
        if (array_length(ntte_full_cavein_saved)>0) {
            var _cx=x,_cy=y+ntte_full_cavein_distance+16,_floor=noone,_distance=infinity
            var _cross=scrNTTEFullLairBorderFloorSet(y,y)
            for(var _i=0;_i<array_length(_cross);++_i) {
                var _f=_cross[_i],_fx=clamp(x,_f.bbox_left,_f.bbox_right),_fy=clamp(y,_f.bbox_top,_f.bbox_bottom)
                var _d=point_distance(x,y,_fx,_fy)
                if (_d<_distance) { _distance=_d; _floor=_f }
            }
            if (instance_exists(_floor)) _cx=(_floor.bbox_left+_floor.bbox_right)/2
            for(var _i=0;_i<array_length(ntte_full_cavein_saved);++_i) with (ntte_full_cavein_saved[_i]) {
                visible=false; x=lerp(x,_cx,1-power(0.9,timescale)); y=_cy
                if (instance_is(id,HealthChest)) mask_index=mskNone
            }
        }
    }
    else {
        ntte_full_cavein=-1
        for(var _i=0;_i<array_length(ntte_full_cavein_saved);++_i) if (instance_exists(ntte_full_cavein_saved[_i])) ntte_full_cavein_saved[_i].visible=true
        var _floors=scrNTTEFullLairBorderFloorSet(y)
        for(var _i=0;_i<array_length(_floors);++_i) scrNTTEFullFloorWalls(_floors[_i])
        with (Wall) if (bbox_bottom-1>other.y) {
            instance_create(x-16,y-16,Top); instance_create(x-16,y,Top); instance_create(x,y-16,Top); instance_create(x,y,Top)
        }
        var _near=noone,_distance=infinity
        for(var _i=0;_i<array_length(_floors);++_i) {
            var _f=_floors[_i]
            if (_f.object_index!=Floor) continue
            var _d=point_distance(x,y,clamp(x,_f.bbox_left,_f.bbox_right),clamp(y,_f.bbox_top,_f.bbox_bottom))
            if (_d<_distance) { _distance=_d; _near=_f }
        }
        if (instance_exists(_near)) {
            var _rubble=instance_create((_near.bbox_left+_near.bbox_right)/2,y,NTTEFullPizzaRubble)
            _rubble.ntte_full_saved=ntte_full_cavein_saved
            var _broken=scrNTTEFullInstances(FloorExplo)
            for(var _i=0;_i<array_length(_broken);++_i) {
                var _f=_broken[_i]
                if (_f.bbox_bottom-1<=_rubble.y-4 || _f.bbox_top>=_rubble.y-4) continue
                var _x1=(_f.bbox_left+_f.bbox_right)/2,_y1=(_f.bbox_top+_f.bbox_bottom)/2
                if (collision_line(_x1,_y1,_rubble.x,_y1,Wall,false,false)) scrNTTEFullFloorTunnel(_x1,_rubble.y-8,_rubble.x,_rubble.y-8)
            }
            with (_rubble) scrNTTEFullPizzaRubbleStep()
        }
    }
}

function scrNTTEFullLairBorderDraw() {
    if (y<view_yview+view_height) {
        draw_set_color(image_blend)
        draw_rectangle(view_xview,y,view_xview+view_width,view_yview+view_height,false)
    }
}

function scrNTTEFullViewShift(_index,_direction,_pan) {
    // BackCont is shared in local co-op. Apply the camera owner's source shift
    // once, independently of the user's screen-shake preference.
    if (_index>=0 && _index!=global.index) return;
    with (BackCont) {
        viewx2+=lengthdir_x(_pan*timescale,_direction)
        viewy2+=lengthdir_y(_pan*timescale,_direction)
    }
}

function scrNTTEFullPizzaRubbleCreate() {
    spr_idle=scrNTTERefSprite("PizzaRubbleIdle"); spr_walk=spr_idle
    spr_hurt=scrNTTERefSprite("PizzaRubbleHurt"); spr_dead=mskNone; spr_shadow=mskNone
    sprite_index=spr_idle; image_xscale=choose(-1,1); image_speed=0.4*timescale; depth=-7
    snd_hurt=sndHitRock; snd_dead=sndWallBreakScrap; mask_index=scrNTTERefSprite("msk.PizzaRubble")
    max_hp=40; hp=max_hp; team=team_none; size=3; ntte_full_saved=[]; ntte_full_peas=false
    instance_create(x,y+16,Wall); instance_create(x-16,y+16,Wall)
    instance_create(x,y+8,InvisiWall); instance_create(x-16,y+8,InvisiWall)
    scrNTTEFullTrenchShake(x,y,20)
    repeat(12) { var _fx=scrNTTEFullTrenchFX(x,y,8,4,Dust); /* NTTE LAIR EFFECT LIFETIME pizza-rubble-create-dust */ if(instance_exists(_fx)) {_fx.image_xscale*=2; _fx.image_yscale*=2; _fx.depth=-8 } }
}

function scrNTTEFullPizzaRubbleStep() {
    if (lockstep_stop) return;
    scrNTTEFullSewerDrainWallProjectiles(); x=xstart; y=ystart; speed=0
    for(var _i=array_length(ntte_full_saved)-1;_i>=0;--_i) {
        var _v=ntte_full_saved[_i]
        if (!instance_exists(_v)) { array_delete(ntte_full_saved,_i,1); continue }
        if (scrNTTEFullIsPickup(_v) && _v.alarm[0]>0) _v.alarm[0]=max(_v.alarm[0],90)
        else if (instance_is(_v,hitme) && !(random(max(0.0001,_v.speed/timescale))<timescale) && random(2)<1) {
            var _ntte_lair_saved_dust_direction=90+orandom(30),_fx=scrNTTEFullTrenchFX(_v.x,_v.y,0,random(3),Dust)
            /* NTTE LAIR EFFECT LIFETIME pizza-rubble-saved-dust */ if(instance_exists(_fx)) {_fx.direction=_ntte_lair_saved_dust_direction; _fx.depth=_v.depth+choose(0,-1) }
        }
        _v.x=x; _v.y=y+16; _v.xprevious=_v.x; _v.yprevious=_v.y; _v.speed=0
    }
    if (sprite_index!=spr_idle && image_index>=image_number-image_speed) sprite_index=spr_idle
    if (ntte_full_peas && random(3)<timescale) {
        var _fx=instance_create(random_range(bbox_left,bbox_right-1),random_range(bbox_top,bbox_bottom-1),LaserCharge)
        _fx.sprite_index=sprSpiralStar; _fx.image_blend=make_color_rgb(147,202,86); _fx.depth=depth-1
        _fx.alarm[0]=random_range(8,16)
        with (_fx) motion_set(90,random_range(1,2)*timescale)
    }
    if (!place_meeting(x,y,Wall)) hp=0
    if (hp<=0) instance_destroy()
}

function scrNTTEFullPizzaRubbleHurt(_damage,_force) {
    if (random(8)<_force) repeat(irandom_range(1,ceil(sqrt(_damage)))) if (random(hp/10)<1) {
        var _d=instance_create(random_range(bbox_left,bbox_right),y+8,Debris)
        _d.depth=1; _d.direction=90+orandom(60); snd_play_hit(sndWallBreak,0.4)
    }
}

function scrNTTEFullPizzaRubbleDeath() {
    snd_play(snd_dead,1+random(0.3))
    repeat(12) {
        var _d=instance_create(x+orandom(8),y+orandom(8),NTTEFullCatDoorDebris)
        _d.sprite_index=sprDebris102; _d.image_index=irandom(_d.image_number-1)
        _d.direction=random(360); _d.speed=random_range(2,8)*timescale; _d.ntte_full_flash=5
        scrNTTEFullTrenchFX(x,y,0,4,Dust)
    }
    var _clear=instance_create(x,y+24,PortalClear)
    _clear.sprite_index=mskPlasmaImpact; _clear.image_index=_clear.image_number-4; _clear.image_speed=-1.2*timescale
    var _walls=scrNTTEFullRectInstances(bbox_left,bbox_top,bbox_right-1,bbox_bottom-1,[Wall,InvisiWall])
    for(var _i=0;_i<array_length(_walls);++_i) with (_walls[_i]) {
        if (!place_meeting(x,y,other.id)) continue
        if (object_index==Wall) instance_create(x,y,FloorExplo)
        instance_destroy()
    }
    for(var _i=0;_i<array_length(ntte_full_saved);++_i) if (instance_exists(ntte_full_saved[_i])) with (ntte_full_saved[_i]) {
        visible=true; x+=orandom(4); y+=orandom(4)
        if (instance_is(id,HealthChest)) mask_index=-1
    }
    scrNTTEFullPetSetSkin(scrNTTEFullPetCreate(x,y+16,"CoolGuy"),ntte_full_peas ? "peas":0)
}
