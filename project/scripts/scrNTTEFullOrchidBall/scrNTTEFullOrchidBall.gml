// Source tepickups.OrchidBall, with shared source-backed trench lightning.
function scrNTTEFullOrchidBallCreate() {
    sprite_index=-1; image_speed=0.5*timescale; depth=-9; spr_sparkle=-1; trail_col=-1; flash=3
    mask_index=mskSuperFlakBullet; image_xscale=1.5; image_yscale=1.5
    friction=0.6*timescale*timescale; direction=random(360); speed=8*timescale; maxspeed=10
    skill=0; num=1; type="basic"; time=0; target=instance_nearest(x,y,Player)
    target_seek=false; portal_inst=noone; creator=noone; setup=true; team=team_none; hitid=-1; persistent=false
    ntte_game=instance_exists(GameCont) ? instance_find(GameCont,0):noone
}
function scrNTTEFullOrchidBallSetup() {
    setup=false
    switch(type) {
        case "portal":
            if(sprite_index==-1) sprite_index=scrNTTERefSprite("RadSkillBall")
            if(spr_sparkle==-1) spr_sparkle=sprEatBigRadPlut
            break
        case "red":
            if(sprite_index==-1) sprite_index=scrNTTERefSprite("RedSkillBall")
            if(spr_sparkle==-1) spr_sparkle=sprLaserCharge
            if(friction==0.6*timescale*timescale) friction=0.3*timescale*timescale
            break
        default:
            if(sprite_index==-1) sprite_index=scrNTTERefSprite("PetOrchidBall")
            if(spr_sparkle==-1) spr_sparkle=scrNTTERefSprite("VaultFlowerSparkle")
            if(trail_col==-1) trail_col=make_color_rgb(128,104,34)
            scrNTTEFullUnlockSet("orchid:seen",true)
    }
}
function scrNTTEFullOrchidBallBeginStep() {
    if(lockstep_stop) return;
    if(flash>0) flash-=timescale
    if(instance_exists(SpiralCont) && (instance_exists(GenCont) || instance_exists(LevCont))) {
        if(!instance_exists(portal_inst)) {
            var _seed=random_get_seed()
            portal_inst=instance_create(SpiralCont.x,SpiralCont.y,SpiralDebris)
            with(portal_inst) {
                sprite_index=other.sprite_index; image_index=other.image_index; image_speed=other.image_speed
                turnspeed=orandom(4); rotspeed=random_range(5,10)*choose(-1,1); dist=random_range(40,60)
            }
            random_set_seed(_seed)
        }
        portal_inst.image_xscale=1+0.1*sin((-portal_inst.image_angle/2)/200)
        portal_inst.image_yscale=portal_inst.image_xscale; portal_inst.grow=0
    }
}
function scrNTTEFullOrchidBallSparkle(_spread=6,_velocity=undefined) {
    var _fx=scrNTTEFullSystemsCreate("VaultFlowerSparkle",x+orandom(_spread),y+orandom(_spread))
    _fx.sprite_index=spr_sparkle
    if(!is_undefined(_velocity)) { _fx.direction=direction; _fx.speed=_velocity*timescale }
    if(!position_meeting(_fx.x,_fx.y,Floor)) _fx.depth=depth+1
    return _fx
}
function scrNTTEFullOrchidBallStep() {
    if(lockstep_stop) return;
    if(setup) scrNTTEFullOrchidBallSetup()
    if(!visible) return;
    var _scale=1+0.1*sin(current_frame/10),_add=timescale/15
    image_xscale+=clamp(_scale-image_xscale,-_add,_add)
    image_yscale+=clamp(_scale-image_yscale,-_add,_add); image_angle+=hspeed/3
    if(sprite_exists(spr_sparkle) && random(1)<1-power(1-1/(trail_col<0 ? 8:4),timescale)) {
        var _fx=scrNTTEFullOrchidBallSparkle(); _fx.image_index=random(1)
    }
    if(target_seek && target!=noone) {
        var _last_target=target
        if(instance_exists(target)) {
            if(type=="red") {
                var _nearest=distance_to_object(target),_orb=id
                with(enemy) if(team!=team_none && team!=team_player && scrNTTEFullValue(id,"name","")!="Tesseract") {
                    var _distance=distance_to_object(_orb)
                    if(_distance<_nearest) { _nearest=_distance; _orb.target=id }
                }
            }
            if(instance_is(target,Player) && place_meeting(x,y,Portal)) {
                persistent=true; visible=false; target_seek=false
                snd_play(sndMutHover,2,0.8)
                var _hit=instance_create(x,y,BulletHit)
                _hit.sprite_index=sprThrowHit; _hit.image_speed=0.4*timescale
                _hit.image_xscale=image_xscale; _hit.image_yscale=image_yscale; _hit.image_angle=image_angle; _hit.depth=-5
                if(sprite_exists(spr_sparkle)) {
                    var _len=random_range(8,12)
                    for(var _dir=0;_dir<360;_dir+=360/16) {
                        var _p=instance_create(x+lengthdir_x(_len,_dir),y+lengthdir_y(_len,_dir),Smoke)
                        /* NTTE NATIVE EFFECT LIFETIME orchid-portal-smoke */ if(instance_exists(_p)) {_p.direction=_dir+orandom(30); _p.speed=random(2)*timescale
                        _p.sprite_index=spr_sparkle; _p.image_index=random(_p.image_number)
                        _p.image_xscale*=1.2; _p.image_yscale*=1.2; _p.depth=-5 }
                    }
                }
            } else if(place_meeting(x,y,target)) { instance_destroy(); return; }
            else {
                motion_add(point_direction(x,y,target.x,target.y),1.5*timescale*timescale)
                speed=min(speed,maxspeed*timescale)
                if(trail_col>=0 && random(1)<min(1,timescale)) repeat(1+(random(3)<1)) {
                    var _p=instance_create(x+orandom(8),y+orandom(8),DiscTrail)
                    _p.sprite_index=choose(sprWepSwap,sprWepSwap,sprThrowHit); _p.image_blend=trail_col
                    _p.image_xscale=0.8; _p.image_yscale=0.8; _p.image_angle=random(360); _p.depth=depth+1
                }
            }
        } else if(instance_exists(Player)) target=instance_nearest(x,y,Player)
        else { instance_destroy(); return; }
        if(type=="red") {
            x+=hspeed; y+=vspeed
            if(instance_exists(target)) {
                var _nodes=scrNTTEFullOrchidBallTether(target,false)
                if((flash>0 || target!=_last_target) && array_length(_nodes)>0) {
                    var _n=_nodes[irandom(array_length(_nodes)-1)]
                    instance_create(_n.x,_n.y,PortalL); snd_play(sndLightningHit,1,2)
                }
            }
            if(target!=_last_target && instance_exists(_last_target) && flash<=0)
                scrNTTEFullOrchidBallTether(_last_target,true)
            x-=hspeed; y-=vspeed
        }
    } else if(!target_seek) {
        if(type=="red" && ((floor(current_frame)%8)<timescale || random(1)<1-power(15/16,timescale))) {
            var _last_id=0
            with(NTTEFullTrenchLightning) _last_id=max(_last_id,id)
            var _last_hit=0
            with(LightningHit) _last_hit=max(_last_hit,id)
            scrNTTEFullTrenchDischarge(x,y,random(360),irandom_range(3,irandom_range(3,5)),true)
            var _nodes=[]
            with(NTTEFullTrenchLightning) if(id>_last_id) array_push(_nodes,id)
            var _trails=scrNTTEFullTrenchLightningDisappear(_nodes)
            for(var _i=0;_i<array_length(_trails);++_i) {
                var _n=_trails[_i]
                _n.sprite_index=scrNTTERefSprite("RedSkillBallTether"); _n.image_yscale=random_range(1,1.5)
                _n.depth=depth+1; _n.speed=speed; _n.friction=friction; _n.direction=direction
            }
            var _orb=id
            with(LightningHit) if(id>_last_hit) {
                sprite_index=asset_get_index("sprPortalL"+string(irandom_range(1,5))); image_angle=0
                depth=_orb.depth+1; speed=_orb.speed; friction=_orb.friction; direction=_orb.direction
            }
        }
        if(speed<=(type=="red" ? 1:3)*timescale) { target_seek=true; flash=max(flash,3) }
    }
}
function scrNTTEFullOrchidBallTether(_target,_disappear) {
    var _arc=lerp(20,4,clamp(point_distance(x,y,_target.x,_target.y)/96,0,1))*sin(current_frame/5)
    var _nodes=scrNTTEFullTrenchArc(x,y,_target.x,_target.y,_arc,_target,true)
    if(_disappear) _nodes=scrNTTEFullTrenchLightningDisappear(_nodes)
    for(var _i=0;_i<array_length(_nodes);++_i) {
        var _n=_nodes[_i]
        _n.sprite_index=scrNTTERefSprite("RedSkillBallTether")
        var _mask=_n.mask_index; _n.mask_index=-1
        with(_n) depth=(place_meeting(x,y+8,Wall) || !place_meeting(x,y+8,Floor)) ? -8:-1
        _n.mask_index=_mask
    }
    return _nodes
}
function scrNTTEFullOrchidBallDraw() {
    if(setup) scrNTTEFullOrchidBallSetup()
    if(flash>0) gpu_set_fog(true,image_blend,0,0)
    draw_self()
    if(flash>0) gpu_set_fog(false,0,0,0)
    gpu_set_blendmode(bm_add)
    draw_sprite_ext(sprite_index,image_index,x,y,image_xscale*2,image_yscale*2,image_angle,image_blend,image_alpha*0.1)
    gpu_set_blendmode(bm_normal)
}
function scrNTTEFullOrchidBallDestroy() {
    if(!instance_exists(ntte_game) || !instance_exists(GameCont) || ntte_game!=instance_find(GameCont,0)) return;
    if(setup) scrNTTEFullOrchidBallSetup()
    if(type=="red") instance_create(x,y,PortalClear)
    if(type=="red" && skill==0) {
        if(instance_exists(target)) scrNTTEFullAnnihilate(target,time)
    } else {
        var _grant=scrNTTEFullSystemsCreate("OrchidSkill",x,y)
        if(skill==0) skill=_grant.skill
        _grant.skill=skill; _grant.num=num; _grant.type=type; _grant.time=time; _grant.creator=creator
        with(_grant) scrNTTEFullOrchidStep()
    }
    if(instance_exists(target)) {
        var _icon=skill>=30 ? scrNTTEFullSkillIcon(skill):[sprSkillIconHUD,skill]
        var _alert=scrNTTEAlertCreate(target.x,target.y,_icon[0],target)
        _alert.image_index=_icon[1]; _alert.image_speed=0; _alert.alert_hold=60; _alert.blink=15; _alert.snd_flash=sndLevelUp
        switch(type) {
            case "basic": _alert.alert_sprite=scrNTTERefSprite("AlertIndicatorOrchid"); _alert.alert_x=6; _alert.alert_y=6; break
            case "portal": _alert.alert_sprite=sprEatRad; _alert.alert_x=6; _alert.alert_y=6; break
            default: _alert.alert_sprite=-1
        }
        with(NTTEAlert) if(id!=_alert && target==_alert.target) {
            if(abs(y-_alert.y)<16) { _alert.target_y-=16; _alert.y-=16 }
        }
    }
    if(sprite_exists(spr_sparkle)) repeat(10+irandom(10)) {
        var _fx=scrNTTEFullOrchidBallSparkle(16,3+random(3)); _fx.depth=-9; _fx.friction=0.2*timescale*timescale
    }
    var _hit=instance_create(x,y,BulletHit)
    _hit.speed=max(4*timescale,speed); _hit.direction=direction; _hit.friction=timescale*timescale
    _hit.sprite_index=sprMutant6Dead; _hit.image_index=11; _hit.image_speed=0.5*timescale
    _hit.image_xscale=0.75; _hit.image_yscale=0.75; _hit.image_angle=direction-90; _hit.depth=-4
    if(spr_sparkle==sprEatRad || spr_sparkle==sprEatBigRad || spr_sparkle==sprEatRadPlut || spr_sparkle==sprEatBigRadPlut)
        _hit.image_blend=make_color_rgb(255,255,0)
    sleep(20)
}
function scrNTTEFullOrchidBallLevelStart() {
    with(NTTEFullOrchidBall) if(!visible && persistent) {
        persistent=false; visible=true; speed=8*timescale; direction=random(360)
        image_xscale=1.5; image_yscale=1.5; flash=3
        if(instance_exists(target)) { x=target.x; y=target.y }
    }
}
function scrNTTEFullOrchidBallTests() {
    var _p=instance_find(Player,0),_skill=mut_last_wish,_old=scr_skill_get(_skill)
    var _ball=scrNTTEFullSystemsCreate("OrchidBall",_p.x,_p.y)
    _ball.skill=_skill; _ball.time=60; _ball.target=_p; _ball.target_seek=true; _ball.speed=0
    with(_ball) scrNTTEFullOrchidBallStep()
    assert(!instance_exists(_ball) && scr_skill_get(_skill)==_old+1,
        "OrchidBall actual collision did not grant source-selected mutation")
    var _timer=noone
    with(NTTEFullOrchidSkill) if(skill==_skill && time_max==60) _timer=id
    assert(instance_exists(_timer) && _timer.ntte_applied,"OrchidBall failed real OrchidSkill lifetime initialization")
    instance_destroy(_timer)
    assert(scr_skill_get(_skill)==_old,"OrchidBall timer did not revoke grant once")
    var _portal=scrNTTEFullSystemsCreate("OrchidBall",_p.x+32,_p.y)
    _portal.type="portal"; _portal.skill=mut_hammerhead; _portal.time=2
    with(_portal) scrNTTEFullOrchidBallSetup()
    assert(_portal.sprite_index==scrNTTERefSprite("RadSkillBall") && _portal.spr_sparkle==sprEatBigRadPlut,
        "Portal OrchidBall lost original sprite/sparkle mapping")
    instance_destroy(_portal,false)
    scrNTTESmokeLog("SYSTEMS ORCHID BALL: actual seek/contact grant, source mutation/time, one-time revoke and portal visuals OK")
}
function scrNTTEFullOrchidBallRedTests() {
    var _p=instance_find(Player,0),_oldx=_p.x,_oldy=_p.y
    _p.x=16000; _p.y=16000
    var _ball=scrNTTEFullSystemsCreate("OrchidBall",_p.x+96,_p.y)
    _ball.type="red"; _ball.target=_p; _ball.target_seek=true; _ball.speed=0; _ball.flash=0
    var _enemy=instance_create(_ball.x+32,_ball.y,Bandit)
    _enemy.team=team_enemy; _enemy.hp=100
    var _nodes=[]
    with(_ball) { scrNTTEFullOrchidBallSetup(); _nodes=scrNTTEFullOrchidBallTether(_enemy,false) }
    assert(array_length(_nodes)>0,"Red OrchidBall did not create real trench tether")
    for(var _i=0;_i<array_length(_nodes);++_i) {
        var _n=_nodes[_i]
        assert(_n.team==_enemy.team && _n.creator==_enemy && _n.damage>0
            && _n.sprite_index==scrNTTERefSprite("RedSkillBallTether"),"Red tether lost original enemy ownership/damaging nodes/visuals")
    }
    var _trails=[]
    with(_ball) _trails=scrNTTEFullOrchidBallTether(_p,true)
    assert(array_length(_trails)>0,"Red OrchidBall old-target tether did not emit disappearing trail")
    for(var _i=0;_i<array_length(_trails);++_i)
        assert(!instance_is(_trails[_i],NTTEFullTrenchLightning),"Old-target tether left live damaging enemy nodes instead of trails")
    with(_ball) scrNTTEFullOrchidBallStep()
    assert(_ball.target==_enemy,"Red OrchidBall failed actual nearest enemy retarget from player")
    // Use actual contact Destroy path and restore the source-wide level state.
    var _old_list=GameCont.annihilation_list,_old_timer=scrNTTEFullValue(GameCont,"annihilation_skill",noone)
    GameCont.annihilation_list=[]; GameCont.annihilation_skill=noone
    _ball.skill=0; _ball.time=3; _ball.x=_enemy.x; _ball.y=_enemy.y; _ball.speed=0
    with(_ball) scrNTTEFullOrchidBallStep()
    assert(!instance_exists(_ball) && array_length(GameCont.annihilation_list)==1
        && GameCont.annihilation_list[0].object_name=="Bandit", "Red OrchidBall contact did not invoke real type-wide annihilation")
    var _new_timer=GameCont.annihilation_skill
    if(instance_exists(_new_timer)) instance_destroy(_new_timer)
    GameCont.annihilation_list=_old_list; GameCont.annihilation_skill=_old_timer
    if(instance_exists(_enemy)) instance_destroy(_enemy,false)
    for(var _i=0;_i<array_length(_nodes);++_i) if(instance_exists(_nodes[_i])) instance_destroy(_nodes[_i],false)
    for(var _i=0;_i<array_length(_trails);++_i) if(instance_exists(_trails[_i])) instance_destroy(_trails[_i],false)
    _p.x=_oldx; _p.y=_oldy
    scrNTTESmokeLog("SYSTEMS RED ORCHID BALL: real damaging owned tether, disappearing old-target trails, nearest enemy retarget and actual contact annihilation OK")
}
