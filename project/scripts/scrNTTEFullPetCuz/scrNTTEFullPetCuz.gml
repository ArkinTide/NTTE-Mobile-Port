// Source petlib.Cuz. The native port already has the Cuz playable race;
// takeover uses scrPlayerCreate instead of NTT's Revive collision trampoline.
function scrNTTEFullPetCuzCreate() {
    spr_idle=sprMutant16Idle; spr_walk=sprMutant16Walk; spr_hurt=sprMutant16Hurt; spr_dead=sprMutant16Dead
    spr_icon=scrNTTERefSprite("PetCuzIcon")
    spr_sit1=sprCuzInteractFrom; spr_sit2=sprCuzIdle; spr_sit3=sprCuzInteractTo; spr_sit4=sprCuzInteract
    spr_horn=sprCuzHorn; spr_cry=sprCuzCry
    snd_horn=sndCuzHorn; snd_lowa=sndMutant16LowA; snd_chst=sndCuzOpen; snd_pick=sndCuzWep
    snd_wrld=sndMutant16Wrld; snd_valt=sndMutant16Valt; snd_idpd=sndMutant16IDPD; snd_popo=sndMutant16Chst
    snd_cry=sndCuzCry; snd_gone=sndCuzOutaway
    cuz_sound={lowa:0,chst:0,pick:0,wrld:0,valt:0,idpd:0,popo:0}; leader_index=-1; cuz=noone
    stat.playtime=scrNTTEFullValue(stat,"playtime",0); array_push(history,"leader_index")
    hooks={step:method(id,scrNTTEFullPetCuzStep),draw:method(id,scrNTTEFullPetCuzDraw),alarm:method(id,scrNTTEFullPetCuzAlarm),cleanup:method(id,scrNTTEFullPetCuzCleanup)}
}
function scrNTTEFullPetCuzStep() {
    if(instance_exists(leader)) {
        leader_index=leader.index
        if(KeyCont.press_horn[leader_index]) snd_play(snd_horn,1,2)
        var _keys=variable_struct_get_names(cuz_sound)
        for(var _i=0;_i<array_length(_keys);++_i) {
            var _key=_keys[_i],_time=variable_struct_get(cuz_sound,_key),_play=0
            if(_key=="pick") {
                var _swap=false
                // Native WepSwap does not declare creator.  Only the
                // explicit pickup/swap effects that opt into Cuz's pickup
                // cue carry that field; ordinary weapon swap flashes must
                // be ignored instead of reading an unset instance variable.
                with(WepSwap) if(variable_instance_exists(id,"creator") && creator==other.leader) _swap=true
                if(_swap && (audio_is_playing(sndWeaponPickup) || audio_is_playing(sndGuitarPickup))) _play=1
            } else if(_key=="popo") { if(instance_exists(IDPDSpawn) || instance_exists(VanSpawn)) _play=30 }
            else if(variable_instance_exists(leader,"snd_"+_key) && audio_is_playing(variable_instance_get(leader,"snd_"+_key))) _play=1
            if(_play>0) {
                if(_time<=0) { variable_struct_set(cuz_sound,_key,_play); snd_play_hit(variable_instance_get(id,"snd_"+_key),0.1) }
            } else if(_time>0) variable_struct_set(cuz_sound,_key,_time-timescale)
        }
        if(cuz!=noone) {
            if(instance_exists(cuz)) {
                if(cuz.spr_idle==spr_cry) {
                    audio_stop_sound(snd_cry)
                    for(var _dir=150;_dir<=390;_dir+=40) {
                        var _fx=instance_create(x,y,Dust)
                        with(_fx) {
                            motion_add(_dir,4*timescale); sprite_index=sprSweat; image_index=irandom(image_number-1)
                            gravity=random_range(0.05,0.15)*timescale*timescale; friction*=1.5
                            image_xscale=1.2; image_yscale=1.2; depth=other.depth-1; image_blend=make_color_rgb(99,131,171)
                        }
                    }
                } else scrNTTEFullPetWalk(270,10)
                snd_play(snd_chst); instance_destroy(cuz,false)
            }
            cuz=noone
        }
    } else if(instance_exists(Player)) {
        var _old_player=noone
        with(Player) if(index==other.leader_index) _old_player=id
        if(instance_exists(_old_player)) leader_index=-1
        if(cuz==noone && position_meeting(x,y,VenuzCouch)) {
            cuz=instance_create(x,y,YungCuz)
            with(cuz) {
                ntte_cuz=other.id; sprite_index=spr_from; image_index=0; image_xscale=other.right
                if(GameCont.area==area_crib && !instance_exists(VenuzTV)) {
                    audio_play_sound(other.snd_cry,0,true)
                    spr_idle=other.spr_cry; spr_to=spr_idle; spr_from=spr_idle; spr_heya=spr_idle
                }
            }
        }
        if(instance_exists(cuz)) {
            var _couch=instance_nearest(cuz.x,cuz.y,VenuzCouch)
            if(instance_exists(_couch)) {
                var _t=1-power(0.9,timescale)
                cuz.x=lerp(cuz.x,clamp(cuz.x,_couch.bbox_left+16,_couch.bbox_right-15),_t)
                cuz.y=lerp(cuz.y,clamp(cuz.y,_couch.bbox_top+16,_couch.bbox_bottom-15),_t)
            }
            if(cuz.spr_idle!=spr_cry && cuz.image_index+cuz.image_speed>=cuz.image_number) {
                var _p=instance_nearest(cuz.x,cuz.y,Player)
                if(instance_exists(_p) && cuz.x!=_p.x) cuz.image_xscale=abs(cuz.image_xscale)*sign(_p.x-cuz.x)
            }
            hspeed=cuz.hspeed; vspeed=cuz.vspeed; x=cuz.x; y=cuz.y; xprevious=x; yprevious=y
        }
    } else if(leader_index>=0 && is_struct(scr_playerinstance_find(leader_index)) && !GameCont.win) {
        scrNTTEFullPetCuzTakeover()
    }
}
function scrNTTEFullPetCuzTakeover() {
// BEGIN NTTE CUZ AUDIO TEST TAKEOVER BEFORE
if(os_type==os_windows && scrNTTEFullSmokeEnabled() && instance_exists(NTTEFullCuzConnectedTest) && variable_instance_exists(instance_find(NTTEFullCuzConnectedTest,0),"ntte_cuz_audio")) try { var _ntte_cuz_audio_event_receiver=id; with(instance_find(NTTEFullCuzConnectedTest,0)) { scrNTTEFullCuzMusicTakeoverBefore(_ntte_cuz_audio_event_receiver); } } catch(_ntte_cuz_audio_error) { with(instance_find(NTTEFullCuzConnectedTest,0)) scrNTTEFullCuzConnectedAbort(_ntte_cuz_audio_error); }
// END NTTE CUZ AUDIO TEST TAKEOVER BEFORE
// BEGIN NTTE CUZ CONNECTED TEST TAKEOVER BEFORE
if(os_type==os_windows && scrNTTEFullSmokeEnabled() && instance_exists(NTTEFullCuzConnectedTest)) try { scrNTTEFullCuzConnectedTakeoverBefore(id); }
catch(_ntte_cuz_connected_error) { scrNTTEFullCuzConnectedAbort(_ntte_cuz_connected_error); }
// END NTTE CUZ CONNECTED TEST TAKEOVER BEFORE
    var _pinst=scr_playerinstance_find(leader_index)
    if(!is_struct(_pinst)) return noone
    var _last_race=_pinst.race,_pet=id,_new=scrPlayerCreate(leader_index,Race.Cuz,0)
    with(_new) {
        ntte_cuz_adopted=true
        x=_pet.x; y=_pet.y; xprevious=x; yprevious=y
        nexthurt=current_frame+30; spirit_index=6
        if(scr_skill_get(mut_strong_spirit)>0) can_spirit=false
        var _fields=["mask_index","sprite_index","image_index","image_speed","image_xscale","image_yscale","image_angle","image_blend","image_alpha","spr_idle","spr_walk","spr_hurt","spr_dead","spr_shadow","spr_shadow_x","spr_shadow_y"]
        for(var _i=0;_i<array_length(_fields);++_i) variable_instance_set(id,_fields[_i],variable_instance_get(_pet,_fields[_i]))
        angle=_pet.portal_angle; snd_play(snd_wrld)
// BEGIN NTTE CUZ CONNECTED TEST TAKEOVER SETUP
if(os_type==os_windows && scrNTTEFullSmokeEnabled() && instance_exists(NTTEFullCuzConnectedTest)) try { scrNTTEFullCuzConnectedTakeoverSetup(id); }
catch(_ntte_cuz_connected_error) { scrNTTEFullCuzConnectedAbort(_ntte_cuz_connected_error); }
// END NTTE CUZ CONNECTED TEST TAKEOVER SETUP
    }
    // Source swaps ultras only after the final player of the former race is gone.
    var _swap=true
    for(var _i=0;_i<player_count;++_i) if(scr_playerinstance_find(_i).race==_last_race) _swap=false
    if(_swap) {
        var _old_ultras=GameCont.ultra_got[_last_race],_new_count=array_length(GameCont.ultra_got[Race.Cuz])-1
        for(var _i=1;_i<array_length(_old_ultras);++_i) if(_old_ultras[_i]!=0) {
            scr_ultra_set(_last_race,_i,0); scr_ultra_set(Race.Cuz,1+((_i-1) mod max(1,_new_count)),1)
        }
    }
    // BEGIN NTTE SOURCE CUZ TAKEOVER MUSIC
    // Original sound_play_music changes only a different controller song.
    with(MusCont) if(song!=mus107) {
        snd_stop(song)
        song=mus107
        snd_play_music(song,true)
    }
    // END NTTE SOURCE CUZ TAKEOVER MUSIC
    with(WepPickup) if(ammo==0) ammo=1
    with(CrownObject) persistent=true
    with(Portal) if(endgame<0) {
        endgame=100
        if(instance_is(id,BigPortal)) sprite_index=sprBigPortal
        else switch(type) {
            case 1: sprite_index=sprPortal; break
            case 2: sprite_index=sprPopoPortal; break
            case 3: sprite_index=sprProtoPortal; break
        }
    }
    with(Revive) if(index==_pet.leader_index) instance_destroy(id,false)
    var _buttons=asset_get_index("button")
    if(_buttons>=0) instance_destroy(_buttons)
    with(UnlockScreen) alarm[0]=-1
    scrLetterbox(false)
    instance_destroy()
    return _new
}
function scrNTTEFullPetCuzDraw(_spr,_img,_x,_y,_xsc,_ysc,_ang,_col,_alp) {
    if(!instance_exists(cuz)) draw_sprite_ext(_spr,_img,_x,_y,_xsc,_ysc,_ang,_col,_alp)
}
function scrNTTEFullPetCuzAlarm(_dir,_dis) {
    if(instance_exists(cuz)) return 60
    if(instance_exists(leader) && (_dis>64 || !is_undefined(path_dir))) {
        scrNTTEFullPetWalk(is_undefined(path_dir) ? _dir+orandom(10):path_dir+orandom(10),is_undefined(path_dir) ? 10:8)
        right=lengthdir_x(1,direction)>=0 ? 1:-1
        return is_undefined(path_dir) ? 10+random(5):walk
    }
    scrNTTEFullPetWalk((instance_exists(leader) ? _dir:direction)+random_range(30,60)*choose(-1,1),random_range(12,24))
    if(!instance_exists(leader) && cuz==noone && instance_exists(VenuzCouch)) {
        var _best=infinity,_target=noone,_pet=id
        with(VenuzCouch) { var _dist=point_distance(x,y,_pet.x,_pet.y); if(_dist<_best && !collision_line(x,y,_pet.x,_pet.y,Wall,false,false)) { _best=_dist; _target=id } }
        if(instance_exists(_target)) direction=point_direction(x,y,_target.x,_target.y)+orandom(30)
    }
    right=lengthdir_x(1,direction)>=0 ? 1:-1
    return 60
}
function scrNTTEFullPetCuzCleanup() {
    if(instance_exists(cuz)) { if(cuz.spr_idle==spr_cry) audio_stop_sound(snd_cry); instance_destroy(cuz,false) }
    if(leader_index<0 || !is_struct(scr_playerinstance_find(leader_index))) snd_play_hit(snd_gone,0.1)
}
// Source petlib.ntte_step "Playing Cuz": the inherited companion has a
// beatbox power, distinct from Epsilon's independently selectable Cuz race.
function scrNTTEFullPetCuzPlayerPower() {
    if(race!=Race.Cuz || !scrNTTEFullValue(id,"ntte_cuz_adopted",false)) return false
    if(!variable_instance_exists(id,"ntte_cuz_snd")) { ntte_cuz_snd=-1; ntte_cuz_snd_id=-1; ntte_cuz_snd_num=-1 }
    if(KeyCont.hold_spec[index]) {
        var _stopped=false
        if(KeyCont.press_spec[index] && audio_is_playing(ntte_cuz_snd_id)) { audio_stop_sound(ntte_cuz_snd_id); _stopped=true }
        if(!audio_is_playing(ntte_cuz_snd_id)) {
            var _seed=random_get_seed(),_beat=[sndCuzBye,sndCuzBye,sndCuzWep]
            if(scr_ultra_get(Race.Cuz,1)>0) _beat=[sndCuzHorn,sndCuzHorn,sndCuzHorn,snd_thrn,-1,-1,-1,-1,-1,-1,-1,-1]
            if(scr_ultra_get(Race.Cuz,2)>0) _beat=array_concat(_beat,[sndCuzBye,sndCuzBye,sndCuzWep,sndCuzBye,sndCuzBye,sndCuzWep,snd_wrld])
            ntte_cuz_snd_num=max(0,ntte_cuz_snd_num+1) mod array_length(_beat)
            var _next=_beat[ntte_cuz_snd_num],_pitch=ntte_cuz_snd==_next ? 1+orandom(0.05):1
            ntte_cuz_snd=_next; ntte_cuz_snd_id=audio_exists(_next) ? snd_play(_next,_pitch):-1
            if(ntte_cuz_snd==_beat[0] && (ntte_cuz_snd_num>0 || !_stopped)) {
                var _side=choose(-1,1),_fx=instance_create(x+8*_side,y+orandom(8),Wind)
                with(_fx) {
                    sprite_index=scrNTTERefSprite("PetParrotNote"); image_blend=c_black; depth=other.depth-1
                    hspeed=random_range(1,1.4)*_side*timescale; gravity=-abs(speed/10)*timescale; friction=0.1*timescale*timescale
                }
                if(wkick==0) wkick=3
            }
            random_set_seed(_seed)
        }
    } else {
        ntte_cuz_snd_num=-1
        if(audio_exists(ntte_cuz_snd) && !audio_is_playing(ntte_cuz_snd_id)) {
            if(scr_skill_get(mut_throne_butt)<=0 || ntte_cuz_snd==snd_valt || ntte_cuz_snd==snd_wrld || ntte_cuz_snd==snd_thrn) ntte_cuz_snd=-1
            else { ntte_cuz_snd=snd_valt; ntte_cuz_snd_id=snd_play(ntte_cuz_snd) }
        }
    }
    var _key="pet:Cuz.petlib.mod",_stat=scrNTTEFullValue(global.ntte_full_progress.stats,_key,undefined)
    if(is_struct(_stat) && scrNTTEFullValue(GameCont,"ntte_cuz_stat_frame",-1)!=current_frame) {
        _stat.playtime+=timescale/30; GameCont.ntte_cuz_stat_frame=current_frame
    }
    return true
}
function scrNTTEFullPetCuzTests() {
    var _p=instance_find(Player,0),_pet=scrNTTEFullPetCreate(_p.x,_p.y,"Cuz")
    var _baseline=buffer_create(65535,buffer_grow,1),_idx=_p.index
    scrSavegamePlayers(_baseline,false)
    assert(_pet.spr_idle==sprMutant16Idle && _pet.cuz==noone && _pet.leader_index==-1,"Cuz constructor/source sprites changed")
    // A regular native weapon-swap flash has no creator field.  Cuz's
    // pickup cue must skip it safely while still accepting the explicit
    // creator-bearing swap effect used by pickup paths.
    var _unowned_swap=instance_create(_p.x,_p.y,WepSwap),_owned_swap=instance_create(_p.x,_p.y,WepSwap)
    _owned_swap.creator=_p
    _pet.leader=_p; with(_pet) scrNTTEFullPetCuzStep()
    if(instance_exists(_unowned_swap)) instance_destroy(_unowned_swap,false)
    if(instance_exists(_owned_swap)) instance_destroy(_owned_swap,false)
    assert(_pet.leader_index==_p.index,"Cuz failed leader tracking")
    var _pinst=scr_playerinstance_find(_p.index),_race=_pinst.race,_skin=_pinst.skin
    var _ultras=json_parse(json_stringify(GameCont.ultra_got)),_new=noone
    with(_pet) _new=scrNTTEFullPetCuzTakeover()
    assert(instance_exists(_new) && _new.race==Race.Cuz && _new.index==_p.index && _new.ntte_cuz_adopted
        && _new.spr_idle==sprMutant16Idle && _new.hp==_new.max_hp,"Cuz real native takeover lost race/index/sprites/full health")
    var _hold=KeyCont.hold_spec[_idx],_press=KeyCont.press_spec[_idx],_handled=false
    KeyCont.hold_spec[_idx]=false; KeyCont.press_spec[_idx]=false
    with(_new) _handled=scrNTTEFullPetCuzPlayerPower()
    assert(_handled,"Adopted Cuz did not override native cry with source beatbox")
    _new.ntte_cuz_adopted=false
    with(_new) _handled=scrNTTEFullPetCuzPlayerPower()
    assert(!_handled,"Pet Cuz override incorrectly captured independently selected native Cuz")
    _new.ntte_cuz_adopted=true
    var _roundtrip=buffer_create(65535,buffer_grow,1)
    scrSavegamePlayers(_roundtrip,false)
    instance_destroy(Player,false)
    buffer_seek(_roundtrip,buffer_seek_start,0); scrSavegamePlayers(_roundtrip,true); buffer_delete(_roundtrip)
    _new=noone
    with(Player) if(scrNTTEFullValue(id,"ntte_cuz_adopted",false)) _new=id
    assert(instance_exists(_new) && _new.race==Race.Cuz,"Cuz actual buffer continuation lost adopted flag/race")
    with(_new) _handled=scrNTTEFullPetCuzPlayerPower()
    assert(_handled,"Reloaded pet Cuz reverted to the native cry power")
    instance_destroy(Player,false)
    buffer_seek(_baseline,buffer_seek_start,0); scrSavegamePlayers(_baseline,true); buffer_delete(_baseline)
    KeyCont.hold_spec[_idx]=_hold; KeyCont.press_spec[_idx]=_press
    _pinst.race=_race; _pinst.skin=_skin; GameCont.ultra_got=_ultras
    scrNTTESmokeLog("SYSTEMS PET CUZ: source sprites/owner, real native takeover, beatbox/native-Cuz distinction, actual player buffer continuation OK")
}
