// Undergrowth1.0.3 native event/API bridge. All time values are30Hz ticks.
#macro wep_ug_fossil_pistol 174
#macro wep_ug_fossil_gun 175
#macro wep_ug_fossil_cannon 176
#macro wep_ug_fossil_hammer 177
#macro wep_ug_mega_grenade_launcher 178

function scrUGRebaseLoadedValue(_value,_key="",_seen=undefined) {
    var _map=scrNTTEFullValue(global,"ntte_weapon_load_rebase",undefined);
    if(!is_struct(_map) || _map.from==_map.to) return _value;
    if(is_numeric(_value) && array_get_index(["wep","bwep","weapon","extra_weps","persistentweps"],_key)>=0)
        return _value>=_map.from && _value<_map.from+_map.count && _value==floor(_value)?_value+_map.to-_map.from:_value;
    if(!is_struct(_value) && !is_array(_value)) return _value;
    if(_key=="ntte_full_native_weapon_save") return _value;
    if(is_undefined(_seen)) _seen={nodes:[]};
    for(var _i=0;_i<array_length(_seen.nodes);++_i) if(_seen.nodes[_i]==_value) return _value;
    array_push(_seen.nodes,_value);
    if(is_array(_value)) for(var _i=0;_i<array_length(_value);++_i) _value[@ _i]=scrUGRebaseLoadedValue(_value[_i],_key,_seen);
    else {
        var _keys=variable_struct_get_names(_value);
        for(var _i=0;_i<array_length(_keys);++_i) {
            var _name=_keys[_i];_value[$ _name]=scrUGRebaseLoadedValue(_value[$ _name],_name,_seen);
        }
    }
    return _value;
}
function scrUGWeaponImportRebase(_data,_objects) {
    var _base=max(maxwep+1,_data.base),_models=scrNTTEFullWeaponNativeDecode(_data.root,_objects);
    global.ntte_weapon_load_rebase={from:_data.base,to:_base,count:array_length(_models)};
    if(_base==_data.base) return;
    var _seen={nodes:[]};
    for(var _i=0;_i<array_length(_objects);++_i) scrUGRebaseLoadedValue(_objects[_i],"",_seen);
    // GameCont's stored carriers (e.g. stolen weapons) precede Player loading.
    with(GameCont) {
        var _keys=variable_instance_get_names(id);
        for(var _i=0;_i<array_length(_keys);++_i) {
            var _key=_keys[_i];variable_instance_set(id,_key,scrUGRebaseLoadedValue(variable_instance_get(id,_key),_key,_seen));
        }
    }
}

