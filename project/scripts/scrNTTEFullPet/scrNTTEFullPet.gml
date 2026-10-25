// Source: tegeneral.Pet/PetRevive and telib.pet_create. Species are registered
// separately; unknown species throw instead of becoming a generic ally.
function scrNTTEFullPetCreateEvent() {
    spr_idle=scrNTTERefSprite("PetParrotIdle"); spr_walk=scrNTTERefSprite("PetParrotWalk")
    spr_hurt=scrNTTERefSprite("PetParrotHurt"); spr_dead=mskNone; spr_icon=scrNTTERefSprite("PetParrotIcon")
    sprite_index=spr_idle; mask_index=mskPlayer; image_speed=0.4*timescale
    spr_shadow=shd24; spr_shadow_x=0; spr_shadow_y=0; right=choose(-1,1); bskin=0; depth=-2
    spr_bubble=sprPlayerBubble; spr_bubble_pop=sprPlayerBubblePop; spr_bubble_x=0; spr_bubble_y=0
    snd_hurt=sndAllyHurt; snd_dead=sndAllyDead; hitid=[spr_idle,""]
    team=team_none; size=1; push=1; max_hp=0; hp=0; nexthurt=0; raddrop=0
    leader=noone; can_take=true; can_path=true; path=[]; path_dir=undefined; path_delay=0
    path_wall=[Wall,InvisiWall]; direction=random(360); friction=0.4*timescale*timescale
    wave=random(1000); walk=0; walkspeed=2; maxspeed=3; pet_loops=0
    stat={found:0,owned:0}; stat_found=true; light=true; light_radius=[32,96]; history=["bskin","team","stat_found"]
    mask_store=undefined; portal_angle=0; portal_inst=noone; corpse=true; corpse_inst=noone; revive=noone
    pet=""; mod_type="mod"; mod_name="petlib"; hooks={}; ntte_pet_alarm=20+random(10); persistent=false
    ntte_game=instance_exists(GameCont) ? instance_find(GameCont,0):noone
    prompt=scrNTTEFullPromptCreate(id,"",mskShield)
}
function scrNTTEFullPetCreate(_x,_y,_pet) {
    scrNTTEFullPetSpeciesInit()
    if(!variable_global_exists("ntte_full_pet_species") || !variable_struct_exists(global.ntte_full_pet_species,_pet))
        throw "NTTE pet species is not implemented: "+_pet
    var _pet_inst=instance_create(_x,_y,NTTEFullPet),_init=variable_struct_get(global.ntte_full_pet_species,_pet)
    if(!variable_global_exists("ntte_full_progress")) scrNTTEFullProgressLoad()
    var _stat_key="pet:"+_pet+".petlib.mod"
    if(!is_struct(scrNTTEFullValue(global.ntte_full_progress.stats,_stat_key,undefined)))
        variable_struct_set(global.ntte_full_progress.stats,_stat_key,{found:0,owned:0})
    with(_pet_inst) {
        pet=_pet; stat=variable_struct_get(global.ntte_full_progress.stats,_stat_key)
        _init(); if(hp==0) hp=max_hp; sprite_index=scrNTTEFullValue(hooks,"initial_sprite",spr_idle)
        scrNTTEFullPetSetSkin(id,bskin)
    }
    return _pet_inst
}
// Pure source sprite lookup for vat previews. Constructors are intentionally
// never called: those allocate prompts and register pet statistics/history.
function scrNTTEFullPetGetSprite(_pet,_mod_type,_mod_name,_skin,_part) {
    if(_mod_type!="mod" || _mod_name!="petlib") throw "Unknown NTTE pet provider: "+string(_mod_type)+"/"+string(_mod_name)
    if(_part=="icon") return scrNTTEFullPetIconSprite(_pet,_skin)
    if(_part!="idle") throw "NTTE pure pet sprite query is not implemented for field: "+string(_part)
    var _key=""
    switch(_pet) {
        case "Scorpion": _key="PetScorpionIdle"; break
        case "Parrot": _key=_skin==1 ? "PetParrotBIdle":"PetParrotIdle"; break
        case "CoolGuy": _key=_skin=="peas" ? "PetPeasIdle":"PetCoolGuyIdle"; break
        case "Orchid": _key="PetOrchidIdle"; break
        case "Octo": _key="PetOctoIdle"; break
        case "Mimic": _key="PetMimicIdle"; break
        case "Salamander": _key="PetSalamanderIdle"; break
        case "Slaughter": _key="PetSlaughterIdle"; break
        case "Spider": _key=_skin==1 ? "PetSpiderCursedIdle":"PetSpiderIdle"; break
        case "Prism": _key="PetPrismIdle"; break
        case "Twins": _key=_skin==1 ? "PetTwinsWhite":"PetTwinsRed"; break
        case "Cuz": return sprMutant16Idle
        case "Weapon": _key=_skin==1 ? "PetWeaponCursedIdle":"PetWeaponIdle"; break
        case "Guardian": _key="PetGuardianIdle"; break
        default: throw "NTTE pure pet sprite query has no species: "+string(_pet)
    }
    return scrNTTERefSprite(_key)
}
function scrNTTEFullPetSkinField(_name,_value) {
    var _old=variable_instance_get(id,_name)
    if(sprite_exists(sprite_index) && sprite_index==_old && string_pos("spr_",_name)==1) sprite_index=_value
    variable_instance_set(id,_name,_value)
}
function scrNTTEFullPetSetSkin(_pet,_skin) {
    if(!instance_exists(_pet)) return false
    with(_pet) {
        bskin=_skin
        var _skin_hook=scrNTTEFullValue(hooks,"skin",undefined)
        if(is_callable(_skin_hook)) _skin_hook()
        hitid[0]=spr_idle
        if(array_length(hitid)>1 && hitid[1]=="") hitid[1]=pet
        if(instance_exists(prompt)) {
            prompt.text=scrNTTEFullPetPromptText(id); prompt.sprite_index=spr_icon
        }
    }
    return true
}
function scrNTTEFullPetTake(_pet,_player) {
    if(!instance_exists(_pet) || !instance_exists(_player) || !_pet.can_take || !_player.visible) return false
    var _max_value=scrNTTEFullValue(_player,"ntte_pet_max",undefined)
    if(!is_numeric(_max_value)) _max_value=scrNTTEFullValue(GameCont,"ntte_pet_max",1)
    if(!is_numeric(_max_value)) _max_value=1
    var _max=max(0,_max_value)
    if(_max<=0) return false
    var _pets=scrNTTEFullValue(_player,"ntte_pet",[])
    // Original capacity is a fixed slot array: remove a vacant slot first,
    // otherwise release the oldest pet before appending the new companion.
    for(var _i=array_length(_pets)-1;_i>=0;--_i) if(!instance_exists(_pets[_i])) array_delete(_pets,_i,1)
    while(array_length(_pets)>=_max) {
        var _old=array_shift(_pets)
        if(instance_exists(_old)) {
            _old.leader=noone; _old.can_take=true; _old.persistent=false
            var _fx=instance_create(_old.x+_old.hspeed,_old.y+_old.vspeed,HealFX)
            _fx.sprite_index=scrNTTERefSprite("PetLost"); _fx.image_xscale=choose(-1,1)
            _fx.image_speed=0.5*timescale; _fx.friction=timescale*timescale/8; _fx.depth=-9
        }
    }
    array_push(_pets,_pet); _player.ntte_pet=_pets
    _pet.leader=_player; _pet.team=_player.team; _pet.can_take=false; _pet.persistent=true
    _pet.direction=point_direction(_pet.x,_pet.y,_player.x,_player.y)
    if(_pet.stat_found) { _pet.stat_found=false; _pet.stat.found+=1 }
    var _fx=instance_create(_player.x,_player.y,WepSwap)
    _fx.sprite_index=scr_skill_get(NTTEFullSkill.Compassion)>0 ? sprHealBigFX:sprHealFX; _fx.creator=_player
    snd_play(sndHealthChestBig); snd_play(sndHitFlesh)
    return true
}
function scrNTTEFullPetWalk(_direction,_time) {
    direction=_direction; walk=_time
    if(speed<0.4*timescale) speed=0.4*timescale
}
function scrNTTEFullPetAlarm() {
    ntte_pet_alarm=30
    if(!visible) return;
    var _leader_dir=0,_leader_distance=0
    if(instance_exists(leader)) { _leader_dir=point_direction(x,y,leader.x,leader.y); _leader_distance=point_distance(x,y,leader.x,leader.y) }
    path_dir=scrNTTEFullPathDirection(path,x,y,path_wall)
    var _custom=scrNTTEFullValue(hooks,"alarm",undefined)
    if(is_callable(_custom)) {
        var _next=_custom(_leader_dir,_leader_distance); /* NTTE SOURCE PET CALLBACK LIFETIME alarm */ if(!instance_exists(self)) return;
        if(is_numeric(_next) && _next!=0) ntte_pet_alarm=_next
    } else if(instance_exists(leader)) {
        if(_leader_distance>24) {
            if(!is_undefined(path_dir)) { scrNTTEFullPetWalk(path_dir+orandom(20),8); ntte_pet_alarm=walk }
            else { scrNTTEFullPetWalk(_leader_dir+orandom(10),10); ntte_pet_alarm=10+random(5) }
        }
    } else scrNTTEFullPetWalk(random(360),15)
}
function scrNTTEFullPetStep() {
    if(lockstep_stop) return;
    if(instance_exists(SpiralCont) && (instance_exists(GenCont) || instance_exists(LevCont))) {
        if(!instance_exists(portal_inst)) {
            portal_inst=instance_create(SpiralCont.x,SpiralCont.y,SpiralDebris)
            with(portal_inst) {
                sprite_index=other.spr_hurt; image_index=2; turnspeed*=1.5; dist/=2
                if(abs(turnspeed)>3) turnspeed/=2
                if(abs(rotspeed)<=8) rotspeed+=8*sign(rotspeed)
            }
        }
        portal_inst.image_xscale=0.85+0.15*sin((-portal_inst.image_angle/2)/200)
        portal_inst.image_yscale=portal_inst.image_xscale; portal_inst.grow=0
    }
    if(!is_undefined(mask_store) && visible) { if(mask_index==mskNone) mask_index=mask_store; mask_store=undefined }
    if(!instance_exists(ntte_game) || (instance_exists(GameCont) && ntte_game!=instance_find(GameCont,0)) || instance_exists(Menu)) {
        instance_destroy(); return;
    }
    wave+=timescale; path_delay=max(0,path_delay-timescale)
    if(pet_loops!=GameCont.loops) {
        max_hp=round(max_hp/(1+0.5*pet_loops)); pet_loops=GameCont.loops; max_hp=round(max_hp*(1+0.5*pet_loops))
    }
    if(instance_exists(revive) && (instance_exists(GenCont) || (instance_exists(leader) && instance_exists(Portal)))) instance_destroy(revive)
    if((instance_exists(GenCont) && instance_exists(FloorMaker)) || instance_exists(LevCont)) {
        visible=false; portal_angle=0
        var _follow=instance_exists(leader) ? leader:instance_nearest(x,y,Player)
        if(instance_exists(_follow)) { x=_follow.x; y=_follow.y }
    }
    if(visible) {
        if(walk>0) { walk-=timescale; speed+=walkspeed*timescale*timescale }
        speed=min(speed,maxspeed*timescale)
        var _anim=scrNTTEFullValue(hooks,"anim",undefined)
        if(is_callable(_anim)) { _anim(); /* NTTE SOURCE PET CALLBACK LIFETIME anim */ if(!instance_exists(self)) return; }
        else if(sprite_index!=spr_hurt || image_index>=sprite_get_number(spr_hurt)-0.4*timescale) sprite_index=speed>0 ? spr_walk:spr_idle
        var _step=scrNTTEFullValue(hooks,"step",undefined)
        if(is_callable(_step)) { _step(); /* NTTE SOURCE PET CALLBACK LIFETIME step */ if(!instance_exists(self)) return; }
    } else walk=0
    if(max_hp>0 && hp<=0) {
        if(!instance_exists(revive)) {
            revive=instance_create(x,y,NTTEFullPetRevive); revive.creator=id
            if(!instance_exists(leader)) revive.damage=0
            motion_add(direction+orandom(20),speed*2)
            if(corpse && !instance_exists(corpse_inst)) corpse_inst=scrNTTEFullCorpseDrop(id)
            sprite_index=spr_hurt; image_index=0
            snd_play_hit(snd_dead,0.3)
            var _death=scrNTTEFullValue(hooks,"death",undefined)
            if(is_callable(_death)) { _death(); /* NTTE SOURCE PET CALLBACK LIFETIME death */ if(!instance_exists(self)) return; }
        }
    } else {
        if(instance_exists(revive)) instance_destroy(revive)
        revive=noone
        if(instance_exists(corpse_inst)) {
            repeat(2) instance_create(corpse_inst.x+orandom(4),corpse_inst.y+orandom(4),Smoke)
            instance_destroy(corpse_inst)
        }
        corpse_inst=noone
    }
    // Original portal attraction and persistent transfer. Dead companions
    // follow the same route through their revive controller.
    var _spin=0
    if(visible || instance_exists(revive)) {
        var _pet_id=id
        with(Portal) if(sprite_index!=sprPortalSpawn && sprite_index!=sprBigPortalSpawn) {
            if((point_distance(x,y,_pet_id.x,_pet_id.y)<64 || (object_index==BigPortal && ntte_full_portal_timer>30))
                && !collision_line(x,y,_pet_id.x,_pet_id.y,Wall,false,false)) {
                var _toward=point_direction(_pet_id.x,_pet_id.y,x,y),_step_length=4*timescale
                with(_pet_id) {
                    var _nx=x+lengthdir_x(_step_length,_toward),_ny=y+lengthdir_y(_step_length,_toward)
                    if(!place_meeting(_nx,y,Wall)) x=_nx
                    if(!place_meeting(x,_ny,Wall)) y=_ny
                    _spin=30*right
                }
            }
        }
        if(place_meeting(x,y,Portal)) {
            repeat(3) instance_create(x,y,Dust)
            if(instance_exists(revive)) instance_destroy(revive)
            visible=false; persistent=true
            if(mask_index!=mskNone) { mask_store=mask_index; mask_index=mskNone }
        }
    }
    if(_spin!=0) {
        portal_angle+=_spin; sprite_index=spr_hurt; image_index=1
        speed-=min(speed,0.4*timescale*3); walk=0
    } else if(portal_angle!=0) {
        if(abs(portal_angle)<1) portal_angle=0
        else portal_angle=angle_difference(0,(portal_angle%360+360)%360)*power(0.8,timescale)
    }
    if(instance_exists(leader)) {
        can_take=false; persistent=true; team=leader.team
        var _seen=true
        for(var _i=0;_i<array_length(path_wall);++_i) if(collision_line(x,y,leader.x,leader.y,path_wall[_i],false,false)) _seen=false
        if(visible && can_path && !_seen) {
            if(!scrNTTEFullPathReaches(path,leader.x,leader.y,path_wall)) {
                if(path_delay<=0) { path_delay=300; path=scrNTTEFullPathCreate(x,y,leader.x,leader.y,path_wall); path=scrNTTEFullPathShrink(path,path_wall,10) }
            } else path_delay=0
        } else { path=[]; path_delay=0 }
        // BEGIN NTTE SOURCE PET BREADCRUMBS
        // tegeneral.Pet_step: after path update, before owned-time stat.
        if(array_length(path)>2 && (wave % 90)<60 && chance(timescale,15/maxspeed)) {
            var _breadcrumb_i=round((wave/10) % array_length(path))
            var _breadcrumb_x1=_breadcrumb_i>0 ? path[_breadcrumb_i-1][0]:x
            var _breadcrumb_y1=_breadcrumb_i>0 ? path[_breadcrumb_i-1][1]:y
            var _breadcrumb_x2=_breadcrumb_i<array_length(path) ? path[_breadcrumb_i][0]:leader.x
            var _breadcrumb_y2=_breadcrumb_i<array_length(path) ? path[_breadcrumb_i][1]:leader.y
            var _breadcrumb_dust=instance_create(lerp(_breadcrumb_x1,_breadcrumb_x2,random(1))+orandom(4),
                lerp(_breadcrumb_y1,_breadcrumb_y2,random(1))+orandom(4),Dust)
            // Native Dust may delete itself during Create. The source with
            // skips its motion body, including RNG, when no instance remains.
            if(instance_exists(_breadcrumb_dust)) with(_breadcrumb_dust)
                motion_set(point_direction(x,y,_breadcrumb_x2,_breadcrumb_y2)+orandom(20),
                    min(random_range(1,5),point_distance(x,y,_breadcrumb_x2,_breadcrumb_y2)/3)*timescale)
        }
        // END NTTE SOURCE PET BREADCRUMBS
        if(instance_is(leader,Player) && array_get_index(scrNTTEFullValue(leader,"ntte_pet",[]),id)>=0) stat.owned+=timescale/30
    } else {
        if(leader!=noone) { leader=noone; can_take=true }
        if(visible) {
            persistent=false
            if(can_take && instance_exists(prompt) && prompt.pick>=0) {
                var _picked=noone,_index=prompt.pick
                with(Player) if(index==_index) _picked=id
                if(instance_exists(_picked)) scrNTTEFullPetTake(id,_picked)
            }
        }
    }
    if(instance_exists(prompt)) { prompt.visible=can_take && visible; prompt.sprite_index=spr_icon }
    // Native scr_can_hit requires HP>0, so harmless pets cannot receive native
    // projectile collision events. Source Pet_step explicitly scans these four
    // damage families to animate dodging without consuming the projectile.
    if((visible || instance_exists(revive)) && max_hp<=0) {
        var _pet=id,_types=[projectile,Explosion,PlasmaImpact,MeatExplosion]
        for(var _t=0;_t<array_length(_types);++_t) with(_types[_t]) if(team!=_pet.team && place_meeting(x,y,_pet))
            scrNTTEFullPetInterceptHit(_pet,scrNTTEFullValue(id,"damage",0),id)
    }
    ntte_pet_alarm-=timescale
    if(ntte_pet_alarm<=0) scrNTTEFullPetAlarm()
}
function scrNTTEFullPetEndStep() {
    // NTTE SPIDER CONTINUOUS ENDSTEP BINDING
    if(pet=="Spider") scrNTTEFullPetSpiderBinding()
    // NTTE SPIDER HIDDEN PORTAL WEB CONTINUATION
    // Source global web EndStep continues after live Portal absorption.
    // Ordinary hidden species AI/physics stay behind the unchanged return.
    if(pet=="Spider" && !visible && !instance_exists(revive) && !instance_exists(GenCont)) scrNTTEFullPetSpiderEndStep()
    if(!visible && !instance_exists(revive)) return;
    var _wall=false
    for(var _i=0;_i<array_length(path_wall);++_i) if(place_meeting(x,y,path_wall[_i])) _wall=true
    if(_wall) {
        x=xprevious; y=yprevious
        for(var _i=0;_i<array_length(path_wall);++_i) {
            var _wall_obj=path_wall[_i],_tries=0
            while(speed!=0 && place_meeting(x+hspeed,y+vspeed,_wall_obj)) {
                if(hspeed!=0 && place_meeting(x+hspeed,y,_wall_obj)) hspeed=abs(hspeed)>timescale ? hspeed/2:0
                else if(vspeed!=0 && place_meeting(x,y+vspeed,_wall_obj)) vspeed=abs(vspeed)>timescale ? vspeed/2:0
                else speed=abs(speed)>timescale ? speed/2:0
                if(++_tries>64) { speed=0; break }
            }
        }
        x+=hspeed; y+=vspeed
    }
    right=hspeed<0 ? -1:(hspeed>0 ? 1:right)
    // Source Pet_end_step pushes by relative size. Player contact only applies
    // while that player is moving; stationary players do not shove pets away.
    var _pet=id
    with(enemy) if(place_meeting(x,y,_pet)) {
        var _away=point_direction(_pet.x,_pet.y,x,y)
        if(size<=_pet.size) motion_add(_away,timescale*timescale)
        if(size>=_pet.size) with(_pet) motion_add(_away+180,push*timescale*timescale)
    }
    with(Player) if(speed!=0 && place_meeting(x,y,_pet)) {
        var _away=point_direction(_pet.x,_pet.y,x,y)
        if(size-3<=_pet.size) motion_add(_away,timescale*timescale)
        if(size-3>=_pet.size) with(_pet) motion_add(_away+180,push*timescale*timescale)
    }
    with(NTTEFullPet) if(id!=_pet && visible && size>=_pet.size && place_meeting(x,y,_pet)) {
        var _away=point_direction(x,y,_pet.x,_pet.y)
        with(_pet) motion_add(_away,push*timescale*timescale)
    }
    var _custom_end=scrNTTEFullValue(hooks,"endstep",undefined)
    if(is_callable(_custom_end)) _custom_end()
}
function scrNTTEFullPetDraw() {
    // A perched Parrot uses its host's ground position but draws above it.
    // A ground shadow here would paint a black stripe across the host's body.
    if(spr_shadow!=-1 && !(pet=="Parrot" && instance_exists(perched)))
        draw_sprite(spr_shadow,0,x+spr_shadow_x,y+spr_shadow_y)
    if(!scrNTTEFullPetOutlineDraw()) scrNTTEFullPetBodyDraw()
}
// Source telib.corpse_drop. Native movement values include timescale, whereas
// NTT exposes logical speed; convert the overkill contribution before capping.
function scrNTTEFullCorpseDrop(_inst,_direction=undefined,_speed=undefined) {
    if(!instance_exists(_inst)) return noone
    var _corpse=instance_create(_inst.x,_inst.y,Corpse)
    _corpse.size=_inst.size; _corpse.sprite_index=_inst.spr_dead
    _corpse.image_xscale=scrNTTEFullValue(_inst,"right",_inst.image_xscale)
    _corpse.direction=is_undefined(_direction) ? _inst.direction:_direction
    var _velocity=is_undefined(_speed) ? _inst.speed:_speed
    if(instance_is(_inst,hitme) && !instance_is(_inst,prop)) {
        _corpse.mask_index=_inst.mask_index
        _velocity+=max(0,-_inst.hp/5)*timescale
        if(instance_is(_inst,enemy)) _velocity+=8*scr_skill_get(mut_impact_wrists)*timescale
    }
    _corpse.speed=min(_velocity,16*timescale)
    if(_corpse.size>0) _corpse.speed/=_corpse.size
    return _corpse
}
function scrNTTEFullPetLevelStart() {
    with(NTTEFullPet) {
        var _scene=asset_get_index("PopoScene")
        if(_scene<0 || !instance_exists(_scene)) visible=true
        if(instance_exists(leader)) {
            x=leader.x; y=leader.y; xprevious=x; yprevious=y
            move_contact_solid(wave,16)
        }
        if(!is_undefined(mask_store) && visible) { if(mask_index==mskNone) mask_index=mask_store; mask_store=undefined }
    }
}
function scrNTTEFullPetCleanup() {
    if(instance_exists(prompt)) instance_destroy(prompt,false)
    if(instance_exists(revive)) instance_destroy(revive,false)
    var _cleanup=scrNTTEFullValue(hooks,"cleanup",undefined)
    if(is_callable(_cleanup)) _cleanup()
    if(array_length(history) && !stat_found && instance_exists(GameCont) && id>GameCont.id) {
        var _values={}
        for(var _i=0;_i<array_length(history);++_i) {
            var _key=history[_i]
            if(variable_instance_exists(id,_key)) variable_struct_set(_values,_key,variable_instance_get(id,_key))
        }
        if(!variable_instance_exists(GameCont,"ntte_pet_history")) GameCont.ntte_pet_history=[]
        array_push(GameCont.ntte_pet_history,[pet,mod_type,mod_name,_values])
    }
}
function scrNTTEFullPetReviveCreate() {
    creator=noone; damage=1; persistent=true; depth=-5; visible=true
    prompt=scrNTTEFullPromptCreate(id,"@rREVIVE",mskReviveArea)
}
function scrNTTEFullPetReviveStep() {
    if(!instance_exists(creator)) { instance_destroy(); return; }
    creator.visible=false
    creator.x+=sin(current_frame/10)/3*timescale; creator.y+=cos(current_frame/10)/3*timescale
    x=creator.x; y=creator.y
    if(!instance_exists(prompt) || prompt.pick<0) return;
    var _picked=noone,_index=prompt.pick
    with(Player) if(index==_index && scrNTTEFullPlayerActive(id)) _picked=id
    if(!instance_exists(_picked)) return;
    if(damage>0) {
        with(_picked) scr_hit_self(other.damage,[sprHealBigFX,"LOVE"])
        var _fx=instance_create(x,y,HealFX); _fx.depth=creator.depth-1
        creator.sprite_index=creator.spr_hurt; creator.image_index=0
        snd_play_hit(creator.snd_hurt,0.2); snd_play(sndHealthChestBig)
    }
    if(instance_exists(creator.prompt)) creator.prompt.pick=_index
    instance_destroy()
}
function scrNTTEFullPetReviveDestroy() {
    if(instance_exists(creator)) { creator.visible=true; creator.hp=creator.max_hp }
    if(instance_exists(prompt)) instance_destroy(prompt,false)
}
function scrNTTEFullPetReviveDraw() {
    if(instance_exists(creator)) with(creator) scrNTTEFullPetDraw()
}

