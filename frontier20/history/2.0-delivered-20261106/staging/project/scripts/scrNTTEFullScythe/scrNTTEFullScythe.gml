// scythe.wep.gml: each physical weapon carries its own ammo and mode state.
// Three numeric mode IDs are a native adapter for one source LWO, not three
// inventories sharing a player-wide resource.
function scrNTTEFullScytheSlot(_primary=true) {
    var _weapon=_primary?wep:bwep, _key=_primary?"ntte_state":"bntte_state";
    if(!scrNTTEIsScythe(scrNTTEFullWeaponRaw(_weapon))) return undefined;
    if(is_struct(_weapon) || scrNTTEFullWeaponIsNative(_weapon)) {
        var _physical=scrNTTEFullWeaponNativeState(_weapon);
        variable_instance_set(id,_key,_physical);
        if(!variable_struct_exists(_physical,"autoswap")) _physical.autoswap=false;
        return _physical;
    }
    var _state=scrNTTEFullValue(id,_key,undefined);
    if(!is_struct(_state) || _state.weapon!=_weapon) {
        _state=scrNTTENewState(_weapon); variable_instance_set(id,_key,_state);
    }
    if(!variable_struct_exists(_state,"autoswap")) _state.autoswap=false;
    return _state;
}
function scrNTTEFullScytheMuscle(_state) {
    var _muscle=scr_skill_get(mut_back_muscle);
    if(_state.muscle!=_muscle) {
        var _base=_state.capacity/(1+0.8*_state.muscle);
        _state.muscle=_muscle; _state.capacity=_base*(1+0.8*_muscle);
        _state.ammo+=_state.capacity-_base;
    }
}
function scrNTTEFullGiveBoneAmmo(_num) {
    for(var _i=0;_i<2;++_i) {
        var _state=scrNTTEFullScytheSlot(_i==0);
        if(!is_struct(_state)) continue;
        scrNTTEMuscle(_state);
        if(_state.ammo<_state.capacity) { _state.ammo=min(_state.ammo+_num,_state.capacity); return true; }
    }
    return false;
}
function scrNTTEFullBoneDust(_x,_y) {
    var _fx=instance_create(_x,_y,NTTEFullSweat);
    _fx.image_blend=choose(make_color_rgb(208,197,180),make_color_rgb(157,133,98),make_color_rgb(111,82,43));
    return _fx;
}
function scrNTTEFullBoneSlashCreate() {
    sprite_index=scrNTTERefSprite("BoneSlashLight"); mask_index=scrNTTERefSprite("msk.BoneSlashLight");
    image_speed=0.4*timescale; friction=0.1*timescale*timescale;
    damage=24; knockback_speed=8*timescale; heavy=false; walled=false; rotspeed=0; ntte_full_setup=true;
}
function scrNTTEFullBoneSlashSetup() {
    if(!ntte_full_setup) return;
    ntte_full_setup=false;
    if(heavy) {
        sprite_index=scrNTTERefSprite("BoneSlashHeavy"); mask_index=scrNTTERefSprite("msk.BoneSlashHeavy");
        damage=32; knockback_speed=12*timescale;
    }
    repeat(3) {
        var _flip=sign(image_yscale),_l=(heavy?24:16)+orandom(2),_d=direction+random_range(30,120)*_flip;
        with(scrNTTEFullBoneDust(x+lengthdir_x(_l,_d),y+lengthdir_y(_l,_d)))
            motion_set(_d+random_range(90,120)*_flip,(1+random(2))*timescale);
    }
}
function scrNTTEFullBoneSlashHit(_target) {
    if(lockstep_stop) return;
    scrNTTEFullBoneSlashSetup();
    if(!instance_exists(_target) || _target.hp<=0 || !scr_can_hit(_target,true)) return;
    var _maxhp=_target.max_hp,_x=_target.x,_y=_target.y;
    if(scr_projectile_hit(_target,damage,knockback_speed) && instance_exists(_target) && _target.hp<=0)
        scrNTTEFullScytheKillDrops(_target,_maxhp,_x,_y);
}
function scrNTTEFullBoneSlashWall(_wall) {
    if(lockstep_stop || walled) return;
    walled=true; friction=0.4*timescale*timescale;
    // Source measures the overlapping wall rectangles after one raw motion
    // step, then returns to the original slash position.
    x+=hspeed; y+=vspeed;
    var _x=bbox_center_x,_y=bbox_center_y,_nearest=_wall,_distance=infinity;
    if(instance_is(_wall,Wall)) {
        var _list=ds_list_create(); instance_place_list(x,y,Wall,_list,false);
        for(var _i=0;_i<ds_list_size(_list);++_i) with(_list[|_i]) {
            var _d=distance_to_point(_x,_y);
            if(_d<_distance) { _distance=_d; _nearest=id; }
        }
        ds_list_destroy(_list);
    }
    var _fx=instance_create((_nearest.bbox_left+_nearest.bbox_right)/2,(_nearest.bbox_top+_nearest.bbox_bottom)/2,MeleeHitWall);
    _fx.image_angle=point_direction(_x,_y,_fx.x,_fx.y);
    _fx.image_blend=choose(c_white,make_color_rgb(208,197,180),make_color_rgb(157,133,98),make_color_rgb(111,82,43));
    snd_play(sndMeleeWall,1.2+random(0.5),2);
    x-=hspeed; y-=vspeed;
}
function scrNTTEFullBoneArrowCreate() {
    sprite_index=scrNTTERefSprite("BoneArrow"); mask_index=mskBolt;
    friction=0.6*timescale*timescale; damage=14; knockback_speed=8*timescale; typ=2;
    ntte_full_bonus=true; ntte_full_bonus_timer=2; ntte_full_bounce=4*scr_skill_get(mut_shotgun_shoulders);
    ntte_full_home=noone; ntte_full_home_dir=0; ntte_full_setup=true; big=false;
}
function scrNTTEFullBoneArrowSetup() {
    if(!ntte_full_setup) return;
    ntte_full_setup=false;
    if(big) { sprite_index=scrNTTERefSprite("BoneArrowHeavy"); friction=0; damage=42; }
}
function scrNTTEFullBoneArrowStep() {
    if(lockstep_stop) return;
    scrNTTEFullBoneArrowSetup();
    if(ntte_full_bonus_timer>0) {
        ntte_full_bonus_timer=max(0,ntte_full_bonus_timer-timescale);
        if(ntte_full_bonus_timer<=0) ntte_full_bonus=false;
    }
    if(ntte_full_home!=noone) {
        if(instance_exists(ntte_full_home) && scr_can_hit(ntte_full_home,true)) {
            if(abs(angle_difference(point_direction(x,y,ntte_full_home.x,ntte_full_home.y),ntte_full_home_dir))<90
                && !place_meeting(x+lengthdir_x(speed,ntte_full_home_dir),y+lengthdir_y(speed,ntte_full_home_dir),ntte_full_home)) {
                var _tx=ntte_full_home.x-lengthdir_x(speed,ntte_full_home_dir),_ty=ntte_full_home.y-lengthdir_y(speed,ntte_full_home_dir);
                var _diff=angle_difference(point_direction(x,y,_tx,_ty),direction)*0.5*timescale;
                direction+=_diff; image_angle+=_diff;
            }
            else { ntte_full_home=noone; direction=ntte_full_home_dir; image_angle=direction; }
        }
        else if(direction!=ntte_full_home_dir) {
            var _diff=angle_difference(ntte_full_home_dir,direction);
            if(abs(_diff)>10) _diff*=0.5*timescale;
            direction+=_diff; image_angle+=_diff;
        }
        else ntte_full_home=noone;
    }
    else {
        ntte_full_home_dir=direction;
        var _max=24*scr_skill_get(mut_bolt_marrow),_nearest=noone;
        if(_max>0) with(hitme) {
            if(team==other.team || team==team_none || instance_is(id,prop) || hp<=0) continue;
            var _dis=distance_to_point(other.x+other.hspeed,other.y+other.vspeed);
            if(_dis<_max && place_meeting(other.x,other.y,other.id)) { _max=_dis; _nearest=id; }
        }
        ntte_full_home=_nearest;
    }
    if(random(7)<timescale) scrNTTEFullBoneDust(x,y);
    if(speed<=4*timescale && current_frame_active) {
        var _fx=instance_create(x,y,Dust); with(_fx) motion_set(other.direction,other.speed);
    }
    if(speed<=2*timescale) instance_destroy();
}
function scrNTTEFullBoneArrowTrail() {
    var _trail=instance_create(x,y,BoltTrail);
    _trail.image_xscale=point_distance(x,y,xprevious,yprevious); _trail.image_yscale+=0.5*big;
    _trail.image_angle=point_direction(x,y,xprevious,yprevious);
}
function scrNTTEFullBoneArrowWall() {
    if(lockstep_stop) return;
    scrNTTEFullBoneArrowSetup();
    move_contact_solid(direction,speed); scrNTTEFullBoneArrowTrail(); xprevious=x; yprevious=y;
    if(big) { friction=1.2*timescale*timescale; sleep(12); scr_screenshake(8); }
    var _fx=instance_create(x,y,Dust); with(_fx) motion_set(other.direction,2*timescale);
    repeat(3) scrNTTEFullBoneDust(x,y);
    if(ntte_full_bounce>0 && !ntte_full_bonus) { ntte_full_bonus=true; ntte_full_bonus_timer=2; }
    var _dir=direction; move_bounce_solid(true); image_angle=direction;
    ntte_full_home_dir+=angle_difference(direction,_dir);
    speed=min(speed*0.8+ntte_full_bounce*timescale,18*timescale); ntte_full_bounce*=0.95;
    if(speed>4*timescale) { snd_play(sndShotgunHitWall,0.7+random(0.3),1.2); snd_play(sndPillarBreak,0.9+random(0.3),0.75); }
}
function scrNTTEFullScytheFire(_weapon,_primary,_state) {
    if(_weapon==wep_ntte_bone_scythe) {
        _state.autoswap=false; _state.combo+=1;
        var _heavy=(_state.combo mod 3)==0,_flip=sign(wepangle),_skill=scr_skill_get(mut_long_arms);
        var _d=gunangle+orandom(4*accuracy),_l=lerp(10,20,_skill);
        var _slash=scr_projectile_create(x+hspeed+lengthdir_x(_l,_d),y+vspeed+lengthdir_y(_l,_d),NTTEFullBoneSlash,_d,lerp(2.5,4.5,_skill));
        _slash.image_yscale*=_flip; _slash.rotspeed=3*_flip; _slash.heavy=_heavy;
        snd_play(sndBlackSword,0.8+random(0.3));
        if(_heavy) { snd_play(sndHammer,1-random(0.2),0.6); snd_play(sndSwapHammer,1.3+random(0.2),0.6); }
        motion_add(_d+30*_flip,(3+_heavy)*timescale);
        scr_weapon_post(gunangle,_heavy?-5:5,2,6+10*_heavy);
        if(_heavy) sleep(12);
        return _slash;
    }
    if(!scrNTTEFullScytheBowSpend(_state,_primary)) return noone;
    var _slug=_weapon==wep_ntte_bone_slugbow,_d=gunangle+orandom((_slug?4:12)*accuracy),_arrow=noone;
    for(var _i=(_slug?0:-1);_i<=(_slug?0:1);++_i) {
        _arrow=scr_projectile_create(x,y,NTTEFullBoneArrow,_d+_i*20*accuracy,_slug?20:16);
        _arrow.big=_slug;
    }
    if(_slug) {
        snd_play(sndHeavyCrossbow,0.9+random(0.3),2/3); snd_play(sndBloodHammer,1.1+random(0.2),2/3);
        motion_add(gunangle+180,3*timescale); scr_weapon_post(gunangle,12,15,17); sleep(40);
    }
    else {
        snd_play(sndSuperCrossbow,0.9+random(0.3),0.5); snd_play(sndBloodLauncherExplo,1.2+random(0.3),0.5);
        scr_weapon_post(gunangle,6,7,3); sleep(4);
    }
    return _arrow;
}
function scrNTTEFullScythePlayerStep() {
    // Migrate old builds once. A shared legacy balance is assigned to only
    // one physical scythe, so loading cannot duplicate it between slots.
    if(!scrNTTEFullValue(id,"ntte_scythe_slots_migrated",false)) {
        var _legacy=scrNTTEFullValue(id,"ntte_bones",0);
        for(var _i=0;_i<2;++_i) {
            var _state=scrNTTEFullScytheSlot(_i==0);
            if(is_struct(_state)) {
                if(_state.ammo<=0 && _legacy>0) _state.ammo=min(_legacy,_state.capacity);
                break;
            }
        }
        ntte_scythe_slots_migrated=true; ntte_bones=0;
    }
    for(var _i=0;_i<2;++_i) {
        var _state=scrNTTEFullScytheSlot(_i==0);
        if(!is_struct(_state)) continue;
        scrNTTEMuscle(_state);
        // Whole bones are worth twenty small fragments. Quest artifacts are
        // excluded; broken thrown bones never create this pickup family.
        var _list=ds_list_create(); instance_place_list(x,y,WepPickup,_list,false);
        for(var _j=0;_j<ds_list_size(_list);++_j) {
            var _pickup=_list[|_j];
            if(!instance_exists(_pickup) || !_pickup.visible || _pickup.curse>(_i==0?curse:bcurse)) continue;
            if(!scrNTTEFullCrabboneOrdinaryPickup(_pickup)) continue;
            var _bone=scrNTTEFullValue(_pickup,"ntte_state",undefined);
            var _ammo=is_struct(_bone)?_bone.ammo:1;
            _state.ammo=min(_state.ammo+20*_ammo,_state.capacity);
            var _fx=instance_create(_pickup.x,_pickup.y,DiscDisappear);
            _fx.image_angle=scrNTTEFullValue(_pickup,"rotation",0);
            snd_play(sndHPPickup,4,0.6); snd_play(sndPickupDisappear,1.2,0.6);
            snd_play(sndBloodGamble,0.4+random(0.2),0.4);
            instance_destroy(_pickup);
        }
        ds_list_destroy(_list);
    }
}
function scrNTTEFullScytheBowSpend(_state,_primary=true) {
    if(_state.ammo>=5 || infammo || global.__debug_infammo) {
        if(!infammo && !global.__debug_infammo) _state.ammo-=5;
        _state.autoswap=false;
        return true;
    }
    if(_primary?KeyCont.press_fire[index]:KeyCont.press_spec[index]) {
        if(scrNTTEFullValue(_state,"autoswap",false)) {
            scrNTTEFullScytheSwap(0);
        }
        else _state.autoswap=true;
    }
    return false;
}
function scrNTTEFullScytheKillDrops(_target,_maxhp,_x,_y) {
    var _name=object_get_name(_target.object_index);
    var _custom=scrNTTEFullValue(_target,"name","");
    if(instance_is(_target,prop) && string_pos("Bone",_name)<=0 && string_pos("Skull",_name)<=0
        && (!is_string(_custom) || (string_pos("Bone",_custom)<=0 && string_pos("Skull",_custom)<=0))) return;
    var _num=ceil(_maxhp/5);
    if(_num<=0) return;
    repeat(floor((_num-1) div 10)) with(instance_create(_x,_y,NTTEFullBoneBigPickup))
        motion_set(random(360),(3+random(1))*timescale);
    repeat(ceil((_num-1) mod 10)+1) with(instance_create(_x,_y,NTTEFullBonePickup))
        motion_set(random(360),(3+random(1))*timescale);
}
function scrNTTEFullBoneBigPickupCreate() {
    var _sprites=scrNTTERefSprite("BonePickupBig");
    sprite_index=_sprites[irandom(array_length(_sprites)-1)]; mask_index=mskBigRad; num=10;
}
function scrNTTEFullBoneFXCreate() {
    var _sprites=scrNTTERefSprite("BonePickup");
    sprite_index=_sprites[irandom(array_length(_sprites)-1)]; image_speed=0; depth=-3;
    creator=noone; ntte_full_delay=2+random(4); speed=(8-ntte_full_delay+random(2))*timescale;
    direction=random(360);
}
function scrNTTEFullBoneFXStep() {
    if(lockstep_stop || !instance_exists(creator)) return;
    ntte_full_delay-=timescale;
    if(ntte_full_delay>0) return;
    if(!place_meeting(x,y,creator) && !place_meeting(x,y,Portal)) {
        x+=creator.hspeed/2; y+=creator.vspeed/2;
        var _d=direction;
        motion_add(point_direction(x,y,creator.x,creator.y),2.4*timescale*timescale);
        image_angle+=direction-_d; speed=min(speed,8*timescale);
        xprevious=x+hspeed*2; yprevious=y+vspeed*2;
    }
    else {
        var _dust=instance_create(x,y,Dust);
        with(_dust) motion_add(other.direction,(2+random(3))*timescale);
        sleep(14); instance_destroy();
    }
}
function scrNTTEFullScytheSwap(_mode=undefined) {
    var _state=scrNTTEFullScytheSlot();
    if(!is_struct(_state)) throw "Scythe swap requires an equipped source scythe";
    var _model=scrNTTEFullWeaponModel(wep),_old=scrNTTEFullWeaponRaw(wep)-wep_ntte_bone_scythe,
        _next=wep_ntte_bone_scythe+max(0,(is_undefined(_mode)?_old+1:_mode) mod 3);
    if(is_struct(_model)) _model.wep=_next;
    else wep=_next;
    _state.weapon=is_struct(_model)?scrNTTEFullWeaponNative(_model):wep; _state.autoswap=false; clicked=false;
    var _sound=_next==wep_ntte_bone_scythe?sndBloodGamble:
        (_next==wep_ntte_bone_shotbow?sndSwapMachinegun:sndSwapMotorized);
    snd_play(_sound); snd_play_hit(sndMutant14Turn,0.1); snd_play(sndFishWarrantEnd,1+random(0.2),4);
    if(variable_instance_exists(id,"swapmove")) swapmove=1;
    if(!visible || instance_exists(GenCont) || instance_exists(LevCont)) return;
    wkick=-3; gunshine=1;
    var _count=0,_owner=id;
    with(NTTEFullBoneFX) if(creator==_owner) _count+=1;
    var _d=gunangle+wepangle;
    repeat(max(0,8-_count)) {
        var _fx=instance_create(x+lengthdir_x(12,_d),y+lengthdir_y(12,_d),NTTEFullBoneFX);
        _fx.creator=id; with(_fx) motion_add(_d,timescale);
    }
    repeat(6) {
        var _fx=instance_create(x+lengthdir_x(8,_d),y+lengthdir_y(8,_d),Dust);
        /* NTTE DUST LIFETIME scythe-swap */ if(instance_exists(_fx)) {_fx.depth=-3; } with(_fx) motion_add(_d+orandom(60),(1+random(5))*timescale);
    }
}