function scrUGDefaults(_kind) {
    ug_kind=_kind;name="";on_step=undefined;on_begin_step=undefined;on_end_step=undefined;
    on_death=undefined;on_hurt=undefined;on_draw=undefined;on_destroy=undefined;on_cleanup=undefined;
    on_wall=undefined;on_hit=undefined;on_anim=undefined;on_alrm0=undefined;on_alrm1=undefined;on_alrm2=undefined;
    alarm0=-1;alarm1=-1;alarm2=-1;creator=noone;target=noone;
    spr_idle=-1;spr_walk=-1;spr_hurt=-1;spr_chrg=-1;spr_dead=-1;spr_fire=-1;spr_shadow=-1;
    spr_shadow_x=0;spr_shadow_y=0;right=1;size=1;team=team_none;hitid=HitId.None;
    image_speed=0.4*timescale;nexthurt=0;canfly=false;raddrop=0;max_hp=1;hp=1;
    canmelee=false;meleedamage=0;givekill=true;corpse=true;friction=0.4*sqr(timescale);
    if(_kind=="enemy") team=team_enemy;
    if(_kind=="projectile" || _kind=="slash") {friction=0;damage=0;force=0;accuracy=1;typ=_kind=="slash"?0:1;}
    ug_destroying=false;
}
function scrUGRef(_f) {return _f;}
function scrUGCall(_f) {
    if(!is_callable(_f)) return false;
    var _cb=method(id,_f),_ret=_cb();
    return is_undefined(_ret)?false:_ret;
}
function scrUGNothing() {return false;}
function scrUGBegin() {scrUGCall(on_begin_step);}
function scrUGStep() {
    if(lockstep_stop) return;
    if((ug_kind=="enemy" || ug_kind=="prop" || ug_kind=="hitme") && hp<=0) {instance_destroy();return;}
    if(ug_kind=="enemy" && !instance_is(id,UGHitme)) {
        // Native creation/charm systems own team and target allegiance.
        // Source acquisition is routed through scrUGTarget for charmed units.
        if(wkick!=0) wkick=approach(wkick,0,timescale);
    }
    scrUGCall(on_step);
    if(!instance_exists(id)) return;
    if(!is_callable(on_step) && (ug_kind=="prop" || ug_kind=="hitme") && image_index+image_speed>=image_number && sprite_exists(spr_idle)) sprite_index=spr_idle;
    // The base projectile's direction->angle pass is bypassed: the author
    // explicitly retains the shot's original angle for its eventual explosion.
}
function scrUGEnd() {scrUGCall(on_end_step);}
function scrUGAlarm(_number) {
    var _key="alarm"+string(_number),_left=variable_instance_get(id,_key);
    if(_left<0) return false;
    _left-=timescale;variable_instance_set(id,_key,_left);
    if(_left>0) return false;
    // Disarm before callback; callbacks can reschedule themselves.
    variable_instance_set(id,_key,-1);
    var _hook=variable_instance_get(id,"on_alrm"+string(_number));
    scrUGCall(_hook);return !instance_exists(id);
}
function scrUGDraw() {
    if(name=="MillipedeSegment") return; // Ordered world-depth pass below.
    if(is_callable(on_draw)) scrUGCall(on_draw);
    else draw_self();
}
function scrUGDestroy() {
    scrNTTEFullMergedNativeDeathCapture(id);
    if(ug_destroying) return;
    ug_destroying=true;
    if(is_callable(on_destroy)) scrUGCall(on_destroy);
    if(hp<=0 && is_callable(on_death)) scrUGCall(on_death);
}
function scrUGCleanup() {scrNTTEFullMergedNativeDeathCapture(id);if(is_callable(on_cleanup)) scrUGCall(on_cleanup);}
function scrUGCollision(_wall) {
    var _entry=scrNTTEFullMergedNativeCollisionBegin(id,other.id);
    if(!is_undefined(_entry) && !_entry.allow) {scrNTTEFullMergedNativeCollisionEnd(_entry);return;}
    try {
    var _cb=_wall?on_wall:on_hit;
    if(!is_callable(_cb)) return;
    // A bound method changes other to its call site. Invoke from the actual
    // collision target, so source top-level other still denotes that target;
    // nested source with blocks then retain ordinary GM scoping.
    var _owner=id,_target=other.id;
    with(_target) {var _bound=method(_owner,_cb);_bound();}
    } finally {scrNTTEFullMergedNativeCollisionEnd(_entry);}
}
function scrUGHasHurt(_who) {
    return instance_exists(_who) && (instance_is(_who,UGEnemy)||instance_is(_who,UGProp)||instance_is(_who,UGHitme)) && is_callable(_who.on_hurt);
}
function scrUGHurt(_who,_damage,_dir,_force) {
    var _cb=method(_who,_who.on_hurt);_cb(_damage,_force/timescale,_dir);
    return true;
}
function scrUGCanHit(_who) {return instance_exists(_who) && scr_can_hit(_who,true);}
function scrUGHit(_who,_damage,_force=0,_dir=direction) {return scr_projectile_hit(_who,_damage,_force*timescale,_dir);}
function scrUGTarget() {scrTarget();return target;}
function scrUGFace(_dir) {right=(_dir>=90 && _dir<270)?-1:1;}
function scrUGRound(_num,_precision) {return _precision==0?_num:round(_num/_precision)*_precision;}
function scrUGMotionAdd(_dir,_spd) {motion_add(_dir,_spd*timescale);}
function scrUGMotionAddCT(_dir,_spd) {motion_add(_dir,_spd*sqr(timescale));}
function scrUGMotionSet(_dir,_spd) {motion_set(_dir,_spd*timescale);}
function scrUGContact(_dir,_distance) {move_contact_solid(_dir,_distance);}
function scrUGBounce(_advanced) {move_bounce_solid(_advanced);}
function scrUGDelete(_who=self) {instance_destroy(_who,false);}
function scrUGSoundPitch(_snd,_pitch) {return snd_play(_snd,_pitch);}
function scrUGSoundPitchVol(_snd,_pitch,_vol) {return snd_play(_snd,_pitch,_vol);}
function scrUGDrawHurt(_on,_col,_a,_b) {gpu_set_fog(_on,_col,_a,_b);}
function scrUGWeaponPost(_kick,_reloadkick,_shake) {scr_weapon_post(gunangle,_kick,_reloadkick,_shake);}
function scrUGButton(_index,_key) {return _key=="fire"?KeyCont.press_fire[_index]:KeyCont.press_pick[_index];}

