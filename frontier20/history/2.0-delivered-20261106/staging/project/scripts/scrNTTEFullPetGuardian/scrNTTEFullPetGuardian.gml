// Source petlib.Guardian. Active race-specific abilities are supplied by the
// original telabs begin-step integration, separately from this pet's physics.
function scrNTTEFullPetGuardianCreate() {
    spr_idle=scrNTTERefSprite("PetGuardianIdle"); spr_walk=spr_idle
    spr_hurt=scrNTTERefSprite("PetGuardianHurt"); spr_dead=scrNTTERefSprite("PetGuardianDisappear")
    spr_icon=scrNTTERefSprite("PetGuardianIcon"); spr_appear=scrNTTERefSprite("PetGuardianAppear")
    spr_disappear=spr_dead; spr_dash_start=scrNTTERefSprite("PetGuardianDashStart")
    spr_dash=scrNTTERefSprite("PetGuardianDash"); spr_dash_charge=scrNTTERefSprite("PetGuardianDashCharge")
    spr_dash_end=scrNTTERefSprite("PetGuardianDashEnd"); spr_shadow_y=3
    snd_hurt=sndCrownGuardianHurt; snd_dead=sndCrownGuardianDead; hitid=[spr_idle,"POPO GUARDIAN"]
    max_hp=80; path_wall=[Wall]; can_escape=false; escape_prompt=noone; corpse=false; push=0
    follow_delay=0; dash_charge=0; dash_charge_side=choose(-1,1); dash_max_charge=10; dash_add_charge=0.5
    dash_direction=0; dash_is_grab=false; grabbed_instance=noone
    stat.punches=scrNTTEFullValue(stat,"punches",0)
    hooks={anim:method(id,scrNTTEFullPetGuardianAnim),step:method(id,scrNTTEFullPetGuardianStep),alarm:method(id,scrNTTEFullPetGuardianAlarm),draw:method(id,scrNTTEFullPetGuardianDraw),hurt:method(id,scrNTTEFullPetGuardianHurt),death:method(id,scrNTTEFullPetGuardianDeath)}
}
function scrNTTEFullPetGuardianAnim() {
    var _end=image_index+image_speed>=image_number
    if(array_get_index([spr_hurt,spr_appear,spr_disappear,spr_dash_start,spr_dash_end],sprite_index)>=0 && !_end) return;
    var _normal=dash_charge==0 && !instance_exists(grabbed_instance)
    if(array_get_index([spr_dash_start,spr_dash,spr_dash_charge],sprite_index)<0) {
        if(_normal) { if(sprite_index==spr_disappear) { sprite_index=spr_appear; image_index=0 } else sprite_index=spr_idle }
        else { sprite_index=spr_dash_start; image_index=0 }
    } else if(_normal) { sprite_index=spr_dash_end; image_index=0 }
    else if(dash_is_grab && !instance_exists(grabbed_instance)) { sprite_index=spr_dash_start; image_index=sprite_get_number(spr_dash_start)-1 }
    else sprite_index=(follow_delay==0 || instance_exists(grabbed_instance)) ? spr_dash_charge:spr_dash
}
function scrNTTEFullPetGuardianStep() {
    var _can_follow=true,_pet=id
    if(follow_delay>0) { follow_delay=max(0,follow_delay-timescale); _can_follow=false }
    if(_can_follow && instance_exists(leader)) {
        var _ox=-8*leader.right,_oy=8*leader.back
        if(dash_charge!=0) {
            for(var _try=0;_try<3;++_try) {
                var _len=point_distance(0,0,_ox,_oy),_angle=dash_direction+90*dash_charge_side
                _ox=lengthdir_x(_len,_angle); _oy=lengthdir_y(_len,_angle)
                if(_try<2 && place_meeting(leader.x+_ox+lengthdir_x(16,dash_direction),leader.y+_oy+lengthdir_y(16,dash_direction),Wall)) dash_charge_side*=-1
                else break
            }
        }
        var _mx=lerp(x,leader.x+_ox,1-power(2/3,timescale)),_my=lerp(y,leader.y+_oy,1-power(0.8,timescale))
        if(point_distance(x,y,_mx,_my)<16 && !collision_line(x,y,_mx,_my,Wall,false,false)) {
            if(!place_meeting(_mx,_my,Wall)) { x=_mx; y=_my; xprevious=x; yprevious=y }
            else if(!place_meeting(_mx,y,Wall)) { x=_mx; xprevious=x }
            else if(!place_meeting(x,_my,Wall)) { y=_my; yprevious=y }
        } else if(sprite_index!=spr_appear) {
            var _fx=instance_create(x,y,Wind)
            _fx.sprite_index=spr_disappear; _fx.image_index=0; _fx.image_xscale=image_xscale; _fx.image_yscale=image_yscale*right
            _fx.image_angle=image_angle; _fx.image_blend=image_blend; _fx.image_alpha=image_alpha; _fx.depth=depth
            x=leader.x; y=leader.y; xprevious=x; yprevious=y; sprite_index=spr_appear; image_index=0
            snd_play(sndGuardianAppear,1.2+orandom(0.1),2/3)
        }
        depth=leader.depth+(_oy>0 ? -1:0)
    }
    var _held=false,_mount_dash=false
    if(instance_exists(leader)) {
        _held=KeyCont.hold_fire[leader.index] || (leader.race==Race.Cuz && KeyCont.hold_spec[leader.index])
        with(NTTEFullPet) if(pet=="Salamander" && leader==_pet.leader) { if(dash_charging) _held=true; if(mount && dash) _mount_dash=true }
    }
    if(_can_follow && ((dash_charge>0 && dash_charge<dash_max_charge) || _held)) {
        if(dash_charge<dash_max_charge) {
            if(dash_charge==0) snd_play(sndDogGuardianBounce,0.7+orandom(0.2))
            dash_charge=min(dash_max_charge,dash_charge+dash_add_charge*timescale)
            if(dash_charge>=dash_max_charge) {
                var _fx=instance_create(x,y,BulletHit); _fx.sprite_index=sprImpactWrists; _fx.image_blend=c_aqua; _fx.depth=depth-1
                snd_play(sndDogGuardianLand,1.5+orandom(0.1),0.4)
            }
        }
        if(instance_exists(leader)) { dash_direction=leader.gunangle; right=lengthdir_x(1,dash_direction)>=0 ? 1:-1 }
        var _off=2*clamp((dash_charge-9)/(dash_max_charge-9),0,1)*timescale,_wind=-10*wave*dash_charge_side
        x+=lengthdir_x(_off,dash_direction+180)+lengthdir_x(_off/2,_wind)
        y+=lengthdir_y(_off,dash_direction+180)+lengthdir_y(_off/2,_wind)
    } else if(dash_charge!=0) {
        direction=dash_direction; speed=max(speed,lerp(maxspeed,24,clamp(dash_charge/dash_max_charge,0,1))*timescale)
        right=lengthdir_x(1,direction)>=0 ? 1:-1
        if(dash_charge==dash_max_charge) {
            scr_screenshake(8)
            if(instance_exists(leader)) with(leader) motion_add(other.direction,other.speed/6)
            if(audio_is_playing(sndDogGuardianLand)) snd_play(sndJockFire,1.2+orandom(0.2))
            var _snd=snd_play(sndIDPDNadeExplo,1.5+orandom(0.3)); if(_snd>=0) audio_sound_set_track_position(_snd,0.3)
            follow_delay=max(follow_delay,dash_charge+30)
        }
        if(instance_exists(leader)) {
            var _aim=point_direction(x,y,leader.x+lengthdir_x(192,leader.gunangle),leader.y+lengthdir_y(192,leader.gunangle))
            dash_direction+=angle_difference(_aim,dash_direction)*(1-power(0.75,timescale))
        }
        if(current_frame_active) {
            if(_mount_dash) { var _fire=scr_projectile_create(x,y,Flame,direction+orandom(20),random_range(3,4)); /* NTTE NATIVE EFFECT LIFETIME guardian-water-flame */ if(instance_exists(_fire)) {_fire.sprite_index=sprFireLilHunter } }
            else instance_create(x+orandom(4),y+4+random(4),Dust)
        }
        if(!dash_is_grab || !instance_exists(grabbed_instance)) scrNTTEFullPetGuardianDashHit()
        if(dash_charge>0) dash_charge=max(0,dash_charge-timescale)
        if(dash_charge==0) dash_is_grab=false
    }
    if(instance_exists(grabbed_instance)) {
        if(follow_delay>0) follow_delay=max(follow_delay,10)
        with(grabbed_instance) {
            if(scrNTTEFullValue(id,"size",0)<3) {
                if(!place_meeting(other.x,other.y,Wall)) { x=other.x; y=other.y; xprevious=x; yprevious=y }
                else if(!place_meeting(other.x,y,Wall)) { x=other.x; xprevious=x }
                else if(!place_meeting(x,other.y,Wall)) { y=other.y; yprevious=y }
                if(!place_meeting(x+other.hspeed,y+other.vspeed,Wall)) { hspeed=other.hspeed; vspeed=other.vspeed }
                else if(!place_meeting(x+other.hspeed,y,Wall)) { hspeed=other.hspeed; vspeed=0 }
                else if(!place_meeting(x,y+other.vspeed,Wall)) { hspeed=0; vspeed=other.vspeed }
            } else speed*=power(0.9,timescale)
        }
        depth=min(depth,grabbed_instance.depth-1)
        x=lerp(x,grabbed_instance.x,1-power(2/3,timescale)); y=lerp(y,grabbed_instance.y,1-power(2/3,timescale)); xprevious=x; yprevious=y
    }
    if(can_escape) scrNTTEFullPetGuardianEscape()
}
function scrNTTEFullPetGuardianDashHit() {
    var _pet=id,_list=ds_list_create()
    image_xscale*=2; image_yscale*=2
    instance_place_list(x,y,hitme,_list,false)
    for(var _i=0;_i<ds_list_size(_list);++_i) {
        var _target=_list[|_i]
        if(!instance_exists(_target) || _target==id || _target.team==team) continue
        if(dash_is_grab) {
            if((!instance_is(_target,prop) && _target.team!=team_none) || instance_is(_target,RadChest)
                || instance_is(_target,Car) || instance_is(_target,CarVenus) || instance_is(_target,CarVenusFixed)) grabbed_instance=_target
        } else if(scr_can_hit(_target,false)) {
            stat.punches+=1; scr_projectile_hit(_target,15,instance_is(_target,prop) ? 0:12,direction)
            snd_play_hit(sndGuardianHurt,0.2); scr_screenshake(10)
            if(instance_exists(_target) && _target.hp> -5) { dash_charge=0; direction=point_direction(_target.x,_target.y,x,y); speed*=0.5; snd_play_hit(sndDogGuardianMelee,0.1); sleep(100) }
        }
        if(dash_charge==0) break
    }
    ds_list_destroy(_list); image_xscale/=2; image_yscale/=2
    if(dash_is_grab && !instance_exists(grabbed_instance)) {
        var _chest=instance_place(x,y,chestprop)
        if(instance_exists(_chest)) grabbed_instance=_chest
    }
    if(dash_is_grab && instance_exists(grabbed_instance)) snd_play(sndDogGuardianLand,1.7+orandom(0.2),2/3)
}
function scrNTTEFullPetGuardianEscape() {
    if(!instance_exists(LastDie) && !instance_exists(LastExecute)) { scrNTTEFullCorpseDrop(id); instance_destroy(); return; }
    can_take=false
    if(!instance_exists(escape_prompt) && instance_exists(prompt) && instance_exists(LastExecute)) escape_prompt=scrNTTEFullPromptCreate(id,prompt.text+"#@cESCAPE",mskReviveArea)
    if(!instance_exists(escape_prompt) || escape_prompt.pick<0) return;
    can_escape=false; can_take=true
    var _portal=instance_create(x,y,Portal),_middle=instance_nearest(_portal.x,_portal.y,FloorMiddle)
    if(instance_exists(_middle) && point_distance(_portal.x,_portal.y,_middle.x,_middle.y)<32) {
        _portal.x=_middle.x; _portal.y=_middle.y; _portal.xprevious=_portal.x; _portal.yprevious=_portal.y
    }
    var _area=scrNTTEFullValue(GameCont,"lastarea",area_labs),_sub=scrNTTEFullValue(GameCont,"lastsubarea",1)
    scrNTTEFullGuardianEscapeQueue(_area,_sub,GameCont.loops)
    with(LastExecute) { repeat(6) instance_create(x,y,IDPDSpawn); mask_index=mskNone; hp=999999; alarm[0]=-1; snd_play(sndLastGrowl,1,1.8) }
    instance_destroy(escape_prompt)
}
function scrNTTEFullPetGuardianAlarm(_dir,_dis) {
    if(follow_delay==0 && dash_charge==0) {
        // petlib.Guardian_alrm0: choose the nearest matching marker BEFORE LOS.
        if(can_escape && !instance_exists(leader) && instance_exists(FloorMiddle)) {
            var _gx=x,_gy=y,_nearest=noone,_nearest_dis=infinity
            with(FloorMiddle) if(sprite_index==sprFloorMiddle) {
                var _distance=point_distance(_gx,_gy,x,y)
                if(_distance<_nearest_dis) { _nearest_dis=_distance; _nearest=id }
            }
            if(instance_exists(_nearest) && !collision_line(x,y,_nearest.x,_nearest.y,Wall,false,false)
                && point_distance(x,y,_nearest.x,_nearest.y)>16) {
                direction=point_direction(x,y,_nearest.x,_nearest.y); walk=6
                // NTT speed is logical; friction_raw is the native friction.
                if(speed/timescale<friction) speed=friction*timescale
                var _face=((direction%360)+360)%360
                if(_face<90 || _face>270) right=1
                else if(_face>90 && _face<270) right=-1
                if(variable_instance_exists(id,"gunangle")) gunangle=_face
                return walk;
            }
        }
        var _p=instance_nearest(x,y,Player),_direction=instance_exists(_p) ? point_direction(x,y,_p.x,_p.y):90+90*-right+orandom(120)
        right=lengthdir_x(1,_direction)>=0 ? 1:-1
    }
    return 60
}
function scrNTTEFullPetGuardianHurt(_damage,_direction,_force=0) {
    hp-=_damage; nexthurt=current_frame+6; motion_add(_direction,_force)
    if(array_get_index([spr_appear,spr_disappear,spr_dash_start,spr_dash_charge,spr_dash,spr_dash_end],sprite_index)<0) { sprite_index=spr_hurt; image_index=0 }
    snd_play(sndCrownGuardianHurt,random_range(1.1,1.3),1); snd_play(sndHitFlesh,random_range(0.8,1),1.2)
    return true
}
function scrNTTEFullPetGuardianDeath() {
    var _fx=scr_projectile_create(x,y,PopoExplosion)
    _fx.sprite_index=sprRogueExplosion; _fx.mask_index=mskExplosion; _fx.image_xscale=2/3; _fx.image_yscale=2/3
    snd_play(sndCrownGuardianDead,random_range(1.1,1.3),1.2)
    var _snd=snd_play(sndLastNotifyDeath,random_range(1.3,1.5),0.75); if(_snd>=0) audio_sound_set_track_position(_snd,0.75)
}
function scrNTTEFullPetGuardianDraw(_spr,_img,_x,_y,_xsc,_ysc,_ang,_col,_alp) {
    var _flash=sprite_index!=spr_hurt && nexthurt>=current_frame+4
    if(_flash) gpu_set_fog(true,image_blend,0,0)
    draw_sprite_ext(_spr,_img,_x,_y,_xsc,_ysc,_ang,_col,_alp)
    if(_flash) gpu_set_fog(false,c_white,0,0)
}
function scrNTTEFullPetGuardianCoreTests() {
    var _p=instance_find(Player,0),_hold=KeyCont.hold_fire[_p.index]
    var _pet=instance_create(_p.x,_p.y,NTTEFullPet)
    with(_pet) { pet="Guardian"; scrNTTEFullPetGuardianCreate(); hp=max_hp; leader=_p; team=_p.team }
    assert(_pet.max_hp==80 && _pet.dash_max_charge==10 && _pet.dash_add_charge==0.5,"Guardian core source stats changed")
    KeyCont.hold_fire[_p.index]=true
    repeat(ceil(20/timescale)) with(_pet) scrNTTEFullPetGuardianStep()
    assert(_pet.dash_charge==10,"Guardian core did not reach full charge after 20 logical ticks")
    var _enemy=instance_create(_pet.x,_pet.y,Bandit)
    _enemy.hp=1000; _enemy.max_hp=1000; _enemy.nexthurt=0; _enemy.team=team_enemy
    _pet.follow_delay=40; _pet.dash_is_grab=false
    with(_pet) scrNTTEFullPetGuardianDashHit()
    assert(_enemy.hp==985 && _pet.stat.punches==1,"Guardian core real melee pipeline lost 15 damage/punch stat")
    _pet.dash_is_grab=true; _pet.dash_charge=10
    with(_pet) scrNTTEFullPetGuardianDashHit()
    assert(_pet.grabbed_instance==_enemy,"Guardian core failed hostile target grab")
    KeyCont.hold_fire[_p.index]=_hold
    instance_destroy(_enemy,false); instance_destroy(_pet,false)
    scrNTTESmokeLog("SYSTEMS PET GUARDIAN CORE: source stats, 20-tick charge, real 15-damage melee/punches and grab OK; race active abilities gated separately")
}
