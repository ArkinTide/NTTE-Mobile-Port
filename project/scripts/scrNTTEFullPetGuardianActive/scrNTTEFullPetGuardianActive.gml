// Source telabs.ntte_begin_step, Popo Guardian pet race abilities.
// Native touch/controller input exposes an aim direction instead of NTT's
// per-player mouse world position. Aim points use that same native cursor ray.
function scrNTTEFullPetGuardianFrame(_period) { return current_frame%_period<timescale }
function scrNTTEFullPetGuardianPlayerActive() {
    var _player=id
    with(NTTEFullPet) if(pet=="Guardian" && visible && leader==_player && hp>0) scrNTTEFullPetGuardianActive()
}
function scrNTTEFullPetGuardianActive() {
    if(!instance_exists(leader) || !instance_is(leader,Player) || !leader.visible) return;
    var _p=leader,_held=_p.can_spec && KeyCont.hold_spec[_p.index],_press=_p.can_spec && KeyCont.press_spec[_p.index]
    var _aimx=_p.x+lengthdir_x(192,_p.gunangle),_aimy=_p.y+lengthdir_y(192,_p.gunangle),_pet=id
    switch(_p.race) {
        case Race.Fish:
            if(_p.roll && point_distance(x,y,_p.x,_p.y)<32 && dash_charge==0) {
                var _dx=lengthdir_x(1.5*timescale,_p.direction),_dy=lengthdir_y(1.5*timescale,_p.direction)
                with(_p) {
                    if(!place_meeting(x+_dx,y+_dy,Wall)) { x+=_dx; y+=_dy; xprevious=x; yprevious=y }
                    else if(!place_meeting(x+_dx,y,Wall)) { x+=_dx; xprevious=x }
                    else if(!place_meeting(x,y+_dy,Wall)) { y+=_dy; yprevious=y }
                }
                x=lerp(x,_p.x,1-power(1/3,timescale)); y=lerp(y,_p.y,1-power(1/3,timescale))
                right=lengthdir_x(1,_p.direction)>=0 ? 1:-1
                if(sprite_index==spr_dash_end) image_index=0
                else if(sprite_index==spr_idle) { sprite_index=spr_dash_start; image_index=0 }
            }
            break
        case Race.Crystal:
            var _own_shield=false,_pet_shield=false
            with(CrystalShield) if(creator==_p) _own_shield=true
            with(NTTEFullPetGuardianShield) if(creator==_pet) _pet_shield=true
            with(NTTEFullCrystalShieldDisappear) if(creator==_pet) _pet_shield=true
            if(_held && dash_charge==0 && _own_shield && !_pet_shield) scrNTTEFullPetGuardianShieldDeploy(_aimx,_aimy)
            break
        case Race.Eyes:
        case Race.Plant:
            if(_press && dash_charge==0 && follow_delay==0) {
                dash_charge=dash_max_charge; dash_direction=_p.gunangle; dash_is_grab=true
                if(_p.race==Race.Eyes) {
                    var _best=infinity,_target=noone
                    with(hitme) if(team!=_pet.team) {
                        var _dis=point_distance(x,y,_aimx,_aimy)
                        if(_dis<_best) { _best=_dis; _target=id }
                    }
                    with(chestprop) { var _dis=point_distance(x,y,_aimx,_aimy); if(_dis<_best) { _best=_dis; _target=id } }
                    if(instance_exists(_target) && !collision_line(x,y,_target.x,_target.y,Wall,false,false)) dash_direction=point_direction(x,y,_target.x,_target.y)
                }
                sprite_index=spr_dash_start; image_index=0
            }
            if(instance_exists(grabbed_instance)) {
                if(_held) {
                    if(_p.race==Race.Plant) speed=0
                    else if(point_distance(x,y,_p.x,_p.y)>32) {
                        var _dir=point_direction(x,y,_p.x,_p.y); right=lengthdir_x(1,_dir+180)>=0 ? 1:-1
                        motion_add(_dir,2*timescale*timescale); with(grabbed_instance) motion_add(_dir,timescale*timescale)
                    }
                } else if(dash_charge==0) grabbed_instance=noone
            }
            break
        case Race.Melting:
            scrNTTEFullPetGuardianMelting(_held,_press)
            break
        case Race.Venuz:
            if(_press && _p.can_shoot && !scr_weapon_is_melee(_p.wep) && dash_charge==0) {
                var _count=2+2*scr_skill_get(mut_throne_butt),_w=_p.wep
                if(_p.ammo[scr_weapon_get_type(_w)]>=scr_weapon_get_cost(_w)*_count && GameCont.rad>=scr_weapon_get_rads(_w)*_count) {
                    var _targets=scrNTTEFullInstances(enemy),_dir=_p.gunangle
                    // Fisher-Yates, matching source's uniformly shuffled first
                    // visible opponent rather than favoring instance order.
                    for(var _i=array_length(_targets)-1;_i>0;--_i) { var _j=irandom(_i),_swap=_targets[_i]; _targets[_i]=_targets[_j]; _targets[_j]=_swap }
                    for(var _i=0;_i<array_length(_targets);++_i) {
                        var _t=_targets[_i]
                        if(_t.team!=team && !collision_line(x,y,_t.x,_t.y,Wall,false,false)) { _dir=point_direction(x,y,_t.x,_t.y); break }
                    }
                    scrNTTEFullActorFire(id,_w,_dir,_p.accuracy*4,false,_p)
                    right=lengthdir_x(1,_dir)>=0 ? 1:-1; sprite_index=spr_dash_end; image_index=1
                    snd_play_hit(sndRogueRifle,0.1)
                }
            }
            break
        case Race.Steroids:
            if(!variable_instance_exists(_p,"ntte_guardian_pet_last_ammo")) _p.ntte_guardian_pet_last_ammo=scrNTTEFullArrayCopy(_p.ammo)
            else if(current_frame_active && dash_charge==0) for(var _i=min(array_length(_p.ammo),array_length(_p.ntte_guardian_pet_last_ammo))-1;_i>=0;--_i) {
                var _diff=_p.ammo[_i]-_p.ntte_guardian_pet_last_ammo[_i]
                if(_diff<0 && (_held || !_p.bcan_shoot)) {
                    var _angle=point_direction(x,y,_aimx,_aimy),_spread=5+5*-_diff
                    follow_delay=max(follow_delay,10); right=lengthdir_x(1,_angle)>=0 ? 1:-1; sprite_index=spr_dash_end; image_index=2
                    _diff=max(-2,_diff)
                    repeat(-_diff) {
                        var _bullet=scr_projectile_create(x,y,Bullet1,_angle+orandom(_spread),16)
                        _bullet.sprite_index=sprIDPDBullet; _bullet.spr_dead=sprIDPDBulletHit
                        snd_play_hit(sndGruntFire,0.1)
                    }
                }
                _p.ntte_guardian_pet_last_ammo[_i]+=_diff
            }
            break
        case Race.Robot:
            if(_press && _p.bwep!=wep_none) {
                var _chest=instance_create(x,y,choose(IDPDChest,HealthChest)),_dir=point_direction(_p.x,_p.y,x,y)
                var _bag=scrNTTEFullSystemsCreate("BackpackPickup",_chest.x,_chest.y)
                _bag.direction=_dir; _bag.target=_chest
                var _fx=instance_create(_chest.x,_chest.y,FishA); _fx.depth=min(_fx.depth,_chest.depth-1)
                sprite_index=spr_appear; image_index=3; snd_play_hit(sndGuardianFire,0.1)
            }
            break
        case Race.Chicken:
            if(_press && _p.wep!=wep_none && _p.curse<=0 && dash_charge==0 && (follow_delay==0 || point_distance(x,y,_p.x,_p.y)<96)) {
                var _angle=_p.gunangle,_side=sign(angle_difference(_angle,point_direction(_p.x,_p.y,x,y)))
                sprite_index=spr_dash_start; image_index=sprite_get_number(spr_dash_start)-1
                repeat(3) scrNTTEFullPetEffect(x,y,[_angle,3],Dust)
                if(follow_delay!=0) { var _fx=instance_create(x,y,ThrowHit); _fx.image_speed=0.5*timescale }
                var _off=10*scr_skill_get(mut_long_arms)
                x=_p.x+lengthdir_x(_off,_angle); y=_p.y+lengthdir_y(_off,_angle); xprevious=_p.x; yprevious=_p.y
                var _slash=scr_projectile_create(x,y,Slash,_angle,2+1.5*scr_skill_get(mut_long_arms))
                _slash.sprite_index=sprPopoSlash; _slash.damage=8; _slash.walled=true
                move_contact_solid(_angle+45*_side,20); right=lengthdir_x(1,_angle+90*_side)>=0 ? 1:-1
                scrNTTEFullPetWalk(_angle+180,3); motion_add(_angle+180,3*timescale); follow_delay=max(follow_delay,10)
                snd_play_hit(sndDogGuardianBounce,0.2); var _snd=snd_play_hit(sndHammer,0.2); if(_snd>=0) audio_sound_set_track_position(_snd,0.035)
            }
            break
        case Race.Rebel:
            scrNTTEFullPetGuardianRebel(_press)
            break
        case Race.Horror:
            if(_p.horrortime>0 && _held && scrNTTEFullPetGuardianFrame(30) && dash_charge==0) {
                var _dir=point_direction(x,y,_aimx,_aimy)+orandom(10)
                var _ball=scrNTTEFullSystemsCreate("SmallLastBall",x,y)
                _ball.creator=id; _ball.team=team; _ball.hitid=hitid; _ball.direction=_dir; _ball.speed=random_range(5,6)*timescale
                var _fx=instance_create(_ball.x+_ball.hspeed,_ball.y+_ball.vspeed,BulletHit)
                _fx.sprite_index=sprThrowHit; _fx.image_speed=0.5*timescale; _fx.image_blend=c_aqua; _fx.depth=_ball.depth-1
                sprite_index=spr_dash_start; image_index=sprite_get_number(spr_dash_start)-1; right=lengthdir_x(1,_dir)>=0 ? 1:-1
                snd_play_hit(sndGruntFire,0.2); snd_play(sndBigBallFire,1+orandom(0.1),0.5)
            }
            break
        case Race.Rogue:
            scrNTTEFullPetGuardianRogue()
            break
        case Race.BigDog:
            if(_press && _p.ammo[Ammo.Explosives]>=3) { scr_projectile_create(x,y,NTTEFullGuardianRocket,random(360)); snd_play_hit(sndEliteGruntRocketFire,0.1) }
            break
        case Race.Skeleton:
            if(scrNTTEFullValue(_p,"ntte_last_hit",-1)==HitId.BloodGamble && _p.sprite_index==_p.spr_hurt && _p.nexthurt>current_frame) {
                if(scrNTTEFullValue(id,"skeleton_has_exploded",true)) {
                    skeleton_has_exploded=false
                    var _blast=scr_projectile_create(x,y,PopoExplosion,_p.gunangle,1); _blast.image_speed=timescale/3
                    repeat(6) instance_create(x+orandom(24),y+orandom(24),BlueFlame)
                    if(dash_charge==0) { sprite_index=spr_appear; image_index=1 }
                    nexthurt=current_frame+6; snd_play_hit(sndIDPDNadeExplo,0.2); snd_play_hit(sndExplosionL,0.2)
                }
            } else skeleton_has_exploded=true
            break
        case Race.Frog:
            if((dash_charge==0 || follow_delay!=0) && place_meeting(x,y,ToxicGas)) {
                with(ToxicGas) if(speed<2*timescale && place_meeting(x,y,_pet)) {
                    motion_add(point_direction(_pet.x,_pet.y,x,y),2*timescale)
                    if(_pet.dash_charge!=0) motion_add(_pet.direction,2*timescale)
                }
                if(sprite_index!=spr_appear) { sprite_index=spr_appear; image_index=2 }
                var _snd=snd_play(sndCrownGuardianDisappear,1+orandom(0.1),1.5); if(_snd>=0) audio_sound_set_track_position(_snd,0.4)
            }
            break
        case NTTEFullRace.Beetle:
            var _menu=scrNTTEFullValue(_p,"beetle_menu_info",undefined)
            if(is_struct(_menu) && _menu.is_open && dash_charge==0) {
                var _shields=[],_vanishing=false
                with(NTTEFullPetGuardianShield) if(creator==_pet) array_push(_shields,id)
                with(NTTEFullCrystalShieldDisappear) if(creator==_pet) _vanishing=true
                if(array_length(_shields)==0 && !_vanishing) {
                    var _shield=instance_create(x,y,NTTEFullPetGuardianShield)
                    _shield.team=team; _shield.creator=id; array_push(_shields,_shield)
                }
                for(var _i=0;_i<array_length(_shields);++_i) {
                    var _shield=_shields[_i]
                    _shield.alarm[0]=max(_shield.alarm[0],3)
                    follow_delay=max(follow_delay,_shield.alarm[0]+10)
                }
            }
            break
        case NTTEFullRace.Parrot:
            scrNTTEFullPetGuardianParrot(_held,_aimx,_aimy)
            break
    }
}
function scrNTTEFullPetGuardianParrot(_held,_aimx,_aimy) {
    var _target=scrNTTEFullValue(id,"ntte_parrot_charm_target",noone),_p=leader
    if(_held) {
        if(instance_exists(grabbed_instance) && grabbed_instance==_target) grabbed_instance=noone
        var _info=scrNTTEFullValue(_target,"ntte_charm",undefined)
        if(!instance_exists(_target) || !is_struct(_info) || !_info.charmed || _info.index!=_p.index) {
            _target=noone
            var _best=infinity,_instances=scrNTTEFullInstances(enemy)
            for(var _i=0;_i<array_length(_instances);++_i) {
                var _enemy=_instances[_i],_charm=scrNTTEFullValue(_enemy,"ntte_charm",undefined)
                if(is_struct(_charm) && _charm.charmed && _charm.index==_p.index) {
                    var _dis=point_distance(_enemy.x,_enemy.y,_aimx,_aimy)
                    if(_dis<_best) { _best=_dis; _target=_enemy }
                }
            }
            ntte_parrot_charm_target=_target
        }
        if(instance_exists(_target)) {
            follow_delay=max(follow_delay,10); grabbed_instance=noone
            var _dir=point_direction(_target.x,_target.y,x,y)
            var _mx=lerp(x,_target.x+lengthdir_x(12,_dir),1-power(2/3,timescale))
            var _my=lerp(y,_target.y+lengthdir_y(12,_dir),1-power(0.8,timescale))
            if(point_distance(x,y,_mx,_my)<16 && !collision_line(x,y,_mx,_my,Wall,false,false)) {
                x=_mx; y=_my; xprevious=x; yprevious=y; right=lengthdir_x(1,_dir+180)>=0 ? 1:-1
            } else if(sprite_index!=spr_appear) {
                var _fx=instance_create(x,y,Wind)
                _fx.sprite_index=spr_disappear; _fx.image_index=0; _fx.image_xscale=image_xscale; _fx.image_yscale=image_yscale*right
                _fx.image_angle=image_angle; _fx.image_blend=image_blend; _fx.image_alpha=image_alpha; _fx.depth=depth
                x=_target.x; y=_target.y; xprevious=x; yprevious=y; sprite_index=spr_appear; image_index=0
                snd_play(sndGuardianAppear,1.2+orandom(0.1),2/3)
            }
            depth=_target.depth
        }
    } else if(instance_exists(_target) && !instance_exists(grabbed_instance)) {
        if(point_distance(x,y,_target.x,_target.y)<32) {
            grabbed_instance=_target
            motion_add(point_direction(x,y,_target.x,_target.y),3*timescale)
            x=lerp(x,_target.x,0.5); y=lerp(y,_target.y,0.5)
        } else ntte_parrot_charm_target=noone
    }
}
function scrNTTEFullPetGuardianShieldDeploy(_aimx,_aimy) {
    var _mx=x,_my=y,_mask=mask_index
    mask_index=mskWepPickup
    if(place_meeting(_aimx,_aimy,Floor) && !place_meeting(_aimx,_aimy,Wall)) { _mx=_aimx; _my=_aimy }
    else {
        var _floors=scrNTTEFullInstances(Floor),_best=infinity
        for(var _i=0;_i<array_length(_floors);++_i) {
            var _f=_floors[_i],_distance=point_distance(_aimx,_aimy,_f.x,_f.y),_cx=(_f.bbox_left+_f.bbox_right+1)/2,_cy=(_f.bbox_top+_f.bbox_bottom+1)/2
            if(_distance<_best && !place_meeting(_cx,_cy,Wall)) {
                _best=_distance; _mx=_cx; _my=_cy-2
                if(place_meeting(_aimx,_cy,Floor) && !place_meeting(_aimx,_cy,Wall)) _mx=_aimx
                else if(place_meeting(_cx,_aimy,Floor) && !place_meeting(_cx,_aimy,Wall)) _my=_aimy
            }
        }
    }
    mask_index=_mask
    if(x!=_mx || y!=_my) {
        var _fx=instance_create(x,y,Wind); _fx.sprite_index=spr_disappear; _fx.image_index=0; _fx.depth=depth
        _fx.image_xscale=image_xscale; _fx.image_yscale=image_yscale*right; _fx.image_angle=image_angle; _fx.image_blend=image_blend; _fx.image_alpha=image_alpha
        x=_mx; y=_my; xprevious=x; yprevious=y; sprite_index=spr_hurt; image_index=0
        var _snd=snd_play_hit(sndEliteShielderTeleport,0.1); if(_snd>=0) audio_sound_set_track_position(_snd,0.1)
    }
    var _shield=instance_create(x,y,NTTEFullPetGuardianShield)
    _shield.alarm[0]=120; _shield.team=team; _shield.creator=id; follow_delay=max(follow_delay,130)
}
function scrNTTEFullPetGuardianShieldCreate() {
    sprite_index=scrNTTERefSprite("PetGuardianShield"); spr_disappear=scrNTTERefSprite("PetGuardianShieldDisappear")
    mask_index=mskWepPickup; image_speed=0.4*timescale
}
function scrNTTEFullPetGuardianShieldEndStep() {
    if(mask_index==mskShield) mask_index=mskWepPickup
    var _self=id
    with(Player) if(team==_self.team && place_meeting(x,y,_self)) motion_add(point_direction(_self.x,_self.y,x,y),timescale*timescale)
    if(sprite_index==sprShielderShieldDisappear) {
        var _fx=instance_create(x,y,NTTEFullCrystalShieldDisappear)
        _fx.sprite_index=spr_disappear; _fx.image_index=image_index; _fx.creator=creator
        instance_destroy()
    }
}
function scrNTTEFullPetGuardianMelting(_held,_press) {
    if(_press && (instance_number(enemy)-instance_number(Van)>0 || instance_exists(Portal))) {
        var _count=0,_left=view_xview,_top=view_yview,_right=_left+game_screen_width,_bottom=_top+game_screen_height
        with(Corpse) if(image_speed==0 && sprite_index!=mskNone && x>_left && y>_top && x<_right && y<_bottom) _count+=1+(size>1)
        if(scr_ultra_get(Race.Melting,UltraSkill.BrainCapacity)) with(enemy) if(hp<6 && x>_left && y>_top && x<_right && y<_bottom) _count+=1+(size>1)
        if(_count>0) {
            melting_explosion_size=min(2,scrNTTEFullValue(id,"melting_explosion_size",0)+_count/8)
            if(dash_charge==0) { sprite_index=spr_dash_end; image_index=1 }
            nexthurt=current_frame+9
            snd_play(sndFreakPopoReviveArea,lerp(3,1.75,melting_explosion_size/2),lerp(2/3,1.75,melting_explosion_size/2))
        }
    }
    var _size=scrNTTEFullValue(id,"melting_explosion_size",0)
    if(_size<=0) return;
    if(_held) {
        if(scrNTTEFullPetGuardianFrame(2/_size)) {
            var _dir=wave*50,_fx=instance_create(x+lengthdir_x(6,_dir),y+lengthdir_y(6,_dir),PlasmaTrail)
            _fx.sprite_index=sprPopoPlasmaTrail; _fx.image_angle=random(360); _fx.depth=depth+1; _fx.vspeed=-random(_size)*timescale
        }
    } else {
        melting_explosion_size=0
        var _expl=scr_projectile_create(x,y,PopoExplosion)
        if(_size<=1) { _expl.sprite_index=sprRogueExplosion; _expl.mask_index=mskExplosion; if(_size<1) _expl.alarm[0]=-1 }
        if(_size%1!=0) { _expl.image_xscale=lerp(0.5,1,_size%1); _expl.image_yscale=_expl.image_xscale }
        repeat(floor(3*_size)) instance_create(x+orandom(12*_size),y+orandom(12*_size),BlueFlame)
        if(dash_charge==0) { sprite_index=spr_appear; image_index=1 }
        nexthurt=current_frame+6; snd_play_hit(sndIDPDNadeExplo,0.2)
    }
}
function scrNTTEFullPetGuardianRebel(_press) {
    var _was=scrNTTEFullValue(id,"rebel_healing_is_active",false),_pet=id,_max=96,_allies=[]
    with(Ally) if(team==_pet.team) array_push(_allies,id)
    if(_press) {
        var _can=leader.hp>((instance_exists(Ally) || scr_ultra_get(Race.Rebel,UltraSkill.Riot)) ? 2:1)
        if(_was) { if(!_can) rebel_healing_is_active=false }
        else if(point_distance(x,y,leader.x,leader.y)<=_max && (_can || array_length(_allies)>0)) {
            rebel_healing_is_active=true; rebel_healing_delay=0; rebel_healing_radius=0
        }
    }
    if(scrNTTEFullValue(id,"rebel_healing_is_active",false)) {
        speed=0; follow_delay=max(follow_delay,3); rebel_healing_radius=min(_max,rebel_healing_radius+_max/10*timescale)
        var _heal=false,_count=0
        if(rebel_healing_delay>0) rebel_healing_delay=max(0,rebel_healing_delay-timescale)
        else { rebel_healing_delay=20; _heal=true }
        for(var _i=0;_i<array_length(_allies);++_i) with(_allies[_i]) if(point_distance(x,y,_pet.x,_pet.y)<=_pet.rebel_healing_radius) {
            if(random(1)<1-power(0.75,timescale)) {
                var _fx=instance_create(x,y,PlasmaTrail); _fx.sprite_index=sprPopoPlasmaTrail; _fx.depth=depth-1
                with(_fx) motion_add(random(360),timescale)
            }
            if(_heal && hp<max_hp) {
                hp=min(hp+1,max_hp); _count+=1
                var _fx=instance_create(x,y,HealFX)
                _fx.sprite_index=scrNTTERefSprite(hp<max_hp ? "BonusHealFX":"BonusHealBigFX"); _fx.vspeed=-random(2)*timescale; _fx.depth=depth-1
            }
        }
        if(_count>0) {
            scr_projectile_hit(id,min(_count,2))
            var _fx=instance_create(x,y,AllyDamage); _fx.sprite_index=scrNTTERefSprite("BonusHealFX")
        }
        // Source uses the healing square for the bullet conversion, while
        // ally healing itself uses the circular radius.
        with(AllyBullet) if(team==_pet.team && abs(x-_pet.x)<=_pet.rebel_healing_radius && abs(y-_pet.y)<=_pet.rebel_healing_radius) {
            instance_change(Bullet1,false); sprite_index=sprIDPDBullet; spr_dead=sprIDPDBulletHit; speed*=2
            var _fx=instance_create(x,y,ThrowHit); _fx.image_blend=c_aqua; snd_play_hit(sndGruntFire,0.1)
        }
        var _angle=360*(wave/20/3)
        for(var _d=_angle;_d<_angle+360;_d+=120) {
            var _tx=x+lengthdir_x(rebel_healing_radius,_d),_ty=y+lengthdir_y(rebel_healing_radius,_d),_fx=instance_create(x,y,PlasmaTrail)
            _fx.sprite_index=sprPopoPlasmaTrail
            if(position_meeting(_tx,_ty,Floor) || !collision_line(x,y,_tx,_ty,Wall,false,false)) {
                _fx.x=_tx; _fx.y=_ty; _fx.image_angle=_d
                if(_heal) { var _hf=instance_create(_tx,_ty,HealFX); _hf.sprite_index=scrNTTERefSprite("BonusHealFX"); _hf.depth=-8 }
                if(rebel_healing_radius>=_max) { _fx.image_xscale=2/3; _fx.image_yscale=3 }
            } else with(_fx) { move_contact_solid(_d,other.rebel_healing_radius); x+=lengthdir_x(5,_d); y+=lengthdir_y(8,_d) }
        }
        if(point_distance(x,y,leader.x,leader.y)>_max || (rebel_healing_radius>=_max && array_length(_allies)==0)) rebel_healing_is_active=false
    }
    if(scrNTTEFullValue(id,"rebel_healing_is_active",false)!=_was) {
        if(rebel_healing_is_active) {
            if(sprite_index==spr_idle) { sprite_index=spr_hurt; image_index=0 }
            nexthurt=current_frame+6; snd_play(sndFreakPopoReviveArea,1.5,2)
        } else {
            sprite_index=spr_appear; image_index=4
            for(var _d=0;_d<360;_d+=45) {
                var _fx=instance_create(x,y,AllyDamage); _fx.sprite_index=sprPopoPlasmaTrail; _fx.direction=_d+orandom(45)
                _fx.x+=3*_fx.hspeed; _fx.y+=3*_fx.vspeed; _fx.speed*=random_range(0.5,1.5)
            }
            snd_play(sndFreakPopoReviveArea,3+orandom(0.1),2)
        }
    }
}
function scrNTTEFullPetGuardianRogue() {
    var _pet=id,_strikes=[],_p=leader
    with(PortalStrike) if(creator==_p) array_push(_strikes,id)
    if(array_length(_strikes)>0) {
        var _info=[]
        for(var _i=0;_i<array_length(_strikes);++_i) {
            var _strike=_strikes[_i],_candidates=[]
            with(enemy) if(team!=_pet.team && place_meeting(x,y,_strike)) array_push(_candidates,id)
            for(var _j=array_length(_candidates)-1;_j>0;--_j) { var _k=irandom(_j),_swap=_candidates[_j]; _candidates[_j]=_candidates[_k]; _candidates[_k]=_swap }
            var _count=0,_height=sprite_get_bbox_bottom(_strike.sprite_index)+1-sprite_get_bbox_top(_strike.sprite_index)
            for(var _j=0;_j<array_length(_candidates);++_j) {
                var _t=_candidates[_j],_tx=clamp(_strike.x,_t.bbox_left,_t.bbox_right+1),_ty=clamp(_strike.y,_t.bbox_top,_t.bbox_bottom+1)
                var _dist=point_distance(_strike.x,_strike.y,_tx,_ty),_dir=point_direction(_strike.x,_strike.y,_tx,_ty)
                var _center=abs(lengthdir_x(lengthdir_x(_dist,_dir),_strike.image_angle-90)+lengthdir_y(lengthdir_y(_dist,_dir),_strike.image_angle-90))
                if(_center<=_height/2) {
                    array_push(_info,{id:_t,x:_t.x,y:_t.y})
                    if(scrNTTEFullPetGuardianFrame(10)) { var _fx=instance_create(_t.x,_t.y,NTTEFullBloodLust); _fx.sprite_index=sprImpactWrists; _fx.image_index=2; _fx.image_blend=current_frame%20<10 ? c_white:c_aqua; _fx.creator=_t }
                    if(++_count>=8) break
                }
            }
        }
        rogue_target_info_list=_info
    } else if(array_length(scrNTTEFullValue(id,"rogue_target_info_list",[]))>0) {
        rogue_missile_target_info_list=array_concat(scrNTTEFullValue(id,"rogue_missile_target_info_list",[]),rogue_target_info_list); rogue_target_info_list=[]
    }
    var _queue=scrNTTEFullValue(id,"rogue_missile_target_info_list",[])
    if(array_length(_queue)>0 && scrNTTEFullPetGuardianFrame(3) && dash_charge==0) {
        var _info=_queue[0],_missile=scrNTTEFullSystemsCreate("RogueMissile",x,y)
        _missile.creator=id; _missile.team=team; _missile.hitid=hitid; _missile.direction=random(360); _missile.speed=4*timescale
        _missile.target=_info.id; _missile.target_x=_info.x; _missile.target_y=_info.y
        var _fx=instance_create(_info.x,_info.y,ImpactWrists)
        _fx.image_angle=0; _fx.image_blend=current_frame%6<3 ? c_white:c_aqua; _fx.depth=-4
        array_delete(rogue_missile_target_info_list,0,1)
        sprite_index=spr_dash_end; image_index=0; snd_play_hit(sndEliteGruntRocketFire,0.1)
    }
}
function scrNTTEFullPetGuardianActiveTests() {
    var _p=instance_find(Player,0),_before=scrNTTEFullInstances(all)
    var _old={race:_p.race,wep:_p.wep,bwep:_p.bwep,ammo:scrNTTEFullArrayCopy(_p.ammo),can:_p.can_spec,canfire:_p.can_shoot,hp:_p.hp,
        hold:KeyCont.hold_spec[_p.index],press:KeyCont.press_spec[_p.index],roll:_p.roll,horror:_p.horrortime}
    var _pet=instance_create(_p.x,_p.y,NTTEFullPet)
    with(_pet) { pet="Guardian"; scrNTTEFullPetGuardianCreate(); hp=max_hp; leader=_p; team=_p.team; sprite_index=spr_idle }
    _p.can_spec=true; KeyCont.hold_spec[_p.index]=true; KeyCont.press_spec[_p.index]=true
    // Melting counts on-screen explodables before native scrPowers consumes
    // those corpses; both the charge and release use real native effects.
    var _corpse=instance_create(view_xview+game_screen_width/2,view_yview+game_screen_height/2,Corpse)
    _corpse.sprite_index=sprBanditDead; _corpse.image_speed=0; _corpse.size=2
    var _enemy=instance_create(_pet.x+48,_pet.y,Bandit)
    with(_pet) scrNTTEFullPetGuardianMelting(true,true)
    assert(scrNTTEFullValue(_pet,"melting_explosion_size",0)>=0.25,"Guardian Melting lost the double count for a large corpse")
    var _expl_before=instance_number(PopoExplosion)
    with(_pet) scrNTTEFullPetGuardianMelting(false,false)
    assert(_pet.melting_explosion_size==0 && instance_number(PopoExplosion)==_expl_before+1,"Guardian Melting did not release its native blast")
    _p.race=Race.Venuz; _p.wep=wep_revolver; _p.can_shoot=true; _p.ammo[Ammo.Bullets]=200
    var _ammo=_p.ammo[Ammo.Bullets],_shots_before=scrNTTEFullInstances(Bullet1)
    with(_pet) scrNTTEFullPetGuardianActive()
    var _shots=scrNTTEFullInstances(Bullet1),_made=0
    for(var _i=0;_i<array_length(_shots);++_i) if(array_get_index(_shots_before,_shots[_i])<0) _made+=1
    assert(_made>0 && _p.ammo[Ammo.Bullets]==_ammo,"Guardian YV extra basic shot failed or consumed leader ammo")
    _p.race=Race.Crystal
    var _crystal=instance_create(_p.x,_p.y,CrystalShield); _crystal.creator=_p
    with(_pet) scrNTTEFullPetGuardianActive()
    var _shield=noone
    with(NTTEFullPetGuardianShield) if(creator==_pet) _shield=id
    assert(instance_exists(_shield) && _shield.team==_p.team && _shield.alarm[0]==120 && _shield.mask_index==mskWepPickup,
        "Guardian Crystal shield failed source lifetime/team/mask setup")
    with(_shield) { event_perform(ev_alarm,0); scrNTTEFullPetGuardianShieldEndStep() }
    assert(!instance_exists(_shield),"Guardian Crystal shield did not convert its native disappearance")
    var _vanish=false
    with(NTTEFullCrystalShieldDisappear) if(creator==_pet && sprite_index==scrNTTERefSprite("PetGuardianShieldDisappear")) _vanish=true
    assert(_vanish,"Guardian Crystal lost its source disappearance artwork")
    _pet.x=_p.x; _pet.y=_p.y; _pet.follow_delay=0; _pet.dash_charge=0
    _p.race=Race.Rebel; _p.hp=max(_p.hp,4)
    var _ally=instance_create(_pet.x,_pet.y,Ally); _ally.creator=_p; _ally.team=_p.team; _ally.hp=1; _ally.max_hp=12
    var _pet_hp=_pet.hp
    with(_pet) scrNTTEFullPetGuardianRebel(true)
    assert(_ally.hp==2 && _pet.hp==_pet_hp-1 && _pet.rebel_healing_is_active,"Guardian Rebel did not trade guardian health for ally healing")
    var _bullet=instance_create(_pet.x,_pet.y,AllyBullet); _bullet.team=_pet.team; _bullet.speed=3*timescale
    with(_pet) scrNTTEFullPetGuardianRebel(false)
    assert(instance_is(_bullet,Bullet1) && _bullet.sprite_index==sprIDPDBullet && abs(_bullet.speed-6*timescale)<0.001,
        "Guardian Rebel source bullet speed/sprite buff failed")
    _p.race=_old.race; _p.wep=_old.wep; _p.bwep=_old.bwep; _p.ammo=_old.ammo; _p.can_spec=_old.can; _p.can_shoot=_old.canfire; _p.hp=_old.hp
    _p.roll=_old.roll; _p.horrortime=_old.horror; KeyCont.hold_spec[_p.index]=_old.hold; KeyCont.press_spec[_p.index]=_old.press
    var _after=scrNTTEFullInstances(all)
    for(var _i=0;_i<array_length(_after);++_i) if(array_get_index(_before,_after[_i])<0) instance_destroy(_after[_i],false)
    scrNTTESmokeLog("SYSTEMS PET GUARDIAN ACTIVE: large-corpse charge/release, YV extra native firing, Crystal shield/disappearance, Rebel real healing cost and bullet buff OK")
}
function scrNTTEFullPetGuardianOtherActiveTests() {
    var _p=instance_find(Player,0),_before=scrNTTEFullInstances(all),_frame=current_frame
    var _fields=["race","x","y","xprevious","yprevious","wep","bwep","curse","roll","direction","can_spec","bcan_shoot","horrortime","sprite_index","nexthurt"]
    var _saved={},_ammo=scrNTTEFullArrayCopy(_p.ammo),_hold=KeyCont.hold_spec[_p.index],_press=KeyCont.press_spec[_p.index]
    var _last_ammo=scrNTTEFullValue(_p,"ntte_guardian_pet_last_ammo",scrNTTEFullArrayCopy(_ammo))
    for(var _i=0;_i<array_length(_fields);++_i) variable_struct_set(_saved,_fields[_i],variable_instance_get(_p,_fields[_i]))
    var _pet=instance_create(_p.x,_p.y,NTTEFullPet)
    with(_pet) { pet="Guardian"; scrNTTEFullPetGuardianCreate(); hp=max_hp; leader=_p; team=_p.team; sprite_index=spr_idle }
    _p.can_spec=true; KeyCont.hold_spec[_p.index]=true; KeyCont.press_spec[_p.index]=true
    _p.race=Race.Fish; _p.roll=1; _p.direction=0
    var _px=_p.x
    with(_pet) scrNTTEFullPetGuardianActive()
    assert(abs(_p.x-_px-1.5*timescale)<0.001 && _p.xprevious==_p.x,"Guardian Fish roll boost did not move and synchronize its real leader")
    _p.race=Race.Plant; _p.roll=0; _pet.dash_charge=0; _pet.follow_delay=0
    with(_pet) scrNTTEFullPetGuardianActive()
    assert(_pet.dash_is_grab && _pet.dash_charge==_pet.dash_max_charge,"Guardian Plant did not initiate its source enemy grab")
    var _target=instance_create(_pet.x+10,_pet.y,Bandit)
    _target.team=team_enemy; _target.speed=0
    _pet.grabbed_instance=_target; _pet.dash_charge=0; _pet.speed=3*timescale
    KeyCont.press_spec[_p.index]=false
    with(_pet) scrNTTEFullPetGuardianActive()
    assert(_pet.speed==0 && _pet.grabbed_instance==_target,"Guardian Plant failed to keep its grabbed target while held")
    KeyCont.hold_spec[_p.index]=false; KeyCont.press_spec[_p.index]=false
    with(_pet) scrNTTEFullPetGuardianActive()
    assert(_pet.grabbed_instance==noone,"Guardian Plant did not release its grabbed instance")
    _p.race=Race.Steroids; _p.bcan_shoot=false; current_frame=0
    _p.ntte_guardian_pet_last_ammo=scrNTTEFullArrayCopy(_p.ammo); _p.ammo[Ammo.Bullets]-=3
    var _shots=scrNTTEFullInstances(Bullet1)
    with(_pet) scrNTTEFullPetGuardianActive()
    var _after=scrNTTEFullInstances(Bullet1),_made=0
    for(var _i=0;_i<array_length(_after);++_i) if(array_get_index(_shots,_after[_i])<0) {
        var _s=_after[_i]
        assert(_s.creator==_pet && _s.team==_pet.team && _s.sprite_index==sprIDPDBullet,"Guardian Steroids turret lost real projectile ownership")
        _made+=1
    }
    assert(_made==2 && _pet.follow_delay>=10,"Guardian Steroids did not cap the real turret burst at two per ammo type")
    _p.ntte_guardian_pet_last_ammo=_last_ammo
    _pet.dash_charge=0; _pet.follow_delay=0; _p.race=Race.Chicken; _p.wep=wep_revolver; _p.curse=0
    KeyCont.press_spec[_p.index]=true
    var _slashes=scrNTTEFullInstances(Slash)
    with(_pet) scrNTTEFullPetGuardianActive()
    var _slash_after=scrNTTEFullInstances(Slash),_slash=noone
    for(var _i=0;_i<array_length(_slash_after);++_i) if(array_get_index(_slashes,_slash_after[_i])<0) _slash=_slash_after[_i]
    assert(instance_exists(_slash) && _slash.damage==8 && _slash.walled && _slash.creator==_pet && _pet.follow_delay>=10,
        "Guardian Chicken did not create its real 8-damage walled melee attack")
    _p.race=Race.Horror; _p.horrortime=1; _pet.dash_charge=0; KeyCont.hold_spec[_p.index]=true
    var _balls=scrNTTEFullInstances(NTTEFullSmallLastBall)
    with(_pet) scrNTTEFullPetGuardianActive()
    var _ball_after=scrNTTEFullInstances(NTTEFullSmallLastBall),_ball=noone
    for(var _i=0;_i<array_length(_ball_after);++_i) if(array_get_index(_balls,_ball_after[_i])<0) _ball=_ball_after[_i]
    assert(instance_exists(_ball) && _ball.creator==_pet && _ball.team==_pet.team && _ball.damage==12,
        "Guardian Horror did not create the actual source SmallLastBall projectile")
    _p.race=Race.BigDog; _p.ammo[Ammo.Explosives]=3
    var _rockets=scrNTTEFullInstances(NTTEFullGuardianRocket)
    with(_pet) scrNTTEFullPetGuardianActive()
    var _rocket_after=scrNTTEFullInstances(NTTEFullGuardianRocket),_rocket=noone
    for(var _i=0;_i<array_length(_rocket_after);++_i) if(array_get_index(_rockets,_rocket_after[_i])<0) _rocket=_rocket_after[_i]
    assert(instance_exists(_rocket) && _rocket.creator==_pet && _rocket.team==_pet.team && _p.ammo[Ammo.Explosives]==3,
        "Guardian BigDog lost its supplemental owned rocket or charged the player twice")
    assert(_rocket.sprite_index==sprPopoRocket && _rocket.mask_index==-1
        && _rocket.visible && !_rocket.persistent
        && _rocket.bbox_right>_rocket.bbox_left && _rocket.bbox_bottom>_rocket.bbox_top,
        "Guardian source PopoRocket lost native visible art, sprite collision mask or nonpersistent lifecycle")
    // Query actual sprite-mask overlap, then dispatch the actual inherited
    // IDPDRocket Wall collision. Do not manually destroy the child rocket.
    var _rocket_wall=instance_create(_rocket.x-8,_rocket.y-8,Wall)
    with(_rocket) assert(place_meeting(x,y,_rocket_wall),
        "Guardian rocket sprite has no actual collision overlap with a real native Wall")
    var _explosions=scrNTTEFullInstances(PopoExplosion)
    with(_rocket_wall) with(_rocket) event_perform(ev_collision,Wall)
    assert(!instance_exists(_rocket),"Guardian rocket failed actual inherited IDPDRocket Wall collision destruction")
    var _explosion_after=scrNTTEFullInstances(PopoExplosion),_owned=false
    for(var _i=0;_i<array_length(_explosion_after);++_i) if(array_get_index(_explosions,_explosion_after[_i])<0 && _explosion_after[_i].creator==_pet) _owned=true
    assert(_owned,"Guardian BigDog rocket explosion lost its actual guardian creator")
    _p.race=Race.Frog; _pet.dash_charge=0
    var _gas=instance_create(_pet.x,_pet.y,ToxicGas); _gas.speed=0
    with(_pet) scrNTTEFullPetGuardianActive()
    assert(abs(_gas.speed-2*timescale)<0.001,"Guardian Frog failed to push real overlapping toxic gas")
    _p.ammo=_ammo; current_frame=_frame
    for(var _i=0;_i<array_length(_fields);++_i) variable_instance_set(_p,_fields[_i],variable_struct_get(_saved,_fields[_i]))
    KeyCont.hold_spec[_p.index]=_hold; KeyCont.press_spec[_p.index]=_press
    var _all=scrNTTEFullInstances(all)
    for(var _i=0;_i<array_length(_all);++_i) if(array_get_index(_before,_all[_i])<0) instance_destroy(_all[_i],false)
    scrNTTESmokeLog("SYSTEMS PET GUARDIAN OTHER ACTIVE: native Fish roll displacement, Plant grab/release, capped Steroids burst, Chicken slash, Horror ball, BigDog native rocket art/mask/nonpersistent lifecycle/real Wall overlap+inherited collision/explosion ownership and Frog gas force OK")
}
function scrNTTEFullPetGuardianSpecificTests() {
    var _p=instance_find(Player,0),_before=scrNTTEFullInstances(all),_frame=current_frame
    var _old={race:_p.race,hp:_p.hp,bwep:_p.bwep,can:_p.can_spec,sp:_p.sprite_index,hurt:_p.nexthurt,total:_p.totdamagetaken,
        hit:scrNTTEFullValue(_p,"ntte_last_hit",HitId.None),menu:scrNTTEFullValue(_p,"beetle_menu_info",undefined),
        hold:KeyCont.hold_spec[_p.index],press:KeyCont.press_spec[_p.index]}
    var _pet=instance_create(_p.x,_p.y,NTTEFullPet)
    with(_pet) { pet="Guardian"; scrNTTEFullPetGuardianCreate(); hp=max_hp; leader=_p; team=_p.team; sprite_index=spr_idle }
    _p.can_spec=true; KeyCont.press_spec[_p.index]=true; KeyCont.hold_spec[_p.index]=true
    _p.race=Race.Robot; _p.bwep=wep_revolver
    var _bags=scrNTTEFullInstances(NTTEFullBackpackPickup)
    with(_pet) scrNTTEFullPetGuardianActive()
    var _after=scrNTTEFullInstances(NTTEFullBackpackPickup),_bag=noone
    for(var _i=0;_i<array_length(_after);++_i) if(array_get_index(_bags,_after[_i])<0) _bag=_after[_i]
    assert(instance_exists(_bag) && instance_exists(_bag.target) && (instance_is(_bag.target,HealthChest) || instance_is(_bag.target,IDPDChest)),
        "Guardian Robot did not throw a real health/IDPD chest inside its airborne wrapper")
    _p.race=Race.Skeleton; _p.hp=max(8,_p.hp); _p.nexthurt=0
    assert(scr_hit(_p,1,HitId.BloodGamble),"Guardian Skeleton fixture failed its actual successful blood-gamble hit")
    var _count=instance_number(PopoExplosion)
    with(_pet) scrNTTEFullPetGuardianActive()
    assert(instance_number(PopoExplosion)==_count+1 && !_pet.skeleton_has_exploded,
        "Guardian Skeleton did not read native successful BloodGamble hit identity")
    with(_pet) scrNTTEFullPetGuardianActive()
    assert(instance_number(PopoExplosion)==_count+1,"Guardian Skeleton safety blast repeated during the same hurt window")
    _p.sprite_index=_p.spr_idle
    with(_pet) scrNTTEFullPetGuardianActive()
    assert(_pet.skeleton_has_exploded,"Guardian Skeleton did not rearm after the hurt window")
    _p.race=Race.Rogue; _pet.dash_charge=0; current_frame=0
    var _target=instance_create(_pet.x+16,_pet.y,Bandit); _target.team=team_enemy
    var _strike=instance_create(_target.x,_target.y,PortalStrike); _strike.creator=_p
    with(_pet) scrNTTEFullPetGuardianRogue()
    assert(array_length(_pet.rogue_target_info_list)>0,"Guardian Rogue failed to mark real enemies inside the native PortalStrike")
    var _marked=_pet.rogue_target_info_list[0]
    instance_destroy(_strike,false)
    var _missiles=scrNTTEFullInstances(NTTEFullRogueMissile)
    with(_pet) scrNTTEFullPetGuardianRogue()
    var _missile_after=scrNTTEFullInstances(NTTEFullRogueMissile),_missile=noone
    for(var _i=0;_i<array_length(_missile_after);++_i) if(array_get_index(_missiles,_missile_after[_i])<0) _missile=_missile_after[_i]
    assert(instance_exists(_missile) && _missile.creator==_pet && _missile.team==_pet.team && _missile.target==_marked.id
        && _missile.target_x==_marked.x && _missile.target_y==_marked.y,"Guardian Rogue did not launch its real source missile with captured mark position and ownership")
    _p.race=NTTEFullRace.Beetle; _p.beetle_menu_info=scrNTTEFullBeetleMenuNew(); _p.beetle_menu_info.is_open=true; _pet.dash_charge=0
    with(_pet) scrNTTEFullPetGuardianActive()
    var _shield=noone
    with(NTTEFullPetGuardianShield) if(creator==_pet) _shield=id
    assert(instance_exists(_shield) && _shield.team==_pet.team,"Guardian Beetle did not deploy the real owned merge-menu shield")
    _shield.alarm[0]=1
    with(_pet) scrNTTEFullPetGuardianActive()
    assert(_shield.alarm[0]==3 && _pet.follow_delay>=13,"Guardian Beetle failed to keep its merge-menu shield alive")
    _p.race=NTTEFullRace.Parrot
    _target.ntte_charm={charmed:true,index:_p.index}; _pet.x=_target.x; _pet.y=_target.y
    with(_pet) scrNTTEFullPetGuardianActive()
    assert(_pet.ntte_parrot_charm_target==_target && _pet.grabbed_instance==noone && _pet.follow_delay>=10,
        "Guardian Parrot did not follow its own charmed enemy while the ability is held")
    KeyCont.hold_spec[_p.index]=false
    with(_pet) scrNTTEFullPetGuardianActive()
    assert(_pet.grabbed_instance==_target,"Guardian Parrot did not grab its nearby charmed target on release")
    _p.race=_old.race; _p.hp=_old.hp; _p.bwep=_old.bwep; _p.can_spec=_old.can; _p.sprite_index=_old.sp; _p.nexthurt=_old.hurt; _p.totdamagetaken=_old.total
    _p.ntte_last_hit=_old.hit; _p.beetle_menu_info=_old.menu; current_frame=_frame
    KeyCont.hold_spec[_p.index]=_old.hold; KeyCont.press_spec[_p.index]=_old.press
    var _all=scrNTTEFullInstances(all)
    for(var _i=0;_i<array_length(_all);++_i) if(array_get_index(_before,_all[_i])<0) instance_destroy(_all[_i],false)
    scrNTTESmokeLog("SYSTEMS PET GUARDIAN SPECIFIC: Robot real airborne chest, native BloodGamble-triggered nonrepeating Skeleton blast, real Rogue strike/owned captured-position missile, Beetle shield refresh and Parrot held/released companion grab OK")
}