function scrUGFilter(_input,_field,_mode,_values) {
    if(_field=="my_health") _field="hp";
    var _src=scrNTTEFullInstances(_input),_out=[];
    for(var _i=0;_i<array_length(_src);++_i) {
        var _who=_src[_i];if(!instance_exists(_who) || !variable_instance_exists(_who,_field)) continue;
        var _v=variable_instance_get(_who,_field),_yes=false;
        for(var _j=0;_j<array_length(_values);++_j) {
            var _b=_values[_j];
            switch(_mode) {case "eq":_yes=_yes||_v==_b;break;case "ne":_yes=_yes||_v!=_b;break;case "le":_yes=_yes||_v<=_b;break;case "ge":_yes=_yes||_v>=_b;break;case "lt":_yes=_yes||_v<_b;break;case "gt":_yes=_yes||_v>_b;break;}
        }
        if(_yes) array_push(_out,_who);
    }
    return _out;
}
function scrUGMatching(_input,_field,_a,_b=undefined,_c=undefined) {return scrUGFilter(_input,_field,"eq",is_undefined(_b)?[_a]:(is_undefined(_c)?[_a,_b]:[_a,_b,_c]));}
function scrUGMatchingNE(_input,_field,_a) {return scrUGFilter(_input,_field,"ne",[_a]);}
function scrUGMatchingLE(_input,_field,_a) {return scrUGFilter(_input,_field,"le",[_a]);}
function scrUGMatchingGE(_input,_field,_a) {return scrUGFilter(_input,_field,"ge",[_a]);}
function scrUGMatchingLT(_input,_field,_a) {return scrUGFilter(_input,_field,"lt",[_a]);}
function scrUGMatchingGT(_input,_field,_a) {return scrUGFilter(_input,_field,"gt",[_a]);}
function scrUGMeeting(_x,_y,_objects) {
    var _oldx=x,_oldy=y;x=_x;y=_y;
    var _out=scrNTTEFullRectInstances(bbox_left,bbox_top,bbox_right-1,bbox_bottom-1,_objects);
    x=_oldx;y=_oldy;
    return _out;
}
function scrUGCreate(_x,_y,_name) {
    if(is_numeric(_name) && object_exists(_name)) return instance_create(_x,_y,_name);
    switch(_name) {
        case "BugBones":return scrUG_BugBones_create(_x,_y);
        case "DirectionalExplosion":return scrUG_DirectionalExplosion_create(_x,_y);
        case "Dragonfly":return scrUG_Dragonfly_create(_x,_y);
        case "Ember":return scrUG_Ember_create(_x,_y);
        case "FireFlower":return scrUG_FireFlower_create(_x,_y);
        case "Firefly":return scrUG_Firefly_create(_x,_y);
        case "FireflyExplode":return scrUG_FireflyExplode_create(_x,_y);
        case "FlamePuff":return scrUG_FlamePuff_create(_x,_y);
        case "FlameSparkle":return scrUG_FlameSparkle_create(_x,_y);
        case "FlameSparkleBig":return scrUG_FlameSparkleBig_create(_x,_y);
        case "Flytrap":return scrUG_Flytrap_create(_x,_y);
        case "GoldPitcherPlant":return scrUG_GoldPitcherPlant_create(_x,_y);
        case "GreenDirectionalExplosion":return scrUG_GreenDirectionalExplosion_create(_x,_y);
        case "LavaSheet":return scrUG_LavaSheet_create(_x,_y);
        case "LavaSplash":return scrUG_LavaSplash_create(_x,_y);
        case "LavaStreak":return scrUG_LavaStreak_create(_x,_y);
        case "Millipede":return scrUG_Millipede_create(_x,_y);
        case "MillipedeSegment":return scrUG_MillipedeSegment_create(_x,_y);
        case "Mushroom":return scrUG_Mushroom_create(_x,_y);
        case "MushroomExplode":return scrUG_MushroomExplode_create(_x,_y);
        case "MushroomExplosion":return scrUG_MushroomExplosion_create(_x,_y);
        case "MushroomSpawn":return scrUG_MushroomSpawn_create(_x,_y);
        case "PitcherPlant":return scrUG_PitcherPlant_create(_x,_y);
        case "UndergrowthBandit":return scrUG_UndergrowthBandit_create(_x,_y);
        case "Vine":return scrUG_Vine_create(_x,_y);
        case "VineChest":return instance_create(_x,_y,UGChest);
        case "Woo":return scrUG_Woo_create(_x,_y);
    }
    throw "Unknown Undergrowth entity: "+string(_name);
}

