// Source petlib.Weapon_* (3255–3867). Uses the actor-fire adapter instead
// of NTT's player_fire_ext and the native directional aim input on iOS.
function scrNTTEFullPetWeaponCreate() {
    spr_spwn=scrNTTERefSprite("PetWeaponSpwn"); spr_hide=scrNTTERefSprite("PetWeaponHide")
    image_index=sprite_get_number(spr_hide)-1
    snd_spwn=sndBallMamaTaunt; snd_hide=sndChest; snd_hurt=sndMimicHurt; snd_dead=sndMimicDead
    mask_index=mskFrogEgg; max_hp=20; spr_shadow_y=-1; spr_bubble_y=-1
    type=choose(Ammo.None,Ammo.Bullets,Ammo.Shells,Ammo.Bolts,Ammo.Explosives,Ammo.Energy)
    gunangle=random(360); gunangle_goal=gunangle; gunangle_turn=0.25
    shootdis_min=0; shootdis_max=192; target=noone; target_visible=false; curse=0; setup=true
    wep=wep_none; bwep=wep_none; wkick=0; bwkick=0; wepangle=0; bwepangle=0
    wepflip=choose(-1,1); bwepflip=choose(-1,1); reload=30; breload=30
    can_shoot=0; bcan_shoot=0; wep_laser=0; bwep_laser=0
    ntte_state=undefined; bntte_state=undefined
    hitid=[spr_spwn,"WEAPON MIMIC"]; array_push(history,"type","curse","wep","bwep")
    stat.battle=scrNTTEFullValue(stat,"battle",[0,0])
    hooks={skin:method(id,scrNTTEFullPetWeaponSkin),anim:method(id,scrNTTEFullPetWeaponAnim),step:method(id,scrNTTEFullPetWeaponStep),
        alarm:method(id,scrNTTEFullPetWeaponAlarm),hurt:method(id,scrNTTEFullPetWeaponHurt),draw:method(id,scrNTTEFullPetWeaponDraw),initial_sprite:spr_hide}
}
function scrNTTEFullPetWeaponSkin() {
    var _prefix=bskin==1 ? "PetWeaponCursed":"PetWeapon",_keys=["idle","walk","hurt","dead","icon","spwn","hide"],_suffix=["Idle","Walk","Hurt","Dead","Icon","Spwn","Hide"]
    for(var _i=0;_i<array_length(_keys);++_i) scrNTTEFullPetSkinField("spr_"+_keys[_i],scrNTTERefSprite(_prefix+_suffix[_i]))
    hitid=[spr_idle,(bskin==1 ? "@q@pCURSED#":"")+"WEAPON MIMIC"]
}
function scrNTTEFullPetWeaponSetup() {
    setup=false
    if(type>=0) {
        if(wep==wep_none) {
            if(curse>0) { wep=wep_super_disc_gun; type=Ammo.Shells }
            else {
                var _sub=(irandom(14)==0 && (stat.found>0 || stat.owned>0)) ? 2:(GameCont.loops>0 ? 1:0)
                var _weapons=[]
                switch(type) {
                    case Ammo.None: _weapons=[wep_wrench,wep_energy_sword,wep_jackhammer]; break
                    case Ammo.Bullets: _weapons=[wep_revolver,wep_heavy_revolver,wep_minigun]; break
                    case Ammo.Shells: _weapons=[wep_shotgun,wep_eraser,wep_heavy_slugger]; break
                    case Ammo.Bolts: _weapons=[wep_crossbow,wep_auto_crossbow,wep_splinter_pistol]; break
                    case Ammo.Explosives: _weapons=[wep_grenade_launcher,wep_blood_launcher,wep_sticky_launcher]; break
                    case Ammo.Energy: _weapons=[wep_laser_cannon,wep_plasma_cannon,wep_super_plasma_cannon]; break
                }
                wep=_weapons[_sub]
            }
            if(bwep==wep_none) {
                var _name=string_upper(scr_weapon_get_name(wep))
                if(string_pos("REVOLVER",_name)>0 || string_pos("PISTOL",_name)>0) bwep=wep
            }
        } else type=scr_weapon_is_melee(wep) ? Ammo.None:scr_weapon_get_type(wep)
        gunangle_turn=0.25; shootdis_min=32; shootdis_max=192
        switch(type) {
            case Ammo.None: shootdis_min=0; break
            case Ammo.Shells: shootdis_min=0; shootdis_max=96+64*(wep==wep_eraser); break
            case Ammo.Bolts: gunangle_turn=0.5; shootdis_min=64; shootdis_max=320; break
            case Ammo.Explosives: gunangle_turn=0.1; break
        }
        if(wep==wep_jackhammer) gunangle_turn=0.1
    }
    var _angle=choose(-120,120)
    wepangle=_angle*scr_weapon_is_melee(wep); bwepangle=-_angle*scr_weapon_is_melee(bwep)
}
function scrNTTEFullPetWeaponAnim() {
    var _normal=speed>0 ? spr_walk:spr_idle
    if(sprite_index!=spr_hide || instance_exists(leader) || (instance_is(id,NTTEFullPetWeaponBoss) && scrNTTEFullWeaponMimicBossTarget())) {
        if(sprite_index==spr_spwn || sprite_index==spr_hide) {
            if(sprite_index==spr_hide) { sprite_index=spr_spwn; image_index=0 }
            if(image_index<=0) {
                var _snd=snd_play(snd_spwn,2,3); if(_snd>=0) audio_sound_set_track_position(_snd,0.2)
                _snd=snd_play_hit(sndTechnomancerActivate,0); if(_snd>=0) audio_sound_gain(_snd,0.4,300)
                snd_play_hit(sndBigWeaponChest,0)
            }
            if(image_index>=sprite_get_number(spr_spwn)-image_speed) {
                wkick=-2; bwkick=-2; if(scr_weapon_is_valid(wep)) snd_play(scrNTTEFullWeaponSwapSound(wep))
                instance_create(x+lengthdir_x(8,gunangle),y+lengthdir_y(8,gunangle),WepSwap); sprite_index=_normal
            }
        } else if(sprite_index!=spr_hurt || image_index>=sprite_get_number(spr_hurt)-image_speed) sprite_index=_normal
    } else {
        image_index=min(image_index,sprite_get_number(spr_hide)-1)
        if(floor(image_index)==sprite_get_number(spr_hide)-2 && image_index<floor(image_index)+image_speed) {
            snd_play(snd_hide,0.8+random(0.2)); repeat(4) scrNTTEFullPetEffect(x,y,2,Dust)
        }
    }
}
function scrNTTEFullPetWeaponReloadFX(_prefix,_weapon) {
    var _snd=-1
    variable_instance_set(id,_prefix+"wepflip",-variable_instance_get(id,_prefix+"wepflip"))
    if(scr_weapon_is_melee(_weapon)) {
        var _dir=gunangle+variable_instance_get(id,_prefix+"wepangle")
        instance_create(x+lengthdir_x(12,_dir),y+lengthdir_y(12,_dir),WepSwap)
        variable_instance_set(id,_prefix+"wkick",-3); _snd=sndMeleeFlip
    } else switch(scr_weapon_get_type(_weapon)) {
        case Ammo.Shells:
            _snd=sndShotReload; variable_instance_set(id,_prefix+"wkick",-4)
            repeat(scr_weapon_get_cost(_weapon)) {
                var _shell=instance_create(x,y,Shell); _shell.sprite_index=sprShotShell
                with(_shell) motion_add(other.gunangle+100*other.right+orandom(20),(2+random(2))*timescale)
            }
            break
        case Ammo.Bolts: _snd=sndCrossReload; break
        case Ammo.Explosives:
            if(array_get_index([wep_grenade_launcher,wep_golden_grenade_launcher,wep_grenade_shotgun,wep_grenade_rifle,wep_auto_grenade_shotgun,wep_ultra_grenade_launcher,wep_sticky_launcher,wep_hyper_launcher,wep_toxic_launcher,wep_cluster_launcher,wep_heavy_grenade_launcher],_weapon)>=0) _snd=sndNadeReload
            break
        case Ammo.Energy:
            var _name=string_upper(scr_weapon_get_name(_weapon))
            if(string_pos("PLASMA",_name)==1) _snd=sndPlasmaReload
            else if(string_pos("LIGHTNING",_name)==1) _snd=sndLightningReload
            break
    }
    if(audio_exists(_snd)) snd_play(_snd,1.15+orandom(0.25),1.5)
}
function scrNTTEFullPetWeaponStep() {
    if(setup) scrNTTEFullPetWeaponSetup()
    if(bskin!=(curse>0)) scrNTTEFullPetSetSkin(id,curse>0 ? 1:0)
    target_visible=instance_exists(target) && target.team!=team && !collision_line(x,y,target.x,target.y,Wall,false,false)
    if(sprite_index!=spr_spwn && instance_exists(leader) && instance_is(leader,Player)
        && (!collision_line(x,y,leader.x,leader.y,Wall,false,false) || target_visible)) {
        var _aimx=leader.x+lengthdir_x(192,leader.gunangle),_aimy=leader.y+lengthdir_y(192,leader.gunangle)
        gunangle_goal=point_direction(x,y,_aimx,_aimy)
        var _weapon=leader.wep,_kind=scr_weapon_get_type(_weapon),_auto=leader.race==Race.Steroids ? scr_weapon_is_auto(_weapon)>=0:scr_weapon_is_auto(_weapon)
        var _enough=leader.infammo!=0 || (leader.ammo[_kind]>=scr_weapon_get_cost(_weapon) && GameCont.rad>=scr_weapon_get_rads(_weapon))
        var _hold=leader.can_shoot && scrNTTEFullValue(leader,"canfire",true) && _auto && _enough
        if(_hold ? KeyCont.hold_fire[leader.index]:KeyCont.press_fire[leader.index]) {
            for(var _hand=0;_hand<2;++_hand) {
                var _b=_hand==0 ? "":"b",_w=variable_instance_get(id,_b+"wep"),_r=variable_instance_get(id,_b+"reload"),_can=variable_instance_get(id,_b+"can_shoot")
                if(_can<=0 && _w!=wep_none && _r<=0) {
                    _can=1; var _load=scr_weapon_get_load(_w)
                    if(scr_weapon_is_auto(_w) || _load<=10) _can+=floor(random(15)/max(1,_load))
                    variable_instance_set(id,_b+"can_shoot",_can); break
                }
            }
        }
    }
    if(target_visible) gunangle_goal=point_direction(x,y,target.x+target.hspeed,target.y+target.vspeed)
    else target=noone
    gunangle+=angle_difference(gunangle_goal,gunangle)*(1-power(1-gunangle_turn,timescale)); right=lengthdir_x(1,gunangle)>=0 ? 1:-1
    for(var _hand=0;_hand<2;++_hand) {
        var _b=_hand==0 ? "":"b",_w=variable_instance_get(id,_b+"wep"),_r=variable_instance_get(id,_b+"reload"),_kick=variable_instance_get(id,_b+"wkick")
        if(!instance_is(id,NTTEFullPetWeaponBoss) || _hand!=0) _kick-=clamp(_kick,-timescale,timescale)
        if(_r>0) {
            _r-=timescale
            if(_r<=0 && _w!=wep_none && sprite_index!=spr_spwn && sprite_index!=spr_hide && variable_instance_get(id,_b+"can_shoot")<=0) {
                scrNTTEFullPetWeaponReloadFX(_b,_w); _kick=variable_instance_get(id,_b+"wkick")
            }
        } else {
            var _laser=variable_instance_get(id,_b+"wep_laser")
            if(scrNTTEFullWeaponMimicLaserSight(wep)) {
                if(target_visible || (instance_exists(leader) && !collision_line(x,y,leader.x,leader.y,Wall,false,false))
                    || (instance_is(id,NTTEFullPetWeaponBoss) && point_distance(x,y,cover_x,cover_y)<24))
                    _laser+=timescale/((target_visible && point_distance(x,y,target.x,target.y)<shootdis_min) ? 60:5)
                else if(_laser>0) _laser-=timescale/3
            }
            var _can=variable_instance_get(id,_b+"can_shoot")
            if(_can>0 && _w!=wep_none) {
                _can-=1; _laser=0
                // Keep separate native MOD state for each hand when customized.
                var _old_state=ntte_state
                if(_hand==1) ntte_state=bntte_state
                var _fire=scrNTTEFullWeaponMimicSharedFire(id,_w,gunangle,1,false,_can)
                if(_hand==1) { bntte_state=_fire.state; ntte_state=_old_state }
                else ntte_state=_fire.state
                _r=_fire.reload; _kick=_fire.wkick*1.5
                variable_instance_set(id,_b+"wepangle",-variable_instance_get(id,_b+"wepangle"))
                variable_instance_set(id,_b+"can_shoot",_can)
            }
            variable_instance_set(id,_b+"wep_laser",_laser)
        }
        variable_instance_set(id,_b+"wkick",_kick); variable_instance_set(id,_b+"reload",_r)
    }
    var _self=id
    with(projectileburst) if(creator==_self) { direction=_self.gunangle; ntte_actor_angle=_self.gunangle }
    with(LaserCannon) if(creator==_self) { direction=_self.gunangle; ntte_actor_angle=_self.gunangle }
}
function scrNTTEFullPetWeaponAlarm(_leader_dir,_leader_dis) {
    ntte_pet_alarm=irandom_range(20,40)
    if(sprite_index==spr_hide || sprite_index==spr_spwn) return 0
    if(instance_exists(leader)) {
        if(!is_undefined(path_dir)) {
            scrNTTEFullPetWalk(path_dir+orandom(20),random_range(5,10)); gunangle_goal+=angle_difference(direction,gunangle_goal)*0.1; return walk
        }
        if(_leader_dis>128) scrNTTEFullPetWalk(_leader_dir+orandom(30),random_range(30,60))
        else if(instance_is(leader,Player)) {
            var _mx=leader.x+lengthdir_x(192,leader.gunangle),_my=leader.y+lengthdir_y(192,leader.gunangle)
            var _tx=lerp(leader.x,_mx,0.5),_ty=lerp(leader.y,_my,0.5)
            scrNTTEFullPetWalk(point_direction(x,y,_tx+orandom(24),_ty+orandom(24)),point_distance(x,y,_tx,_ty)/4+irandom(20))
            var _pet=id
            for(var _pass=0;_pass<2 && !instance_exists(target);++_pass) {
                var _best=64,_cx=_pass==0 ? x:_mx,_cy=_pass==0 ? y:_my
                with(hitme) if(id!=_pet && team!=_pet.team && team!=team_none && hp>0 && mask_index!=mskNone) {
                    var _distance=point_distance(x,y,_cx,_cy)
                    if(_distance<_best && !collision_line(x,y,_pet.x,_pet.y,Wall,false,false)) { _best=_distance; _pet.target=id }
                }
            }
        }
    } else { sprite_index=spr_hide; image_index=0 }
    return 0
}
function scrNTTEFullPetWeaponHurt(_damage,_direction,_force=0) {
    var _source=scrNTTEFullValue(id,"ntte_pet_hit_source",noone),_attacker=scrNTTEFullValue(_source,"creator",noone)
    if(instance_exists(_attacker) && scrNTTEFullValue(_attacker,"team",team)!=team) target=_attacker
    return false
}
function scrNTTEFullPetWeaponDrawGun(_row) {
    var _angle=gunangle+_row.angle*(1-_row.kick/20)
    draw_sprite_ext(scr_weapon_get_sprite(_row.wep),0,_row.x-lengthdir_x(_row.kick,_angle),_row.y-lengthdir_y(_row.kick,_angle),
        1,_row.flip,_angle,_row.col,_row.alpha)
}
function scrNTTEFullPetWeaponDraw(_spr,_img,_x,_y,_xs,_ys,_ang,_col,_alpha) {
    var _rows=[],_off=(wep!=wep_none && bwep!=wep_none) ? 5:2
    if(_spr!=spr_spwn && _spr!=spr_hide && !instance_exists(revive)) for(var _hand=0;_hand<2;++_hand) {
        var _b=_hand==0 ? "":"b",_w=variable_instance_get(id,_b+"wep"),_a=variable_instance_get(id,_b+"wepangle"),_r=variable_instance_get(id,_b+"reload"),_d=gunangle+_a
        if(_w!=wep_none) array_push(_rows,{wep:_w,x:_x+lengthdir_x(1,_d)+lengthdir_x(_off,_d-90),y:_y+lengthdir_y(1,_d)+lengthdir_y(_off*2/3,_d-90),
            angle:_a,kick:variable_instance_get(id,_b+"wkick"),flip:(_a!=0 ? variable_instance_get(id,_b+"wepflip"):1)*sign(_off),
            col:merge_color(_col,c_black,0.15*(_r>0)*scr_weapon_is_melee(_w)),alpha:_alpha,laser:min(1,variable_instance_get(id,_b+"wep_laser"))})
        _off*=-1
    }
    for(var _i=0;_i<array_length(_rows);++_i) {
        var _row=_rows[_i]
        if(_row.laser>0 && scrNTTEFullWeaponMimicLaserSight(_row.wep)) {
            var _range=0
            while(_range<1000 && !position_meeting(_row.x+lengthdir_x(_range,gunangle),_row.y+lengthdir_y(_range,gunangle),Wall)) _range+=2
            draw_sprite_ext(sprLaserSightPlayer,0,_row.x,_row.y,_range/2+2,1,gunangle,make_color_rgb(250,54,0),_row.laser*_alpha)
        }
        if(_row.y<_y) scrNTTEFullPetWeaponDrawGun(_row)
    }
    var _hurt=_spr!=spr_hurt && nexthurt>current_frame+3
    if(_hurt) gpu_set_fog(true,image_blend,0,0)
    draw_sprite_ext(_spr,_img,_x,_y,_xs,_ys,_ang,_col,_alpha)
    if(_hurt) gpu_set_fog(false,0,0,0)
    for(var _i=0;_i<array_length(_rows);++_i) if(_rows[_i].y>=_y) scrNTTEFullPetWeaponDrawGun(_rows[_i])
}
function scrNTTEFullPetWeaponTests() {
    var _p=instance_find(Player,0),_old=scrNTTEFullValue(_p,"ntte_pet",[]),_oldmax=scrNTTEFullValue(_p,"ntte_pet_max",undefined)
    var _snapshot=scrNTTEFullInstances(all),_oldloops=GameCont.loops
    _p.ntte_pet=[]; _p.ntte_pet_max=1
    var _pet=scrNTTEFullPetCreate(_p.x+48,_p.y,"Weapon")
    assert(_pet.max_hp==20 && _pet.mask_index==mskFrogEgg && _pet.sprite_index==_pet.spr_hide,"Weapon pet source constructor changed")
    // Explicit normal/loop weapon selection never takes the rare branch for a
    // newly discovered pet; this checks the whole six-type table deterministically.
    var _normal=[wep_wrench,wep_revolver,wep_shotgun,wep_crossbow,wep_grenade_launcher,wep_laser_cannon]
    var _loop=[wep_energy_sword,wep_heavy_revolver,wep_eraser,wep_auto_crossbow,wep_blood_launcher,wep_plasma_cannon]
    for(var _loops=0;_loops<2;++_loops) for(var _kind=0;_kind<6;++_kind) {
        GameCont.loops=_loops
        with(_pet) { type=_kind; wep=wep_none; bwep=wep_none; stat={found:0,owned:0,battle:[0,0]}; scrNTTEFullPetWeaponSetup() }
        assert(_pet.wep==(_loops==0 ? _normal[_kind]:_loop[_kind]),"Weapon pet normal/loop table mismatch for type "+string(_kind))
        assert((_kind==Ammo.Bullets)==(_pet.bwep==_pet.wep),"Weapon pet revolver akimbo setup mismatch")
    }
    with(_pet) { curse=1; wep=wep_none; bwep=wep_none; scrNTTEFullPetWeaponSetup(); scrNTTEFullPetWeaponStep() }
    assert(_pet.wep==wep_super_disc_gun && _pet.type==Ammo.Shells && _pet.bskin==1 && _pet.spr_idle==scrNTTERefSprite("PetWeaponCursedIdle"),
        "Weapon pet cursed Super Disc or skin behavior differs from source")
    GameCont.loops=_oldloops
    _pet.curse=0; _pet.wep=wep_revolver; _pet.bwep=wep_revolver
    with(_pet) scrNTTEFullPetWeaponSetup()
    scrNTTEFullPetTake(_pet,_p)
    _pet.sprite_index=_pet.spr_idle; _pet.reload=0; _pet.breload=0; _pet.can_shoot=1; _pet.bcan_shoot=1
    var _before=scrNTTEFullInstances(Bullet1)
    with(_pet) scrNTTEFullPetWeaponStep()
    var _fired=0
    with(Bullet1) if(array_get_index(_before,id)<0 && creator==_pet && team==_p.team) _fired+=1
    assert(_fired==2 && _pet.reload>0 && _pet.breload>0,"Weapon pet did not fire both native revolvers from real pet ownership")
    var _friendly=instance_create(_pet.x+8,_pet.y,Bandit),_hostile=instance_create(_pet.x+16,_pet.y,Bandit)
    _friendly.team=_p.team; _hostile.team=team_enemy; _pet.target=noone
    with(_pet) scrNTTEFullPetWeaponAlarm(0,0)
    assert(_pet.target!=_friendly,"Weapon pet locked onto a friendly unit")
    _pet.target=_friendly; with(_pet) scrNTTEFullPetWeaponStep()
    assert(_pet.target==noone,"Weapon pet retained a friendly unit target")
    var _after=scrNTTEFullInstances(all)
    for(var _i=0;_i<array_length(_after);++_i) if(array_get_index(_snapshot,_after[_i])<0) instance_destroy(_after[_i],false)
    _p.ntte_pet=_old; _p.ntte_pet_max=_oldmax; GameCont.loops=_oldloops
    scrNTTESmokeLog("SYSTEMS PET WEAPON: all normal/loop weapon tables, akimbo, cursed skin/Super Disc, real dual firing and friendly-target exclusion OK")
}
