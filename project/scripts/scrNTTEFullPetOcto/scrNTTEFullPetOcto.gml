// Source petlib.Octo. The native Epsilon has no custom arc-chain object;
// connection state uses TrenchArc nodes and the same 160px LOS budget.
function scrNTTEFullPetOctoCreate() {
    spr_idle=scrNTTERefSprite("PetOctoIdle"); spr_walk=spr_idle; spr_hurt=scrNTTERefSprite("PetOctoHurt")
    spr_icon=scrNTTERefSprite("PetOctoIcon"); spr_hide=scrNTTERefSprite("PetOctoHide"); spr_shadow=shd16; spr_shadow_y=5
    friction=0.1*timescale*timescale; maxspeed=3.4; hiding=false; arc_list=[]; arc_wait=0; path_wall=[Wall]
    spr_bubble=-1; spr_bubble_pop=-1
    stat.arcing=scrNTTEFullValue(stat,"arcing",0)
    hooks={anim:method(id,scrNTTEFullPetOctoAnim),step:method(id,scrNTTEFullPetOctoStep),alarm:method(id,scrNTTEFullPetOctoAlarm),hurt:method(id,scrNTTEFullPetOctoHurt),draw:method(id,scrNTTEFullPetOctoDraw)}
}
function scrNTTEFullPetOctoAnim() {
    if(hiding) sprite_index=spr_hide
    else if(sprite_index!=spr_hurt || image_index+image_speed>=image_number || image_index+image_speed<0)
        sprite_index=speed==0?spr_idle:spr_walk
}

function scrNTTEFullPetOctoStep() {
    if(instance_exists(leader)) {
        if(hiding) {hiding=false;light=true;spr_shadow=shd16}
    } else if(hiding) {
        light=false;spr_shadow=-1
        if(image_index<1) {
            image_index-=image_speed*0.95
            var _intro=false
            with(NTTEFullPitSquid) if(ntte_full_intro) _intro=true
            if(_intro) {instance_destroy();return}
        } else if(image_index+image_speed>=image_number || image_index+image_speed<0) {
            var _pits=[]
            with(Floor) if(sprite_index==scrNTTERefSprite("FloorTrenchB")) array_push(_pits,id)
            if(array_length(_pits)>0) {
                var _pit=_pits[irandom(array_length(_pits)-1)]
                x=(_pit.bbox_left+_pit.bbox_right)/2;y=(_pit.bbox_top+_pit.bbox_bottom)/2
                xprevious=x;yprevious=y
            }
        }
        speed=clamp(speed,0,(maxspeed-0.4)*timescale)
        var _can_take=false,_pet=id
        with(Floor) if(sprite_index==scrNTTERefSprite("FloorTrenchB") && collision_point(_pet.x,_pet.y-4,id,false,false)!=noone) _can_take=true
        can_take=_can_take
    }
    if(array_length(path)==0) for(var _i=0;_i<array_length(path_wall);++_i)
        if(place_meeting(x+hspeed,y+vspeed,path_wall[_i])) {
            if(place_meeting(x+hspeed,y,path_wall[_i])) hspeed*=-0.5
            if(place_meeting(x,y+vspeed,path_wall[_i])) vspeed*=-0.5
            scrNTTEFullPetOctoAlarmLook()
        }
}

function scrNTTEFullPetOctoDraw(_spr,_img,_x,_y,_xsc,_ysc,_ang,_col,_alp) {
    if(!hiding) draw_sprite_ext(_spr,_img,_x,_y,_xsc,_ysc,_ang,_col,_alp)
}
// Source enemy_walk/look: Octo friction .1, native pixels per step.
function scrNTTEFullPetOctoAlarmWalk(_dir,_duration) {
    direction=_dir;walk=_duration
    if(speed<friction/timescale) speed=friction/timescale
}
function scrNTTEFullPetOctoAlarmLook() {
    var _dir=((direction%360)+360)%360
    if(_dir<90 || _dir>270) right=1
    else if(_dir>90 && _dir<270) right=-1
}
function scrNTTEFullPetOctoAlarm(_leader_dir,_leader_dis) {
    if(instance_exists(leader)) {
        if(_leader_dis>64 || collision_line(x,y,leader.x,leader.y,Wall,false,false)) {
            if(!is_undefined(path_dir)) {
                scrNTTEFullPetOctoAlarmWalk(path_dir+orandom(10),6)
                scrNTTEFullPetOctoAlarmLook()
                return 1+irandom(walk)+irandom(6)
            }
            scrNTTEFullPetOctoAlarmWalk(_leader_dir+orandom(20),random_range(5,15))
            scrNTTEFullPetOctoAlarmLook()
            return walk+random(5)
        }
        // Discrete Alarm impulse: raw velocity maps with one timescale.
        motion_add(_leader_dir+orandom(60),(1.5+random(1.5))*timescale)
        scrNTTEFullPetOctoAlarmLook()
        if(array_length(arc_list)>0 && variable_instance_exists(leader,"index")) {
            var _enemy=instance_nearest(x,y,enemy)
            if(instance_exists(_enemy) && point_distance(x,y,_enemy.x,_enemy.y)<160) {
                var _index=leader.index
                var _mx=leader.x+lengthdir_x(KeyCont.dis_fire[_index],KeyCont.dir_fire[_index])
                var _my=leader.y+lengthdir_y(KeyCont.dis_fire[_index],KeyCont.dir_fire[_index])
                motion_add(point_direction(x,y,_mx,_my)+orandom(10),2*timescale)
            }
        }
        return 20+random(10)
    }
    if(scrNTTEFullAreaKey(GameCont.area)=="trench" && !hiding) {
        var _under=false,_pet=id
        with(Floor) if(sprite_index==scrNTTERefSprite("FloorTrenchB") && collision_point(_pet.x,_pet.y-4,id,false,false)!=noone) _under=true
        if(_under) {
            hiding=true;sprite_index=spr_hide;image_index=0
            repeat(4+irandom(4)) {
                var _dust=scrNTTEFullPetEffect(x,y,2,Dust)
                if(instance_exists(_dust)) _dust.waterbubble=random(2)<1
            }
        } else {
            var _best=infinity,_dir=-1
            with(Floor) if(sprite_index==scrNTTERefSprite("FloorTrenchB")) {
                var _cx=bbox_center_x,_cy=bbox_center_y
                var _d=point_distance(_pet.x,_pet.y,_cx,_cy)
                if(_d<_best && !collision_line(_pet.x,_pet.y,_cx,_cy,Wall,false,false)) {
                    _best=_d;_dir=point_direction(_pet.x,_pet.y,_cx,_cy)
                }
            }
            if(_dir>=0) {
                scrNTTEFullPetOctoAlarmWalk(_dir,random_range(10,15))
                scrNTTEFullPetOctoAlarmLook()
                return walk+random(5)
            }
        }
    }
    instance_create(x,y,Bubble)
    scrNTTEFullPetOctoAlarmWalk(direction+orandom(60),random_range(5,15))
    scrNTTEFullPetOctoAlarmLook()
    return walk+random_range(30,60)
}

