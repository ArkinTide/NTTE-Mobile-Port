// Original petlib.Prism. Lightning metadata is attached by native generator
// hooks, because Epsilon grows a whole chain synchronously instead of Alarm0.
function scrNTTEFullPrismLightningMetadata(_first,_remaining) {
    var _nodes=scrNTTEFullInstances(Lightning),_chain=[]
    for(var _i=0;_i<array_length(_nodes);++_i) if(_nodes[_i].id>=_first) array_push(_chain,_nodes[_i])
    for(var _i=0;_i<array_length(_chain);++_i) {
        _chain[_i].ntte_prism_chain=_chain
        _chain[_i].ntte_prism_remaining=max(0,_remaining-_i)
    }
}
function scrNTTEFullPetPrismCreate() {
    spr_idle=scrNTTERefSprite("PetPrismIdle"); spr_walk=spr_idle; spr_hurt=spr_idle
    spr_icon=scrNTTERefSprite("PetPrismIcon"); spr_shadow_y=-1; spr_bubble=-1; spr_bubble_pop=-1
    depth=-3; mask_index=mskFrogEgg; maxspeed=2.5; tp_delay=irandom(30); ntte_pet_alarm=-1
    spawn_loc=[x,y]; path_wall=[Wall]; flash_frame=0
    stat.splits=scrNTTEFullValue(stat,"splits",0)
    hooks={step:method(id,scrNTTEFullPetPrismStep),draw:method(id,scrNTTEFullPetPrismDraw),alarm:method(id,function(_dir,_dis) { return 999999999 })}
}
function scrNTTEFullPetPrismSplit(_projectile) {
    var _pet=id,_clone=noone
    with(_projectile) {
        can_prism_duplicate=false
        if(scrNTTEFullValue(id,"prism_duplicate",false)) {
            if(speed>timescale) snd_play(sndCursedReminder,1.5)
            return noone
        }
        prism_duplicate=false; _pet.stat.splits+=1; _pet.speed*=0.5
        var _direction=random(360)
        for(var _dis=6;_dis>=-6;_dis-=2) {
            var _trail=instance_create(_pet.x+lengthdir_x(_dis,_direction),_pet.y+lengthdir_y(_dis,_direction),BoltTrail)
            _trail.direction=_direction; _trail.speed=timescale; _trail.image_angle=_direction; _trail.image_xscale=2
            _trail.image_yscale=1+(1-(_dis+6)/12)
            if(scr_skill_get(mut_bolt_marrow)>0) _trail.image_yscale*=0.7
            _trail.depth=-4
        }
        instance_create(x+orandom(16),y+orandom(16),CaveSparkle)
        snd_play(sndCrystalShield,1.4+orandom(0.1),2.4)
        _pet.flash_frame=max(_pet.flash_frame,current_frame+max(1,sprite_height/16))
        var _native_attack=instance_is(id,NTTEAttack)
        var _cursed=_native_attack ? !cursed:(variable_instance_exists(id,"curse") && curse<=0)
        if(_cursed) {
            if(_native_attack) cursed=true
            else curse=true
            for(var _i=0;_i<3;++_i) {
                var _streak=scrNTTEFullPetEffect(x,y,[direction+orandom(5),2+3*_i],AcidStreak)
                _streak.sprite_index=scrNTTERefSprite("WaterStreak"); _streak.image_speed=random_range(0.2,0.4)*timescale
                _streak.image_blend=make_color_rgb(103,27,131); _streak.depth=-4
            }
            snd_play(sndCursedChest,0.8)
        }
        // Original Trident curses instead of splitting on its first pass.
        var _trident=_native_attack && scrNTTEFullValue(id,"kind",-1)==NTTEKind.Trident
        if(!_cursed || !_trident) {
            _clone=scrNTTEFullOrchidClone(id)
            // The mobile weapon layer stores returning ammo on one shared state
            // identity. A cloned projectile reserves an additional return on it.
            if(_native_attack && instance_exists(_clone)) {
                _clone.state=state
                if(is_struct(state) && !refunded && refund>0 && state_epoch==state.epoch) state.outstanding+=refund
            }
            var _accuracy=scrNTTEFullValue(_pet.leader,"accuracy",1)
            if(object_index==Laser) {
                var _length=point_distance(xstart,ystart,_pet.x,_pet.y)+12,_angle=image_angle
                with(_clone) {
                    x=other.xstart+lengthdir_x(_length,_angle); y=other.ystart+lengthdir_y(_length,_angle)
                    xstart=x; ystart=y; image_angle+=orandom(20*_accuracy)
                    event_perform(ev_alarm,0)
                }
            } else if(object_index==Lightning) {
                var _chain=scrNTTEFullValue(id,"ntte_prism_chain",[id])
                for(var _i=0;_i<array_length(_chain);++_i) if(instance_exists(_chain[_i])) _chain[_i].prism_duplicate=true
                var _angle=image_angle+random_range(20,40)*choose(-1,1)*_accuracy
                // Native nodes expose their post-Alarm ammo directly. Mobile
                // metadata records the pre-decrement budget of a moved segment.
                var _remaining=variable_instance_exists(id,"ammo") ? ammo
                    :scrNTTEFullValue(id,"ntte_prism_remaining",1)-1
                _clone.image_angle=_angle
                var _names=variable_instance_get_names(_clone)
                var _exclude=["id","object_index","bbox_bottom","bbox_top","bbox_right","bbox_left","image_number","sprite_yoffset","sprite_xoffset","sprite_height","sprite_width","ammo","x","y","xstart","ystart","xprevious","yprevious","image_xscale","image_yscale","image_angle","direction","ntte_full_lightning_chain","ntte_prism_chain","ntte_prism_remaining"]
                with(_clone) {
                    // Original petlib2549..2552 always grows this copied node,
                    // even at zero/negative ammo. It creates no new spawn FX.
                    ammo=min(30,_remaining);ntte_full_lightning_chain={nodes:[]}
                    event_perform(ev_alarm,0)
                }
                with(Lightning) if(id>_clone) {
                    prism_duplicate=true
                    for(var _i=0;_i<array_length(_names);++_i) {
                        var _name=_names[_i]
                        if(array_get_index(_exclude,_name)<0) variable_instance_set(id,_name,variable_instance_get(_clone,_name))
                    }
                    // These children are native Alarm0 births, followed by
                    // explicit field copies rather than instance_copy. Keep
                    // their copied effect tags for next-event discovery.
                    scrNTTEFullMergedEffectsQueueCopiedTags(id)
                }
            } else {
                var _offset=random_range(4,16)*_accuracy
                direction+=_offset; image_angle+=_offset
                _clone.direction-=_offset; _clone.image_angle-=_offset
            }
        }
        prism_duplicate=true
    }
    return _clone
}
function scrNTTEFullPetPrismStep() {
    var _pet=id
    if(instance_exists(leader)) {
        spawn_loc=[x,y]; scrNTTEFullPetWalk(direction,1)
        var _candidates=[]
        with(projectile) if((team==_pet.leader.team || creator==_pet.leader)
            && scrNTTEFullValue(id,"can_prism_duplicate",true) && distance_to_object(_pet)<=8) array_push(_candidates,id)
        for(var _i=0;_i<array_length(_candidates);++_i) {
            var _candidate=_candidates[_i]
            if(instance_exists(_candidate) && (_candidate.speed!=0 || _candidate.x!=_candidate.xstart
                || _candidate.y!=_candidate.ystart || !position_meeting(_candidate.xstart,_candidate.ystart,id))) scrNTTEFullPetPrismSplit(_candidate)
        }
        with(projectile) if(speed>0 && !scrNTTEFullValue(id,"can_prism_duplicate",true)) {
            var _round=id,_near=false
            with(NTTEFullPet) if(pet=="Prism" && bbox_right>=_round.bbox_left-16 && bbox_left<=_round.bbox_right+16
                && bbox_bottom>=_round.bbox_top-16 && bbox_top<=_round.bbox_bottom+16) _near=true
            if(!_near) can_prism_duplicate=true
        }
        if(tp_delay>0) tp_delay-=timescale
        else if(!collision_circle(leader.x,leader.y,96,id,true,false)) {
            tp_delay=15
            var _old_x=x,_old_y=y,_distance=96,_direction=point_direction(leader.x,leader.y,x,y)+180
            var _leader_on_floor=false
            with(leader) _leader_on_floor=place_meeting(x,y,Floor)
            do {
                x=leader.x+lengthdir_x(_distance,_direction)+orandom(4)
                y=leader.y+lengthdir_y(_distance,_direction)+orandom(4); _distance-=4
            } until(_distance< -12 || (!place_meeting(x,y,Wall) && (place_meeting(x,y,Floor) || !_leader_on_floor)))
            if(!place_meeting(x,y,Wall)) {
                flash_frame=max(flash_frame,current_frame+1)
                repeat(4) { var _fx=instance_create(_old_x+orandom(6),_old_y+orandom(6),irandom(5)==0 ? CaveSparkle:Curse); _fx.direction=random(360); _fx.depth=depth-1 }
                snd_play(sndCursedReminder,0.6+orandom(0.1),2)
            }
        }
    } else {
        x+=sin(current_frame/10)*0.4*timescale; y+=cos(current_frame/10)*0.4*timescale
        if(tp_delay>0) tp_delay-=timescale
        else if(instance_exists(Floor)) {
            tp_delay=irandom(30)
            if(!position_meeting(spawn_loc[0],spawn_loc[1],Floor)) {
                var _floor=instance_find(Floor,irandom(instance_number(Floor)-1))
                spawn_loc=[(_floor.bbox_left+_floor.bbox_right+1)/2,(_floor.bbox_top+_floor.bbox_bottom+1)/2]
            }
            var _floor=scrNTTEFullNearestBBox(spawn_loc[0]+orandom(64),spawn_loc[1]+orandom(64),Floor)
            var _fx=(_floor.bbox_left+_floor.bbox_right+1)/2,_fy=(_floor.bbox_top+_floor.bbox_bottom+1)/2
            if(!place_meeting(_fx,_fy,Wall)) {
                x=_fx; y=_fy; flash_frame=max(flash_frame,current_frame+1)
                repeat(4) { var _fx=instance_create(x+orandom(6),y+orandom(6),irandom(5)==0 ? CaveSparkle:Curse); _fx.direction=random(360); _fx.depth=depth-1 }
                snd_play(sndCursedReminder,0.6+orandom(0.1),2+random(2))
            }
        }
    }
    if(place_meeting(x+hspeed,y+vspeed,Wall)) {
        if(place_meeting(x+hspeed,y,Wall)) hspeed*=-1
        if(place_meeting(x,y+vspeed,Wall)) vspeed*=-1
        direction+=orandom(20)
    }
    if(random(3)<timescale) repeat(irandom(4)) instance_create(x+orandom(8),y+orandom(8),Curse)
}
function scrNTTEFullPetPrismDraw(_spr,_img,_x,_y,_xsc,_ysc,_ang,_col,_alp) {
    if(flash_frame>current_frame) gpu_set_fog(true,image_blend,0,0)
    draw_sprite_ext(_spr,_img,_x,_y,_xsc,_ysc,_ang,_col,_alp)
    if(flash_frame>current_frame) gpu_set_fog(false,0,0,0)
}
function scrNTTEFullPetPrismTests() {
    var _p=instance_find(Player,0),_old=scrNTTEFullValue(_p,"ntte_pet",[]),_oldmax=scrNTTEFullValue(_p,"ntte_pet_max",undefined)
    _p.ntte_pet=[]; _p.ntte_pet_max=1
    var _pet=scrNTTEFullPetCreate(_p.x+12,_p.y,"Prism"); scrNTTEFullPetTake(_pet,_p)
    assert(_pet.pet=="Prism" && _pet.maxspeed==2.5 && is_callable(_pet.hooks.step),"Prism constructor/source stats changed")
    var _shot=instance_create(_pet.x,_pet.y,Laser)
    _shot.team=_p.team; _shot.creator=_p; _shot.speed=2; _shot.direction=0; _shot.image_angle=0
    _shot.xstart=_shot.x; _shot.ystart=_shot.y; _shot.can_prism_duplicate=true
    var _before=_pet.stat.splits,_clone=noone
    with(_pet) _clone=scrNTTEFullPetPrismSplit(_shot)
    assert(instance_exists(_clone) && _pet.stat.splits==_before+1 && _clone.creator==_p,"Prism failed to split an allied Laser with preserved ownership")
    if(instance_exists(_shot)) instance_destroy(_shot,false); if(instance_exists(_clone)) instance_destroy(_clone,false)
    var _state=scrNTTENewState(wep_ntte_sawblade_gun)
    _state.ammo=0; _state.outstanding=1
    _shot=instance_create(_pet.x,_pet.y,NTTEAttack)
    _shot.kind=NTTEKind.Disc; _shot.state=_state; _shot.state_epoch=_state.epoch; _shot.refund=1
    _shot.team=_p.team; _shot.creator=_p; _shot.direction=0; _shot.image_angle=0
    with(_pet) _clone=scrNTTEFullPetPrismSplit(_shot)
    assert(instance_exists(_clone) && _clone.state==_state && _state.outstanding==2,
        "Prism returning attack split lost shared state identity or outstanding reservation")
    instance_destroy(_shot); instance_destroy(_clone)
    assert(_state.outstanding==0,"Prism cloned return cleanup left outstanding ammo reservations")
    scrNTTEFullPetPrismLightningTests(_p,_pet)
    instance_destroy(_pet,false); _p.ntte_pet=_old; _p.ntte_pet_max=_oldmax
    scrNTTESmokeLog("SYSTEMS PET PRISM: constructor, allied Laser split, ownership and split stats OK")
}

