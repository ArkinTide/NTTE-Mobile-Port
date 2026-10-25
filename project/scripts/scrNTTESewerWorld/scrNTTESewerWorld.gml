enum NTTESewerEvent { Natural, Den, Off, Bats, Cats }

function scrNTTESewerSetting() {
    if(!scrNTTESmokeEnabled()) return NTTESewerEvent.Natural
    if (!scrGameIsCustomMode() || !is_struct(UberCont.custom_options)) return NTTESewerEvent.Natural
    if (!variable_struct_exists(UberCont.custom_options,"ntte_sewer_event")) UberCont.custom_options.ntte_sewer_event=0
    return clamp(floor(UberCont.custom_options.ntte_sewer_event),0,4)
}

function scrNTTESewerEventName(_event) {
    switch (_event) {
        case NTTESewerEvent.Den: return "GATOR DEN"
        case NTTESewerEvent.Off: return "OFF"
        case NTTESewerEvent.Bats: return "BATS"
        case NTTESewerEvent.Cats: return "CATS"
    }
    return "NATURAL"
}

function scrNTTESewerDen(_room) {
    var _cx=_room.x,_cy=_room.y
    scrNTTEDesertSpawn(_cx,_cy,NTTESewerTable)
    with (instance_create(_cx,_cy,NTTEDesertDecor)) {
        sprite_index=sprNTTERug
        image_index=0
        depth=6
    }
    // Four seated gators: the two new types are guaranteed in the test encounter.
    var _types=[NTTEBabyGator,NTTEBoneGator,NTTEAlbinoGator,BuffGator]
    for(var _i=0;_i<4;++_i) {
        var _d=(_i<2 ? 0:180)+((_i mod 2)==0 ? -20:20),
            _g=scrNTTEDesertSpawn(_cx+lengthdir_x(34,_d),_cy+lengthdir_y(34,_d),_types[_i])
        if (!instance_exists(_g)) continue
        _g.gunangle=(_d+180+360) mod 360
        _g.right=sign(lengthdir_x(1,_g.gunangle))
        if (_i<3) {
            _g.ntte_gator_den=true
            _g.ntte_gator_awake=false
        }
        else _g.alarm[1]=90
    }
    // Relocate the level's existing chests; special animal chests are a later stage.
    var _chests=[]
    with (chestprop) if (instance_is(id,WeaponChest) || instance_is(id,AmmoChest)) array_push(_chests,id)
    for(var _i=0;_i<min(3,array_length(_chests));++_i) {
        var _chest=_chests[_i]
        _chest.x=_cx+(_i-1)*40
        _chest.y=_cy-56
        _chest.xprevious=_chest.x; _chest.yprevious=_chest.y
        _chest.xstart=_chest.x; _chest.ystart=_chest.y
    }
}

function scrNTTESewerPopulate(_forced=-1) {
    if (!instance_exists(GameCont) || !instance_exists(Player) || !global.is_server
        || GameCont.area!=area_sewers || instance_exists(TutCont)
        || scrGameIsDailyRun() || scrGameIsWeeklyRun()) return NTTESewerEvent.Off
    if (_forced<0 && variable_instance_exists(id,"ntte_sewer_done") && ntte_sewer_done) return NTTESewerEvent.Off
    if (_forced<0) ntte_sewer_done=true
    var _setting=_forced>=0 ? _forced:scrNTTESewerSetting(),_chosen=NTTESewerEvent.Natural
    if (_setting==NTTESewerEvent.Off) return _setting
    // Original natural chance is gated by NTTE's Crime Crown unlock. That crown
    // has not been ported; do not silently bypass the gate. Custom mode forces it.
    if (_setting==NTTESewerEvent.Den) _chosen=NTTESewerEvent.Den
    if (_setting==NTTESewerEvent.Bats) {
        // Explicit custom encounter: the original natural replacement code was
        // disabled. Do not invent a natural spawn chance or bypass crown gates.
        var _room=scrNTTEDesertRoom(5,5)
        if (is_struct(_room)) {
            for(var _i=0;_i<4;++_i) {
                var _d=45+90*_i
                scrNTTEDesertSpawn(_room.x+lengthdir_x(40,_d),_room.y+lengthdir_y(40,_d),NTTEBat)
            }
            scrNTTEAlertCreate(_room.x,_room.y-16,sprNTTEBatIdle)
            _chosen=NTTESewerEvent.Bats
        }
    }
    if (_setting==NTTESewerEvent.Cats) {
        var _room=scrNTTEDesertRoom(7,5)
        if (is_struct(_room)) {
            for(var _i=0;_i<3;++_i) {
                var _d=30+120*_i
                scrNTTEDesertSpawn(_room.x+lengthdir_x(64,_d),_room.y+lengthdir_y(48,_d),NTTECatHole)
                scrNTTEDesertSpawn(_room.x+lengthdir_x(36,_d),_room.y+lengthdir_y(28,_d),NTTECat)
            }
            scrNTTEDesertSpawn(_room.x,_room.y-48,NTTEBat)
            _chosen=NTTESewerEvent.Cats
        }
    }
    if (_chosen==NTTESewerEvent.Den) {
        // Connected native-grid chamber (5x5 instead of the NTT 5x4 room).
        var _room=scrNTTEDesertRoom(5,5)
        if (is_struct(_room)) {
            scrNTTESewerDen(_room)
            // Original GatorDen shows its GatorAlert when the seated group wakes.
        }
        else _chosen=NTTESewerEvent.Natural
    }
    GameCont.ntte_sewer_last_event=_chosen
    return _chosen
}