// Only dedicated touch/gamepad mode commands change Scythe form.
// PICK/USE remains available for normal interactions.
function scrNTTEFullScytheSwapInput() {
    // MobileUI can sample immediately before UberCont advances the frame.
    var _sample=scrNTTEFullValue(id,"ntte_scythe_touch_frame",-1),
        _touch=_sample>=0 && _sample<=current_frame && current_frame-_sample<=timescale+0.000001;
    if(!_touch) return false;
    ntte_scythe_touch_frame=-1;
    scrNTTEFullScytheSwap();
    GameCont.ntte_scythe_tip_index=-1;
    return true;
}

function scrNTTEFullScytheControlPlayer() {
    var _player=noone;
    with(Player) if(index==global.index) {_player=id;break;}
    return _player;
}

function scrNTTEFullScytheControlVisible(_player) {
    if(instance_exists(MenuOptions) && MenuOptions.editing_mode) return true;
    return instance_exists(_player) && _player.visible && _player.hp>0
        && scrNTTEIsScythe(scrNTTEFullWeaponRaw(_player.wep));
}

function scrNTTEFullScytheControlUpdate(_player) {
    if(_player.index!=global.index) return;
    var _show=!UberCont.opt_keyboard && !UberCont.opt_gamepad
        && scrNTTEFullScytheControlVisible(_player);
    if(_show && instance_exists(MobileUI)) {
        if(!instance_exists(ButtonNTTEScythe)) instance_create(0,0,ButtonNTTEScythe);
    }
    else if(instance_exists(ButtonNTTEScythe)) instance_destroy(ButtonNTTEScythe);
}