function scrNTTEFullPetExport() {
    var _rows=[],_ids=[],_fields=["pet","mod_type","mod_name","bskin","team","stat_found","stat","history","max_hp","hp","pet_loops","scorpion_city","can_take","walk","direction","ntte_pet_alarm","wave","portal_angle"]
    with(NTTEFullPet) if(instance_exists(leader) && instance_is(leader,Player)) {
        var _values={},_save_fields=scrNTTEFullArrayCopy(_fields)
        for(var _i=0;_i<array_length(history);++_i) if(array_get_index(_save_fields,history[_i])<0) array_push(_save_fields,history[_i])
        for(var _i=0;_i<array_length(_save_fields);++_i) {
            var _key=_save_fields[_i]
            // Twins links are portable row indices, never physical references.
            if(pet=="Twins" && (_key=="partner" || _key=="ntte_twins_missing_partner")) continue
            if(variable_instance_exists(id,_key)) variable_struct_set(_values,_key,variable_instance_get(id,_key))
        }
        array_push(_ids,id)
        array_push(_rows,{owner:leader.index,values:_values,dead:instance_exists(revive),slot:array_get_index(scrNTTEFullValue(leader,"ntte_pet",[]),id)>=0,partner:-1})
    }
    for(var _r=0;_r<array_length(_ids);++_r) if(_ids[_r].pet=="Twins") {
        // Native other/self scopes can denote the same live instance as a
        // ref while comparing unequal. Resolve the live physical ID first.
        var _pet=_ids[_r],_link=instance_exists(_pet.partner) ? array_get_index(_ids,_pet.partner.id):-1
        _rows[_r].partner=_link
        _rows[_r].missing_partner=_link<0 && (_pet.partner!=noone || _pet.ntte_twins_missing_partner)
    }
    return {schema:1,pets:_rows}
}
function scrNTTEFullPetImport(_data) {
    if(!is_struct(_data) || scrNTTEFullValue(_data,"schema",0)!=1 || !is_array(scrNTTEFullValue(_data,"pets",undefined))) return false
    with(NTTEFullPet) { history=[]; instance_destroy() }
    with(Player) ntte_pet=[]
    var _restored=array_create(array_length(_data.pets),noone)
    var _fields=["bskin","team","stat_found","stat","history","max_hp","hp","pet_loops","scorpion_city","can_take","walk","direction","ntte_pet_alarm","wave","portal_angle"]
    for(var _r=0;_r<array_length(_data.pets);++_r) {
        var _row=_data.pets[_r],_owner=noone
        with(Player) if(index==_row.owner) _owner=id
        if(!instance_exists(_owner) || !is_struct(_row.values)) continue
        var _pet=scrNTTEFullPetCreate(_owner.x,_owner.y,_row.values.pet)
        _restored[_r]=_pet
        var _load_fields=scrNTTEFullArrayCopy(_fields)
        // Only species-authored history fields may extend the save schema.
        for(var _i=0;_i<array_length(_pet.history);++_i) if(array_get_index(_load_fields,_pet.history[_i])<0) array_push(_load_fields,_pet.history[_i])
        for(var _i=0;_i<array_length(_load_fields);++_i) {
            var _key=_load_fields[_i]
            if(_pet.pet=="Twins" && (_key=="partner" || _key=="ntte_twins_missing_partner")) continue
            if(variable_struct_exists(_row.values,_key)) variable_instance_set(_pet,_key,variable_struct_get(_row.values,_key))
        }
        // Old nonempty Twins history predates its partner registration.
        // Preserve the source vat's deliberately empty, one-use history.
        if(_pet.pet=="Twins" && array_length(_pet.history)>0) {
            var _twins_fields=["partner","ntte_twins_missing_partner"]
            for(var _i=0;_i<array_length(_twins_fields);++_i)
                if(array_get_index(_pet.history,_twins_fields[_i])<0) array_push(_pet.history,_twins_fields[_i])
        }
        _pet.leader=_owner; _pet.can_take=false; _pet.persistent=true
        if(_pet.pet=="Mimic" && is_struct(scrNTTEFullValue(_pet,"ntte_state",undefined)))
            _pet.ntte_state=scrNTTEStateRestored(_pet.ntte_state)
        scrNTTEFullPetSetSkin(_pet,_pet.bskin)
        variable_struct_set(global.ntte_full_progress.stats,"pet:"+_pet.pet+".petlib.mod",_pet.stat)
        if(scrNTTEFullValue(_row,"slot",true)) array_push(_owner.ntte_pet,_pet)
        if(_row.dead) { _pet.revive=instance_create(_pet.x,_pet.y,NTTEFullPetRevive); _pet.revive.creator=_pet }
    }
    for(var _r=0;_r<array_length(_restored);++_r) if(instance_exists(_restored[_r]) && _restored[_r].pet=="Twins") {
        var _link=scrNTTEFullValue(_data.pets[_r],"partner",-1)
        if(_link>=0 && _link<array_length(_restored) && instance_exists(_restored[_link])) {
            _restored[_r].partner=_restored[_link]; _restored[_r].ntte_twins_missing_partner=false
        } else _restored[_r].ntte_twins_missing_partner=scrNTTEFullValue(_data.pets[_r],"missing_partner",false)
    }
    scrNTTEFullPetHistoryImport(_restored)
    return true
}

