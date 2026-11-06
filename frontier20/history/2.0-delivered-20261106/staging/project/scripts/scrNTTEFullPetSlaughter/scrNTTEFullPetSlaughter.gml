// Original petlib.Slaughter, 533..888: bubble armor, bite and crab-bone fetch.
function scrNTTEFullPetSlaughterCreate() {
    spr_idle=scrNTTERefSprite("PetSlaughterIdle"); spr_walk=scrNTTERefSprite("PetSlaughterWalk")
    spr_hurt=scrNTTERefSprite("PetSlaughterHurt"); spr_dead=scrNTTERefSprite("PetSlaughterDead")
    spr_spwn=scrNTTERefSprite("PetSlaughterSpwn"); spr_fire=scrNTTERefSprite("PetSlaughterBite")
    spr_icon=scrNTTERefSprite("PetSlaughterIcon"); spr_shadow_y=-2; depth=-3
    hitid=[spr_idle,"SLAUGHTERFISH"]; snd_hurt=sndOasisBossHurt; snd_dead=sndFreakDead; snd_spwn=sndOasisBossDead
    mask_index=mskFrogEgg; max_hp=30; maxspeed=3.4; size=2
    spr_bubble=-1;spr_bubble_pop=-1
    nextexplo=0; target=noone; my_bite=noone; my_bone=noone
    stat.bites=scrNTTEFullValue(stat,"bites",0)
    hooks={initial_sprite:spr_spwn,anim:method(id,scrNTTEFullPetSlaughterAnim),step:method(id,scrNTTEFullPetSlaughterStep),alarm:method(id,scrNTTEFullPetSlaughterAlarm),hurt:method(id,scrNTTEFullPetSlaughterHurt),death:method(id,scrNTTEFullPetSlaughterDeath)}
}
function scrNTTEFullPetSlaughterAnim() {
    if((sprite_index!=spr_hurt && sprite_index!=spr_spwn && sprite_index!=spr_fire) || image_index>=sprite_get_number(sprite_index)-image_speed) {
        if(sprite_index==spr_spwn) {
            sprite_index=spr_hurt; image_index=0; depth=-2
            snd_play(snd_spwn,1.2+random(0.1),1.2)
            for(var _d=direction;_d<direction+360;_d+=120) {
                repeat(2) scrNTTEFullPetEffect(x,y,[_d+orandom(40),4],Dust)
                var _streak=instance_create(x+lengthdir_x(-8,_d),y+lengthdir_y(-8,_d),NTTEFullWaterStreak)
                with(_streak) { motion_set(_d+orandom(20),1.5*timescale); image_angle=direction; friction=0.1*timescale*timescale }
            }
        } else sprite_index=speed>0 ? spr_walk:spr_idle
    }
}
function scrNTTEFullPetSlaughterBubble(_x,_y,_small,_direction=0,_speed=0) {
    var _bubble=instance_create(_x,_y,_small ? NTTEFullBubbleExplosionSmall:NTTEFullBubbleExplosion)
    _bubble.team=team; _bubble.creator=id; _bubble.direction=_direction; _bubble.speed=_speed*timescale
    return _bubble
}
function scrNTTEFullPetSlaughterStep() {
    if(sprite_index==spr_spwn) speed=0
    if(nextexplo>current_frame) image_index=0
    if(sprite_index==spr_fire) {
        if(image_index<3) {
            if(!instance_exists(my_bite)) my_bite=instance_create(x,y,RobotEat)
            if(instance_exists(my_bone)) with(my_bone) {
                hspeed=3.5*other.right*timescale; vspeed=orandom(2)*timescale
                rotspeed=random_range(8,16)*choose(-1,1)
                if(place_meeting(x,y,Wall) && scrNTTEFullWorldBudge(id,Wall,24)) instance_create(x,y,Dust)
                instance_create(x,y,Dust)
            }
            my_bone=noone
        } else if(image_index<3+image_speed) {
            stat.bites+=1
            if(instance_exists(target) && instance_is(target,hitme)) {
                snd_play(sndExplosionS,1.5,1.2)
                var _dir=point_direction(x,y,target.x,target.y)
                for(var _a=_dir;_a<_dir+360;_a+=120) {
                    var _bubble=scrNTTEFullPetSlaughterBubble(target.x-lengthdir_x(8,_dir)+lengthdir_x(8,_a),
                        target.y-lengthdir_y(8,_dir)+lengthdir_y(8,_a),true,_dir+orandom(20),6)
                    with(_bubble) {
                        repeat(2) scrNTTEFullPetEffect(x,y,[direction+orandom(30),3],Smoke)
                        image_angle=0; friction=0.75*timescale*timescale; x-=hspeed; y-=vspeed
                    }
                }
            } else if(instance_exists(target) && instance_is(target,WepPickup)) {
                my_bone=target; snd_play(sndBloodGamble,2+orandom(0.2),0.6)
            }
            snd_play(sndSharpTeeth,1.5+orandom(0.2),0.5)
        }
        if(instance_exists(my_bite)) {
            my_bite.x=x; my_bite.y=y; my_bite.sprite_index=scrNTTERefSprite("SlaughterBite")
            my_bite.image_index=image_index; my_bite.image_xscale=right; my_bite.depth=depth-1
        }
    } else if(!instance_exists(target)) target=noone
    if(instance_exists(my_bone)) {
        var _x=x+hspeed+10*right,_y=y+vspeed+2,_pet=id
        with(my_bone) {
            if(point_distance(x,y,_x,_y)>2) { x+=(_x-x)*0.8*timescale; y+=(_y-y)*0.8*timescale }
            else { x=_x; y=_y }
            xprevious=x; yprevious=y; speed=0
            image_angle+=angle_difference((10+10*sin((x+y)/10))*_pet.right,image_angle)*0.5*timescale
            var _drop=!visible,_bone=id
            if(!_drop) with(Portal) if(point_distance(x,y,_bone.x,_bone.y)<96
                && !collision_line(x,y,_bone.x,_bone.y,Wall,false,false)) _drop=true
            if(_drop) _pet.my_bone=noone
        }
    }
}
function scrNTTEFullPetSlaughterAlarm(_dir,_dis) {
    ntte_pet_alarm=20+random(10)
    if(sprite_index==spr_fire || sprite_index==spr_spwn) return 0
    if(!instance_exists(leader)) {
        scrNTTEFullPetWalk(random(360),random_range(8,16)); right=lengthdir_x(1,direction)>=0 ? 1:-1; return 30+random(10)
    }
    var _target_visible=instance_exists(target) && !collision_line(x,y,target.x,target.y,Wall,false,false)
    if(!is_undefined(path_dir) && (_dis>96 || !instance_exists(target) || !_target_visible)) {
        scrNTTEFullPetWalk(path_dir+orandom(20),12); right=lengthdir_x(1,direction)>=0 ? 1:-1; return 1+irandom(walk)
    }
    if(target!=my_bone && instance_exists(target) && point_distance(target.x,target.y,leader.x,leader.y)<160 && _target_visible) {
        var _td=point_direction(x,y,target.x,target.y)
        if((target.visible || !instance_is(target,WepPickup)) && distance_to_object(target)<(instance_is(target,WepPickup) ? 2:32)) {
            sprite_index=spr_fire; image_index=0; speed=0; walk=0; right=lengthdir_x(1,_td)>=0 ? 1:-1
        } else { scrNTTEFullPetWalk(_td+orandom(20),random_range(8,16)); right=lengthdir_x(1,direction)>=0 ? 1:-1; ntte_pet_alarm=10 }
    } else if(_dis>48) {
        scrNTTEFullPetWalk(_dir+orandom(20),random_range(15,25)); right=lengthdir_x(1,direction)>=0 ? 1:-1
        if(instance_exists(my_bone)) walk=ntte_pet_alarm
    } else if(!instance_exists(my_bone)) { scrNTTEFullPetWalk(_dir+orandom(90),random_range(8,16)); right=lengthdir_x(1,direction)>=0 ? 1:-1 }
    if(sprite_index!=spr_fire) {
        var _pet=id,_best=infinity
        with(hitme) if(team!=_pet.team && team!=team_none && mask_index!=mskNone && !instance_is(id,prop)
            && (instance_is(id,enemy) || instance_is(id,Player) || instance_is(id,Sapling) || instance_is(id,Ally) || instance_is(id,SentryGun) || instance_is(id,NTTEFullPet))) {
            var _d=point_distance(x,y,_pet.x,_pet.y)
            if(_d<_best && !collision_line(x,y,_pet.x,_pet.y,Wall,false,false)) { _best=_d; _pet.target=id }
        }
        _target_visible=instance_exists(target) && !collision_line(x,y,target.x,target.y,Wall,false,false)
        if(instance_exists(target) && !collision_line(leader.x,leader.y,target.x,target.y,Wall,false,false)) {
            motion_add(point_direction(x,y,target.x,target.y)+orandom(10),2*timescale); right=lengthdir_x(1,direction)>=0 ? 1:-1
        }
        if(!instance_exists(my_bone) && (!instance_exists(target) || !_target_visible)) {
            _best=160
            with(WepPickup) if(visible && scrNTTEFullCrabboneIs(wep)) {
                var _d=point_distance(x,y,_pet.x,_pet.y)
                if(_d<_best && !collision_line(x,y,_pet.x,_pet.y,Wall,false,false)) { _best=_d; _pet.target=id }
            }
        } else return 5+random(10)
    }
    return 0
}
function scrNTTEFullPetSlaughterHurt(_damage,_dir,_force=0) {
    var _source=scrNTTEFullValue(id,"ntte_pet_hit_source",noone)
    if(sprite_index==spr_spwn) return true
    if(hp>0 && (instance_exists(leader) || (sprite_index!=spr_fire && scrNTTEFullValue(_source,"typ",0)==1))) {
        if(instance_exists(leader)) {
            if(snd_hurt==sndOasisBossHurt) snd_play(snd_hurt,1.2+random(0.1),1.4)
            if(nextexplo<=current_frame) {
                nextexplo=current_frame+6
                var _start=random(360),_num=3+scrCrownCheck(Crown.Death)
                scrNTTEFullPetSlaughterBubble(x,y,false)
                for(var _d=_start;_d<_start+360;_d+=360/_num) scrNTTEFullPetSlaughterBubble(x+lengthdir_x(8,_d),y+lengthdir_y(8,_d),true)
                snd_play(sndExplosion,1.5+random(0.5),1.2)
            }
            return false
        }
        if(!instance_exists(_source) || scrNTTEFullValue(_source,"typ",1)!=0) {
            right=lengthdir_x(1,direction)>=0 ? 1:-1; sprite_index=spr_fire; image_index=2; nexthurt=current_frame+6; walk=0
        }
    } else if(sprite_index!=spr_fire) { sprite_index=spr_fire; image_index=3 }
    return true
}
function scrNTTEFullPetSlaughterDeath() { snd_play(snd_dead,1.5+random(0.3),1.4) }
function scrNTTEFullPetSlaughterTests() {
    var _p=instance_find(Player,0),_old=scrNTTEFullValue(_p,"ntte_pet",[]),_ox=_p.x,_oy=_p.y,_crown=GameCont.crown
    _p.ntte_pet=[]; _p.x=14000; _p.y=14000; GameCont.crown=Crown.None
    var _pet=scrNTTEFullPetCreate(_p.x,_p.y,"Slaughter"),_source=instance_create(_p.x+24,_p.y,EnemyBullet1)
    assert(_pet.hp==30 && _pet.size==2 && _pet.sprite_index==_pet.spr_spwn,"Slaughterfish original HP/size/spawn animation was overwritten")
    with(_source) scr_hit(_pet,4)
    assert(_pet.hp==30,"Slaughterfish vulnerable during original spawn animation")
    scrNTTEFullPetTake(_pet,_p); _pet.sprite_index=_pet.spr_idle
    var _big=instance_number(NTTEFullBubbleExplosion),_small=instance_number(NTTEFullBubbleExplosionSmall)
    with(_source) scr_hit(_pet,4)
    assert(_pet.hp==26 && instance_number(NTTEFullBubbleExplosion)==_big+1 && instance_number(NTTEFullBubbleExplosionSmall)==_small+3,
        "Owned Slaughterfish did not take real damage and emit1big/3small original bubble armor")
    with(_source) scr_hit(_pet,1)
    assert(instance_number(NTTEFullBubbleExplosion)==_big+1,"Slaughterfish bubble armor ignored6logicalframe cooldown")
    with(NTTEFullBubbleExplosion) if(creator==_pet) assert(team==_p.team,"Slaughterfish armor lost allied ownership")
    // Actual frame3 bite emits precisely3small moving bubbles and increments once.
    var _enemy=instance_create(_pet.x+16,_pet.y,Bandit),_bites=_pet.stat.bites
    _pet.target=_enemy; _pet.sprite_index=_pet.spr_fire; _pet.image_index=3
    _small=instance_number(NTTEFullBubbleExplosionSmall)
    with(_pet) { nextexplo=0; scrNTTEFullPetSlaughterStep() }
    assert(_pet.stat.bites==_bites+1 && instance_number(NTTEFullBubbleExplosionSmall)==_small+3,"Slaughterfish actual attack frame missed3bubble bite")
    var _bone=scrWeaponPickupCreate(_pet.x+8,_pet.y,wep_ntte_bone)
    _pet.target=_bone; _pet.image_index=3
    with(_pet) scrNTTEFullPetSlaughterStep()
    assert(_pet.my_bone==_bone && _bone.speed==0,"Slaughterfish did not carry real crab-bone pickup")
    _pet.image_index=1
    with(_pet) scrNTTEFullPetSlaughterStep()
    assert(_pet.my_bone==noone && abs(_bone.hspeed)==3.5*timescale,"Slaughterfish did not toss previous fetched bone on next bite")
    instance_destroy(_bone,false); instance_destroy(_enemy,false); instance_destroy(_source,false)
    instance_destroy(_pet)
    with(NTTEFullBubbleExplosion) if(creator==_pet) instance_destroy(id,false)
    with(NTTEFullBubbleExplosionSmall) if(creator==_pet) instance_destroy(id,false)
    _p.ntte_pet=_old; _p.x=_ox; _p.y=_oy; GameCont.crown=_crown
    scrNTTESmokeLog("SYSTEMS PET SLAUGHTER: source spawn immunity, realHPdamage/1big3small armor/cooldown/team, frame3triplebubblebite, actualbonecarry/toss OK")
}