function scrUGWeaponsInit() {
    var _names=["FOSSIL PISTOL","FOSSIL GUN","FOSSIL CANNON","FOSSIL HAMMER","MEGA GRENADE LAUNCHER"],
        _text=["WISHBONE","PREHISTORIC","DINOSAUR HUNTER","PRIMITIVE","DANGEROUS"],
        _cost=[1,3,4,3,3],_load=[10,20,30,30,20],_tier=[8,9,11,9,-1],
        _sprites=[sprUGFossilPistol,sprUGFossilGun,sprUGFossilCannon,sprUGFossilHammer,sprUGMegaGrenadeLauncher];
    for(var _i=0;_i<5;++_i) {
        var _w=174+_i;
        scrNTTERegisterBulletWeapon(_w,_names[_i],_text[_i],_cost[_i],_load[_i],false,_tier[_i],_sprites[_i],_i==3?sndSwapHammer:sndSwapExplosive);
        wep_type[_w]=Ammo.Explosives;wep_mele[_w]=_i==3;
    }
}
function scrUGLocalize() {
    var _rows=[["FOSSIL PISTOL","化石手枪"],["FOSSIL GUN","化石枪"],["FOSSIL CANNON","化石加农炮"],["FOSSIL HAMMER","化石锤"],
        ["MEGA GRENADE LAUNCHER","巨型榴弹发射器"],["WISHBONE","许愿骨"],["PREHISTORIC","史前遗物"],["DINOSAUR HUNTER","恐龙猎手"],
        ["PRIMITIVE","原始之力"],["DANGEROUS","危险品"],["FIREFLY","萤火虫"],["DRAGONFLY","蜻蜓"],["FLYTRAP","捕蝇草"],
        ["PITCHER PLANT","猪笼草"],["GOLD PITCHER PLANT","黄金猪笼草"],["MILLIPEDE","马陆"],["MUSHROOM","蘑菇"],["VINE","藤蔓"],
        ["FIREFLY TRAP","捕萤草"],["GOLDEN PITCHER PLANT","黄金猪笼草"],["MUSHROOM BOMB","蘑菇炸弹"],
        ["UNDERGROWTH","林下秘境"],["MILLIPEDES DRINK OIL","马陆以石油为饮"],["CAREFUL WITH THE MUSHROOMS","当心蘑菇"],
        ["REMEMBER THEIR GREED","记住他们的贪婪"],["PETROLEUM WETLANDS","石油湿地"],["WAS IT WORTH IT","这一切值得吗"],
        ["VENGEFUL NATURE","大自然的复仇"],["FOSSIL FUELS","化石燃料"],["BLACK GOLD","黑色黄金"],["IGNIVOROUS","以火为食"]];
    for(var _i=0;_i<array_length(_rows);++_i) global.ntte_zh_dictionary[$ _rows[_i][0]]=_rows[_i][1];
}
function scrUGWeaponSwap(_weapon) {
    switch(_weapon) {
        case wep_ug_fossil_pistol:return scrUG_fossil_pistol_weapon_swap();
        case wep_ug_fossil_gun:return scrUG_fossil_gun_weapon_swap();
        case wep_ug_fossil_cannon:return scrUG_fossil_cannon_weapon_swap();
        case wep_ug_fossil_hammer:return scrUG_fossil_hammer_weapon_swap();
        case wep_ug_mega_grenade_launcher:return scrUG_mega_grenade_launcher_weapon_swap();
    }
    return sndSwapExplosive;
}
function scrUGWeaponReloaded(_weapon) {
    switch(scrNTTEFullWeaponRaw(_weapon)) {
        case wep_ug_fossil_pistol:scrUG_fossil_pistol_weapon_reloaded();break;
        case wep_ug_fossil_gun:scrUG_fossil_gun_weapon_reloaded();break;
        case wep_ug_fossil_cannon:scrUG_fossil_cannon_weapon_reloaded();break;
        case wep_ug_fossil_hammer:scrUG_fossil_hammer_weapon_reloaded();break;
        default:return false;
    }
    return true;
}
function scrUGWeaponStep() {
    if(scrNTTEFullWeaponRaw(wep)==wep_ug_fossil_hammer) scrUG_fossil_hammer_step(true);
}
function scrUGWeaponFire(_weapon,_primary) {
    switch(_weapon) {
        case wep_ug_fossil_pistol:scrUG_fossil_pistol_weapon_fire();break;
        case wep_ug_fossil_gun:scrUG_fossil_gun_weapon_fire();break;
        case wep_ug_fossil_cannon:scrUG_fossil_cannon_weapon_fire();break;
        case wep_ug_fossil_hammer:scrUG_fossil_hammer_weapon_fire();break;
        case wep_ug_mega_grenade_launcher:scrUG_mega_grenade_launcher_weapon_fire();break;
        default:return false;
    }
    return true;
}
function scrUGChestStep() {
    if(!place_meeting(x,y,Player) && !place_meeting(x,y,PortalShock)) return;
    snd_play(sndBigWeaponChest);snd_play(sndPlantSnareTrapperTB,0.8,0.6);
    instance_create(x,y,FXChestOpen);
    with(instance_create(x,y,ChestOpen)) sprite_index=other.spr_dead;
    with(instance_create(x,y,PortalClear)) {image_xscale=4/3;image_yscale=4/3;}
    if(GameCont.crown==crwn_hatred) with(Player) if(place_meeting(x,y,other.id)) {
        scr_projectile_hit(id,1);repeat(16) with(instance_create(x,y,Rad)) motion_set(random(360),random_range(2,6)*timescale);
    }
    var _held=[],_min=0,_max=GameCont.hard+2,_pool=[];
    with(Player) {_max+=(race==Race.Robot);if(wep!=wep_none) array_push(_held,wep);if(bwep!=wep_none) array_push(_held,bwep);}
    if(scr_ultra_get(Race.Robot,UltraSkill.RefinedTaste)) _min+=4;
    for(var _w=1;_w<=maxwep;++_w) {
        var _tier=scr_weapon_get_area(_w);
        if(_tier>=_min && _tier<=_max && array_get_index(_held,_w)<0 && scrNTTEFullWeaponCandidate(_w,false,undefined,id)) array_push(_pool,_w);
    }
    // Filter once; source's retry loop never terminates when all are held.
    repeat(5) {
        var _w=array_length(_pool)>0?_pool[irandom(array_length(_pool)-1)]:wep_screwdriver;
        with(instance_create(x,y,WepPickup)) {
            // This runner does not refresh raw-number pickups after Create.
            // Set metadata without consuming extra RNG between the five rolls.
            wep=_w;name=scr_weapon_get_name(_w);type=scr_weapon_get_type(_w);
            sprite_index=scr_weapon_get_sprite(_w);ammo=true;roll=true;
        }
    }
    GameCont.nochest=0;instance_destroy();
}