function scrNTTEFullScytheControlPress(_player,_touch,_pressed) {
    if(_touch<0 || !_pressed || !scrNTTEFullScytheControlVisible(_player)
        || instance_exists(MenuOptions) || global.console_active) return false;
    _player.ntte_scythe_touch_frame=current_frame;
    return true;
}

function scrNTTEFullScytheControlDraw(_player,_scale,_simplified) {
    if(!scrNTTEFullScytheControlVisible(_player)) return;
    var _raw=instance_exists(_player)?scrNTTEFullWeaponRaw(_player.wep):wep_ntte_bone_scythe;
    if(!scrNTTEIsScythe(_raw)) _raw=wep_ntte_bone_scythe;
    var _sprite=scrNTTEFullWeaponHUDSprite(_raw),_alpha=index<0?1:0.6,
        _radius=rad*(0.5+_scale)/2;
    draw_set_color(c_black);draw_set_alpha(_alpha*37/255);
    draw_circle(x-1,y-1,_radius,false);
    draw_set_color(c_white);draw_set_alpha(_alpha);
    if(_simplified) draw_circle_width(x,y,_radius,1);
    else draw_sprite_ext(sprMobileControlCorners,0,x,y,_scale,_scale,0,c_white,_alpha);
    if(sprite_exists(_sprite)) {
        var _s=max(1,min(2,floor(28/max(sprite_get_width(_sprite),sprite_get_height(_sprite)))))*_scale;
        draw_sprite_ext(_sprite,0,x+(sprite_get_xoffset(_sprite)-sprite_get_width(_sprite)/2)*_s,
            y+(sprite_get_yoffset(_sprite)-sprite_get_height(_sprite)/2)*_s,_s,_s,0,c_white,_alpha);
    }
    draw_sprite_ext(sprLoadoutArrow,0,x+12*_scale,y-12*_scale,0.65*_scale,0.65*_scale,90,c_white,_alpha);
    draw_set_color(c_white);draw_set_alpha(1);
}

function scrNTTEFullScytheAttackTests() {
    var _player=instance_find(Player,0),_target=instance_create(12000,12000,Bandit);
    _target.hp=20; _target.max_hp=105; _target.nexthurt=-1;
    var _slash=noone;
    with(_player) _slash=scr_projectile_create(_target.x,_target.y,NTTEFullBoneSlash,0,3);
    var _before=instance_number(NTTEFullBonePickup),_big=instance_number(NTTEFullBoneBigPickup);
    with(_slash) scrNTTEFullBoneSlashHit(_target);
    assert(_target.hp==-4 && instance_number(NTTEFullBoneBigPickup)==_big+2
        && instance_number(NTTEFullBonePickup)==_before+3,"Real scythe slash failed damage or source bone kill drops");
    _before=instance_number(NTTEFullBonePickup);
    with(_slash) scrNTTEFullBoneSlashHit(_target);
    assert(instance_number(NTTEFullBonePickup)==_before,"Dead enemy reaped duplicate bones");
    var _heavy=noone; with(_player) _heavy=scr_projectile_create(12100,12000,NTTEFullBoneSlash,0,3);
    _heavy.heavy=true; with(_heavy) scrNTTEFullBoneSlashSetup();
    assert(_heavy.damage==32 && _heavy.knockback_speed==12*timescale
        && _heavy.mask_index==scrNTTERefSprite("msk.BoneSlashHeavy"),"Heavy scythe setup lost source collision mask or force");
    var _wall=instance_create(12100,12000,Wall),_x=_heavy.x,_y=_heavy.y,_fx=instance_number(MeleeHitWall);
    with(_heavy) { scrNTTEFullBoneSlashWall(_wall); scrNTTEFullBoneSlashWall(_wall); }
    assert(_heavy.x==_x && _heavy.y==_y && _heavy.friction==0.4*timescale*timescale
        && instance_number(MeleeHitWall)==_fx+1,"Scythe wall contact moved slash or repeated hit effect");
    var _arrow=noone; with(_player) _arrow=scr_projectile_create(12200,12000,NTTEFullBoneArrow,0,16);
    _target.hp=100; _target.nexthurt=-1;
    with(_arrow) { scrNTTEFullBoneArrowSetup(); if(scr_can_hit(_target,true)) scr_projectile_hit(_target,damage+2*ntte_full_bonus,knockback_speed); }
    assert(_target.hp==84,"Bone arrow first two-tick damage bonus missing");
    repeat(round(2/timescale)) with(_arrow) scrNTTEFullBoneArrowStep();
    assert(!_arrow.ntte_full_bonus,"Bone arrow bonus lifetime changed with framerate");
    _arrow.big=true; _arrow.ntte_full_setup=true; with(_arrow) scrNTTEFullBoneArrowSetup();
    assert(_arrow.damage==42 && _arrow.friction==0,"Slugbow arrow failed heavy setup");
    _arrow.x=12300; _arrow.y=12000; _arrow.ntte_full_bounce=4; _arrow.speed=20*timescale;
    with(_arrow) scrNTTEFullBoneArrowWall();
    // GameMaker stores builtin motion fields as single precision. Compare the
    // source value with its storage tolerance, not double-precision equality.
    assert(abs(_arrow.friction-1.2*timescale*timescale)*1000000<=1 && _arrow.ntte_full_bonus
        && abs(_arrow.speed-18*timescale)*100000<=1,"Heavy arrow wall friction/bounce cap/bonus reset differs from source: "+json_stringify([_arrow.friction,_arrow.ntte_full_bonus,_arrow.speed,timescale]));
    instance_destroy(_target,false); instance_destroy(_slash,false); instance_destroy(_heavy,false);
    instance_destroy(_arrow,false); instance_destroy(_wall,false); instance_destroy(NTTEFullBonePickup,false);
    scrNTTESmokeLog("PASS real bone slash damage/kill/duplicate prevention/heavy mask/wall and arrow bonus/heavy/bounce at source logical duration");
}
function scrNTTEFullScytheStateTests() {
    var _player=instance_find(Player,0);
    var _wep=_player.wep,_bwep=_player.bwep,_state=_player.ntte_state,_bstate=_player.bntte_state;
    var _old_migrated=scrNTTEFullValue(_player,"ntte_scythe_slots_migrated",false),_legacy=scrNTTEFullValue(_player,"ntte_bones",0);
    with(_player) {
        wep=wep_ntte_bone_shotbow; bwep=wep_ntte_bone_slugbow;
        ntte_state=scrNTTENewState(wep); bntte_state=scrNTTENewState(bwep);
        ntte_state.ammo=10; bntte_state.ammo=27; ntte_scythe_slots_migrated=true;
        var _one=ntte_state,_two=bntte_state;
        scrNTTEPlayerStep();
        assert(_one.ammo==10 && _two.ammo==27,"Dual scythes share a player bone balance");
        var _inf=infammo,_debug=global.__debug_infammo;
        infammo=false; global.__debug_infammo=false;
        assert(scrNTTEFullScytheBowSpend(_one) && _one.ammo==5 && _two.ammo==27,"Front scythe spent another physical weapon's ammo");
        infammo=_inf; global.__debug_infammo=_debug;
        scrNTTESwapState();
        var _swap=wep; wep=bwep; bwep=_swap;
        scrNTTEPlayerStep();
        assert(ntte_state==_two && bntte_state==_one && ntte_state.ammo==27,"Weapon swap reset/reassigned scythe state");
        var _item=instance_create(x,y,NTTEFullBonePickup); _item.num=3;
        with(_item) scrNTTEFullCustomPickupOpen(_player);
        assert(_two.ammo==30 && _one.ammo==5,"Bone pickup refilled both scythes or wrong slot");
        _two.ammo=_two.capacity;
        _item=instance_create(x,y,NTTEFullBonePickup); _item.num=3;
        with(_item) scrNTTEFullCustomPickupOpen(_player);
        assert(_two.ammo==_two.capacity && _one.ammo==8,"Full primary failed to route pickup into secondary scythe");
        var _restored=json_parse(json_stringify([_one,_two]));
        _restored[0]=scrNTTEStateRestored(_restored[0]); _restored[1]=scrNTTEStateRestored(_restored[1]);
        assert(_restored[0].ammo==8 && _restored[1].ammo==_two.capacity,"Slot save restore lost independent ammo");
        ntte_scythe_slots_migrated=false; ntte_bones=13; _one.ammo=0; _two.ammo=0;
        scrNTTEFullScythePlayerStep(); scrNTTEFullScythePlayerStep();
        assert(_two.ammo==13 && _one.ammo==0 && ntte_bones==0,"Legacy save migration duplicated ammo");
    }
    var _before_small=instance_number(NTTEFullBonePickup),_before_large=instance_number(NTTEFullBoneBigPickup);
    var _dummy=instance_create(12000,12000,Bandit);
    with(_player) scrNTTEFullScytheKillDrops(_dummy,105,_dummy.x,_dummy.y);
    assert(instance_number(NTTEFullBoneBigPickup)==_before_large+2
        // Parent family count includes the two large children as well.
        && instance_number(NTTEFullBonePickup)==_before_small+3,"Scythe kill did not split 21 bones into 2 large and 1 small pickup");
    instance_destroy(_dummy,false); instance_destroy(NTTEFullBonePickup,false);
    with(_player) {
        wep=_wep; bwep=_bwep; ntte_state=_state; bntte_state=_bstate;
        ntte_scythe_slots_migrated=_old_migrated; ntte_bones=_legacy;
    }
    scrNTTESmokeLog("PASS independent scythe slots, swap/spend/refill/save/legacy and source 10+1 bone drops");
    scrNTTEFullScytheControlNativeTests();
    scrNTTEFullScythePlayerStepNativeTests();
    scrNTTEFullScytheGamepadNativeTests();
    scrNTTEFullMobileVolumeButtonNativeTests();
}