// GameCont session data uses native JSON, so its lost-pet history also needs
// portable Twins links. Runtime history stays source-shaped, with real refs.
function scrNTTEFullPetHistoryExport(_history) {
    if(!is_array(_history)) return _history
    var _ids=[],_rows=[]
    with(NTTEFullPet) if(instance_exists(leader) && instance_is(leader,Player)) array_push(_ids,id)
    for(var _r=0;_r<array_length(_history);++_r) {
        var _data=_history[_r],_row={data:_data,partner:-1,missing_partner:false}
        if(is_array(_data) && array_length(_data)>=4 && _data[0]=="Twins" && _data[1]=="mod" && _data[2]=="petlib" && is_struct(_data[3])) {
            var _values={},_keys=variable_struct_get_names(_data[3]),_physical=scrNTTEFullValue(_data[3],"partner",noone)
            for(var _i=0;_i<array_length(_keys);++_i) {
                var _key=_keys[_i]
                if(_key!="partner" && _key!="ntte_twins_missing_partner") variable_struct_set(_values,_key,variable_struct_get(_data[3],_key))
            }
            _row.data=[_data[0],_data[1],_data[2],_values]
            _row.partner=instance_exists(_physical) ? array_get_index(_ids,_physical.id):-1
            _row.missing_partner=_row.partner<0 && (_physical!=noone || scrNTTEFullValue(_data[3],"ntte_twins_missing_partner",false))
        }
        array_push(_rows,_row)
    }
    return {schema:1,rows:_rows}
}
function scrNTTEFullPetHistoryImport(_restored) {
    var _history=scrNTTEFullValue(GameCont,"ntte_pet_history",undefined)
    // Older saves used raw source-shaped arrays. Preserve their old behavior.
    if(!is_struct(_history) || scrNTTEFullValue(_history,"schema",0)!=1 || !is_array(scrNTTEFullValue(_history,"rows",undefined))) return false
    var _rows=[]
    for(var _r=0;_r<array_length(_history.rows);++_r) {
        var _row=_history.rows[_r],_data=_row.data
        if(is_array(_data) && array_length(_data)>=4 && _data[0]=="Twins" && _data[1]=="mod" && _data[2]=="petlib" && is_struct(_data[3])) {
            var _link=scrNTTEFullValue(_row,"partner",-1),_physical=noone
            if(_link>=0 && _link<array_length(_restored) && instance_exists(_restored[_link])) _physical=_restored[_link]
            _data[3].partner=_physical
            _data[3].ntte_twins_missing_partner=(_physical==noone) && scrNTTEFullValue(_row,"missing_partner",false)
        }
        array_push(_rows,_data)
    }
    GameCont.ntte_pet_history=_rows
    return true
}