// Original petlib2549..2552 grows the copied segment itself, including a
// depleted segment. Check real Alarm0 geometry/terminal effects and quantities;
// the ordinary mobile constructor has a different first-segment convention.
function scrNTTEFullPetPrismLightningTests(_owner,_pet) {
    var _before=scrNTTEFullInstances(all),_game=scrNTTEFullAreaGeneratorSnapshot(GameCont),
        _seed=random_get_seed(),_plain=variable_global_exists("ntte_full_merged_plain_depth")
            ?global.ntte_full_merged_plain_depth:0
    GameCont.area=1;GameCont.underwater=false;global.ntte_full_merged_plain_depth=0
    try {
        scrNTTEFullPrismLightningTraceTests(_owner)
        var _budgets=[0,1,3,2.5,31,-1]
        for(var _trial=0;_trial<array_length(_budgets);++_trial) {
            var _budget=_budgets[_trial],_source=noone
            with(_owner) _source=scrNTTEFullMergedLightningCreate(92000+_trial*1000,92000,0,_budget+1)
            assert(instance_exists(_source) && _source.ammo==_budget,
                "Prism Lightning test failed to create actual native post-Alarm budget")
            _source.damage=13;_source.hitid=[991];_source.prism_contract_token={value:73}
            var _old_chain=scrNTTEFullArrayCopy(_source.ntte_prism_chain),
                _nodes=scrNTTEFullInstances(Lightning),_hits=instance_number(LightningHit),
                _spawns=instance_number(LightningSpawn),_split_before=_pet.stat.splits,_copy=noone,
                _x=_source.x,_y=_source.y,_angle=_source.image_angle,_direction=_source.direction
            with(_pet) _copy=scrNTTEFullPetPrismSplit(_source)
            var _expected=max(1,ceil(min(30,_budget))),_created=0
            with(Lightning) if(array_get_index(_nodes,id)<0) { _created+=1 }
            assert(instance_exists(_copy) && _created==_expected
                && instance_number(LightningHit)==_hits+1 && instance_number(LightningSpawn)==_spawns,
                "Prism Lightning source branch quantity/terminal effects differ: budget="+string(_budget)
                +" created="+string(_created)+" expected="+string(_expected)
                +" impacts="+string(instance_number(LightningHit)-_hits)
                +" spawns="+string(instance_number(LightningSpawn)-_spawns))
            assert(_copy.ammo==min(30,_budget)-1 && _copy.speed==0
                && point_distance(_x,_y,_copy.x,_copy.y)>=7.99
                && point_distance(_x,_y,_copy.x,_copy.y)<=12.01,
                "Prism Lightning copied segment did not perform real first Alarm0")
            assert(_pet.stat.splits==_split_before+1,"Prism Lightning split stats duplicated")
            assert(_source.x==_x && _source.y==_y && _source.image_angle==_angle
                && _source.direction==_direction && _source.ammo==_budget,
                "Prism Lightning split modified original segment geometry or real ammo")
            with(Lightning) if(array_get_index(_nodes,id)<0) {
                assert(creator==_owner && team==_owner.team && damage==13 && hitid[0]==991
                    && prism_contract_token.value==73 && !prism_duplicate && !can_prism_duplicate,
                    "Prism Lightning descendants lost owner/team/damage/hitid/custom fields or original copied flags")
                assert(array_length(ntte_prism_chain)==_expected && array_get_index(ntte_prism_chain,_copy)>=0,
                    "Prism Lightning branch metadata lost its real nodes")
                for(var _i=0;_i<array_length(ntte_prism_chain);++_i)
                    assert(array_get_index(_old_chain,ntte_prism_chain[_i])<0,
                        "Prism Lightning branch reused the original chain")
            }
            for(var _i=0;_i<array_length(_old_chain);++_i)
                assert(_old_chain[_i].prism_duplicate,"Prism original Lightning chain can split repeatedly")
        }
        var _lengths=[1,1.5,4]
        for(var _trial=0;_trial<array_length(_lengths);++_trial) {
            var _length=_lengths[_trial],_source=noone
            with(_owner) _source=scrLightningCreate(100000+_trial*1000,94000,0,_length)
            assert(instance_exists(_source) && !variable_instance_exists(_source,"ammo"),
                "Prism ordinary mobile test did not use the unscoped original constructor")
            var _nodes=instance_number(Lightning),_hits=instance_number(LightningHit),
                _spawns=instance_number(LightningSpawn),_copy=noone,
                _expected=max(1,ceil(min(30,_length-1)))
            with(_pet) _copy=scrNTTEFullPetPrismSplit(_source)
            assert(instance_number(Lightning)==_nodes+_expected
                && instance_number(LightningHit)==_hits+1 && instance_number(LightningSpawn)==_spawns
                && _copy.ammo==min(30,_length-1)-1,
                "Prism ordinary Lightning remaining-budget conversion/branch quantity differs: length="+string(_length))
        }
    }
    finally {
        var _all=scrNTTEFullInstances(all)
        for(var _i=array_length(_all)-1;_i>=0;--_i)
            if(array_get_index(_before,_all[_i])<0) instance_destroy(_all[_i],false)
        scrNTTEFullAreaGeneratorRestore(_game);random_set_seed(_seed)
        global.ntte_full_merged_plain_depth=_plain
    }
    scrNTTESmokeLog("SYSTEMS PRISM LIGHTNING: actual copied Alarm0, zero/negative/fractional/capped budgets, branch counts, terminal impacts, no extra spawn, ownership/fields and independent chains OK")
}