function scrNTTEFullPetOctoHurt(_damage,_direction,_force=0) {
    if(!hiding) {
        sprite_index=spr_hurt;image_index=0
        scrNTTEFullPetOctoAlarmWalk(_direction,10)
        var _look=(((direction+180)%360)+360)%360
        if(_look<90 || _look>270) right=1
        else if(_look>90 && _look<270) right=-1
    }
    return true
}

function scrNTTEFullPetOctoChain() {
    var _ax=x,_ay=y,_anchor=id,_limit=160,_break=visible ? -1:0
    for(var _i=0;_i<array_length(arc_list);++_i) {
        var _record=arc_list[_i],_target=_record.id
        if(_break<0) {
            if(instance_exists(_target)) {
                var _tx=(_target.bbox_left+_target.bbox_right+1)/2+_target.hspeed
                var _ty=(_target.bbox_top+_target.bbox_bottom+1)/2+_target.vspeed
                var _distance=infinity
                with(_target) _distance=distance_to_object(_anchor)
                if(_distance<=_limit && !collision_line(_tx,_ty,_ax,_ay,Wall,false,false)) { _record.x=_tx; _record.y=_ty }
                else _break=_i
            } else _break=_i
        }
        if(arc_wait>0 && _i==array_length(arc_list)-1) {
            if(random(1)<timescale) {
                var _along=random(point_distance(_ax,_ay,_record.x,_record.y)),_dir=point_direction(_ax,_ay,_record.x,_record.y)
                var _fx=instance_create(_ax+lengthdir_x(_along,_dir),_ay+lengthdir_y(_along,_dir),choose(PortalL,LaserCharge))
                if(_fx.object_index==LaserCharge) {
                    _fx.sprite_index=sprLightning; _fx.image_xscale=random_range(0.5,2); _fx.image_yscale=random_range(0.5,2)
                    _fx.image_angle=random(360); _fx.alarm[0]=4+random(4)
                }
                with(_fx) motion_add(random(360),timescale)
            }
        } else {
            var _amount=clamp((point_distance(_ax,_ay,_record.x,_record.y)-32)/(_limit-32),0,1)
            var _arc=lerp(24,8,_amount)*sin((wave/300+_i/3)*2*pi)
            var _nodes=scrNTTEFullTrenchArc(_ax,_ay,_record.x,_record.y,_arc,id,false)
            if(arc_wait<=0 && _break>=0 && _i>=_break) scrNTTEFullTrenchLightningDisappear(_nodes)
        }
        _ax=_record.x; _ay=_record.y; _anchor=_record.id
    }
    if(arc_wait<=0 && _break>=0) {
        instance_create(_ax,_ay,LightningHit)
        array_resize(arc_list,_break)
    }
    if(array_length(arc_list)>(arc_wait>0 ? 1:0)) stat.arcing+=timescale/30
    if(arc_wait>0) {
        arc_wait-=timescale
        if(arc_wait<=0 && array_length(arc_list)>0) {
            snd_play(sndLightningHit,1,2)
            if(scr_skill_get(mut_laser_brain)>0) {
                var _dir=point_direction(x,y,_ax,_ay),_fx=instance_create(x,y,LaserBrain)
                _fx.image_angle=_dir+orandom(10); _fx.creator=id
                _fx=instance_create(_ax,_ay,LaserBrain); _fx.image_angle=_dir+orandom(10)+180; _fx.creator=_anchor
            }
        }
    } else if(visible && instance_exists(leader)) {
        var _candidates=[],_pet=id,_leader=leader
        if(leader.visible) array_push(_candidates,leader)
        with(NTTEFullPet) if(id!=_pet && leader==_leader && visible) array_push(_candidates,id)
        if(array_length(arc_list)>0) with(projectile)
            if(creator==_leader || (creator!=_leader && creator!=_pet && team==_leader.team)) array_push(_candidates,id)
        var _tx=leader.x,_ty=leader.y,_distance=infinity,_nearest=noone,_nx=0,_ny=0
        if(variable_instance_exists(leader,"gunangle")) { _tx+=lengthdir_x(_limit/2,leader.gunangle); _ty+=lengthdir_y(_limit/2,leader.gunangle) }
        for(var _c=0;_c<array_length(_candidates);++_c) {
            var _candidate=_candidates[_c],_used=false
            for(var _j=0;_j<array_length(arc_list);++_j) if(arc_list[_j].id==_candidate) _used=true
            if(_used || !instance_exists(_candidate)) continue
            var _owner=scrNTTEFullValue(_candidate,"creator",noone)
            if(instance_exists(_owner) && instance_is(_owner,NTTEFullPet) && _owner.pet=="Octo") continue
            var _cx=(_candidate.bbox_left+_candidate.bbox_right+1)/2+_candidate.hspeed
            var _cy=(_candidate.bbox_top+_candidate.bbox_bottom+1)/2+_candidate.vspeed
            var _d=point_distance(_cx,_cy,_tx,_ty),_anchor_distance=infinity
            with(_candidate) _anchor_distance=distance_to_object(_anchor)
            if(_d<_distance && _anchor_distance<=_limit && !collision_line(_cx,_cy,_ax,_ay,Wall,false,false)) {
                _distance=_d; _nearest=_candidate; _nx=_cx; _ny=_cy
            }
        }
        if(instance_exists(_nearest)) {
            array_push(arc_list,{id:_nearest,x:_nx,y:_ny})
            arc_wait=instance_is(_nearest,projectile) ? min(30,2*array_length(arc_list)):6
        }
    }
}
function scrNTTEFullPetOctoAllChains() { with(NTTEFullPet) if(pet=="Octo") scrNTTEFullPetOctoChain() }
function scrNTTEFullPetOctoBubblesDraw() {
    if(!GameCont.underwater) with(NTTEFullPet) if(pet=="Octo" && visible && !hiding)
        draw_sprite(sprPlayerBubble,-1,x+spr_bubble_x,y+spr_bubble_y)
}
function scrNTTEFullPetOctoTests() {
    var _p=instance_find(Player,0),_old_pets=scrNTTEFullValue(_p,"ntte_pet",[])
    _p.ntte_pet=[]
    var _pet=scrNTTEFullPetCreate(_p.x+64,_p.y,"Octo"); scrNTTEFullPetTake(_pet,_p)
    scrNTTEFullPetOctoAlarmSourceTests(_pet)
    scrNTTEFullPetOctoLocalSourceTests(_pet)
    assert(_pet.maxspeed==3.4 && _pet.spr_hide==scrNTTERefSprite("PetOctoHide") && _pet.spr_shadow_y==5,"Octo source constructor changed")
    _pet.leader=noone; _pet.hiding=true; _pet.visible=true; _pet.sprite_index=_pet.spr_hide; _pet.image_index=0
    with(_pet) scrNTTEFullPetOctoStep()
    assert(!_pet.light && _pet.spr_shadow==-1 && _pet.can_take==false,"Octo hidden state incorrectly exposes light/take prompt")
    _pet.leader=_p; _pet.hiding=false; _pet.arc_list=[]; _pet.arc_wait=0
    with(_pet) scrNTTEFullPetOctoAlarm(0,80)
    assert(_pet.speed>0 || _pet.walk>0,"Octo leader follow lost source idle motion")
    _pet.x=_p.x+64; _pet.y=_p.y; _pet.speed=0
    with(_pet) scrNTTEFullPetOctoChain()
    assert(array_length(_pet.arc_list)==1 && _pet.arc_list[0].id==_p && _pet.arc_wait==6,
        "Octo first conduit did not select its actual leader or original six-frame delay")
    repeat(ceil(6/timescale)) with(_pet) scrNTTEFullPetOctoChain()
    assert(_pet.arc_wait<=0,"Octo conduit delay did not use logical time")
    var _before=instance_number(NTTEFullTrenchLightning),_stat=_pet.stat.arcing
    with(_pet) scrNTTEFullPetOctoChain()
    assert(instance_number(NTTEFullTrenchLightning)>_before && _pet.stat.arcing>_stat,
        "Octo established conduit failed real player lightning or source arcing time stat")
    var _old_x=_p.x; _p.x+=400
    _pet.arc_wait=0
    with(_pet) scrNTTEFullPetOctoChain()
    assert(array_length(_pet.arc_list)==0,"Octo out-of-range conduit did not break original prefix")
    _p.x=_old_x
    with(NTTEFullTrenchLightning) if(creator==_pet) instance_destroy(id,false)
    instance_destroy(_pet); _p.ntte_pet=_old_pets
    scrNTTESmokeLog("SYSTEMS PET OCTO: source constructor/hide/movement, actual leader conduit delay, real player lightning/stat, range break OK")
}