function scrNTTEFullScytheControlNativeTests() {
    scrNTTEFullWeaponNativeInit();
    // scrOptionsUpdate is genuine editor behaviour and reloads saved options.
    // Its private map must retain this driver's rate instead of the user's60.
    var _control_rate=game_get_speed(gamespeed_fps),_control_scale=timescale,
        _control_driver=instance_find(NTTESmokeTest,0),
        _control_selected=instance_exists(_control_driver)?_control_driver.rates[_control_driver.pass_index]:-1;
    scrNTTESmokeLog("SCYTHE EDITOR CLOCK before "+json_stringify({
        selected:_control_selected,speed:_control_rate,scale:_control_scale,
        option:UberCont.opt_framerate,saved:save_get_value("options","framerate",-1)}));
    assert((_control_selected==30 || _control_selected==60) && _control_rate==_control_selected
        && abs(_control_scale-30.0/_control_selected)*1000000<1,
        "Scythe editor fixture entered with a different native driver clock");
    var _before=scrNTTEFullInstances(all),_players=scrNTTEFullAreaGeneratorSnapshot(Player),
        _keys=KeyCont,_game=scrNTTEFullAreaGeneratorSnapshot(GameCont),
        _uber=scrNTTEFullAreaGeneratorSnapshot(UberCont),_back=scrNTTEFullAreaGeneratorSnapshot(BackCont),
        _models=scrNTTEFullArrayCopy(global.ntte_full_native_weapon_models),_seed=random_get_seed(),
        _old_save=UberCont.saveData,_save=ds_map_create(),_skills=ds_list_create(),
        _parked=scrNTTEFullInstances([MobileUI,MenuOptions,BackButton]),
        _debug=global.__debug_infammo,_console=global.console_active,
        _draw=scrNTTEFullCoastDrawState(),_shader=shader_current(),_surface=-1,_camera=-1,_target=false,
        _font=draw_get_font(),_ha=draw_get_halign(),_va=draw_get_valign(),_scale_controls=[];
    ds_map_copy(_save,_old_save);UberCont.saveData=_save;
    save_set_value("options","framerate",_control_rate);
    for(var _i=0;_i<array_length(_parked);++_i) instance_deactivate_object(_parked[_i]);
    gpu_push_state();
    KeyCont=json_parse(json_stringify(_keys));
    try {
        var _p=instance_find(Player,0),_model={wep:wep_ntte_bone_scythe},_handle=scrNTTEFullWeaponNative(_model),
            _other=scrNTTEFullWeaponNative({wep:wep_ntte_bone_slugbow}),_state=scrNTTEFullWeaponNativeState(_handle),
            _other_state=scrNTTEFullWeaponNativeState(_other);
        GameCont.skills=_skills;global.__debug_infammo=false;global.console_active=false;
        _p.x=197000;_p.y=197000;_p.xprevious=_p.x;_p.yprevious=_p.y;_p.hspeed=0;_p.vspeed=0;
        _p.visible=true;_p.hp=8;_p.race=Race.Fish;_p.infammo=0;_p.gunangle=0;_p.accuracy=0;
        _p.wep=_handle;_p.bwep=_other;_p.ntte_state=_state;_p.bntte_state=_other_state;
        _p.ntte_scythe_slots_migrated=true;_p.ntte_crabbone_scythe_frame=-1;_p.ntte_scythe_touch_frame=-1;
        _state.ammo=0;_other_state.ammo=20;_p.curse=0;_p.bcurse=0;
        KeyCont.press_pick[_p.index]=false;KeyCont.press_fire[_p.index]=false;KeyCont.hold_fire[_p.index]=false;
        var _fragment=instance_create(_p.x,_p.y,NTTEFullBonePickup);_fragment.num=6;
        with(_fragment) scrNTTEFullCustomPickupOpen(_p);
        assert(_state.ammo==6 && _other_state.ammo==20 && _p.ntte_state==_state && _state.weapon==_handle,
            "Real fragment pickup could not refill native physical Scythe or reset a slot/state identity");
        with(_p) scrNTTEFullScytheSwap(1);
        assert(_p.wep==_handle && scrNTTEFullWeaponRaw(_handle)==wep_ntte_bone_shotbow && _state.ammo==6,
            "Direct physical Scythe transform replaced its handle or ammunition");
        var _arrows=instance_number(NTTEFullBoneArrow);
        for(var _press=0;_press<3;++_press) {
            _p.can_shoot=true;_p.reload=0;_p.wepangle=1;KeyCont.press_fire[_p.index]=true;
            with(_p) scrPlayerFiring();
            assert(_p.wep==_handle && _p.ntte_state==_state && _state.weapon==_handle,
                "Actual native firing/empty autoswap changed the physical Scythe state");
            if(_press==0) assert(_state.ammo==1 && instance_number(NTTEFullBoneArrow)==_arrows+3,
                "Refilled physical Shotbow could not fire three source arrows for five fragments");
            if(_press==1) assert(_state.autoswap && scrNTTEFullWeaponRaw(_handle)==wep_ntte_bone_shotbow,
                "First empty press failed the original two-press autoswap latch");
        }
        assert(scrNTTEFullWeaponRaw(_handle)==wep_ntte_bone_scythe && !_state.autoswap && _state.ammo==1,
            "Second empty press did not return the same physical Scythe to its usable melee mode");
        KeyCont.press_fire[_p.index]=false;
        KeyCont.press_pick[_p.index]=true;
        with(_p) scrNTTEFullMergedRuntimeStateStepSlots();
        assert(scrNTTEFullWeaponRaw(_handle)==wep_ntte_bone_scythe && KeyCont.press_pick[_p.index],
            "PICK/USE changed Scythe form without the dedicated mode command");
        var _pickup=scrWeaponPickupCreate(_p.x,_p.y,wep_revolver);
        _pickup.visible=true;
        KeyCont.press_pick[_p.index]=true;
        with(_p) scrNTTEFullMergedRuntimeStateStepSlots();
        assert(scrNTTEFullWeaponRaw(_handle)==wep_ntte_bone_scythe,
            "PICK/USE changed Scythe form beside a weapon interaction");
        assert(scrNTTEFullScytheControlPress(_p,0,true),"Physical Scythe rejected dedicated touch command");
        with(_p) scrNTTEFullMergedRuntimeStateStepSlots();
        assert(scrNTTEFullWeaponRaw(_handle)==wep_ntte_bone_shotbow && _state.ammo==1
            && instance_exists(_pickup) && KeyCont.press_pick[_p.index],
            "Dedicated transform was blocked by a nearby weapon or consumed its pickup command");
        assert(!scrNTTEFullScytheControlPress(_p,0,false),"Held transform touch repeated without a new press");
        with(_p) scrNTTEFullMergedRuntimeStateStepSlots();
        assert(scrNTTEFullWeaponRaw(_handle)==wep_ntte_bone_shotbow,"One touch advanced multiple Scythe modes");
        KeyCont.press_pick[_p.index]=false;
        save_set_value("controls","ButtonNTTEScythe_x",160);
        save_set_value("controls","ButtonNTTEScythe_y",80);
        var _button=instance_create(0,0,ButtonNTTEScythe);
        assert(_button.custom_position && _button.x==160 && _button.y==80,
            "Scythe button did not inherit the native remappable position storage");
        _surface=surface_create(320,192);assert(surface_exists(_surface),"Scythe control render surface unavailable");
        _camera=camera_create_view(0,0,320,192,0,noone,-1,-1,-1,-1);
        for(var _mode=0;_mode<3;++_mode) {
            with(_p) scrNTTEFullScytheSwap(_mode);
            surface_set_target(_surface);_target=true;camera_apply(_camera);
            matrix_set(matrix_world,matrix_build_identity());shader_reset();gpu_set_blendmode(bm_normal);
            gpu_set_texfilter(false);draw_clear_alpha(c_black,1);draw_set_alpha(1);draw_set_color(c_white);
            with(_button) scrNTTEFullScytheControlDraw(_p,1,false);
            surface_reset_target();_target=false;
            var _pixels=0;
            for(var _y=52;_y<108;++_y) for(var _x=132;_x<188;++_x)
                if(surface_getpixel(_surface,_x,_y)!=c_black) _pixels++;
            assert(_pixels>40 && surface_getpixel(_surface,200,80)==c_black,
                "Scythe transform control was blank or exceeded its stable bounds");
            var _path=working_directory+"ntte-scythe-control-"+string(_mode)+"-"+string(30/timescale)+".png";
            surface_save(_surface,_path);
            scrNTTESmokeLog("SCYTHE CONTROL rendered mode="+string(_mode)+" pixels="+string(_pixels)+" image="+_path);
        }
        UberCont.opt_keyboard=false;UberCont.opt_gamepad=false;
        _p.wep=wep_revolver;scrNTTEFullScytheControlUpdate(_p);
        assert(!instance_exists(ButtonNTTEScythe),"Hidden Scythe control retained an invisible touch target");
        var _menu=instance_create(0,0,MenuOptions);_menu.debug=true;with(_menu) event_user(10);_menu.editing_mode=true;
        with(_menu) scrOptionsMenuChangeCategory(OptionCategory.Controls_Remapping,false);
        scrCreateMobileControls();
        assert(instance_exists(ButtonNTTEScythe) && scrNTTEFullScytheControlVisible(_p),
            "Native layout editor omitted Scythe control when no Scythe was equipped");
        var _rows=_menu.options[OptionCategory.Controls_Remapping];
        for(var _row=0;_row<array_length(_rows);++_row)
            assert(_rows[_row].type!="slider" || _rows[_row].key!="controls_scale",
                "Removed bottom remap size slider was recreated");
        var _controls=_menu.options[OptionCategory.Controls],_has_scale=false;
        for(var _row=0;_row<array_length(_controls);++_row)
            if(_controls[_row].type=="slider" && _controls[_row].key=="controls_scale") _has_scale=true;
        assert(_has_scale,"Removing the remap footer also removed the original control-size option");
        assert(scrMobileControlsRemapFooterTouch(gui_w/2,gui_h-LETTERBOX_SIZE-10)
            && !scrMobileControlsRemapFooterTouch(0,0),"Layout footer failed to reserve its remaining menu gesture region");
        save_set_value("controls","scale",0.25);scrOptionsUpdate();
        assert(game_get_speed(gamespeed_fps)==_control_selected
            && abs(timescale-30.0/_control_selected)*1000000<1,
            "Actual editor OptionsUpdate changed the selected native clock");
        assert(UberCont.opt_controls_scale==0.25,"Layout size did not reach native render/touch scale immediately");
        _button=instance_find(ButtonNTTEScythe,0);
        var _swap=instance_find(ButtonSwap,0),_swap_x=_swap.x,_swap_y=_swap.y,
            _swap_saved_x=save_get_value("controls",_swap.key+"_x"),_swap_saved_y=save_get_value("controls",_swap.key+"_y");
        with(MobileUI) index=-1;
        with(_button) scrMobileControlsRemapSample(0,160,80,true);
        assert(_button.index==0,"Editor could not acquire Scythe finger ownership");
        with(_button) event_user(0);assert(_button.index==0,"Real input event reset editor drag ownership");
        with(_button) scrMobileControlsRemapSample(0,176,90,true);with(_button) event_user(0);
        with(_button) scrMobileControlsRemapSample(0,182,96,false);
        assert(_button.index==-1 && _button.x==182 && _button.y==96
            && save_get_value("controls",_button.key+"_x")==182 && save_get_value("controls",_button.key+"_y")==96,"Scythe drag release did not save coordinates");
        _button.x=0;_button.y=0;with(_button) event_user(10);
        assert(_button.custom_position && _button.x==182 && _button.y==96,"Scythe position failed after editor drag");
        assert(_swap.x==_swap_x && _swap.y==_swap_y && save_get_value("controls",_swap.key+"_x")==_swap_saved_x
            && save_get_value("controls",_swap.key+"_y")==_swap_saved_y,"Scythe edit moved or rewrote another control");
        with(_button) scrMobileControlsRemapSample(1,gui_w/2,gui_h-LETTERBOX_SIZE-10,true);
        assert(_button.index==-1,"Scythe editor stole remaining footer menu gesture");
        _scale_controls=scrNTTEFullInstances(MobileUI);
        for(var _i=0;_i<array_length(_scale_controls);++_i) if(_scale_controls[_i]!=_button) instance_deactivate_object(_scale_controls[_i]);
        _button.x=160;_button.y=80;_button.smoothrad=0;
        UberCont.quit_pause=false;UberCont.want_pause=false;UberCont.opt_volumecontrol=false;
        var _previous_width=0,_scale_values=[0.5,0.75,1];
        for(var _s=0;_s<array_length(_scale_values);++_s) {
            save_set_value("controls","scale",_scale_values[_s]);scrOptionsUpdate();
            assert(game_get_speed(gamespeed_fps)==_control_selected
                && abs(timescale-30.0/_control_selected)*1000000<1,
                "Actual slider OptionsUpdate changed the selected native clock");
            assert(UberCont.opt_controls_scale==_scale_values[_s],"Editor scale failed persisted update");
            surface_set_target(_surface);_target=true;camera_apply(_camera);
            matrix_set(matrix_world,matrix_build_identity());shader_reset();gpu_set_blendmode(bm_normal);
            gpu_set_texfilter(false);draw_clear_alpha(c_black,1);draw_set_alpha(1);draw_set_color(c_white);
            scrDrawMobileControls(noone);surface_reset_target();_target=false;
            var _min_x=320,_max_x=-1;
            for(var _y=0;_y<192;++_y) for(var _x=0;_x<320;++_x)
                if(surface_getpixel(_surface,_x,_y)!=c_black) {_min_x=min(_min_x,_x);_max_x=max(_max_x,_x);}
            var _width=_max_x-_min_x+1;
            assert(_width>_previous_width,"Actual control scale plateaued: "+json_stringify([_s,_width,_previous_width]));
            _previous_width=_width;
            var _path=working_directory+"ntte-controls-scale-"+string(_scale_values[_s])+"-"+string(30/timescale)+".png";
            surface_save(_surface,_path);scrNTTESmokeLog("CONTROLS SCALE value="+string(_scale_values[_s])+" width="+string(_width)+" image="+_path);
        }

    }
    finally {
        for(var _i=0;_i<array_length(_scale_controls);++_i) if(instance_exists(_scale_controls[_i])) instance_activate_object(_scale_controls[_i]);
        if(_target) surface_reset_target();
        if(surface_exists(_surface)) surface_free(_surface);
        if(_camera!=-1) camera_destroy(_camera);
        gpu_pop_state();
        matrix_set(matrix_world,_draw.world);matrix_set(matrix_view,_draw.view);matrix_set(matrix_projection,_draw.projection);
        if(_shader>=0) shader_set(_shader);else shader_reset();
        draw_set_font(_font);draw_set_halign(_ha);draw_set_valign(_va);
        draw_set_color(_draw.color);draw_set_alpha(_draw.alpha);
        scrNTTEFullMergedRuntimeTestCleanup(_before);
        for(var _i=0;_i<array_length(_parked);++_i) instance_activate_object(_parked[_i]);
        scrNTTEFullAreaGeneratorRestore(_players);KeyCont=_keys;
        scrNTTEFullAreaGeneratorRestore(_game);scrNTTEFullAreaGeneratorRestore(_uber);scrNTTEFullAreaGeneratorRestore(_back);
        UberCont.saveData=_old_save;ds_map_destroy(_save);ds_list_destroy(_skills);
        global.ntte_full_native_weapon_models=_models;global.__debug_infammo=_debug;global.console_active=_console;
        random_set_seed(_seed);
        // Cleanup restores the original engine state even if an editor assert
        // throws. No measured input fixture assigns a synthetic timescale.
        game_set_speed(_control_rate,gamespeed_fps);global.time_scale=_control_scale;
        assert(game_get_speed(gamespeed_fps)==_control_selected
            && abs(timescale-30.0/_control_selected)*1000000<1,
            "Scythe editor failed to restore exact selected native clock");
        scrNTTESmokeLog("SCYTHE EDITOR CLOCK restored "+json_stringify({
            selected:_control_selected,speed:game_get_speed(gamespeed_fps),scale:timescale,
            option:UberCont.opt_framerate,saved:save_get_value("options","framerate",-1)}));
    }
    scrNTTESmokeLog("SCYTHE CONTROL native physical fragment pickup/fire/empty two-press autoswap, nearby pickup independence/single touch, inherited layout persistence/three-mode actual render, editor entry without bottom slider+original size storage OK @"+string(30/timescale));
}