function scrUGDrawTop() {
    var _segments=[];with(UGEnemy) if(name=="MillipedeSegment" && visible) array_push(_segments,id);
    array_sort(_segments,function(_a,_b){return _a.y-_b.y;});
    for(var _i=0;_i<array_length(_segments);++_i) with(_segments[_i]) if(instance_exists(parent)) scrUGLeg(90);
    for(var _i=0;_i<array_length(_segments);++_i) with(_segments[_i]) {
        scrUG_MillipedeSegment_draw();
        if(instance_exists(parent)) scrUGLeg(270);
    }
    var _explosions=scrUGMatching(Explosion,"name","MushroomExplosion");
    array_sort(_explosions,function(_a,_b){return _a.y-_b.y;});
    for(var _i=0;_i<array_length(_explosions);++_i) with(_explosions[_i]) if(visible) {
        draw_sprite_ext(sprite_index,image_index,x,y,image_xscale,image_yscale,image_angle,image_blend,abs(image_alpha));
    }
    gpu_set_blendmode(bm_add);
    for(var _i=0;_i<array_length(_explosions);++_i) with(_explosions[_i]) if(visible) {
        draw_sprite_ext(sprite_index,image_index,x,y,image_xscale*2,image_yscale*2,image_angle,image_blend,abs(image_alpha)/10);
    }
    gpu_set_blendmode(bm_normal);
}
function scrUGLeg(_base) {
    var _spr=sprite_index==spr_hurt?spr_foot_hurt:spr_foot_idle,_n=sprite_get_number(_spr),
        _angle=gunangle+_base+cos(wave/10)*10,_index=(_angle/(360/_n)) mod _n,
        _dist=8+10*abs(dcos(_angle)),_x=(parent.x+x)/2+lengthdir_x(_dist,_angle),_y=(parent.y+y)/2+lengthdir_y(_dist,_angle)-z;
    var _hurt=sprite_index==spr_hurt && image_index<1;
    if(_hurt) gpu_set_fog(true,image_blend,0,0);
    draw_sprite(_spr,_index,_x,_y);
    if(_hurt) gpu_set_fog(false,c_white,0,0);
}
function scrUGDark(_gray,_vx,_vy) {
    with(UGEnemy) if(visible) {
        var _radius=0;
        switch(name) {
            case "Firefly":_radius=16+16*_gray;break;
            case "Dragonfly":_radius=64+64*_gray;break;
            case "PitcherPlant":case "GoldPitcherPlant":if(light_coeff>(_gray?0:2/3)) _radius=(_gray?16:12)*(1+light_coeff);break;
            case "Flytrap":if(light_coeff>(_gray?0:2/3)) _radius=(_gray?40:20)*(1+light_coeff);break;
        }
        if(_radius>0) draw_circle(x-_vx,y-_vy,_radius+random(2+2*_gray),false);
    }
    with(UGObject) if(visible) {
        if(name=="FireflyExplode") draw_circle(x-_vx,y-_vy,32+32*_gray+random(2),false);
        if(name=="MushroomExplode") draw_circle(x-_vx,y-_vy,(_gray?16:8)+(16+16*_gray)*(image_index/image_number)+random(4),false);
    }
    if(!_gray) with(Explosion) if(scrNTTEFullValue(id,"name","")=="MushroomExplosion" && image_index<2)
        draw_rectangle(0,0,view_width,view_height,false);
}
function scrUGBloom() {
    with(UGProjectile) if(visible && (name=="LavaBomb" || name=="LavaBombBig"))
        draw_sprite_ext(sprite_index,image_index,x,y,image_xscale*2,image_yscale*2,image_angle,image_blend,image_alpha/10);
}
function scrUGShadows(_vx,_vy) {
    with(UGObject) if(visible && name=="FireflyExplode" && sprite_exists(spr_shadow))
        draw_sprite(spr_shadow,0,x-_vx+spr_shadow_x,y-_vy+spr_shadow_y);
}

// The native loop cluster pass duplicates an object's class. UGEnemy is a
// shared shell: its named factory must also run, just as at initial population.
// Keep the original count, offset RNG, and ordinary enemy construction.
function scrUGClusterCreate(_x,_y,_object,_source) {
    if(_object==UGEnemy && instance_exists(_source))
        return scrUGCreate(_x,_y,_source.name);
    return instance_create(_x,_y,_object);
}
