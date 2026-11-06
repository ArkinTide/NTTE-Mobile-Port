enum NTTEDesertEvent { Natural, Camp, Nest, Scorpions, Off }

function scrNTTEDesertSetting() {
    if(!scrNTTESmokeEnabled()) return NTTEDesertEvent.Natural
    if (!scrGameIsCustomMode() || !is_struct(UberCont.custom_options)) return NTTEDesertEvent.Natural
    // Existing custom-mode files predate this field; migrate without resetting slots.
    if (!variable_struct_exists(UberCont.custom_options,"ntte_desert_event"))
        UberCont.custom_options.ntte_desert_event=NTTEDesertEvent.Natural
    return clamp(floor(UberCont.custom_options.ntte_desert_event),0,4)
}

function scrNTTEDesertEventName(_event) {
    switch (_event) {
        case NTTEDesertEvent.Camp: return "BANDIT CAMP"
        case NTTEDesertEvent.Nest: return "MAGGOT PARK"
        case NTTEDesertEvent.Scorpions: return "SCORPION CITY"
        case NTTEDesertEvent.Off: return "OFF"
    }
    return "NATURAL"
}

function scrNTTEDesertPickEvent(_setting,_subarea,_hard) {
    if (_setting!=NTTEDesertEvent.Natural) return _setting
    // Original chances: Maggot Park 1/50 from 1-2; Bandit Camp 1/10 at 1-3,
    // otherwise 1/20 from difficulty 3. Scorpion City originally needs a pet.
    if (_hard>=2 && random(50)<1) return NTTEDesertEvent.Nest
    if (_hard>=3 && random(_subarea==3 ? 10:20)<1) return NTTEDesertEvent.Camp
    return NTTEDesertEvent.Natural
}

function scrNTTEDesertAddFloor(_fx,_fy) {
    if (position_meeting(_fx+16,_fy+16,Floor)) return noone
    var _f=instance_create(_fx,_fy,Floor)
    if (!instance_exists(_f)) return noone
    // Structural carving must not generate wall explosions, drops or projectiles.
    with (Wall) if (point_in_rectangle(x+8,y+8,_fx,_fy,_fx+31,_fy+31)) instance_destroy(id,false)
    with (Top) if (point_distance(x,y,_fx,_fy)<24) instance_destroy(id,false)
    return _f
}

function scrNTTEDesertRoom(_w,_h) {
    var _anchor=noone,_best=-1
    with (Floor) {
        var _d=point_distance(x+16,y+16,10016,10016)
        if (_d>=128 && _d<800 && _d>_best) { _best=_d; _anchor=id }
    }
    if (!instance_exists(_anchor)) _anchor=instance_furthest(10016,10016,Floor)
    if (!instance_exists(_anchor)) return undefined
    var _dir=round(point_direction(10016,10016,_anchor.x+16,_anchor.y+16)/90)*90,
        _sx=round(lengthdir_x(32,_dir)),_sy=round(lengthdir_y(32,_dir)),
        _px=_anchor.x,_py=_anchor.y,_new=[]
    // Three-wide connected approach, then a rectangular chamber on the same grid.
    for(var _i=0;_i<5;++_i) {
        for(var _side=-1;_side<=1;++_side) {
            var _f=scrNTTEDesertAddFloor(_px+(_sy==0 ? 0:_side*32),_py+(_sx==0 ? 0:_side*32))
            if (instance_exists(_f)) array_push(_new,_f)
        }
        _px+=_sx; _py+=_sy
    }
    var _cx=_px,_cy=_py
    for(var _dx=-(_w div 2);_dx<=(_w div 2);++_dx) {
        for(var _dy=-(_h div 2);_dy<=(_h div 2);++_dy) {
            var _f=scrNTTEDesertAddFloor(_cx+_dx*32,_cy+_dy*32)
            if (instance_exists(_f)) array_push(_new,_f)
        }
    }
    // Remove inner walls that used to border the old map; only new tiles need walls.
    with (Wall) if (position_meeting(x+8,y+8,Floor)) instance_destroy(id,false)
    for(var _i=0;_i<array_length(_new);++_i) with (_new[_i]) mcr_floor_make_walls;
    return {x:_cx+16,y:_cy+16,floors:_new}
}

function scrNTTEDesertSpawn(_x,_y,_object) {
    var _inst=instance_create(_x,_y,_object)
    if (!scrNTTEDesertBudge(_inst)) { instance_destroy(_inst,false); return noone }
    return _inst
}

function scrNTTEDesertCamp(_room) {
    var _cx=_room.x,_cy=_room.y,_chests=[],_campers=[]
    // Move up to three existing chests rather than duplicating their rewards.
    with (chestprop) if (instance_is(id,WeaponChest) || instance_is(id,AmmoChest)) array_push(_chests,id)
    for(var _i=0;_i<3;++_i) {
        var _a=90+_i*120,_x=_cx+lengthdir_x(48,_a),_y=_cy+lengthdir_y(40,_a),
            _tent=scrNTTEDesertSpawn(_x,_y,NTTEBanditTent)
        if (instance_exists(_tent) && _i<array_length(_chests) && instance_exists(_chests[_i])) {
            var _chest=_chests[_i]
            _chest.x=_tent.x; _chest.y=_tent.y+4
            _chest.xprevious=_chest.x; _chest.yprevious=_chest.y
            _chest.xstart=_chest.x; _chest.ystart=_chest.y
            _tent.ntte_chest=_chest
        }
        var _camper=scrNTTEDesertSpawn(_x+12,_y+16,NTTECamperBandit)
        if (instance_exists(_camper)) array_push(_campers,_camper)
    }
    scrNTTEDesertSpawn(_cx+16,_cy,NTTEHikerBandit)
    with (instance_create(_cx,_cy,NTTEDesertDecor)) sprite_index=sprNTTEBanditCampfire
    // The original cross-event interaction: campers can ride nearby scorpions.
    var _mounts=[]
    with (Scorpion) if (point_distance(x,y,_cx,_cy)<240) array_push(_mounts,id)
    for(var _i=0;_i<min(array_length(_mounts),array_length(_campers));++_i) _campers[_i].ntte_mount=_mounts[_i]
}