// Freeze short native chains and their RNG continuation before replacing the
// recursive bridge. No long-chain budget or original regression is weakened.
function scrNTTEFullPrismLightningTraceTests(_owner) {
    var _before=scrNTTEFullInstances(all),_seed=random_get_seed()
    try {
        var _lengths=[0,1,2.5,4,12]
        for(var _trial=0;_trial<array_length(_lengths);++_trial) {
            var _length=_lengths[_trial],_nodes=scrNTTEFullInstances(Lightning),
                _impacts=scrNTTEFullInstances(LightningHit),_spawns=instance_number(LightningSpawn),_root=noone
            random_set_seed(925701+_trial)
            with(_owner) _root=scrNTTEFullMergedBasicProjectileCreate(110000+1000*_trial,97000,Lightning,0)
            _root.ammo=_length
            with(_root) event_perform(ev_alarm,0)
            var _rows=[],_hits=[],_tail=[]
            with(Lightning) if(array_get_index(_nodes,id)<0) array_push(_rows,
                {x:x,y:y,xprevious:xprevious,yprevious:yprevious,xstart:xstart,ystart:ystart,
                direction:direction,image_angle:image_angle,image_index:image_index,
                image_xscale:image_xscale,image_yscale:image_yscale,image_speed:image_speed,
                ammo:ammo,speed:speed,damage:damage,visible:visible,owner:creator==_owner,team:team,
                remaining:ntte_prism_remaining,chain_nodes:array_length(ntte_prism_chain)})
            array_sort(_rows,function(_a,_b) { return _b.ammo-_a.ammo })
            with(LightningHit) if(array_get_index(_impacts,id)<0) array_push(_hits,
                {x:x,y:y,image_angle:image_angle,image_speed:image_speed,image_xscale:image_xscale,image_yscale:image_yscale})
            repeat(6) array_push(_tail,random(1))
            assert(array_length(_rows)==max(1,ceil(_length)) && array_length(_hits)==1
                && instance_number(LightningSpawn)==_spawns,
                "Native Lightning trace source budget/terminal contract changed")
            scrNTTESmokeLog("PRISM LIGHTNING NATIVE TRACE "+json_stringify({rate:30/timescale,
                length:_length,nodes:_rows,impacts:_hits,random_tail:_tail}))
        }
    }
    finally {
        var _all=scrNTTEFullInstances(all)
        for(var _i=array_length(_all)-1;_i>=0;--_i)
            if(array_get_index(_before,_all[_i])<0) instance_destroy(_all[_i],false)
        random_set_seed(_seed)
    }
}