function scrNTTEFullScythePlayerStepNativeTests() {
    scrNTTEFullWeaponNativeInit();
    var _fixture=scrNTTEFullVanillaFixtureBegin(),_players=scrNTTEFullAreaGeneratorSnapshot(Player),
        _keys=KeyCont,_back=scrNTTEFullAreaGeneratorSnapshot(BackCont),
        _uber=scrNTTEFullAreaGeneratorSnapshot(UberCont),_models=scrNTTEFullArrayCopy(global.ntte_full_native_weapon_models),
        _frame=current_frame,_stop=lockstep_stop,_skills=ds_list_create(),
        _debug=global.__debug_infammo,_noreload=global.__debug_noreload,_console=global.console_active,
        _parked=scrNTTEFullInstances([MobileUI,MenuOptions,BackButton,NTTEFullPrompt,Cinematic,SitDown,MenuGen]);
    for(var _i=0;_i<array_length(_parked);++_i) instance_deactivate_object(_parked[_i]);
    lockstep_stop=false;GameCont.skills=_skills;GameCont.ntte_full_native_skill_counts={};
    global.__debug_infammo=false;global.__debug_noreload=false;global.console_active=false;
    KeyCont=json_parse(json_stringify(_keys));
    try {
        var _p=instance_find(Player,0),_loads=[12,18,15];
        assert(!scrGameIsLockState(),"Native Scythe Player Step fixture is locked");
        UberCont.opt_keyboard=false;UberCont.opt_gamepad=false;
        for(var _mode=0;_mode<3;++_mode) {
            var _before=scrNTTEFullInstances(all),_handle=scrNTTEFullWeaponNative({wep:wep_ntte_bone_scythe+_mode}),
                _state=scrNTTEFullWeaponNativeState(_handle);
            _state.ammo=40;_state.combo=0;
            _p.x=198000;_p.y=198000;_p.xprevious=_p.x;_p.yprevious=_p.y;_p.speed=0;
            _p.wep=_handle;_p.bwep=wep_none;_p.ntte_state=_state;_p.bntte_state=undefined;
            _p.hp=8;_p.max_hp=8;_p.lsthealth=8;_p.fainted=0;_p.race=Race.Fish;_p.visible=true;
            _p.roll=0;_p.can_walk=false;_p.can_spec=false;_p.can_pick=false;_p.can_shoot=true;
            _p.reload=0;_p.reloadspeed=1;_p.infammo=0;_p.curse=0;_p.bcurse=0;_p.clicked=false;
            _p.wepangle=120;_p.gunangle=0;_p.wkick=0;_p.specfiring=false;
            _p.ntte_scythe_slots_migrated=true;_p.ntte_crabbone_scythe_frame=-1;_p.ntte_scythe_touch_frame=-1;
            KeyCont.press_swap[_p.index]=false;KeyCont.press_pick[_p.index]=false;KeyCont.moving[_p.index]=0;
            KeyCont.hold_fire[_p.index]=false;KeyCont.press_fire[_p.index]=false;
            KeyCont.hold_spec[_p.index]=false;KeyCont.press_spec[_p.index]=false;
            for(var _press=0;_press<3;++_press) {
                var _slashes=instance_number(NTTEFullBoneSlash),_arrows=instance_number(NTTEFullBoneArrow);
                KeyCont.hold_fire[_p.index]=true;KeyCont.press_fire[_p.index]=true;
                current_frame+=timescale;with(_p) event_perform(ev_step,ev_step_normal);
                with(_p) event_perform(ev_step,ev_step_end);
                assert(_p.wep==_handle && _p.ntte_state==_state && _state.weapon==_handle,"Scythe fire changed physical inventory identity");
                assert(!_p.can_shoot && abs(_p.reload-(_loads[_mode]-timescale))*1000000<=1,
                    "Scythe actual reload12/18/15 failed: "+json_stringify([_mode,_press,_p.reload,_p.can_shoot]));
                assert(instance_number(NTTEFullBoneSlash)==_slashes+(_mode==0)
                    && instance_number(NTTEFullBoneArrow)==_arrows+(_mode==1?3:(_mode==2?1:0)),"Player Step did not emit actual Scythe attack");
                if(_mode==0) {
                    var _list=scrNTTEFullInstances(NTTEFullBoneSlash),_slash=_list[array_length(_list)-1];
                    assert(_slash.heavy==(_press==2),"Third Scythe attack lost heavy combo");
                }
                assert(_state.ammo==40-(_mode==0?0:5*(_press+1)),"Scythe attack lost five-fragment cost");
                KeyCont.hold_fire[_p.index]=false;KeyCont.press_fire[_p.index]=false;
                repeat(ceil(_loads[_mode]/timescale)-1) {
                    current_frame+=timescale;with(_p) event_perform(ev_step,ev_step_normal);with(_p) event_perform(ev_step,ev_step_end);
                }
                assert(_p.reload==0 && _p.can_shoot,"Scythe reload did not rearm attack without gun swap");
            }
            if(_mode==2) {
                var _arrows=instance_number(NTTEFullBoneArrow);
                KeyCont.hold_fire[_p.index]=true;KeyCont.press_fire[_p.index]=false;
                repeat(3) {current_frame+=timescale;with(_p) event_perform(ev_step,ev_step_normal);with(_p) event_perform(ev_step,ev_step_end);}
                assert(instance_number(NTTEFullBoneArrow)==_arrows,"Semiautomatic Slugbow fired from held-only input");
            }
            KeyCont.hold_fire[_p.index]=false;KeyCont.press_fire[_p.index]=false;scrNTTEFullMergedRuntimeTestCleanup(_before);
        }
        var _handle=scrNTTEFullWeaponNative({wep:wep_ntte_bone_scythe}),_state=scrNTTEFullWeaponNativeState(_handle);
        _p.wep=_handle;_p.bwep=wep_none;_p.ntte_state=_state;_p.bntte_state=undefined;
        _p.ntte_crabbone_scythe_frame=-1;_p.ntte_scythe_touch_frame=-1;
        for(var _mode=0;_mode<3;++_mode) {
            assert(scrNTTEFullScytheControlPress(_p,0,true),"Dedicated control rejected sampled press");
            current_frame+=timescale;with(_p) event_perform(ev_step,ev_step_normal);
            assert(scrNTTEFullWeaponRaw(_handle)==wep_ntte_bone_scythe+((_mode+1) mod 3)
                && _p.ntte_scythe_touch_frame==-1,"Pre-increment touch lost or not consumed by actual Player Step");
            current_frame+=timescale;with(_p) event_perform(ev_step,ev_step_normal);
            assert(scrNTTEFullWeaponRaw(_handle)==wep_ntte_bone_scythe+((_mode+1) mod 3),"One touch advanced multiple modes");
        }
        _p.ntte_scythe_touch_frame=current_frame-3*timescale;
        current_frame+=timescale;with(_p) event_perform(ev_step,ev_step_normal);
        assert(scrNTTEFullWeaponRaw(_handle)==wep_ntte_bone_scythe,"Expired touch changed mode");
    } finally {
        scrNTTEFullAreaGeneratorRestore(_players);KeyCont=_keys;scrNTTEFullAreaGeneratorRestore(_back);scrNTTEFullAreaGeneratorRestore(_uber);
        scrNTTEFullVanillaFixtureEnd(_fixture);
        for(var _i=0;_i<array_length(_parked);++_i) instance_activate_object(_parked[_i]);
        global.ntte_full_native_weapon_models=_models;current_frame=_frame;lockstep_stop=_stop;ds_list_destroy(_skills);
        global.__debug_infammo=_debug;global.__debug_noreload=_noreload;global.console_active=_console;
    }
    scrNTTESmokeLog("SCYTHE PLAYER STEP actual consecutive attacks / source reload / ammo / combo / semiauto / delayed touch exactly once OK @"+string(30/timescale));
}

