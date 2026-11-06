// Source petlib.Scorpion_*; this pet is distinct from hostile SilverScorpion.
function scrNTTEFullPetSpeciesInit() {
    if(!variable_global_exists("ntte_full_pet_species")) global.ntte_full_pet_species={}
    variable_struct_set(global.ntte_full_pet_species,"Scorpion",scrNTTEFullPetScorpionCreate)
    variable_struct_set(global.ntte_full_pet_species,"Parrot",scrNTTEFullPetParrotCreate)
    variable_struct_set(global.ntte_full_pet_species,"CoolGuy",scrNTTEFullPetCoolGuyCreate)
    variable_struct_set(global.ntte_full_pet_species,"Orchid",scrNTTEFullPetOrchidCreate)
    variable_struct_set(global.ntte_full_pet_species,"Octo",scrNTTEFullPetOctoCreate)
    variable_struct_set(global.ntte_full_pet_species,"Mimic",scrNTTEFullPetMimicCreate)
    variable_struct_set(global.ntte_full_pet_species,"Salamander",scrNTTEFullPetSalamanderCreate)
    variable_struct_set(global.ntte_full_pet_species,"Slaughter",scrNTTEFullPetSlaughterCreate)
    variable_struct_set(global.ntte_full_pet_species,"Spider",scrNTTEFullPetSpiderCreate)
    variable_struct_set(global.ntte_full_pet_species,"Prism",scrNTTEFullPetPrismCreate)
    variable_struct_set(global.ntte_full_pet_species,"Twins",scrNTTEFullPetTwinsCreate)
    variable_struct_set(global.ntte_full_pet_species,"Cuz",scrNTTEFullPetCuzCreate)
    variable_struct_set(global.ntte_full_pet_species,"Weapon",scrNTTEFullPetWeaponCreate)
    variable_struct_set(global.ntte_full_pet_species,"Guardian",scrNTTEFullPetGuardianCreate)
}
function scrNTTEFullPetScorpionCreate() {
    spr_idle=scrNTTERefSprite("PetScorpionIdle"); spr_walk=scrNTTERefSprite("PetScorpionWalk")
    spr_hurt=scrNTTERefSprite("PetScorpionHurt"); spr_dead=scrNTTERefSprite("PetScorpionDead")
    spr_icon=scrNTTERefSprite("PetScorpionIcon"); spr_fire=scrNTTERefSprite("PetScorpionFire"); spr_shield=scrNTTERefSprite("PetScorpionShield")
    hitid=[spr_idle,"SILVER SCORPION"]; snd_hurt=sndScorpionMelee; snd_dead=sndScorpionDie
    snd_fire=sndScorpionFireStart; snd_shield=sndGoldScorpionHurt; spr_shadow_y=-1
    mask_index=mskFrogEgg; max_hp=12; maxspeed=3.4; target=noone; my_venom=noone; scorpion_city=true
    array_push(history,"scorpion_city"); stat.blocked=scrNTTEFullValue(stat,"blocked",0)
    hooks={anim:method(id,scrNTTEFullPetScorpionAnim),step:method(id,scrNTTEFullPetScorpionStep),alarm:method(id,scrNTTEFullPetScorpionAlarm),hurt:method(id,scrNTTEFullPetScorpionHurt),death:method(id,scrNTTEFullPetScorpionDeath)}
}
function scrNTTEFullPetScorpionAnim() {
    if((sprite_index!=spr_hurt && sprite_index!=spr_shield) || image_index>=sprite_get_number(sprite_index)-image_speed)
        sprite_index=instance_exists(my_venom) ? spr_fire:(walk>0 ? spr_walk:spr_idle)
}
function scrNTTEFullPetScorpionStep() {
    var _self=id
    with(hitme) if(id!=_self && place_meeting(x,y,_self)) {
        var _away=point_direction(_self.x,_self.y,x,y)
        if(size<_self.size) motion_add(_away,timescale)
        with(_self) motion_add(_away+180,timescale)
    }
    if(instance_exists(my_venom) && my_venom.charge) {
        if(instance_exists(target)) {
            my_venom.direction+=angle_difference(point_direction(my_venom.x,my_venom.y,target.x,target.y),my_venom.direction)*0.1*timescale
            my_venom.image_angle=my_venom.direction; my_venom.depth=depth-(my_venom.direction>=180)
        }
        direction=my_venom.direction; right=lengthdir_x(1,direction)>=0 ? 1:-1
        for(var _i=0;_i<array_length(path_wall);++_i) if(place_meeting(x+hspeed,y+vspeed,path_wall[_i])) {
            if(place_meeting(x+hspeed,y,path_wall[_i])) hspeed*=-1
            if(place_meeting(x,y+vspeed,path_wall[_i])) vspeed*=-1
            right=lengthdir_x(1,direction)>=0 ? 1:-1
        }
    }
}
function scrNTTEFullPetScorpionAlarm(_leader_dir,_leader_dis) {
    ntte_pet_alarm=20+irandom(10)
    target=noone; var _distance=infinity,_pet=id
    with(hitme) if(id!=_pet && team!=_pet.team && team!=team_none && mask_index!=mskNone
        && (instance_is(id,enemy) || instance_is(id,Player) || instance_is(id,Ally) || instance_is(id,SentryGun))) {
        var _d=point_distance(x,y,_pet.x,_pet.y)
        if(_d<_distance) { _distance=_d; _pet.target=id }
    }
    var _seen=instance_exists(target) && !collision_line(x,y,target.x,target.y,Wall,false,false)
    if(sprite_index==spr_shield) return 0
    if(instance_exists(leader)) {
        if(!is_undefined(path_dir) && (_leader_dis>48 || !instance_exists(target) || !_seen)) {
            scrNTTEFullPetWalk(path_dir+orandom(15),15); right=lengthdir_x(1,direction)>=0 ? 1:-1
            return 1+irandom(max(0,walk))
        }
        if(_leader_dis>28) { scrNTTEFullPetWalk(_leader_dir+orandom(20),random_range(10,30)); right=lengthdir_x(1,direction)>=0 ? 1:-1 }
        if(instance_exists(target) && !instance_exists(my_venom) && _seen && _leader_dis<=96
            && !collision_line(leader.x,leader.y,target.x,target.y,Wall,false,false) && random(3)<2) {
            snd_play(snd_fire,1.2,3)
            var _aim=point_direction(x,y,target.x,target.y)
            right=lengthdir_x(1,_aim)>=0 ? 1:-1
            my_venom=scr_projectile_create(x,y,NTTEFullVenomBlast,_aim)
        }
    } else {
        scrNTTEFullPetWalk(random(360),random_range(10,20)); right=lengthdir_x(1,direction)>=0 ? 1:-1
        return 20+irandom(20)
    }
    return 0
}
function scrNTTEFullPetScorpionHurt(_damage,_direction,_force=0) {
    if(hp>0 && sprite_index==spr_fire && instance_exists(leader)) return false
    motion_add(_direction,2*timescale); nexthurt=current_frame+6; walk=0
    sprite_index=spr_shield; image_index=0
    var _fx=instance_create(x,y,ThrowHit); _fx.depth=depth-1
    snd_play(snd_shield,1.4+random(0.4),1.8); snd_play(sndCursedPickupDisappear,0.8+random(0.4),1.8)
    stat.blocked+=1
    return true
}
function scrNTTEFullPetScorpionDeath() {
    snd_play(snd_dead,0.8+random(0.1),1.5); snd_play(sndGoldScorpionDead,1.2+random(0.2),2.5)
    var _start=random(360)
    for(var _d=_start;_d<_start+360;_d+=72) {
        repeat(irandom_range(8,12)) scr_projectile_create(x,y,NTTEVenomPellet,_d+orandom(12),8+random(8))
        var _fx=instance_create(x,y,AcidStreak)
        with(_fx) motion_set(_d,4*timescale)
    }
}
function scrNTTEFullPetInterceptHit(_target,_damage,_source) {
    if(!instance_exists(_target) || !instance_is(_target,NTTEFullPet)) return false
    if(!_target.visible || (instance_exists(_source) && instance_is(_source,Corpse))) return true
    _target.ntte_pet_hit_source=_source
    var _hook=scrNTTEFullValue(_target.hooks,"hurt",undefined)
    var _direction=instance_exists(_source) ? point_direction(_source.x,_source.y,_target.x,_target.y):0
    var _force=scrNTTEFullValue(_source,"force",scrNTTEFullValue(_source,"knockback_speed",0))
    if(_target.max_hp<=0) {
        if(_target.sprite_index!=_target.spr_hurt && _force>0) {
            if(is_callable(_hook)) _hook(_damage,_direction,_force)
            else { _target.sprite_index=_target.spr_hurt; _target.image_index=0 }
        }
        return true
    }
    if(instance_exists(_source) && instance_is(_source,Debris)) return true
    return is_callable(_hook) ? _hook(_damage,_direction,_force):false
}
function scrNTTEFullPetScorpionTests() {
    var _p=instance_find(Player,0),_old_pets=scrNTTEFullValue(_p,"ntte_pet",[]),_old_max=scrNTTEFullValue(_p,"ntte_pet_max",undefined)
    _p.ntte_pet=[]; _p.ntte_pet_max=1
    var _pet=scrNTTEFullPetCreate(_p.x,_p.y,"Scorpion"),_source=instance_create(_p.x+32,_p.y,Bandit)
    assert(_pet.pet=="Scorpion" && _pet.hp==12 && _pet.scorpion_city && _pet.maxspeed==3.4,
        "Scorpion pet constructor/source stats changed")
    scrNTTEFullPetTake(_pet,_p)
    _pet.sprite_index=_pet.spr_idle; _pet.nexthurt=0
    var _blocked_before=_pet.stat.blocked
    with(_source) scr_hit(_pet,3)
    assert(_pet.hp==12 && _pet.sprite_index==_pet.spr_shield && _pet.stat.blocked==_blocked_before+1,
        "Scorpion idle shield failed to block via real native hit pipeline")
    _pet.sprite_index=_pet.spr_fire; _pet.nexthurt=0
    with(_source) scr_hit(_pet,3)
    assert(_pet.hp==9,"Scorpion firing hurt window incorrectly blocked real damage")
    _pet.sprite_index=_pet.spr_idle
    var _seed=random_get_seed(); random_set_seed(170721)
    repeat(64) {
        with(_pet) scrNTTEFullPetScorpionAlarm(0,0)
        if(instance_exists(_pet.my_venom)) break
    }
    assert(instance_exists(_pet.my_venom) && _pet.my_venom.creator==_pet && _pet.my_venom.team==_p.team,
        "Scorpion pet did not create the original charged venom blast with allied ownership")
    instance_destroy(_pet.my_venom,false)
    var _before=instance_number(NTTEVenomPellet)
    with(_pet) scrNTTEFullPetScorpionDeath()
    var _after=instance_number(NTTEVenomPellet)-_before
    assert(_after>=40 && _after<=60,"Scorpion pet death lost original five groups of 8..12 venom pellets")
    with(NTTEVenomPellet) if(creator==_pet) instance_destroy(id,false)
    random_set_seed(_seed)
    var _save=json_parse(json_stringify(scrNTTEFullPetExport())),_found=_pet.stat.found
    assert(scrNTTEFullPetImport(_save),"Pet continuation schema failed")
    _pet=_p.ntte_pet[0]
    assert(instance_exists(_pet) && _pet.pet=="Scorpion" && _pet.leader==_p && _pet.hp==9
        && _pet.stat.found==_found && _pet.scorpion_city && is_callable(_pet.hooks.alarm),
        "Pet continuation lost ownership/history/stats or failed to reconstruct species methods")
    instance_destroy(_source,false); instance_destroy(_pet)
    _p.ntte_pet=_old_pets; _p.ntte_pet_max=_old_max
    scrNTTESmokeLog("SYSTEMS PET SCORPION: stats/city, real idle shield/firing damage, allied charged VenomBlast, five-way death pellets, JSON continuation owner/stats/species methods OK")
}
