// Source petlib.Orchid and ntte_setup_Orchid_Rad; telib.rad_path.
function scrNTTEFullPetOrchidCreate() {
    spr_idle=scrNTTERefSprite("PetOrchidIdle"); spr_walk=scrNTTERefSprite("PetOrchidWalk")
    spr_hurt=scrNTTERefSprite("PetOrchidHurt"); spr_icon=scrNTTERefSprite("PetOrchidIcon")
    raddrop=0; skill_rads=60; skill_inst=[]; stat.mutations=scrNTTEFullValue(stat,"mutations",0)
    hooks={step:method(id,scrNTTEFullPetOrchidStep),draw:method(id,scrNTTEFullPetOrchidDraw)}
    array_push(history,"raddrop")
}
function scrNTTEFullPetOrchidStep() {
    wave+=timescale
    if(raddrop>=skill_rads) {
        raddrop-=skill_rads
        var _orb=scrNTTEFullSystemsCreate("OrchidBall",x,y); _orb.creator=id; stat.mutations++
        repeat(5) {
            var _fx=instance_create(x+hspeed+orandom(12),y+vspeed+orandom(12),CaveSparkle)
            _fx.direction=90; _fx.speed=random(1)*timescale; _fx.depth=-8
            _fx.image_speed=lerp(0.2,0.4,_fx.speed/max(timescale,0.0001))*timescale
            _fx.hspeed+=hspeed/1.5; _fx.vspeed+=vspeed/1.5
        }
        snd_play(sndFlyFire,1.5,0.8); snd_play(sndCrownRandom,0.8+random(0.3),0.2)
    }
    skill_inst=[]; var _pet=id
    with(NTTEFullOrchidBall) if(creator==_pet) array_push(_pet.skill_inst,id)
    with(NTTEFullOrchidSkill) if(creator==_pet) array_push(_pet.skill_inst,id)
    if(random(15/(1+0.5*array_length(skill_inst)))<timescale) {
        var _fx=scrNTTEFullSystemsCreate("VaultFlowerSparkle",x+orandom(8),y+orandom(8))
        _fx.direction=90; _fx.speed=0.1*timescale; _fx.depth=depth+choose(-1,-1,1)
    }
}
function scrNTTEFullPetOrchidDraw(_spr,_img,_x,_y,_xsc,_ysc,_ang,_col,_alp) {
    draw_sprite_ext(_spr,_img,_x,_y,_xsc,_ysc,_ang,_col,_alp)
    var _scale=lerp(1.5,1.8,0.5+0.5*sin(wave/10)),_alpha=lerp(0.05,0.25,(raddrop+skill_rads*array_length(skill_inst))/skill_rads)
    gpu_set_blendmode(bm_add)
    draw_sprite_ext(_spr,_img,_x,_y,_xsc*_scale,_ysc*_scale,_ang,_col,_alp*_alpha)
    gpu_set_blendmode(bm_normal)
}
function scrNTTEFullPetOrchidRadSetup(_rad) {
    if(!instance_exists(_rad)) return false
    var _nearest=noone,_distance=infinity
    with(NTTEFullPet) if(pet=="Orchid" && visible && instance_exists(leader) && !array_length(skill_inst)) {
        var _d=point_distance(x,y,_rad.x,_rad.y)
        if(_d<_distance) { _distance=_d; _nearest=id }
    }
    if(!instance_exists(_nearest)) return false
    var _fx=scrNTTEFullSystemsCreate("VaultFlowerSparkle",_rad.x+_rad.hspeed/2,_rad.y+_rad.vspeed/2)
    _fx.direction=_rad.direction; _fx.speed=0.4*timescale; _fx.ntte_sparkle_left=random_range(20,30); _fx.ntte_sparkle_max=_fx.ntte_sparkle_left
    _fx.image_alpha*=2
    scrNTTEFullRadPathAssign(_rad,_nearest)
    return true
}
function scrNTTEFullRadPathAssign(_rad,_target,_heal=0) {
    if(!instance_exists(_rad)) return undefined
    // Source rad_path only claims an instance once; later callers may adjust
    // its returned record's heal, but cannot silently replace its owner.
    if(is_struct(scrNTTEFullValue(_rad,"ntte_full_rad_path",undefined))) return _rad.ntte_full_rad_path
    var _state={target:_target,path:[],can_path:true,heal:_heal}
    _rad.ntte_full_rad_path=_state
    return _state
}
// Rad context, called after native animation update and before native player
// attraction. A claimed rad is handled here until completion/target loss.
function scrNTTEFullRadPathStep() {
    var _state=scrNTTEFullValue(id,"ntte_full_rad_path",undefined)
    if(!is_struct(_state)) return false
    var _target=_state.target
    if(!instance_exists(_target)) { ntte_full_rad_path=undefined; return false }
    var _tx=_target.x,_ty=_target.y,_path=_state.path
    if(array_length(_path)) {
        var _dir=collision_line(x,y,_tx,_ty,Wall,false,false) ? scrNTTEFullPathDirection(_path,x,y,Wall):point_direction(x,y,_tx,_ty)
        if(!is_undefined(_dir)) {
            speed=min(speed+random(max(friction,2*timescale*timescale)),12*timescale)
            direction+=angle_difference(_dir,direction)*min(1,max(0.2,16/max(0.0001,point_distance(x,y,_tx,_ty)))*timescale)
            image_angle+=speed
            if(place_meeting(x+hspeed,y+vspeed,Wall)) {
                var _min=min(speed,2*timescale)
                if(place_meeting(x+hspeed,y,Wall)) hspeed=0
                if(place_meeting(x,y+vspeed,Wall)) vspeed=0
                speed=max(_min,speed)
                if(place_meeting(x+hspeed,y,Wall)) hspeed=0
                if(place_meeting(x,y+vspeed,Wall)) vspeed=0
            }
        } else _state.path=[]
        if(place_meeting(x,y,_target) || point_distance(x,y,_tx,_ty)<=speed) {
            if(instance_is(_target,Player)) { speed=0; ntte_full_rad_path=undefined; return false }
            if(variable_instance_exists(_target,"raddrop")) _target.raddrop+=(object_index==BigRad ? 10:1)
            if(_state.heal>0) {
                _target.hp+=_state.heal; snd_play(sndHPPickup,1,0.3)
                var _fx=instance_create(random_range(_target.bbox_left,_target.bbox_right),random_range(_target.bbox_top,_target.bbox_bottom),AnimParticle)
                _fx.sprite_index=random(3)<1 ? scrNTTERefSprite("BossHealFX"):sprFrogHeal; _fx.depth=_target.depth-1
            }
            snd_play(sndRadPickup,1,0.5)
            var _eat=instance_create(x,y,RadEat)
            if(sprite_index==sprBigRad) _eat.sprite_index=sprEatBigRad
            instance_destroy(); return true
        }
    } else if(speed<=friction*2) {
        speed=max(speed,friction)
        if(!_state.can_path && !collision_line(x,y,_tx,_ty,Wall,false,false)) _state.can_path=true
        if(_state.can_path && !scrNTTEFullPathReaches(_path,_tx,_ty,Wall)) {
            _path=scrNTTEFullPathCreate(x,y,_tx,_ty,Wall)
            _path=scrNTTEFullPathShrink(_path,Wall,2); _state.path=_path; _state.can_path=false
            var _source=id
            with(Rad) {
                var _other_state=scrNTTEFullValue(id,"ntte_full_rad_path",undefined)
                if(id!=_source && is_struct(_other_state) && _other_state.target==_target && !array_length(_other_state.path)
                    && !collision_line(x,y,_source.x,_source.y,Wall,false,false)) {
                    _other_state.path=_path; _other_state.can_path=false
                }
            }
        }
    }
    return true
}
function scrNTTEFullPetOrchidTests() {
    var _p=instance_find(Player,0),_old_pets=scrNTTEFullValue(_p,"ntte_pet",[])
    _p.ntte_pet=[]
    var _pet=scrNTTEFullPetCreate(_p.x+64,_p.y,"Orchid")
    scrNTTEFullPetTake(_pet,_p)
    var _before=_pet.stat.mutations,_small=instance_create(_pet.x,_pet.y,Rad),_big=instance_create(_pet.x,_pet.y,BigRad)
    scrNTTEFullPetOrchidRadSetup(_small); scrNTTEFullPetOrchidRadSetup(_big)
    _small.ntte_full_rad_path.path=[[_pet.x,_pet.y]]; _big.ntte_full_rad_path.path=[[_pet.x,_pet.y]]
    with(_small) scrNTTEFullRadPathStep()
    with(_big) scrNTTEFullRadPathStep()
    assert(!instance_exists(_small) && !instance_exists(_big) && _pet.raddrop==11,
        "Orchid actual normal/big rad path did not deliver 1/10 radiation")
    _pet.raddrop=65
    with(_pet) scrNTTEFullPetOrchidStep()
    var _orb=noone
    with(NTTEFullOrchidBall) if(creator==_pet) _orb=id
    assert(instance_exists(_orb) && _pet.raddrop==5 && _pet.stat.mutations==_before+1 && array_length(_pet.skill_inst)==1,
        "Orchid 60-rad budget did not produce its real owned mutation ball")
    var _new=instance_create(_pet.x+8,_pet.y,Rad)
    assert(!scrNTTEFullPetOrchidRadSetup(_new),"Orchid collected new rads while a source-owned skill ball remained active")
    instance_destroy(_new,false); instance_destroy(_orb,false); instance_destroy(_pet); _p.ntte_pet=_old_pets
    scrNTTESmokeLog("SYSTEMS PET ORCHID: actual 1/10 rad delivery, 60-rad real owned ball/stat/budget, active-ball collection gate OK")
}