// Original Octo local hooks, independent of production helpers.
function scrNTTEFullPetOctoLocalLiteralLook(_dir) {
    _dir=((_dir%360)+360)%360
    if(_dir<90 || _dir>270) right=1
    else if(_dir>90 && _dir<270) right=-1
}
function scrNTTEFullPetOctoLocalLiteralAnim() {
    var _end=(image_index+image_speed>=image_number) || (image_index+image_speed<0)
    var _enemy_sprite=(sprite_index!=spr_hurt || _end)?((speed==0)?spr_idle:spr_walk):sprite_index
    sprite_index=hiding?spr_hide:_enemy_sprite
}
function scrNTTEFullPetOctoLocalLiteralStep() {
    if(instance_exists(leader)) {
        if(hiding) {hiding=false;light=true;spr_shadow=shd16}
    } else if(hiding) {
        light=false;spr_shadow=-1
        if(image_index<1) {
            image_index-=image_speed*0.95
            var _intro=false
            with(NTTEFullPitSquid) if(ntte_full_intro) _intro=true
            if(_intro) {instance_destroy();return}
        } else if((image_index+image_speed>=image_number) || (image_index+image_speed<0)) {
            var _list=[]
            with(Floor) if(sprite_index==scrNTTERefSprite("FloorTrenchB")) array_push(_list,id)
            var _chosen=array_length(_list)>0?_list[irandom(array_length(_list)-1)]:noone
            with(_chosen) {other.x=bbox_center_x;other.y=bbox_center_y;other.xprevious=other.x;other.yprevious=other.y}
        }
        speed=clamp(speed,0,(3.4-0.4)*timescale)
        var _meet=0,_pet=id
        with(Floor) if(collision_point(_pet.x,_pet.y-4,id,false,false)!=noone && sprite_index==scrNTTERefSprite("FloorTrenchB")) _meet++
        can_take=_meet>0
    }
    if(!array_length(path)) {
        for(var _i=0;_i<array_length(path_wall);++_i) {
            var _object=path_wall[_i]
            if(place_meeting(x+hspeed,y+vspeed,_object)) {
                if(place_meeting(x+hspeed,y,_object)) hspeed*=-0.5
                if(place_meeting(x,y+vspeed,_object)) vspeed*=-0.5
                scrNTTEFullPetOctoLocalLiteralLook(direction)
            }
        }
    }
}
function scrNTTEFullPetOctoLocalLiteralHurt(_damage,_direction,_force) {
    if(!hiding) {
        sprite_index=spr_hurt;image_index=0
        direction=_direction;walk=10
        if(speed<0.1*timescale) speed=0.1*timescale
        scrNTTEFullPetOctoLocalLiteralLook(direction+180)
    }
    return true
}
function scrNTTEFullPetOctoLocalSourceState(_pet) {
    return [_pet.x,_pet.y,_pet.xprevious,_pet.yprevious,_pet.hspeed,_pet.vspeed,_pet.speed,_pet.direction,
        _pet.right,_pet.walk,_pet.hiding,_pet.light,_pet.spr_shadow,_pet.can_take,_pet.sprite_index,
        _pet.image_index,_pet.image_speed,_pet.mask_index]
}
function scrNTTEFullPetOctoLocalSourcePair(_pet,_operation,_dir,_seed,_where) {
    var _before=scrNTTEFullInstances(all),_snapshot=scrNTTEFullAreaGeneratorSnapshot(_pet)
    random_set_seed(_seed)
    var _expected_return=undefined
    with(_pet) {
        if(_operation==0) scrNTTEFullPetOctoLocalLiteralStep()
        else if(_operation==1) scrNTTEFullPetOctoLocalLiteralAnim()
        else _expected_return=scrNTTEFullPetOctoLocalLiteralHurt(77,_dir,9)
    }
    var _expected_state=scrNTTEFullPetOctoLocalSourceState(_pet),_expected=scrNTTEFullPetEffectAdditiveCapture(_before)
    scrNTTEFullPetEffectAdditiveCleanup(_before);scrNTTEFullAreaGeneratorRestore(_snapshot)
    random_set_seed(_seed)
    var _actual_return=undefined
    with(_pet) {
        if(_operation==0) hooks.step()
        else if(_operation==1) hooks.anim()
        else _actual_return=hooks.hurt(77,_dir,9)
    }
    var _actual_state=scrNTTEFullPetOctoLocalSourceState(_pet),_actual=scrNTTEFullPetEffectAdditiveCapture(_before)
    assert(_operation!=2 || _actual_return==_expected_return,"Octo native hurt hook return changed")
    assert(array_length(_expected.rows)==0 && array_length(_actual.rows)==0,"Octo narrow local hook unexpectedly creates effects")
    scrNTTEFullPetEffectAdditiveExact(_expected_state,_actual_state,_where+"/pet-state")
    scrNTTEFullPetEffectAdditiveExact(_expected.tail,_actual.tail,_where+"/RNG6")
    scrNTTESmokeLog("OCTO LOCAL SOURCE EXACT "+_where+",raw-v="+json_stringify([_pet.hspeed/timescale,_pet.vspeed/timescale])+",state="+json_stringify(_actual_state)+",RNG6="+json_stringify(_actual.tail))
}