function scrNTTEDesertNest(_room) {
    var _cx=_room.x,_cy=_room.y,_chest=instance_nearest(_cx,_cy,WeaponChest)
    if (instance_exists(_chest)) {
        // Transfer one existing chest into the nest room and upgrade it once.
        instance_destroy(_chest,false)
        scrNTTEDesertSpawn(_cx,_cy,BigWeaponChest)
    }
    for(var _i=0;_i<3;++_i) {
        var _a=90+_i*120
        scrNTTEDesertSpawn(_cx+lengthdir_x(64,_a),_cy+lengthdir_y(64,_a),NTTEMaggotNest)
    }
    for(var _i=0;_i<5;++_i) {
        var _a=_i*72
        scrNTTEDesertSpawn(_cx+lengthdir_x(100,_a),_cy+lengthdir_y(100,_a),MaggotSpawn)
    }
    with (instance_create(_cx+72,_cy+32,NTTEDesertDecor)) sprite_index=sprNTTECowSkull
}

function scrNTTEDesertScorpions(_room) {
    var _cx=_room.x,_cy=_room.y
    // Preserve bosses and large enemies. Replacements are structural removals,
    // so they cannot grant kills, rads or spawn death projectiles.
    var _replace=[]
    with (enemy) if (size<4 && !scrEnemyIsBoss(id) && !instance_is(id,NTTEMaggotNest)
        && point_distance(x,y,10016,10016)>80) array_push(_replace,id)
    for(var _i=0;_i<array_length(_replace);++_i) {
        var _old=_replace[_i],_x=_old.x,_y=_old.y,_small=_old.size<=1
        instance_destroy(_old,false)
        scrNTTEDesertSpawn(_x,_y,_small ? NTTEBabyScorpion:Scorpion)
    }
    for(var _i=0;_i<6;++_i) {
        var _a=_i*60
        scrNTTEDesertSpawn(_cx+lengthdir_x(64,_a),_cy+lengthdir_y(64,_a),
            _i==0 ? NTTEBabyScorpionGold:NTTEBabyScorpion)
    }
    scrNTTEDesertSpawn(_cx,_cy,NTTESilverScorpion)
    for(var _i=0;_i<3;++_i) scrNTTEDesertSpawn(_cx+(_i-1)*48,_cy+72,NTTEScorpionRock)
    // The original image is 48x48 with an 8px origin, not a 16px tile.
    // Its central opaque 32x32 region fits the native floor cell exactly.
    for(var _i=0;_i<array_length(_room.floors);++_i) {
        var _f=_room.floors[_i]
        with (instance_create(_f.x,_f.y,NTTEDesertDecor)) {
            sprite_index=sprNTTEFloorScorpionTile
            image_index=irandom(1)
            depth=7
        }
    }
}

function scrNTTEDesertPopulate(_forced=-1) {
    if (!instance_exists(GameCont) || !instance_exists(Player) || !global.is_server
        || GameCont.area!=area_desert || instance_exists(TutCont)
        || scrGameIsDailyRun() || scrGameIsWeeklyRun()) return NTTEDesertEvent.Off
    if (_forced<0 && variable_instance_exists(id,"ntte_desert_done") && ntte_desert_done) return NTTEDesertEvent.Off
    if (_forced<0) ntte_desert_done=true
    var _setting=_forced>=0 ? _forced:scrNTTEDesertSetting()
    if (_setting==NTTEDesertEvent.Off) return _setting
    var _chosen=scrNTTEDesertPickEvent(_setting,GameCont.subarea,GameCont.hard)
    if (_chosen!=NTTEDesertEvent.Natural) {
        var _room=scrNTTEDesertRoom(_chosen==NTTEDesertEvent.Nest ? 9:7,_chosen==NTTEDesertEvent.Nest ? 9:5)
        if (is_struct(_room)) {
            switch (_chosen) {
                case NTTEDesertEvent.Camp: scrNTTEDesertCamp(_room); break
                case NTTEDesertEvent.Nest: scrNTTEDesertNest(_room); break
                case NTTEDesertEvent.Scorpions: scrNTTEDesertScorpions(_room); break
            }
            var _icon=_chosen==NTTEDesertEvent.Camp ? sprNTTEBanditAlert:
                (_chosen==NTTEDesertEvent.Nest ? sprNTTEFlyAlert:sprNTTEPetScorpionIcon)
            scrNTTEAlertCreate(_room.x,_room.y-16,_icon)
        }
        else _chosen=NTTEDesertEvent.Natural
    }
    // The large cactus can occur on ordinary desert maps too; it brings two babies.
    var _cactus=instance_furthest(10016,10016,Cactus)
    if (instance_exists(_cactus) && point_distance(_cactus.x,_cactus.y,10016,10016)>128
        && (_setting!=NTTEDesertEvent.Natural || random(9)<1)) {
        var _x=_cactus.x,_y=_cactus.y
        instance_destroy(_cactus,false)
        scrNTTEDesertSpawn(_x,_y,NTTEBigCactus)
        repeat(2) scrNTTEDesertSpawn(_x+orandom(24),_y+orandom(24),NTTEBabyScorpion)
    }
    GameCont.ntte_desert_last_event=_chosen
    return _chosen
}