function scrNTTEFullScytheGamepadSample(_index,_held,_pressed,_released) {
    if(!UberCont.opt_gamepad || global.console_active || instance_exists(MenuOptions) || scrGameIsLockState()) return false;
    var _player=noone;
    with(Player) if(index==_index) {_player=id;break;}
    if(!scrNTTEFullScytheControlVisible(_player)) return false;
    if(_pressed) _player.ntte_scythe_touch_frame=current_frame;
    if(_held || _pressed || _released) {
        var _binding=Key.scythe[1],_actions=["fire","spec","pick","swap","horn"];
        for(var _a=0;_a<array_length(_actions);++_a) {
            var _action=_actions[_a],_keys=Key[$ _action];
            if(array_length(_keys)<2 || _keys[1]!=_binding) continue;
            KeyCont[$ "hold_"+_action][_index]=false;
            KeyCont[$ "press_"+_action][_index]=false;
            KeyCont[$ "release_"+_action][_index]=false;
        }
    }
    return true;
}

function scrNTTEFullScytheGamepadNativeTests() {
    scrNTTEFullWeaponNativeInit();
    var _fixture=scrNTTEFullVanillaFixtureBegin(),_players=scrNTTEFullAreaGeneratorSnapshot(Player),
        _uber=scrNTTEFullAreaGeneratorSnapshot(UberCont),_back=scrNTTEFullAreaGeneratorSnapshot(BackCont),
        _keys=KeyCont,_bindings=Key,_pads=global.__input_gamepads,_index=global.index,
        _models=scrNTTEFullArrayCopy(global.ntte_full_native_weapon_models),_frame=current_frame,_stop=lockstep_stop,
        _skills=ds_list_create(),_oldsave=UberCont.saveData,_save=ds_map_create(),_rate=game_get_speed(gamespeed_fps),
        _debug=global.__debug_infammo,_noreload=global.__debug_noreload,_console=global.console_active,
        _flag=keymap_ret_nogamepad,_parked=scrNTTEFullInstances([MobileUI,MenuOptions,BackButton,NTTEFullPrompt,Cinematic,SitDown,MenuGen]);
    for(var _i=0;_i<array_length(_parked);++_i) instance_deactivate_object(_parked[_i]);
    KeyCont=json_parse(json_stringify(_keys));Key=json_parse(json_stringify(_bindings));
    ds_map_copy(_save,_oldsave);UberCont.saveData=_save;lockstep_stop=false;GameCont.skills=_skills;GameCont.ntte_full_native_skill_counts={};
    global.__debug_infammo=false;global.__debug_noreload=false;global.console_active=false;
    try {
        var _p=instance_find(Player,0),_handle=scrNTTEFullWeaponNative({wep:wep_ntte_bone_scythe}),
            _state=scrNTTEFullWeaponNativeState(_handle),_actions=["fire","spec","pick","swap","horn"];
        _p.index=0;global.index=0;UberCont.opt_keyboard=false;UberCont.opt_gamepad=true;
        _p.x=199000;_p.y=199000;_p.xprevious=_p.x;_p.yprevious=_p.y;_p.speed=0;
        _p.wep=_handle;_p.bwep=wep_revolver;_p.ntte_state=_state;_p.bntte_state=undefined;
        _p.hp=8;_p.max_hp=8;_p.lsthealth=8;_p.fainted=0;_p.race=Race.Fish;_p.visible=true;
        _p.roll=0;_p.can_walk=false;_p.can_spec=false;_p.can_pick=false;_p.can_shoot=true;
        _p.reload=0;_p.reloadspeed=1;_p.infammo=0;_p.curse=0;_p.bcurse=0;_p.clicked=false;
        _p.wepangle=120;_p.gunangle=0;_p.wkick=0;_p.specfiring=false;
        _p.ntte_scythe_slots_migrated=true;_p.ntte_crabbone_scythe_frame=-1;_p.ntte_scythe_touch_frame=-1;
        KeyCont.activeforever[0]=false;KeyCont.gamepad[0]=true;
        assert(!scrGameIsLockState(),"Scythe gamepad fixture locked");scrKeymapsSetup();
        assert(Key.scythe[1]==gp_face4,"Default Scythe mode action is not Xbox Y");
        var _menu=instance_create(0,0,MenuOptions);with(_menu) scrOptionsMenuChangeCategory(OptionCategory.Controls_Remapping_Keys,false);
        var _found=false;
        for(var _i=0;_i<array_length(_menu.items);++_i) {
            var _item=_menu.items[_i];
            if(_item.type=="keybind" && _item.key=="scythe") {_found=true;assert(_item.available && _item.visible,"Scythe binding row unavailable");}
        }
        assert(_found,"Actual gamepad menu omitted mode binding");instance_destroy(_menu,false);
        var _pad={key:gp_face4,held:false,pressed:false,released:false};
        _pad.get_held=method(_pad,function(_key){return held && _key==key;});
        _pad.get_pressed=method(_pad,function(_key){return pressed && _key==key;});
        _pad.get_released=method(_pad,function(_key){return released && _key==key;});
        _pad.get_value=method(_pad,function(_axis){return 0;});global.__input_gamepads=[_pad];
        var _codes=[gp_face4,gp_face3];
        for(var _binding=0;_binding<array_length(_codes);++_binding) {
            Key.scythe[1]=_codes[_binding];scrOptionsSaveKeymaps();scrKeymapsSetup();scrOptionsLoadKeymaps();
            assert(Key.scythe[1]==_codes[_binding],"Mode remapping lost at native save/load");_pad.key=_codes[_binding];
            for(var _a=0;_a<array_length(_actions);++_a) Key[$ _actions[_a]][1]=_pad.key;
            repeat(3) {
                var _raw=scrNTTEFullWeaponRaw(_handle);_pad.held=true;_pad.pressed=true;_pad.released=false;
                with(UberCont) scrHandleInputsGeneral(0);
                assert(_p.ntte_scythe_touch_frame==current_frame,"Real key_check sampler missed command");
                for(var _a=0;_a<array_length(_actions);++_a) {
                    var _action=_actions[_a];
                    assert(!KeyCont[$ "hold_"+_action][0] && !KeyCont[$ "press_"+_action][0] && !KeyCont[$ "release_"+_action][0],"Mode binding leaked competing "+_action);
                }
                current_frame+=timescale;with(_p) event_perform(ev_step,ev_step_normal);with(_p) event_perform(ev_step,ev_step_end);
                var _expected=wep_ntte_bone_scythe+((_raw-wep_ntte_bone_scythe+1) mod 3);
                assert(_p.wep==_handle && _p.bwep==wep_revolver && _p.ntte_state==_state && scrNTTEFullWeaponRaw(_handle)==_expected && _p.ntte_scythe_touch_frame==-1,"Sampled mode press failed once-only transform or swapped inventory");
                _pad.pressed=false;with(UberCont) scrHandleInputsGeneral(0);
                current_frame+=timescale;with(_p) event_perform(ev_step,ev_step_normal);with(_p) event_perform(ev_step,ev_step_end);
                assert(scrNTTEFullWeaponRaw(_handle)==_expected && _p.wep==_handle,"Held mode button repeated transform");
                _pad.held=false;_pad.released=true;with(UberCont) scrHandleInputsGeneral(0);
                current_frame+=timescale;with(_p) event_perform(ev_step,ev_step_normal);with(_p) event_perform(ev_step,ev_step_end);
                assert(scrNTTEFullWeaponRaw(_handle)==_expected && _p.wep==_handle,"Released mode button transformed/swapped inventory");_pad.released=false;
            }
        }
        _p.wep=wep_revolver;_p.ntte_state=undefined;_pad.held=true;_pad.pressed=true;_pad.released=false;
        with(UberCont) scrHandleInputsGeneral(0);
        assert(KeyCont.press_swap[0] && KeyCont.hold_swap[0],"Mode binding consumed ordinary weapon swap");
        assert(game_get_speed(gamespeed_fps)==_rate,"Scythe input test changed engine rate");
        scrNTTESmokeLog("SCYTHE GAMEPAD actual key_check/General/PlayerStep,defaultY+remappedX persistence/menu,3modes once,held/release,5conflicts,ordinary swap OK @"+string(_rate)+"; physical Xbox/mobile untested");
    } finally {
        scrNTTEFullAreaGeneratorRestore(_players);scrNTTEFullAreaGeneratorRestore(_back);scrNTTEFullVanillaFixtureEnd(_fixture);scrNTTEFullAreaGeneratorRestore(_uber);
        for(var _i=0;_i<array_length(_parked);++_i) instance_activate_object(_parked[_i]);
        KeyCont=_keys;Key=_bindings;global.__input_gamepads=_pads;global.index=_index;UberCont.saveData=_oldsave;
        ds_map_destroy(_save);ds_list_destroy(_skills);global.ntte_full_native_weapon_models=_models;current_frame=_frame;lockstep_stop=_stop;
        global.__debug_infammo=_debug;global.__debug_noreload=_noreload;global.console_active=_console;keymap_ret_nogamepad=_flag;
    }
}