function scrNTTEFullPetOctoLocalSourceTests(_pet) {
    var _p=_pet.leader
    assert(os_type==os_windows && scrNTTESmokeEnabled() && !instance_exists(GenCont) && !instance_exists(FloorMaker)
        && instance_exists(_p),"Octo local oracle needs isolated native desktop context")
    var _before=scrNTTEFullInstances(all),_rng=random_get_seed(),_particles=UberCont.opt_prtcls
    var _saved_pet=scrNTTEFullAreaGeneratorSnapshot(_pet),_saved_p=scrNTTEFullAreaGeneratorSnapshot(_p),_saved_game=scrNTTEFullAreaGeneratorSnapshot(GameCont)
    var _park=[],_types=[Floor,Wall,InvisiWall,NTTEFullPitSquid]
    for(var _i=0;_i<array_length(_types);++_i) {
        var _ids=scrNTTEFullInstances(_types[_i])
        for(var _j=0;_j<array_length(_ids);++_j) if(array_get_index(_park,_ids[_j])<0) array_push(_park,_ids[_j])
    }
    for(var _i=0;_i<array_length(_park);++_i) instance_deactivate_object(_park[_i])
    var _seeds=[41017,41018,41019,41020,73103,73104,73105,73106],_directions=[0,90,180,270,-90,450]
    var _step_modes=["unhide","leader-plain","hide-negative","hide-contact","teleport-one","teleport-two","teleport-reverse","wall90","wall270","wall37","wall-with-path"]
    try {
        for(var _operation=0;_operation<3;++_operation) {
            var _count=_operation==0?11:(_operation==1?6:24)
            for(var _mode=0;_mode<_count;++_mode) for(var _s=0;_s<8;++_s) {
                scrNTTEFullPetEffectAdditiveCleanup(_before)
                scrNTTEFullAreaGeneratorRestore(_saved_pet);scrNTTEFullAreaGeneratorRestore(_saved_p);scrNTTEFullAreaGeneratorRestore(_saved_game)
                GameCont.area=area_desert;GameCont.underwater=false;UberCont.opt_prtcls=true
                _pet.x=150000;_pet.y=150064;_pet.xprevious=_pet.x;_pet.yprevious=_pet.y
                _pet.path=[];_pet.leader=noone;_pet.hiding=true;_pet.visible=true
                _pet.sprite_index=_pet.spr_hide;_pet.image_index=0.25;_pet.image_speed=0.4*timescale
                _pet.friction=0.1*timescale*timescale;_pet.direction=90;_pet.speed=7*timescale;_pet.right=(_s mod 2)==0?-1:1;_pet.walk=0
                _pet.light=true;_pet.spr_shadow=shd16;_pet.can_take=false
                var _dir=0,_label=string(_mode)
                if(_operation==0) {
                    _label=_step_modes[_mode]
                    if(_mode<=1) {_pet.leader=_p;_pet.hiding=_mode==0}
                    if(_mode>=2 && _mode<=6) {
                        var _floor=instance_create(150064,150016,Floor)
                        assert(instance_exists(_floor),"Octo local native Floor constructor failed")
                        _floor.sprite_index=scrNTTERefSprite("FloorTrenchB");_floor.image_index=0;_floor.image_xscale=1.5;_floor.image_yscale=1.25;_floor.image_speed=0
                        var _cx=(_floor.bbox_left+_floor.bbox_right)/2,_cy=(_floor.bbox_top+_floor.bbox_bottom)/2
                        if(_mode==3) {
                            _pet.x=_cx;_pet.y=_cy+4;_pet.xprevious=_pet.x;_pet.yprevious=_pet.y;_pet.image_index=1.25
                            assert(collision_point(_pet.x,_pet.y-4,_floor,false,false)==_floor,"Octo local genuine pit contact absent")
                        } else assert(collision_point(_pet.x,_pet.y-4,_floor,false,false)==noone,"Octo local negative contact witness absent")
                        if(_mode>=4) {
                            _pet.image_index=_pet.image_number-_pet.image_speed/2
                            if(_mode==5) {
                                var _floor2=instance_create(149904,150096,Floor)
                                assert(instance_exists(_floor2),"Octo local second real pit absent")
                                _floor2.sprite_index=scrNTTERefSprite("FloorTrenchB");_floor2.image_index=0;_floor2.image_xscale=0.75;_floor2.image_yscale=1.5;_floor2.image_speed=0
                            }
                            if(_mode==6) {_pet.image_index=1.25;_pet.image_speed=-4*timescale}
                            assert(_pet.image_index>=1 && (_pet.image_index+_pet.image_speed>=_pet.image_number || _pet.image_index+_pet.image_speed<0),"Octo local source anim_end witness absent")
                        }
                    }
                    if(_mode>=7) {
                        _pet.hiding=false;_pet.leader=_p;_pet.sprite_index=_pet.spr_idle
                        _pet.direction=_mode==8?270:(_mode==9?37:90);_pet.speed=6*timescale
                        var _wall=instance_create(_pet.x+1,_pet.y-8,Wall)
                        assert(instance_exists(_wall),"Octo local actual native Wall absent")
                        _wall.image_yscale=1.25
                        with(_pet) assert(place_meeting(x+hspeed,y+vspeed,Wall),"Octo local real wall collision absent")
                        if(_mode==10) _pet.path=[[_pet.x+16,_pet.y]]
                    }
                } else if(_operation==1) {
                    _pet.hiding=_mode==0;_pet.sprite_index=_pet.spr_hurt;_pet.image_index=0;_pet.speed=0
                    if(_mode==2) _pet.image_index=_pet.image_number-_pet.image_speed/2
                    if(_mode==3) _pet.image_speed=-0.4*timescale
                    if(_mode>=4) {_pet.sprite_index=_pet.spr_idle;_pet.speed=_mode==5?1.25*timescale:0}
                } else {
                    _pet.hiding=_mode>=12;_pet.sprite_index=_pet.hiding?_pet.spr_hide:_pet.spr_idle
                    _pet.image_index=2;_pet.speed=(_mode mod 2)==0?0:1.25*timescale
                    _dir=_directions[(_mode mod 12) div 2]
                }
                var _where="rate="+string(30/timescale)+",hook="+string(_operation)+",mode="+_label+",seed="+string(_seeds[_s])
                scrNTTEFullPetOctoLocalSourcePair(_pet,_operation,_dir,_seeds[_s],_where)
            }
        }
        scrNTTESmokeLog("SYSTEMS OCTO LOCAL SOURCE: registered Step/Anim/Hurt vs original literals;11+6+24 cases x8 seeds exact state/RNG6 @"+string(30/timescale))
    } finally {
        scrNTTEFullPetEffectAdditiveCleanup(_before)
        scrNTTEFullAreaGeneratorRestore(_saved_pet);scrNTTEFullAreaGeneratorRestore(_saved_p);scrNTTEFullAreaGeneratorRestore(_saved_game)
        for(var _i=0;_i<array_length(_park);++_i) instance_activate_object(_park[_i])
        UberCont.opt_prtcls=_particles;random_set_seed(_rng)
    }
}


