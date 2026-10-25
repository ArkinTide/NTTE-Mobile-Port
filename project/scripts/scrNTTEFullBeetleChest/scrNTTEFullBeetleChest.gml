// beetle.race.gml::BeetleChest/BeetleChestOpen. Storage transfers the actual
// native weapon handle and its canonical state, including on room cleanup.
function scrNTTEFullBeetleChestInfo(_index) {
    if(!is_array(scrNTTEFullValue(GameCont,"player_beetle_chest_info_list",undefined))) GameCont.player_beetle_chest_info_list=[]
    while(array_length(GameCont.player_beetle_chest_info_list)<=_index)
        array_push(GameCont.player_beetle_chest_info_list,{wep:wep_none,has_ammo:true,has_blast:true})
    return GameCont.player_beetle_chest_info_list[_index]
}
function scrNTTEFullBeetleChestPlayer(_index) {
    var _who=noone
    with(Player) if(index==_index) { _who=id; break }
    return _who
}
function scrNTTEFullBeetleChestDust(_from,_to) {
    for(var _dir=_from;_dir<_to;_dir+=45) {
        var _fx=instance_create(x,y,Dust); /* NTTE DUST LIFETIME beetle-chest-dust */ if(instance_exists(_fx)) {_fx.direction=_dir; _fx.speed=3*timescale; _fx.depth=depth-1 }
    }
}
function scrNTTEFullBeetleChestCopy(_destination) {
    _destination.spr_shadow=spr_shadow; _destination.spr_shadow_x=spr_shadow_x; _destination.spr_shadow_y=spr_shadow_y
    _destination.image_xscale=image_xscale; _destination.image_yscale=image_yscale; _destination.image_angle=image_angle
    _destination.image_blend=image_blend; _destination.image_alpha=image_alpha
    _destination.mask_index=mask_index<0 ? sprite_index:mask_index
}
function scrNTTEFullBeetleChestCreate() {
    sprite_index=scrNTTERefSprite("QuestChest"); spr_dead=scrNTTERefSprite("QuestChestOpen"); spr_open=sprFXChestOpen
    spr_shadow=shd32; spr_shadow_x=0; spr_shadow_y=-1; snd_open=sndChest; ammo=false
    image_speed=0; ntte_beetle_opening=false
}
function scrNTTEFullBeetleChestOpen(_target) {
    if(ntte_beetle_opening) return noone
    ntte_beetle_opening=true
    var _open=instance_create(x,y,NTTEFullBeetleChestOpen)
    scrNTTEFullBeetleChestCopy(_open)
    if(instance_is(_target,Player)) {
        _open.index=_target.index
        _open.team=_target.team; _open.hitid=_target.hitid
        if(is_array(scrNTTEFullValue(GameCont,"player_beetle_chest_info_list",undefined))) {
            var _info=scrNTTEFullBeetleChestInfo(_target.index),_weapon=_info.wep
            var _ultra=scrNTTEFullRaceUltraGet(_target,1)
            if(_weapon!=wep_none) {
                var _ground=scrNTTEFullSystemsCreate("WepPickupGrounded",x,y)
                var _pickup=scrWeaponPickupCreate(x,y,_weapon,_info.has_ammo)
                _ground.target=_pickup
                // The original supplies twice here, restoring ammo after each
                // collision. The physical pickup remains supplied afterwards.
                if(_info.has_ammo && _ultra) with(_pickup) with(_target) {
                    repeat(2) {
                        event_perform(ev_collision,WepPickup)
                        if(instance_exists(_pickup)) _pickup.ammo=_info.has_ammo
                        else break
                    }
                }
                _info.wep=wep_none
            }
            if(_info.has_blast && _ultra) {
                _info.has_blast=false
                instance_create(x,y,PortalClear)
                for(var _rotation=120;_rotation<=360;_rotation+=120) {
                    // A chest blast makes a real weapon copy; the stored item
                    // on the ground must not gain charge/reload from firing.
                    scrNTTEFullActorFireAt(_open,scrNTTEFullBeetleClone(_weapon),_rotation,undefined,_target)
                    repeat(3) {
                        var _fx=scrNTTEFullSystemsCreate("BoneFX",x,y)
                        _fx.sprite_index=scrNTTERefSprite("BackpackDebris"); _fx.image_index=random(sprite_get_number(_fx.sprite_index)); _fx.creator=_open
                        _fx.direction=_target.gunangle+_rotation; _fx.speed=3*timescale
                    }
                }
                snd_play(scrNTTEFullRaceSound(NTTEFullRace.Beetle,"Chst",_target.snd_chst))
            }
            if(_info.has_ammo) { _info.has_ammo=false; snd_open=_ultra ? sndBigWeaponChest:sndWeaponChest }
        }
    }
    if(sprite_exists(spr_open)) { var _fx=instance_create(x,y,FXChestOpen); _fx.sprite_index=spr_open }
    snd_play(snd_open)
    spr_dead=-1; instance_destroy()
    return _open
}
function scrNTTEFullBeetleChestStep() {
    if(lockstep_stop || instance_exists(GenCont)) return;
    if(random(30)<timescale) {
        var _sparkle=true
        if(is_array(scrNTTEFullValue(GameCont,"player_beetle_chest_info_list",undefined))) {
            _sparkle=false
            with(Player) if(scrNTTEFullPlayerActive(id)) {
                var _info=scrNTTEFullBeetleChestInfo(index)
                if(_info.has_ammo && (_info.wep==wep_none || scr_weapon_get_type(_info.wep)!=Ammo.None)) { _sparkle=true; break }
            }
        }
        if(_sparkle) {
            var _fx=scrNTTEFullSystemsCreate("VaultFlowerSparkle",random_range(bbox_left,bbox_right),random_range(bbox_top,bbox_bottom))
            _fx.sprite_index=scrNTTERefSprite("QuestSparkle"); _fx.depth=depth-1
        }
    }
    var _meet=[Player,PortalShock]
    for(var _i=0;_i<2;++_i) if(place_meeting(x,y,_meet[_i])) {
        var _target=instance_nearest(x,y,_meet[_i])
        // CustomChest's shared Hatred handling also applies to portal opening.
        if(scrCrownCheck(crwn_hatred)) {
            repeat(16) { var _rad=instance_create(x,y,Rad); _rad.direction=random(360); _rad.speed=random_range(2,6)*timescale }
            if(instance_is(_target,Player)) with(_target) scr_hit_self(1,HitId.CrownOfHatred)
        }
        scrNTTEFullBeetleChestOpen(_target); return;
    }
}
function scrNTTEFullBeetleChestDraw() {
    draw_self()
    if(is_array(scrNTTEFullValue(GameCont,"player_beetle_chest_info_list",undefined))) {
        var _blast=false
        with(Player) if(scrNTTEFullPlayerActive(id) && scrNTTEFullRaceUltraGet(id,1) && scrNTTEFullBeetleChestInfo(index).has_blast) { _blast=true; break }
        if(_blast) draw_sprite(sprGunWarrant,current_frame*0.4,x,y)
    }
}
function scrNTTEFullBeetleChestOpenCreate() {
    sprite_index=scrNTTERefSprite("QuestChestOpen"); image_speed=0; depth=1
    spr_shadow=shd32; spr_shadow_x=0; spr_shadow_y=-1
    index=-1; target=noone; ntte_beetle_stored=false; ntte_beetle_closing=false
    prompt=scrNTTEFullPromptCreate(id,"DROP"); prompt.visible=false
}
function scrNTTEFullBeetleChestOpenEmpty() {
    var _owner=scrNTTEFullBeetleChestPlayer(index)
    if(!instance_exists(_owner) || !_owner.visible) return false
    if(is_array(scrNTTEFullValue(GameCont,"player_beetle_chest_info_list",undefined)) && scrNTTEFullBeetleChestInfo(index).wep!=wep_none) return false
    var _has=false
    with(WepPickup) if(visible && curse<=0 && place_meeting(x,y,other)) { _has=true; break }
    return !_has
}
function scrNTTEFullBeetleChestOpenStep() {
    if(lockstep_stop) return;
    var _empty=scrNTTEFullBeetleChestOpenEmpty(),_players=0
    with(Player) if(visible) _players+=1
    if((_empty && _players==1) || place_meeting(x,y,Player) || place_meeting(x,y,PortalShock)) {
        if(instance_exists(prompt)) {
            prompt.visible=_empty
            if(_empty) {
                var _p=scrNTTEFullBeetleChestPlayer(prompt.pick),_chest=id
                if(instance_exists(_p)) with(_p) if(can_pick && wep!=wep_none) {
                    if(curse<=0) {
                        scrWeaponPickupCreate(_chest.x,_chest.y,wep,false)
                        snd_play(wep==wep_guitar ? sndGuitarPickup:sndWeaponPickup,1+orandom(0.1))
                        wep=wep_none; curse=0; ntte_state=scrNTTEFullBeetleEquipState(wep_none)
                        scrSwapWeps(false); clicked=false
                    }
                    else snd_play(sndCursedReminder,1+orandom(0.05))
                }
            }
        }
    }
    else { ntte_beetle_closing=true; instance_destroy() }
}
function scrNTTEFullBeetleChestStore() {
    if(ntte_beetle_stored) return false
    ntte_beetle_stored=true
    // NTTE BEETLE SOURCE REGISTERED SLOT STORAGE: ref_player_is_active checks slot membership.
    if(!is_struct(scr_playerinstance_find(index))) return false
    var _info=scrNTTEFullBeetleChestInfo(index)
    if(_info.wep!=wep_none) return false
    var _nearest=noone,_distance=infinity
    with(WepPickup) if(visible && curse<=0) {
        var _d=point_distance(x,y,other.x,other.y)
        if(_d<_distance) { _distance=_d; _nearest=id }
    }
    if(!instance_exists(_nearest)) return false
    var _can=false
    with(_nearest) _can=place_meeting(x,y,other) || collision_line(x,y,other.x,other.y,Wall,false,false)==noone
    if(!_can) return false
    // No distance cutoff: the original stores the nearest visible weapon
    // anywhere in clear line of sight, not only one touching the chest.
    _info.wep=_nearest.wep; _info.has_ammo=_nearest.ammo
    with(_nearest) scrNTTEFullBeetleChestDust(22.5,180)
    instance_destroy(_nearest)
    return true
}
function scrNTTEFullBeetleChestOpenDestroy() {
    // Store before creating the replacement so a room transition can use the
    // cleanup path without spawning a redundant chest/effects in the next room.
    scrNTTEFullBeetleChestStore()
    if(ntte_beetle_closing) {
        var _closed=instance_create(x,y,NTTEFullBeetleChest)
        scrNTTEFullBeetleChestCopy(_closed)
        with(_closed) scrNTTEFullBeetleChestDust(202.5,360)
        snd_play(sndMimicMelee,1+orandom(0.1),2/3)
    }
}
function scrNTTEFullBeetleChestOpenCleanup() {
    scrNTTEFullBeetleChestStore()
    if(instance_exists(prompt)) instance_destroy(prompt)
}
function scrNTTEFullBeetleChestBeforeRoomEnd() {
    // Must precede the native transition's Player/WepPickup destruction.
    with(NTTEFullBeetleChestOpen) scrNTTEFullBeetleChestStore()
}
function scrNTTEFullBeetleChestRecall(_pressed) {
    if(race!=NTTEFullRace.Beetle || !_pressed || !scrNTTEFullPlayerActive(id)
        || !scrNTTEFullRaceUltraGet(id,1) || (is_struct(scrNTTEFullValue(id,"beetle_menu_info",undefined)) && beetle_menu_info.is_open)) return false
    if(wep!=wep_none && (infammo!=0 || (ammo[scr_weapon_get_type(wep)]>=scr_weapon_get_cost(wep) && GameCont.rad>=scr_weapon_get_rads(wep)))) return false
    var _chest=instance_nearest(x,y,NTTEFullBeetleChest)
    if(!instance_exists(_chest) || point_distance(x,y,_chest.x,_chest.y)<=64) return false
    var _px=x,_py=y
    with(_chest) {
        for(var _d=0;_d<360;_d+=60) { var _fx=instance_create(x,y,Dust); /* NTTE DUST LIFETIME beetle-chest-recall */ if(instance_exists(_fx)) {_fx.direction=_d; _fx.speed=3*timescale } }
        x=_px; y=_py; xprevious=x; yprevious=y; scrNTTEFullWorldBudge(id,Wall)
        for(var _d=0;_d<360;_d+=60) { var _fx=instance_create(x,y,Dust); /* NTTE DUST LIFETIME beetle-chest-recall */ if(instance_exists(_fx)) {_fx.direction=_d; _fx.speed=3*timescale } }
    }
    snd_play(sndChickenReturn,1.2+orandom(0.1),1.5)
    return true
}
function scrNTTEFullBeetleChestLevelStart(_sx,_sy,_normal_area,_hard) {
    var _beetles=[]
    with(Player) if(race==NTTEFullRace.Beetle) array_push(_beetles,id)
    if(array_length(_beetles)==0) return noone
    var _cx=_sx,_cy=_sy
    if(_normal_area || _hard==1) {
        var _candidates=[],_floors=scrNTTEFullInstances(Floor,true)
        for(var _i=0;_i<array_length(_floors);++_i) with(_floors[_i]) {
            var _central=true
            for(var _xx=bbox_left-8;_xx<=bbox_right+8;_xx+=16)
                for(var _yy=bbox_top-8;_yy<=bbox_bottom+8;_yy+=16)
                    if(_xx<bbox_left || _xx>bbox_right || _yy<bbox_top || _yy>bbox_bottom)
                        if(!position_meeting(_xx,_yy,Floor)) { _central=false; break }
            if(_central) array_push(_candidates,id)
        }
        if(array_length(_candidates)==0) _candidates=_floors
        var _preferred=[]
        for(var _i=0;_i<array_length(_candidates);++_i) {
            var _v=_candidates[_i],_x=(_v.bbox_left+_v.bbox_right)/2,_y=(_v.bbox_top+_v.bbox_bottom)/2,_clear=false
            with(WeaponChest) if(collision_line(x,y,_x,_y,Wall,false,false)==noone) { _clear=true; break }
            if(_clear) array_push(_preferred,_v)
        }
        if(array_length(_preferred)>0) _candidates=_preferred
        scrNTTEFullFloorSetStyle(true)
        var _start=scrNTTEFullFloorRoomStart(_sx,_sy,64,_candidates)
        if(is_struct(_start)) {
            var _room=scrNTTEFullFloorRoomCreate(_start.x,_start.y,2,2,"",random(360),0,-32)
            _cx=_room.x; _cy=_room.y
            var _hurt=[]
            for(var _i=0;_i<array_length(_beetles);++_i) if(_beetles[_i].headloses>0) array_push(_hurt,_beetles[_i])
            _hurt=array_shuffle(_hurt)
            if(array_length(_room.floors)>0) {
                var _fi=irandom(array_length(_room.floors)-1)
                for(var _i=0;_i<array_length(_hurt);++_i) {
                    if(instance_number(HealthChest)>=array_length(_hurt)) break
                    if(random(2)<1 && random(8)>=_hurt[_i].max_hp) {
                        var _f=_room.floors[_fi%array_length(_room.floors)]
                        scrNTTEFullLairChestCreate((_f.bbox_left+_f.bbox_right)/2,(_f.bbox_top+_f.bbox_bottom)/2,HealthChest,true)
                        _fi+=1
                    }
                }
            }
        }
        scrNTTEFullFloorResetStyle()
    }
    // The source initializes storage lazily; keep the no-list first opening
    // behavior rather than giving the initial empty chest a new supply.
    if(is_array(scrNTTEFullValue(GameCont,"player_beetle_chest_info_list",undefined)))
        for(var _i=0;_i<array_length(_beetles);++_i) {
            var _info=scrNTTEFullBeetleChestInfo(_beetles[_i].index); _info.has_ammo=true; _info.has_blast=true
        }
    return scrNTTEFullLairChestCreate(_cx,_cy,"BeetleChest",true)
}
function scrNTTEFullBeetleChestTests() {
    var _p=instance_find(Player,0),_before=scrNTTEFullInstances(all),_oldinfo=scrNTTEFullValue(GameCont,"player_beetle_chest_info_list",undefined)
    var _old={x:_p.x,y:_p.y,race:_p.race,wep:_p.wep,bwep:_p.bwep,curse:_p.curse,bcurse:_p.bcurse,
        state:_p.ntte_state,bstate:_p.bntte_state,pick:_p.can_pick,ultra:scrNTTEFullValue(_p,"ntte_race_ultra",0),
        ammo:scrNTTEFullArrayCopy(_p.ammo),presspick:KeyCont.press_pick[_p.index],angle:_p.gunangle,menu:scrNTTEFullValue(_p,"beetle_menu_info",undefined)}
    GameCont.player_beetle_chest_info_list=[]
    _p.x=71000; _p.y=71000; _p.race=NTTEFullRace.Beetle; _p.ntte_race_ultra=0
    var _open=instance_create(_p.x,_p.y,NTTEFullBeetleChestOpen); _open.index=_p.index
    var _model=scrNTTEFullWeaponMerge(wep_revolver,wep_shotgun),_handle=scrNTTEFullWeaponNative(_model)
    var _state=scrNTTEFullWeaponNativeState(_handle); _state.beetle_test_charge=17
    var _item=scrWeaponPickupCreate(_p.x+140,_p.y,_handle,true)
    var _cursed=scrWeaponPickupCreate(_p.x+1,_p.y,wep_crossbow,false); _cursed.curse=1
    var _hidden=scrWeaponPickupCreate(_p.x+2,_p.y,wep_wrench,false); _hidden.visible=false
    var _stored=false
    with(_open) _stored=scrNTTEFullBeetleChestStore()
    var _info=scrNTTEFullBeetleChestInfo(_p.index)
    assert(_stored && !instance_exists(_item) && instance_exists(_cursed) && instance_exists(_hidden),
        "Beetle chest storage did not filter cursed/invisible items or lost original unrestricted LOS range")
    assert(_info.wep==_handle && _info.has_ammo && scrNTTEFullWeaponNativeState(_info.wep)==_state && _state.beetle_test_charge==17,
        "Beetle chest cloned/lost physical merged weapon state during storage")
    with(_open) _stored=scrNTTEFullBeetleChestStore()
    assert(!_stored && _info.wep==_handle,"Beetle chest cleanup stored or consumed twice")
    instance_destroy(_open,false)
    var _closed=instance_create(_p.x,_p.y,NTTEFullBeetleChest),_released=noone
    with(_closed) _released=scrNTTEFullBeetleChestOpen(_p)
    var _grounds=scrNTTEFullInstances(NTTEFullWepPickupGrounded),_drop=noone
    for(var _i=0;_i<array_length(_grounds);++_i) if(array_get_index(_before,_grounds[_i])<0 && instance_exists(_grounds[_i].target)) {
        if(_grounds[_i].target.wep==_handle) _drop=_grounds[_i].target
    }
    assert(instance_exists(_released) && _released.index==_p.index && instance_exists(_drop) && _drop.ammo && _info.wep==wep_none && !_info.has_ammo,
        "Beetle opening did not release exactly the stored supplied item through the real grounded weapon wrapper")
    assert(scrNTTEFullWeaponNativeState(_drop.wep)==_state,"Beetle opening changed the stored physical weapon model/state identity")
    // Store before real room-transition destruction, then reset the same
    // supply exactly once at the next level (no duplication or clone).
    scrNTTEFullBeetleChestBeforeRoomEnd()
    assert(_info.wep==_handle && !instance_exists(_drop),"Beetle room-end hook failed to preserve the released item before native teardown")
    var _level=scrNTTEFullBeetleChestLevelStart(_p.x,_p.y,false,0)
    assert(instance_exists(_level) && _info.wep==_handle && _info.has_ammo && _info.has_blast,
        "Beetle level start did not replenish storage supply/blast while preserving its actual weapon")
    // Prompt drop transfers the actual current item then swaps to secondary.
    _info.wep=wep_none
    var _promptChest=instance_create(_p.x,_p.y,NTTEFullBeetleChestOpen); _promptChest.index=_p.index
    _p.wep=_handle; _p.bwep=wep_wrench; _p.curse=0; _p.bcurse=0; _p.can_pick=true
    _p.ntte_state=_state; _p.bntte_state=scrNTTEFullBeetleEquipState(wep_wrench)
    _promptChest.prompt.pick=_p.index
    with(_promptChest) scrNTTEFullBeetleChestOpenStep()
    var _found=false
    with(WepPickup) if(wep==_handle && point_distance(x,y,_p.x,_p.y)<1) _found=true
    assert(_found && _p.wep==wep_wrench && _p.bwep==wep_none,"Beetle DROP prompt failed real native slot transfer/swap")
    // Ultra A uses the actual native collision supply twice, then fires from
    // the chest in three authored directions without charging player ammo.
    _promptChest.prompt.visible=false; KeyCont.press_pick[_p.index]=false
    _p.ammo[Ammo.Bullets]=0; _p.ntte_race_ultra=1; _p.gunangle=17
    _info.wep=wep_revolver; _info.has_ammo=true; _info.has_blast=true
    var _bulletbefore=scrNTTEFullInstances(Bullet1),_ultrachest=instance_create(_p.x,_p.y,NTTEFullBeetleChest),_ultraopen=noone
    with(_ultrachest) _ultraopen=scrNTTEFullBeetleChestOpen(_p)
    var _bullets=scrNTTEFullInstances(Bullet1),_angles=[]
    for(var _i=0;_i<array_length(_bullets);++_i) if(array_get_index(_bulletbefore,_bullets[_i])<0) {
        assert(_bullets[_i].creator==_p && _bullets[_i].team==_p.team,"Beetle Ultra chest projectile lost real player ownership/team")
        array_push(_angles,scrNTTEFullValue(_bullets[_i],"ntte_actor_angle",undefined))
    }
    assert(array_length(_angles)==3 && array_get_index(_angles,137)>=0 && array_get_index(_angles,257)>=0 && array_get_index(_angles,377)>=0,
        "Beetle Ultra A did not emit the original 120/240/360-degree weapon shots")
    assert(_p.ammo[Ammo.Bullets]==min(typ_amax[Ammo.Bullets],4*scrAmmoGetPickupAmount(Ammo.Bullets)) && !_info.has_blast && !_info.has_ammo,
        "Beetle Ultra A double supply was lost, replayed or consumed by the chest blast")
    // Recall requires an empty/insufficient weapon, never a distance shortcut
    // for a supplied weapon, and can move a chest only beyond source64px.
    var _recall=instance_create(_p.x+300,_p.y,NTTEFullBeetleChest),_recalled=false
    // Other closed fixtures would win nearest; remove just those test chests.
    var _closedlist=scrNTTEFullInstances(NTTEFullBeetleChest)
    for(var _i=0;_i<array_length(_closedlist);++_i) if(_closedlist[_i]!=_recall && array_get_index(_before,_closedlist[_i])<0) instance_destroy(_closedlist[_i],false)
    with(_p) { wep=wep_none; beetle_menu_info=scrNTTEFullBeetleMenuNew(); _recalled=scrNTTEFullBeetleChestRecall(true) }
    assert(_recalled && point_distance(_p.x,_p.y,_recall.x,_recall.y)<1,"Beetle Ultra A failed to recall the remote chest on empty-weapon fire input")
    with(_p) _recalled=scrNTTEFullBeetleChestRecall(true)
    assert(!_recalled,"Beetle Ultra A recalled a chest already within the source64px distance")
    var _all=scrNTTEFullInstances(all)
    // Mark every test chest stored before cleanup so the cleanup itself cannot
    // vacuum original gameplay pickups as the fixture is removed.
    for(var _i=0;_i<array_length(_all);++_i) if(array_get_index(_before,_all[_i])<0 && instance_exists(_all[_i])) {
        if(instance_is(_all[_i],NTTEFullBeetleChestOpen)) _all[_i].ntte_beetle_stored=true
        instance_destroy(_all[_i],false)
    }
    with(_p) { x=_old.x; y=_old.y; race=_old.race; wep=_old.wep; bwep=_old.bwep; curse=_old.curse; bcurse=_old.bcurse;
        ntte_state=_old.state; bntte_state=_old.bstate; can_pick=_old.pick; ntte_race_ultra=_old.ultra; ammo=_old.ammo;
        gunangle=_old.angle; beetle_menu_info=_old.menu }
    KeyCont.press_pick[_p.index]=_old.presspick
    GameCont.player_beetle_chest_info_list=_oldinfo
    scrNTTESmokeLog("SYSTEMS BEETLE CHEST: source LOS/no-range storage, curse/invisible filters, actual merged state/grounded transfers, room-end persistence, native DROP, Ultra A double supply/three owner shots and64px recall OK")
}
