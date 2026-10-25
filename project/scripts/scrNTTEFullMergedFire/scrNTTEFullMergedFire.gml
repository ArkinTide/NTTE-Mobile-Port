// temerge.mod.gml 1303..2146. Shared shot accounting and emission geometry.
// These are used by the native replacement pipeline; they do not enable the
// still incomplete merged projectile event table or natural Beetle gate.
// temerge_decide_weapon294..325: two independent native selector calls, with
// the selected stock appended to the existing exclusions for the front draw.
function scrNTTEFullMergedWeaponDecide(_min=0,_max=GameCont.hard,_gold=false,_exclude=undefined) {
    if(is_undefined(_exclude)) _exclude=[]
    var _stock=scrNTTEFullWeaponDecide(_min,_max,_gold,_exclude,self),_front_exclude=[]
    for(var _i=0;_i<array_length(_exclude);++_i) array_push(_front_exclude,_exclude[_i])
    array_push(_front_exclude,_stock)
    return scrNTTEFullWeaponMerge(_stock,scrNTTEFullWeaponDecide(_min,_max,_gold,_front_exclude,self))
}
function scrNTTEFullMergeFireFrame(_weapon,_owner,_previous=undefined) {
    var _model=scrNTTEFullWeaponModel(_weapon),_stock=scrNTTEFullWeaponRaw(_model),
        _front=scrNTTEFullWeaponMergedPart(_model),_stock_cost=scr_weapon_get_cost(_stock),
        _front_cost=scr_weapon_get_cost(_front),_type=scr_weapon_get_type(_model),
        _cost=scr_weapon_get_cost(_model),_rads=scr_weapon_get_rads(_model)
    var _frame={last_vars:_previous,main_vars:undefined,has_shot:false,shot_count:0,
        shot_replace_count:0,shot_replace_min:max(1,_stock_cost),
        shot_replace_base:power(1.5,1+max(0,(_front_cost-1)/9)),
        shot_replace_cost_interval:_stock_cost==0 ? 1:abs(_stock_cost),
        shot_is_delayed:false,frame:current_frame,owner:_owner,weapon:_model,
        infammo:scrNTTEFullValue(_owner,"infammo",0),ammo_type:_type,
        ammo_cost:_cost,rads_cost:_rads}
    _frame.main_vars=is_struct(_previous) ? _previous.main_vars:_frame
    return _frame
}
function scrNTTEFullMergeFireReplacement(_frame,_advance=true) {
    // Count all candidates, including those rejected by the logarithmic limit.
    // Minimum uses the signed stock cost; its interval uses the absolute cost.
    var _allowed=_frame.has_shot && _frame.shot_replace_count<
        _frame.shot_replace_min+floor(logn(_frame.shot_replace_base,1+_frame.shot_count))
    if(_allowed) _frame.shot_replace_count+=1
    if(_advance && _frame.has_shot) _frame.shot_count+=1
    return _allowed
}
function scrNTTEFullMergeFireStop(_frame) {
    while(is_struct(_frame)) { _frame.has_shot=false; _frame=_frame.last_vars; }
}
function scrNTTEFullMergeFireCost(_frame,_owner,_can_cost=true,_front_has_merge=false,_can_fire=true) {
    var _main=_frame.main_vars,_charge=_can_cost && (!_front_has_merge || !_can_fire)
        && instance_exists(_owner) && instance_is(_owner,Player) && _main.infammo==0
    if(_charge) {
        for(var _parent=_frame;is_struct(_parent);_parent=_parent.last_vars) {
            // Deferred emissions pay at their first replacement. They must not
            // inherit the modulo suppression of a previous immediate frame.
            if(_parent.shot_is_delayed && _parent.shot_replace_count==1) break
            if(((_parent.shot_replace_count-1)%_parent.shot_replace_cost_interval)>=1) {
                _charge=false; break
            }
        }
    }
    var _ammo=0,_rads=0
    if(_charge) {
        var _index=_frame.shot_replace_count,_factor=_index==0 ? 1:
            power(_index,0.795)-power(_index-1,0.795)
        // Source rounds the adjustment, not cost*factor. This distinction
        // matters for signed costs and exact half-way rounding.
        _ammo=_main.ammo_cost+round(_main.ammo_cost*(_factor-1))
        _rads=_main.rads_cost+round(_main.rads_cost*(_factor-1))
        if(_owner.ammo[_main.ammo_type]>=_ammo && GameCont.rad>=_rads) {
            _owner.ammo[_main.ammo_type]-=_ammo; GameCont.rad-=_rads
        }
        else { _can_fire=false; _ammo=0;_rads=0; scrNTTEFullMergeFireStop(_frame); }
    }
    return {can_fire:_can_fire,charged:_charge,ammo:_ammo,rads:_rads}
}
function scrNTTEFullMergeFireAt(_projectile,_weapon,_origin_x,_origin_y,_origin_angle,_accuracy,_independent=false) {
    var _front=scrNTTEFullWeaponMergedPart(_weapon),_dir=_projectile.direction,
        _logical_speed=_projectile.speed/timescale,
        _logical_friction=_projectile.friction/(timescale*timescale)
    if(_dir==0 && _projectile.speed==0) _dir=_projectile.image_angle==0 ? _origin_angle:_projectile.image_angle
    var _at={x:undefined,y:undefined,position_distance:point_distance(_origin_x,_origin_y,_projectile.xstart,_projectile.ystart),
        position_direction:undefined,position_rotation:angle_difference(point_direction(_origin_x,_origin_y,_projectile.xstart,_projectile.ystart),_origin_angle),
        direction:undefined,direction_rotation:angle_difference(_dir,_origin_angle),
        speed_factor:scrNTTEFullValue(_projectile,"temerge_speed_factor",0.5+max(0,abs(_logical_speed/32)*(1-_logical_friction/2))),
        accuracy:_accuracy,wep:_front,team:_projectile.team,creator:_projectile.creator}
    _independent=_independent || round(_at.position_distance)>16
    if(_independent) { _at.x=_origin_x;_at.y=_origin_y;_at.direction=_origin_angle; }
    return {at:_at,independent:_independent}
}
function scrNTTEFullMergeFireSort(_instances,_origin_x,_origin_y) {
    var _sort=[],_group=0,_distance=0
    for(var _i=0;_i<array_length(_instances);++_i) {
        var _inst=_instances[_i]
        if(!instance_exists(_inst)) continue
        var _d=point_distance(_origin_x,_origin_y,_inst.xstart,_inst.ystart)
        if(abs(_d-_distance)>8) { _distance=_d;_group+=1; }
        array_push(_sort,{instance:_inst,key:_group+random(1)})
    }
    array_sort(_sort,function(_a,_b) { return _a.key-_b.key; })
    for(var _i=0;_i<array_length(_sort);++_i) _sort[_i]=_sort[_i].instance
    return _sort
}
// The native emitter resolves weapon-specific fire/setup/event definitions.
// Requiring explicit callbacks here avoids silently dropping unsupported stock
// effects. The normal character gate stays closed until that table is complete.
function scrNTTEFullMergeReplaceList(_instances,_frame,_origin_x,_origin_y,_origin_angle,_accuracy,_emit,_event_lookup) {
    var _sorted=scrNTTEFullMergeFireSort(_instances,_origin_x,_origin_y),_independent=false,
        _weapon=_frame.weapon,_model=scrNTTEFullWeaponModel(_weapon),
        _reload=scr_weapon_get_load(_weapon),_results=[]
    for(var _i=0;_i<array_length(_sorted);++_i) {
        var _shot=_sorted[_i]
        if(!instance_exists(_shot)) continue
        // A thrown copy of the stock weapon is a physical weapon, not a bullet
        // to erase. Its dedicated fire hook appends the front to that item.
        var _shot_wep=scrNTTEFullValue(_shot,"wep",undefined)
        if(!is_undefined(_shot_wep) && (_shot_wep==_weapon || scrNTTEFullWeaponRaw(_shot_wep)==scrNTTEFullWeaponRaw(_weapon))) {
            var _sprite=scr_weapon_get_sprite(_shot_wep)
            if(_shot.sprite_index==_sprite) continue
            var _stock_sprite=scr_weapon_get_sprite(scrNTTEFullWeaponRaw(_weapon))
            if(_shot.sprite_index==_stock_sprite) {
                _shot.sprite_index=_sprite
                if(is_array(_shot.hitid) && array_length(_shot.hitid)>1 && _shot.hitid[1]==_sprite) _shot.hitid[1]=_shot.sprite_index
                continue
            }
        }
        var _was_active=_frame.has_shot
        if(scrNTTEFullMergeFireReplacement(_frame,false)) {
            if(instance_is(_shot,NTTEFullPortalBullet)) scrNTTEFullMergedPortalBind(_shot)
            var _mount=scrNTTEFullMergeFireAt(_shot,_weapon,_origin_x,_origin_y,_origin_angle,_accuracy,_independent),_at=_mount.at
            _independent=_mount.independent
            var _merge={last_fire_vars:_frame,
                on_fire:scrNTTEFullValue(_shot,"temerge_on_fire",undefined),
                on_setup:scrNTTEFullValue(_shot,"temerge_on_setup",undefined),
                on_hit:scrNTTEFullValue(_shot,"temerge_on_hit",undefined),
                on_wall:scrNTTEFullValue(_shot,"temerge_on_wall",undefined),
                on_destroy:scrNTTEFullValue(_shot,"temerge_on_destroy",undefined),
                speed_factor:scrNTTEFullValue(_shot,"temerge_speed_factor",undefined),
                object:scrNTTEFullValue(_shot,"temerge_object",_shot.object_index),setup_vars:{}}
            var _defaults=_event_lookup(_merge.object)
            if(!is_struct(_defaults)) throw "Merged stock projectile event table is not resolved"
            for(var _e=0;_e<5;++_e) {
                var _name=["fire","setup","hit","wall","destroy"][_e],_field="on_"+_name
                if(is_undefined(_merge[$ _field])) _merge[$ _field]=scrNTTEFullValue(_defaults,_name,undefined)
            }
            // Use a local callable to preserve the shot as self and the firing
            // source as other. Do not invoke it as a struct method.
            var _fire_hook=_merge.on_fire
            if(is_callable(_fire_hook)) with(_shot) _fire_hook(_at,_merge.setup_vars)
            if(!instance_exists(_shot)) { if(_was_active) _frame.shot_count+=1; continue; }
            var _can_cost=scrNTTEFullValue(_shot,"temerge_can_cost",true),
                _can_fire=scrNTTEFullValue(_shot,"temerge_can_fire",true)
            if(_can_cost || _can_fire) {
                var _cost=scrNTTEFullMergeFireCost(_frame,_at.creator,_can_cost,
                    scrNTTEFullWeaponHasMerge(_at.wep)==true,_can_fire)
                if(_cost.can_fire) {
                    _model.temerge.wep_fire_frame=current_frame
                    _merge.speed_factor=_at.speed_factor
                    var _emission=_emit(_at,_merge)
                    if(!is_struct(_emission)) throw "Merged emitter did not return its native firing result"
                    array_push(_results,_emission)
                    _reload=min(_reload,_emission.reload)
                    if(!_emission.has_shot) scrNTTEFullMergeFireStop(_frame)
                }
            }
        }
        if(_was_active) _frame.shot_count+=1
        // Even limit-suppressed stock shots are erased. Destroy events would
        // explode Grenades/Flak and create unrequested extra stock projectiles.
        if(instance_exists(_shot) && scrNTTEFullValue(_shot,"temerge_can_delete",true)) instance_destroy(_shot,false)
    }
    _model.temerge.wep_fire_reload=_reload
    return _results
}
function scrNTTEFullMergedAccountingTestEvents(_object) {
    // A normal shell/bullet has no stock-specific setup/fire event in NTTE.
    return {fire:undefined,setup:undefined,hit:undefined,wall:undefined,destroy:undefined}
}
// temerge_projectile_setup2056..2145. Apply one stock ancestor's inherited
// metadata once per final projectile. Nested ancestors use independent refs.
function scrNTTEFullMergeApplyEffects(_input,_merge,_weapon=undefined) {
    if(!is_struct(_merge)) return []
    var _fresh=[]
    for(var _i=0;_i<array_length(_input);++_i) {
        var _p=_input[_i]
        if(!instance_exists(_p)) continue
        if(!variable_instance_exists(_p,"temerge_vars_list")) _p.temerge_vars_list=[]
        if(array_get_index(_p.temerge_vars_list,_merge)>=0 || !scrNTTEFullValue(_p,"temerge_can_setup",true)) continue
        array_push(_p.temerge_vars_list,_merge);array_push(_fresh,_p)
    }
    var _factor=scrNTTEFullValue(_merge,"speed_factor",1)
    if(_factor!=1) for(var _i=0;_i<array_length(_fresh);++_i) with(_fresh[_i]) {
        if(speed!=0) switch(object_index) {
            case PlasmaBall:case PlasmaBig:case PlasmaHuge:
                scrNTTEFullMergedProjectileAddEffect(id,"fixed_plasma_speed_factor");break;
            case Seeker:
                scrNTTEFullMergedProjectileAddEffect(id,"fixed_seeker_speed_factor");break;
            case Rocket:case Nuke:
                if(_factor>1) {
                    if(active || alarm[1]>0) {
                        active=false;alarm[1]=max(alarm[1],0)+1
                        speed=max(speed,(object_index==Nuke?5:12)*timescale)
                    }
                }
                else scrNTTEFullMergedProjectileAddEffect(id,"fixed_rocket_speed_factor")
                break;
        }
        if(!variable_instance_exists(id,"temerge_fixed_speed_factor")) temerge_fixed_speed_factor=1
        temerge_fixed_speed_factor*=_factor
        image_angle-=direction
        var _max=(16+bbox_right-bbox_left)*timescale
        image_angle+=direction
        if(speed<_max) speed=min(speed*_factor,_max)
    }
    // Gun Gun's physical weapon transformation is owned by the native thrown
    // weapon bridge. Do not claim normal completeness before it is connected.
    var _setup=scrNTTEFullValue(_merge,"on_setup",undefined)
    if(!is_undefined(_setup)) {
        if(is_callable(_setup)) _setup(_fresh,_merge.setup_vars)
        else scrNTTEFullMergedEffectsCall(id,id,_setup,[_fresh,_merge.setup_vars])
    }
    for(var _i=0;_i<3;++_i) {
        var _event=["hit","wall","destroy"][_i],_ref=scrNTTEFullValue(_merge,"on_"+_event,undefined)
        if(!is_undefined(_ref)) scrNTTEFullMergedProjectileAddEvent(_fresh,_event,_ref)
    }
    return _fresh
}
function scrNTTEFullMergedAccountingTestEmit(_at,_merge) {
    var _owner=_at.creator,_saved={x:_owner.x,y:_owner.y},
        _angle=is_undefined(_at.direction) ? _owner.gunangle:_at.direction,
        _x=is_undefined(_at.x) ? _owner.x:_at.x,_y=is_undefined(_at.y) ? _owner.y:_at.y
    _owner.x=_x+lengthdir_x(_at.position_distance,_angle+_at.position_rotation)
    _owner.y=_y+lengthdir_y(_at.position_distance,_angle+_at.position_rotation)
    var _result
    try { _result=scrNTTEFullActorFire(_owner,_at.wep,_angle+_at.direction_rotation,_at.accuracy,false,_owner); }
    finally { _owner.x=_saved.x;_owner.y=_saved.y; }
    _result.has_shot=array_length(_result.shots)>0
    return _result
}
function scrNTTEFullMergedFireAccountingTests() {
    var _p=instance_find(Player,0),_players=scrNTTEFullAreaGeneratorSnapshot(Player),
        _game=scrNTTEFullAreaGeneratorSnapshot(GameCont),_before=scrNTTEFullInstances(all)
    try {
        _p.infammo=0;_p.accuracy=0;_p.ammo=array_create(Ammo.NUM_AMMO_TYPES,100);GameCont.rad=100
        var _weapon=scrNTTEFullWeaponMerge(wep_shotgun,wep_revolver),
            _frame=scrNTTEFullMergeFireFrame(_weapon,_p),_shot=scrNTTEFullActorFire(_p,wep_shotgun,30,0),_shells=[]
        for(var _i=0;_i<array_length(_shot.shots);++_i)
            if(instance_exists(_shot.shots[_i]) && instance_is(_shot.shots[_i],projectile)) array_push(_shells,_shot.shots[_i])
        assert(array_length(_shells)==7,"Merged fire accounting fixture lost actual seven-shell native Shotgun")
        _frame.has_shot=true
        var _accepted=0,_charged=0
        // Shotgun stock cost1 and seven real shells produce five replacement
        // firings under base1.5, not seven front shots and not one front shot.
        for(var _i=0;_i<array_length(_shells);++_i) if(scrNTTEFullMergeFireReplacement(_frame)) {
            _accepted+=1
            var _cost=scrNTTEFullMergeFireCost(_frame,_p)
            _charged+=_cost.ammo
        }
        assert(_accepted==5 && _frame.shot_count==7 && _charged==5 && _p.ammo[Ammo.Bullets]==95,
            "Merged Shotgun replacement density or marginal ammo payment differs from source")
        // A two-ammo stock pays indices1,3,5. Index2 itself must still fire.
        var _double=scrNTTEFullWeaponMerge(wep_double_shotgun,wep_revolver),
            _double_frame=scrNTTEFullMergeFireFrame(_double,_p)
        _double_frame.has_shot=true
        var _paid=[]
        repeat(5) {
            assert(scrNTTEFullMergeFireReplacement(_double_frame),"Double Shotgun rejected an allowed source replacement")
            var _cost=scrNTTEFullMergeFireCost(_double_frame,_p)
            array_push(_paid,_cost.ammo)
            assert(_cost.can_fire,"Modulo-free replacement was incorrectly blocked")
        }
        assert(_paid[0]==2 && _paid[1]==0 && _paid[2]==1 && _paid[3]==0 && _paid[4]==1,
            "Merged two-ammo stock lost interval payment or0.795 marginal decay")
        // Test chained suppression and its deferred exception. This prevents
        // charging once per merge depth instead of once per final emission.
        var _nested=scrNTTEFullMergeFireFrame(_weapon,_p,_double_frame)
        _nested.has_shot=true;_nested.shot_replace_count=1;_double_frame.shot_replace_count=2
        var _old=_p.ammo[Ammo.Bullets]
        assert(scrNTTEFullMergeFireCost(_nested,_p).ammo==0 && _p.ammo[Ammo.Bullets]==_old,
            "Nested merge ignored its outer stock's cost interval")
        _nested.shot_is_delayed=true
        assert(scrNTTEFullMergeFireCost(_nested,_p).ammo==2,
            "Deferred first replacement incorrectly inherited outer immediate-cost suppression")
        _p.ammo[Ammo.Bullets]=0
        var _failure=scrNTTEFullMergeFireCost(_nested,_p)
        assert(!_failure.can_fire && !_nested.has_shot && !_double_frame.has_shot && _p.ammo[Ammo.Bullets]==0,
            "Ammo failure did not stop all ancestor replacement frames atomically")
        // Geometry uses initial coordinates and logical speed; post-create
        // native launch compensation and frame rate must not alter the mount.
        var _shell=_shells[0]
        _shell.xstart=_p.x+12;_shell.ystart=_p.y;_shell.direction=45;_shell.speed=16*timescale;_shell.friction=0
        _shell.x+=5
        var _mount=scrNTTEFullMergeFireAt(_shell,_weapon,_p.x,_p.y,30,0)
        assert(!_mount.independent && _mount.at.position_distance==12 && _mount.at.direction_rotation==15
            && abs(_mount.at.speed_factor-1)<0.0001 && is_undefined(_mount.at.x),
            "Immediate replacement lost source relative mount/angle or logical speed factor")
        _shell.friction=0.2*timescale*timescale
        var _friction_mount=scrNTTEFullMergeFireAt(_shell,_weapon,_p.x,_p.y,30,0)
        assert(abs(_friction_mount.at.speed_factor-0.95)<0.0001,
            "Merged speed inheritance used physical friction instead of original logical friction")
        _shell.friction=0
        _shell.xstart=_p.x+17
        var _fixed=scrNTTEFullMergeFireAt(_shell,_weapon,_p.x,_p.y,30,0)
        _shell.xstart=_p.x+2
        var _still_fixed=scrNTTEFullMergeFireAt(_shell,_weapon,_p.x,_p.y,30,0,_fixed.independent)
        assert(_fixed.independent && _fixed.at.x==_p.x && _fixed.at.direction==30 && _still_fixed.independent,
            "Independent emission anchoring did not persist for subsequent stock projectiles")
        _shell.direction=0;_shell.speed=0;_shell.image_angle=75
        var _stationary=scrNTTEFullMergeFireAt(_shell,_weapon,_p.x,_p.y,30,0)
        assert(_stationary.at.direction_rotation==45 && _stationary.at.speed_factor==0.5,
            "Stationary stock projectile lost image-angle fallback or minimum speed factor")
        // Exercise the whole replacement loop with actual native emissions.
        // All seven stock shells disappear without destruction side effects;
        // five real front Revolver rounds are created and paid for once each.
        _p.ammo[Ammo.Bullets]=100;_p.gunangle=30
        var _real_frame=scrNTTEFullMergeFireFrame(_weapon,_p)
        _real_frame.has_shot=true
        var _replacement=scrNTTEFullMergeReplaceList(_shells,_real_frame,_p.x,_p.y,30,0,
            scrNTTEFullMergedAccountingTestEmit,scrNTTEFullMergedAccountingTestEvents),_live_rounds=0
        assert(array_length(_replacement)==5 && _p.ammo[Ammo.Bullets]==95,
            "Actual stock-to-front replacement emitted or charged the wrong number of native firings")
        for(var _i=0;_i<array_length(_shells);++_i) assert(!instance_exists(_shells[_i]),
            "Stock projectile survived the native replacement pass")
        for(var _i=0;_i<array_length(_replacement);++_i) {
            var _created=_replacement[_i].shots
            for(var _j=0;_j<array_length(_created);++_j) if(instance_exists(_created[_j]) && instance_is(_created[_j],Bullet1)) {
                _live_rounds+=1
                assert(_created[_j].creator==_p && _created[_j].team==_p.team,
                    "Native replacement lost front round owner or team")
            }
        }
        assert(_live_rounds==5 && _weapon.temerge.wep_fire_frame==current_frame,
            "Replacement results were not actual live native front projectiles or lost the merged firing frame")
    }
    finally {
        var _all=scrNTTEFullInstances(all)
        for(var _i=array_length(_all)-1;_i>=0;--_i) if(array_get_index(_before,_all[_i])<0) instance_destroy(_all[_i],false)
        scrNTTEFullAreaGeneratorRestore(_players);scrNTTEFullAreaGeneratorRestore(_game)
    }
    scrNTTESmokeLog("FULL MERGED FIRE ACCOUNTING: real Shotgun emissions, logarithmic replacement density, nested/modulo/deferred ammo, failure propagation and mount geometry OK")
}