// Independent source-literal Octo Alarm; no production hooks are replaced.
function scrNTTEFullPetOctoAlarmLiteralWalk(_dir,_time) {
    direction=_dir;walk=_time
    if(speed<0.1*timescale) speed=0.1*timescale
}
function scrNTTEFullPetOctoAlarmLiteralLook() {
    var _dir=((direction%360)+360)%360
    if(_dir<90 || _dir>270) right=1
    else if(_dir>90 && _dir<270) right=-1
}
function scrNTTEFullPetOctoAlarmLiteral(_leaderDir,_leaderDis) {
    if(instance_exists(leader)) {
        if(_leaderDis>64 || collision_line(x,y,leader.x,leader.y,Wall,false,false)) {
            if(!is_undefined(path_dir)) {
                scrNTTEFullPetOctoAlarmLiteralWalk(path_dir+orandom(10),6)
                scrNTTEFullPetOctoAlarmLiteralLook()
                return 1+irandom(walk)+irandom(6)
            } else {
                scrNTTEFullPetOctoAlarmLiteralWalk(_leaderDir+orandom(20),random_range(5,15))
                scrNTTEFullPetOctoAlarmLiteralLook()
            }
            return walk+random(5)
        } else {
            motion_add(_leaderDir+orandom(60),(1.5+random(1.5))*timescale)
            scrNTTEFullPetOctoAlarmLiteralLook()
            if(array_length(arc_list) && variable_instance_exists(leader,"index")) {
                var _enemy=instance_nearest(x,y,enemy)
                if(instance_exists(_enemy) && point_distance(x,y,_enemy.x,_enemy.y)<160) {
                    var _mx=leader.x+lengthdir_x(KeyCont.dis_fire[leader.index],KeyCont.dir_fire[leader.index])
                    var _my=leader.y+lengthdir_y(KeyCont.dis_fire[leader.index],KeyCont.dir_fire[leader.index])
                    motion_add(point_direction(x,y,_mx,_my)+orandom(10),2*timescale)
                }
            }
            return 20+random(10)
        }
    } else {
        if(scrNTTEFullAreaKey(GameCont.area)=="trench" && !hiding) {
            var _meet=false,_owner=id
            with(Floor) if(sprite_index==scrNTTERefSprite("FloorTrenchB") && collision_point(_owner.x,_owner.y-4,id,false,false)!=noone) _meet=true
            if(_meet) {
                hiding=true;sprite_index=spr_hide;image_index=0
                repeat(4+irandom(4)) with(scrNTTEFullPetEffectFaceSourceReference(x,y,2,Dust)) waterbubble=random(2)<1
            } else {
                var _dir=-1,_disMax=infinity
                with(Floor) if(sprite_index==scrNTTERefSprite("FloorTrenchB")) {
                    var _x=bbox_center_x,_y=bbox_center_y,_dis=point_distance(other.x,other.y,_x,_y)
                    if(_dis<_disMax && !collision_line(other.x,other.y,_x,_y,Wall,false,false)) {
                        _disMax=_dis;_dir=point_direction(other.x,other.y,_x,_y)
                    }
                }
                if(_dir>=0) {
                    scrNTTEFullPetOctoAlarmLiteralWalk(_dir,random_range(10,15))
                    scrNTTEFullPetOctoAlarmLiteralLook()
                    return walk+random(5)
                }
            }
        }
        instance_create(x,y,Bubble)
        scrNTTEFullPetOctoAlarmLiteralWalk(direction+orandom(60),random_range(5,15))
        scrNTTEFullPetOctoAlarmLiteralLook()
        return walk+random_range(30,60)
    }
}
function scrNTTEFullPetOctoAlarmLiteralDispatch() {
    ntte_pet_alarm=30
    var _dir=0,_dis=0
    if(instance_exists(leader)) {_dir=point_direction(x,y,leader.x,leader.y);_dis=point_distance(x,y,leader.x,leader.y)}
    path_dir=scrNTTEFullPathDirection(path,x,y,path_wall)
    var _next=scrNTTEFullPetOctoAlarmLiteral(_dir,_dis)
    if(is_numeric(_next) && _next!=0) ntte_pet_alarm=_next
}
function scrNTTEFullPetOctoAlarmState(_pet) {
    with(_pet) {
        var _row=[x,y,xprevious,yprevious,hiding,sprite_index,image_index,hspeed,vspeed,speed,direction,walk,right,ntte_pet_alarm,!is_undefined(path_dir)]
        if(!is_undefined(path_dir)) array_push(_row,path_dir)
        return _row
    }
    return []
}