// Production callback queue and real mobile button User 0 events.
function scrNTTEFullMobileVolumeSample(_fixture,_type="",_volume="") {
    assert(UberCont.volqueue==_fixture.queue && ds_queue_size(_fixture.queue)==0,"Unexpected volume callback queue state")
    if(_type!="") ds_queue_enqueue(_fixture.queue,[_type,_volume])
    with(UberCont) scrHandleInputsGeneral(0)
    assert(ds_queue_size(_fixture.queue)==0,"General did not consume volume queue")
    assert(_fixture.swap.index==-1 && _fixture.active.index==-1,"Physical desktop touch entered volume fixture")
    return {swap_command:_fixture.swap.volume_control_command,active_command:_fixture.active.volume_control_command,
        swap:[KeyCont.press_swap[0],KeyCont.hold_swap[0],KeyCont.release_swap[0]],
        active:[KeyCont.press_spec[0],KeyCont.hold_spec[0],KeyCont.release_spec[0]],forever:KeyCont.activeforever[0]}
}
function scrNTTEFullMobileVolumeAssert(_actual,_swap,_active,_forever,_swap_command,_active_command,_label) {
    for(var _i=0;_i<3;++_i) {
        assert(_actual.swap[_i]==_swap[_i],_label+" swap edge/hold/release differs: "+json_stringify(_actual))
        assert(_actual.active[_i]==_active[_i],_label+" active edge/hold/release differs: "+json_stringify(_actual))
    }
    assert(_actual.forever==_forever && _actual.swap_command==_swap_command && _actual.active_command==_active_command,
        _label+" latch/command differs: "+json_stringify(_actual))
}
function scrNTTEFullMobileVolumeButtonNativeTests() {
    assert(os_type==os_windows && scrNTTEFullSmokeEnabled(),"Volume regression requires Windows smoke")
    var _rate=game_get_speed(gamespeed_fps),_scale=timescale,_driver=instance_find(NTTESmokeTest,0),
        _selected=instance_exists(_driver)?_driver.rates[_driver.pass_index]:-1,
        _delta=_scale-30.0/max(1,_rate),
        _clock={selected:_selected,speed:_rate,scale:_scale,option:UberCont.opt_framerate,
            saved:save_get_value("options","framerate",-1),
            uncapped:UberCont.test_framerate_uncapped,requested:global.__debug_test_framerate_uncapped,
            speed_precise:string_format(_rate,0,15),scale_precise:string_format(_scale,0,15),
            delta_precise:string_format(_delta,0,15),epsilon_precise:string_format(math_get_epsilon(),0,15)}
    scrNTTESmokeLog("VOLUME NATIVE CLOCK "+json_stringify(_clock))
    assert((_selected==30 || _selected==60) && _rate==_selected && abs(_delta)*1000000<1,
        "Volume regression requires selected actual native30/60: "+json_stringify(_clock))
    var _before=scrNTTEFullInstances(all),_players=scrNTTEFullAreaGeneratorSnapshot(Player),
        _uber=scrNTTEFullAreaGeneratorSnapshot(UberCont),_game=scrNTTEFullAreaGeneratorSnapshot(GameCont),
        _back=scrNTTEFullAreaGeneratorSnapshot(BackCont),_keys=KeyCont,_key_bytes=json_stringify(KeyCont),
        _index=global.index,_console=global.console_active,_mobile=is_mobile,_seed=random_get_seed(),
        _oldsave=UberCont.saveData,_save=ds_map_create(),_queue=ds_queue_create(),
        _parked=scrNTTEFullInstances([MobileUI,MenuOptions,BackButton]),
        _p=instance_find(Player,0),_pi=scr_playerinstance_find(_p.index),_prefs=_pi.cprefs
    ds_map_copy(_save,_oldsave);UberCont.saveData=_save
    for(var _i=0;_i<array_length(_parked);++_i) instance_deactivate_object(_parked[_i])
    KeyCont=json_parse(json_stringify(_keys))
    try {
        global.index=0;global.console_active=false;is_mobile=true
        UberCont.opt_keyboard=false;UberCont.opt_gamepad=false;UberCont.opt_stickregions=false
        UberCont.opt_controls_scale=1;UberCont.paused=false;UberCont.volqueue=_queue
        assert(_p.index==0 && _index==0 && _pi!=undefined,"Volume regression requires actual preference record zero")
        _p.race=Race.Fish;_pi.cprefs=0;KeyCont.activeforever[0]=false
        var _swap=instance_create(0,0,ButtonSwap),_active=instance_create(0,0,ButtonActive)
        _swap.rad=-1;_active.rad=-1;_swap.index=-1;_active.index=-1
        var _fixture={queue:_queue,swap:_swap,active:_active},_zero=[false,false,false],
            _press=[true,false,false],_hold=[false,true,false],_release=[false,false,true]
        assert(instance_number(ButtonSwap)==1 && instance_number(ButtonActive)==1,"Volume fixture retained duplicate controls")
        scrNTTEFullMobileVolumeAssert(scrNTTEFullMobileVolumeSample(_fixture),_zero,_zero,false,0,0,"Initial idle")
        var _volumes=["up","down"]
        for(var _v=0;_v<array_length(_volumes);++_v) {
            var _volume=_volumes[_v],_up=_volume=="up"
            for(var _pass=0;_pass<2;++_pass) {
                var _label=_volume+" press "+string(_pass+1)
                scrNTTEFullMobileVolumeAssert(scrNTTEFullMobileVolumeSample(_fixture,"volumeButtonPressed",_volume),
                    _up?_press:_zero,_up?_zero:_press,false,_up?2:0,_up?0:2,_label)
                scrNTTEFullMobileVolumeAssert(scrNTTEFullMobileVolumeSample(_fixture),
                    _up?_hold:_zero,_up?_zero:_hold,false,_up?2:0,_up?0:2,_label+" held")
                scrNTTEFullMobileVolumeAssert(scrNTTEFullMobileVolumeSample(_fixture,"volumeButtonPressed",_volume),
                    _up?_hold:_zero,_up?_zero:_hold,false,_up?2:0,_up?0:2,_label+" repeated callback")
                scrNTTEFullMobileVolumeAssert(scrNTTEFullMobileVolumeSample(_fixture,"volumeButtonReleased",_volume),
                    _up?_release:_zero,_up?_zero:_release,false,0,0,_label+" released")
                scrNTTEFullMobileVolumeAssert(scrNTTEFullMobileVolumeSample(_fixture),_zero,_zero,false,0,0,_label+" idle")
                scrNTTEFullMobileVolumeAssert(scrNTTEFullMobileVolumeSample(_fixture,"volumeButtonReleased",_volume),
                    _zero,_zero,false,0,0,_label+" duplicate release")
            }
        }
        var _races=[3,NTTEFullRace.Parrot],_names=["eyes","parrot"]
        for(var _r=0;_r<array_length(_races);++_r) {
            var _pref=array_get_index(UberCont.cpref_list,_names[_r]);assert(_pref>=0,"Missing preference "+_names[_r])
            _p.race=_races[_r];_pi.cprefs=1<<(_pref+1);KeyCont.activeforever[0]=false
            assert(_active.can_forever(_p),"ButtonActive rejected "+_names[_r]+" preference")
            for(var _pass=0;_pass<2;++_pass) {
                var _label=_names[_r]+" toggle cycle "+string(_pass+1),
                    _on=[_races[_r]==NTTEFullRace.Parrot,true,false],_latched=[false,true,false]
                scrNTTEFullMobileVolumeAssert(scrNTTEFullMobileVolumeSample(_fixture,"volumeButtonPressed","down"),_zero,_on,true,0,2,_label+" on")
                scrNTTEFullMobileVolumeAssert(scrNTTEFullMobileVolumeSample(_fixture),_zero,_latched,true,0,2,_label+" held")
                scrNTTEFullMobileVolumeAssert(scrNTTEFullMobileVolumeSample(_fixture,"volumeButtonPressed","down"),_zero,_latched,true,0,2,_label+" repeated callback")
                scrNTTEFullMobileVolumeAssert(scrNTTEFullMobileVolumeSample(_fixture,"volumeButtonReleased","down"),_zero,_latched,true,0,0,_label+" release latched")
                scrNTTEFullMobileVolumeAssert(scrNTTEFullMobileVolumeSample(_fixture),_zero,_latched,true,0,0,_label+" idle latched")
                scrNTTEFullMobileVolumeAssert(scrNTTEFullMobileVolumeSample(_fixture,"volumeButtonPressed","down"),_zero,_zero,false,0,2,_label+" off consumes command")
                scrNTTEFullMobileVolumeAssert(scrNTTEFullMobileVolumeSample(_fixture),_zero,_zero,false,0,2,_label+" next event remains off")
                scrNTTEFullMobileVolumeAssert(scrNTTEFullMobileVolumeSample(_fixture,"volumeButtonPressed","down"),_zero,_zero,false,0,2,_label+" repeated remains off")
                scrNTTEFullMobileVolumeAssert(scrNTTEFullMobileVolumeSample(_fixture,"volumeButtonReleased","down"),_zero,_zero,false,0,0,_label+" off release")
                scrNTTEFullMobileVolumeAssert(scrNTTEFullMobileVolumeSample(_fixture),_zero,_zero,false,0,0,_label+" off idle")
            }
        }
        assert(game_get_speed(gamespeed_fps)==_rate && timescale==_scale,"Volume regression changed engine timing")
        scrNTTESmokeLog("VOLUME CALLBACK real queue/General/callback/ButtonSwap+Active, two raw press-hold-release cycles, duplicate callbacks, Eyes+Parrot on-off latch and early-exit consumption OK @"
            +string(_rate)+"; physical Android Java dispatch untested")
    } finally {
        scrNTTEFullMergedRuntimeTestCleanup(_before)
        _pi.cprefs=_prefs;is_mobile=_mobile;global.index=_index;global.console_active=_console
        KeyCont=_keys;scrNTTEFullAreaGeneratorRestore(_players)
        scrNTTEFullAreaGeneratorRestore(_game);scrNTTEFullAreaGeneratorRestore(_back)
        scrNTTEFullAreaGeneratorRestore(_uber);UberCont.saveData=_oldsave
        for(var _i=0;_i<array_length(_parked);++_i) instance_activate_object(_parked[_i])
        ds_queue_destroy(_queue);ds_map_destroy(_save);random_set_seed(_seed)
        assert(KeyCont==_keys && json_stringify(KeyCont)==_key_bytes,"Volume regression mutated original KeyCont")
    }
}