function scrNTTEFullPetFrameworkTests() {
    var _p=instance_find(Player,0),_old_pets=scrNTTEFullValue(_p,"ntte_pet",[]),_old_max=scrNTTEFullValue(_p,"ntte_pet_max",undefined)
    var _old_pick=KeyCont.press_pick[_p.index],_old_hp=_p.hp,_old_nexthurt=_p.nexthurt
    _p.ntte_pet=[]; _p.ntte_pet_max=1
    // Framework fixture uses real production objects; no species is marked
    // implemented or selectable by these ownership/lifecycle tests.
    var _a=instance_create(_p.x,_p.y,NTTEFullPet),_b=instance_create(_p.x+8,_p.y,NTTEFullPet)
    _a.pet="framework-test-a"; _b.pet="framework-test-b"
    assert(scrNTTEFullPetTake(_a,_p) && _a.leader==_p && _a.persistent && !_a.can_take
        && array_length(_p.ntte_pet)==1 && _a.stat.found==1,"Pet ownership failed original slot/stats/faction/persistence")
    assert(scrNTTEFullPetTake(_b,_p) && _a.leader==noone && _a.can_take && !_a.persistent
        && _p.ntte_pet[0]==_b,"Pet capacity replacement did not release oldest companion")
    _p.ntte_pet_max=0
    assert(!scrNTTEFullPetTake(_a,_p),"Pet acquisition ignored zero capacity")
    _p.ntte_pet_max=1
    _b.max_hp=12; _b.hp=0
    with(_b) scrNTTEFullPetStep()
    var _revive=_b.revive
    assert(instance_exists(_revive) && _revive.damage==1,"Owned pet death failed native revive controller/cost")
    _revive.prompt.pick=_p.index
    with(_revive) scrNTTEFullPetReviveStep()
    assert(!instance_exists(_revive) && _b.visible && _b.hp==12 && _p.hp==_old_hp-1,
        "Pet revival failed original one HP LOVE cost or full companion HP restore")
    var _pa=_a.prompt,_pb=_b.prompt
    instance_destroy(_a); instance_destroy(_b)
    assert(!instance_exists(_pa) && !instance_exists(_pb),"Pet cleanup leaked pickup prompts")
    _p.ntte_pet=_old_pets; _p.ntte_pet_max=_old_max; _p.hp=_old_hp; _p.nexthurt=_old_nexthurt
    KeyCont.press_pick[_p.index]=_old_pick
    scrNTTESmokeLog("SYSTEMS PET FRAMEWORK: production ownership/faction/capacity replacement, found stat, death/revive LOVE HP cost, prompt cleanup OK; species remain gated")
}