function scrNTTEFullPetOctoAlarmSourceTests(_pet) {
    assert(os_type==os_windows && scrNTTESmokeEnabled() && !instance_exists(GenCont) && !instance_exists(FloorMaker),"Octo oracle needs isolated actual desktop context")
    var _p=_pet.leader
    assert(instance_exists(_p) && _p.index>=0 && _p.index<4,"Octo oracle lacks indexed real leader")
    var _before=scrNTTEFullInstances(all),_seed=random_get_seed(),_particles=UberCont.opt_prtcls
    var _saved_pet=scrNTTEFullAreaGeneratorSnapshot(_pet),_saved_player=scrNTTEFullAreaGeneratorSnapshot(_p),_saved_game=scrNTTEFullAreaGeneratorSnapshot(GameCont)
    var _input=[KeyCont.dir_fire[_p.index],KeyCont.dis_fire[_p.index],KeyCont.touch[_p.index],KeyCont.gamepad[_p.index],KeyCont.keyboard[_p.index]]
    var _park=[],_types=[Floor,Wall,InvisiWall,enemy]
    for(var _i=0;_i<array_length(_types);++_i) {
        var _ids=scrNTTEFullInstances(_types[_i])
        for(var _j=0;_j<array_length(_ids);++_j) if(array_get_index(_park,_ids[_j])<0) array_push(_park,_ids[_j])
    }
    for(var _i=0;_i<array_length(_park);++_i) instance_deactivate_object(_park[_i])
    var _seeds=[41017,41018,41019,41020,73103,73104,73105,73106]
    var _modes=["path","direct","near-no-arc","near-arc-touch","near-arc-pad","arc-range160","arc-range200","idle-dry","hiding-idle","pit-dry","pit-water","pit-particles-off","pit-center","pit-blocked"]
    try {
        for(var _mode=0;_mode<array_length(_modes);++_mode) for(var _s=0;_s<8;++_s) {
            scrNTTEFullPetEffectAdditiveCleanup(_before)
            scrNTTEFullAreaGeneratorRestore(_saved_pet);scrNTTEFullAreaGeneratorRestore(_saved_player);scrNTTEFullAreaGeneratorRestore(_saved_game)
            GameCont.area=area_desert;GameCont.underwater=false;UberCont.opt_prtcls=true
            _pet.x=150000;_pet.y=150064;_pet.xprevious=_pet.x;_pet.yprevious=_pet.y
            _pet.direction=(_s mod 2)==0?90:270;_pet.speed=0;_pet.right=-1;_pet.walk=0
            _pet.visible=true;_pet.hiding=false;_pet.leader=noone;_pet.path=[];_pet.path_dir=undefined;_pet.arc_list=[];_pet.ntte_pet_alarm=0
            _pet.friction=0.1*timescale*timescale;_pet.sprite_index=_pet.spr_idle;_pet.image_index=0
            _p.x=_pet.x+128;_p.y=_pet.y;_p.xprevious=_p.x;_p.yprevious=_p.y
            KeyCont.dir_fire[_p.index]=19+47*_s;KeyCont.dis_fire[_p.index]=40+13*_s
            KeyCont.keyboard[_p.index]=false;KeyCont.touch[_p.index]=_mode==3;KeyCont.gamepad[_p.index]=_mode==4
            if(_mode<=6) {
                _pet.leader=_p
                if(_mode==0) _pet.path=[[_pet.x+16,_pet.y-16],[_pet.x+32,_pet.y-16]]
                if(_mode>=2) {_p.x=_pet.x+32;_p.xprevious=_p.x}
                if(_mode>=3) {
                    _pet.arc_list=[{id:_p,x:_p.x,y:_p.y}]
                    var _distance=_mode==5?160:(_mode==6?200:64),_enemy=instance_create(_pet.x+_distance,_pet.y,Bandit)
                    assert(instance_exists(_enemy) && point_distance(_pet.x,_pet.y,_enemy.x,_enemy.y)==_distance,"Octo enemy range witness absent")
                }
            }
            if(_mode==8) {_pet.hiding=true;_pet.sprite_index=_pet.spr_hide}
            if(_mode>=9) {
                var _floor=instance_create(150080,150016,Floor)
                assert(instance_exists(_floor),"Octo native Floor constructor failed")
                _floor.sprite_index=scrNTTERefSprite("FloorTrenchB");_floor.image_index=0;_floor.image_xscale=1.5;_floor.image_yscale=1.25;_floor.image_speed=0
                GameCont.area=scrNTTEFullAreaId("trench")
                var _cx=(_floor.bbox_left+_floor.bbox_right)/2,_cy=(_floor.bbox_top+_floor.bbox_bottom)/2
                if(_mode<=11) {
                    _pet.x=_cx;_pet.y=_cy+4;_pet.xprevious=_pet.x;_pet.yprevious=_pet.y
                    assert(collision_point(_pet.x,_pet.y-4,_floor,false,false)==_floor,"Octo positive actual pit collision missing")
                    GameCont.underwater=_mode==10;UberCont.opt_prtcls=_mode!=11
                } else {
                    assert(collision_point(_pet.x,_pet.y-4,_floor,false,false)==noone && (_cx!=_floor.x || _cy!=_floor.y),"Octo bbox-center negative collision witness missing")
                    if(_mode==13) {
                        var _wall=instance_create((_pet.x+_cx)/2,(_pet.y+_cy)/2,Wall)
                        assert(instance_exists(_wall) && collision_line(_pet.x,_pet.y,_cx,_cy,Wall,false,false)!=noone,"Octo native blocked pit witness absent")
                    }
                }
            }
            var _case_before=scrNTTEFullInstances(all),_case_pet=scrNTTEFullAreaGeneratorSnapshot(_pet)
            var _where="rate="+string(30/timescale)+",mode="+_modes[_mode]+",seed="+string(_seeds[_s])
            random_set_seed(_seeds[_s]);with(_pet) scrNTTEFullPetOctoAlarmLiteralDispatch()
            var _state=scrNTTEFullPetOctoAlarmState(_pet),_expected=scrNTTEFullPetEffectAdditiveCapture(_case_before),_dust=0,_bubble=0
            for(var _i=0;_i<array_length(_expected.rows);++_i) {if(_expected.rows[_i][0]==Dust) _dust++;if(_expected.rows[_i][0]==Bubble) _bubble++}
            if(_mode==9) assert(_dust>=4 && _dust<=8 && _bubble==1,"Octo source dry hiding Dust/Bubble count changed")
            if(_mode==10) assert(_dust==0 && _bubble>=5 && _bubble<=9,"Octo source underwater replacement Bubble count changed")
            if(_mode==11 || _mode==7 || _mode==8 || _mode==13) assert(_dust==0 && _bubble==1,"Octo source unconditional fallback Bubble absent")
            if(_mode==12) assert(array_length(_expected.rows)==0 && _pet.walk>=10 && _pet.walk<=15,"Octo source pit-follow timing/effects changed")
            if(_mode==0) assert(!is_undefined(_pet.path_dir) && _pet.ntte_pet_alarm>=1 && _pet.ntte_pet_alarm<=13,"Octo source path dispatch/timer witness absent")
            if(_mode==1) assert(is_undefined(_pet.path_dir) && _pet.ntte_pet_alarm>=_pet.walk && _pet.ntte_pet_alarm<_pet.walk+5,"Octo source direct-follow timer witness absent")
            scrNTTEFullPetEffectAdditiveCleanup(_case_before);scrNTTEFullAreaGeneratorRestore(_case_pet)
            random_set_seed(_seeds[_s]);with(_pet) scrNTTEFullPetAlarm()
            var _actual_state=scrNTTEFullPetOctoAlarmState(_pet),_actual=scrNTTEFullPetEffectAdditiveCapture(_case_before)
            scrNTTEFullPetEffectAdditiveExact(_state,_actual_state,_where+"/pet-state")
            scrNTTEFullPetEffectAdditiveExact(_expected.rows,_actual.rows,_where+"/newborn-fields")
            scrNTTEFullPetEffectAdditiveExact(_expected.tail,_actual.tail,_where+"/RNG6")
            scrNTTESmokeLog("OCTO ALARM SOURCE EXACT "+_where+",born="+string(array_length(_actual.rows))+",raw-v="+json_stringify([_pet.hspeed/timescale,_pet.vspeed/timescale])+",state="+json_stringify(_actual_state)+",RNG6="+json_stringify(_actual.tail))
        }
        scrNTTESmokeLog("SYSTEMS OCTO ALARM SOURCE: common Alarm registered production hook,14 native modes x8 seeds,exact state/newborn/RNG6 @"+string(30/timescale))
    } finally {
        scrNTTEFullPetEffectAdditiveCleanup(_before)
        scrNTTEFullAreaGeneratorRestore(_saved_pet);scrNTTEFullAreaGeneratorRestore(_saved_player);scrNTTEFullAreaGeneratorRestore(_saved_game)
        for(var _i=0;_i<array_length(_park);++_i) instance_activate_object(_park[_i])
        KeyCont.dir_fire[_p.index]=_input[0];KeyCont.dis_fire[_p.index]=_input[1];KeyCont.touch[_p.index]=_input[2];KeyCont.gamepad[_p.index]=_input[3];KeyCont.keyboard[_p.index]=_input[4]
        UberCont.opt_prtcls=_particles;random_set_seed(_seed)
    }
}
