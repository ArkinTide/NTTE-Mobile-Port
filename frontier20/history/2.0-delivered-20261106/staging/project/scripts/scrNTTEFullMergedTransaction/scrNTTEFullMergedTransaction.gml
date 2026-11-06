// temerge.mod.gml1303..1643,6140..6164: native pre/post firing transaction.
// Keep the actor (self of the original weapon fire) distinct from its creator.
// Root native scrFire(...,false) has no engine precharge: precharged defaults
// false. Passing true is only valid after the original engine already debited
// the initial cost; refunding a free native shot would manufacture ammo/rads.
function scrNTTEFullMergeTransactionCameraSnapshot() {
    var _result=[]
    with(BackCont) array_push(_result,{instance:id,shake:shake,viewx2:viewx2,viewy2:viewy2})
    return _result
}
function scrNTTEFullMergeTransactionCameraRestore(_snapshot) {
    for(var _i=0;_i<array_length(_snapshot);++_i) {
        var _row=_snapshot[_i]
        if(instance_exists(_row.instance)) with(_row.instance) {
            shake=_row.shake; viewx2=_row.viewx2; viewy2=_row.viewy2
        }
    }
}
function scrNTTEFullMergeTransactionCameraCombine(_fire,_main) {
    for(var _i=0;_i<array_length(_fire);++_i) {
        var _row=_fire[_i]
        if(!instance_exists(_row.instance)) continue
        for(var _j=0;_j<array_length(_main);++_j) if(_main[_j].instance==_row.instance) {
            var _base=_main[_j]
            with(_row.instance) {
                shake+=_row.shake-_base.shake
                viewx2+=_row.viewx2-_base.viewx2; viewy2+=_row.viewy2-_base.viewy2
            }
            break
        }
    }
}
function scrNTTEFullMergeTransactionSoundMarker() {
    // Bypass snd_play: its native implementation stops an existing same-asset
    // channel and skips uncapped tests. This independent channel is inaudible.
    var _sound=audio_play_sound(sndSwapPistol,-100,false,0)
    if(_sound>=0) audio_stop_sound(_sound)
    // Optional native smoke observer; it never replaces the real audio call.
    if(variable_global_exists("ntte_full_merge_sound_marker_observer")
        && is_array(global.ntte_full_merge_sound_marker_observer))
        array_push(global.ntte_full_merge_sound_marker_observer,_sound)
    return _sound
}
function scrNTTEFullMergeTransactionSnapshot(_actor,_owner,_frame) {
    if(!instance_exists(_actor) || !is_struct(_frame)) throw "Merged transaction requires its actual live actor/frame"
    _frame.actor=_actor; _frame.owner=_owner; _frame.frame=current_frame
    _frame.x=_actor.x; _frame.y=_actor.y; _frame.hspeed=_actor.hspeed; _frame.vspeed=_actor.vspeed
    _frame.wepangle=scrNTTEFullValue(_actor,"wepangle",1)
    _frame.wkick=scrNTTEFullValue(_actor,"wkick",0); _frame.reload=scrNTTEFullValue(_actor,"reload",0)
    _frame.infammo=scrNTTEFullValue(_actor,"infammo",0)
    _frame.ammo=instance_exists(_owner) && instance_is(_owner,Player) ? scrNTTEFullArrayCopy(_owner.ammo):undefined
    _frame.rads=GameCont.rad; _frame.shake=scrNTTEFullMergeTransactionCameraSnapshot()
    _frame.opt_shake=UberCont.opt_shake; _frame.opt_freeze=UberCont.opt_freeze
    _frame.before_instances=scrNTTEFullMergedCaptureBegin(); _frame.assets=[]
    // This private flag is issued only by RuntimePlayerFire's terminal
    // unmerged-front branch. Such a frame cannot become a replacement stock.
    _frame.min_sound_id=scrNTTEFullValue(_frame,"ntte_merged_terminal_plain_front",false)
        ?-1:scrNTTEFullMergeTransactionSoundMarker()
    _frame.max_sound_id=_frame.min_sound_id
    _frame.transaction_captured=false; _frame.transaction_closed=false
    return _frame
}
function scrNTTEFullMergeTransactionBegin(_actor,_owner,_frame,_front=false,_precharged=false) {
    scrNTTEFullMergeTransactionSnapshot(_actor,_owner,_frame)
    _frame.is_front=_front
    var _previous=scrNTTEFullValue(_frame,"last_vars",undefined)
    if(is_struct(_previous)) {
        var _main=_previous.main_vars
        if(!is_struct(_main) || !variable_struct_exists(_main,"x")) throw "Merged ancestor transaction was not begun"
        _frame.main_vars=_main
        if(_frame.frame>_main.frame) {
            // A later deferred emission establishes a fresh baseline. Source
            // costs/infammo remain those of the original root weapon.
            var _keys=["frame","x","y","hspeed","vspeed","wepangle","wkick","reload","ammo","rads","shake","opt_shake","opt_freeze"]
            for(var _i=0;_i<array_length(_keys);++_i) _main[$ _keys[_i]]=_frame[$ _keys[_i]]
        } else {
            with(_actor) {
                x=_main.x; y=_main.y; hspeed=_main.hspeed; vspeed=_main.vspeed
                wepangle=abs(wepangle)*sign(_main.wepangle)
            }
            scrNTTEFullMergeTransactionCameraRestore(_main.shake)
        }
    } else {
        _frame.main_vars=_frame
        if(_precharged && _frame.infammo==0) {
            if(instance_is(_actor,Player)) {
                _actor.ammo[_frame.ammo_type]+=_frame.ammo_cost
                if(instance_exists(_owner) && instance_is(_owner,Player)) _frame.ammo=scrNTTEFullArrayCopy(_owner.ammo)
            }
            GameCont.rad+=_frame.rads_cost; _frame.rads=GameCont.rad
        }
    }
    _actor.wkick=0
    if(!_front) { UberCont.opt_shake=0; UberCont.opt_freeze=0 }
    return _frame
}
// Seal a stock emission before replacing its shots. Failed fronts may delete
// only stock-side assets, never later unrelated or successful front instances.
function scrNTTEFullMergeTransactionCapture(_frame) {
    if(_frame.transaction_captured) return _frame.assets
    var _now=scrNTTEFullMergedRuntimeNew(_frame.before_instances)
    for(var _i=0;_i<array_length(_now);++_i) array_push(_frame.assets,_now[_i])
    _frame.max_sound_id=scrNTTEFullValue(_frame,"ntte_merged_terminal_plain_front",false)
        ?-1:scrNTTEFullMergeTransactionSoundMarker()
    _frame.transaction_captured=true
    return _frame.assets
}
function scrNTTEFullMergeTransactionMuffle(_minimum,_maximum) {
    if(_minimum<0 || _maximum<=_minimum) return;
    if(!variable_global_exists("ntte_merge_muffle")) global.ntte_merge_muffle=[]
    for(var _sound=_minimum;_sound<_maximum;++_sound) if(audio_is_playing(_sound)) {
        var _asset=asset_get_index(audio_get_name(_sound))
        if(!audio_exists(_asset)) continue
        var _found=false
        for(var _i=0;_i<array_length(global.ntte_merge_muffle);++_i) {
            var _muffle=global.ntte_merge_muffle[_i]
            if(_muffle.sound!=_asset) continue
            _found=true; _muffle.sound_id=_sound
            if(_muffle.frame<current_frame) {
                _muffle.frame=current_frame
                audio_sound_gain(_asset,lerp(audio_sound_get_gain(_asset),_muffle.sound_gain*0.1,0.2),0)
            }
            break
        }
        if(!_found) array_push(global.ntte_merge_muffle,
            {sound:_asset,sound_id:_sound,sound_gain:audio_sound_get_gain(_asset),frame:current_frame})
    }
}
function scrNTTEFullMergeTransactionMuffleStep() {
    if(!variable_global_exists("ntte_merge_muffle")) return;
    for(var _i=array_length(global.ntte_merge_muffle)-1;_i>=0;--_i) {
        var _muffle=global.ntte_merge_muffle[_i],_sound=_muffle.sound
        if(audio_is_playing(_sound)) {
            if(audio_is_playing(_muffle.sound_id)) continue
            var _gain=lerp(audio_sound_get_gain(_sound),_muffle.sound_gain,0.1)
            if(_muffle.sound_gain!=0 && abs(1-_gain/_muffle.sound_gain)>0.1) {
                audio_sound_gain(_sound,_gain,0); continue
            }
        }
        audio_sound_gain(_sound,_muffle.sound_gain,0)
        array_delete(global.ntte_merge_muffle,_i,1)
    }
}
function scrNTTEFullMergeTransactionMuffleRestore() {
    if(!variable_global_exists("ntte_merge_muffle")) return;
    for(var _i=0;_i<array_length(global.ntte_merge_muffle);++_i) {
        var _muffle=global.ntte_merge_muffle[_i]
        audio_sound_gain(_muffle.sound,_muffle.sound_gain,0)
    }
    global.ntte_merge_muffle=[]
}
function scrNTTEFullMergeTransactionUndoStocks(_frame) {
    for(var _stock=_frame.last_vars;is_struct(_stock);_stock=_stock.last_vars) {
        if(!scrNTTEFullValue(_stock,"transaction_captured",false)) continue
        scrNTTEFullMergeTransactionMuffle(_stock.min_sound_id,_stock.max_sound_id)
        for(var _i=0;_i<array_length(_stock.assets);++_i)
            if(instance_exists(_stock.assets[_i])) instance_destroy(_stock.assets[_i],false)
    }
}
function scrNTTEFullMergeTransactionEnd(_frame,_has_shot=undefined) {
    if(_frame.transaction_closed) return _frame.has_shot
    scrNTTEFullMergeTransactionCapture(_frame)
    if(is_undefined(_has_shot)) {
        _has_shot=false
        for(var _i=0;_i<array_length(_frame.assets);++_i) {
            var _inst=_frame.assets[_i]
            if(instance_exists(_inst) && instance_is(_inst,projectile)) { _has_shot=true; break }
        }
        if(!_has_shot) for(var _i=0;_i<array_length(_frame.assets);++_i) {
            var _inst=_frame.assets[_i]
            if(instance_exists(_inst) && variable_instance_exists(_inst,"team")) {
                _has_shot=true; _frame.shot_is_delayed=true; break
            }
        }
    }
    _frame.has_shot=_has_shot
    var _actor=_frame.actor,_main=_frame.main_vars
    try {
        if(_has_shot && instance_exists(_actor)) with(_actor) {
            if(sign(wepangle)!=sign(_main.wepangle)) {
                if(!variable_struct_exists(_main,"wepangle_side_frame") || current_frame-_main.wepangle_side_frame>1)
                    _main.wepangle_side=sign(wepangle)
                _main.wepangle_side_frame=current_frame
            }
            if(variable_struct_exists(_main,"wepangle_side")) wepangle=abs(wepangle)*sign(_main.wepangle_side)
            if(wkick==0) wkick=_frame.wkick
            else if(_frame!=_main) wkick=max(abs(wkick),abs(_frame.wkick))*((wkick<0 || _frame.wkick<0) ? -1:1)
            x+=_frame.x-_main.x; y+=_frame.y-_main.y
            hspeed+=_frame.hspeed-_main.hspeed; vspeed+=_frame.vspeed-_main.vspeed
            scrNTTEFullMergeTransactionCameraCombine(_frame.shake,_main.shake)
        }
        else if(!_has_shot) {
            scrNTTEFullMergeTransactionUndoStocks(_frame)
            if(instance_exists(_actor)) with(_actor) {
                wepangle=abs(wepangle)*sign(_main.wepangle)
                if(wkick==0) wkick=_main.wkick
            }
        }
        if(!_frame.is_front) {
            if(instance_exists(_frame.owner) && instance_is(_frame.owner,Player) && is_array(_frame.ammo))
                _frame.owner.ammo=scrNTTEFullArrayCopy(_frame.ammo)
            GameCont.rad=_frame.rads
        }
        if(instance_exists(_actor) && _actor.reload<=0 && _frame.reload>0)
            _actor.reload=max(_actor.reload,scrNTTEFullValue(_actor,"reloadspeed",1)*timescale)
    } finally {
        UberCont.opt_shake=_frame.opt_shake; UberCont.opt_freeze=_frame.opt_freeze
        _frame.transaction_closed=true
    }
    return _frame.has_shot
}
function scrNTTEFullMergedTransactionTests() {
    var _p=instance_find(Player,0),_before=scrNTTEFullInstances(all),_tick=current_frame
    var _players=scrNTTEFullAreaGeneratorSnapshot(Player),_game=scrNTTEFullAreaGeneratorSnapshot(GameCont),
        _back=scrNTTEFullAreaGeneratorSnapshot(BackCont),_uber=scrNTTEFullAreaGeneratorSnapshot(UberCont)
    var _muffles=variable_global_exists("ntte_merge_muffle") ? global.ntte_merge_muffle:[]
    var _sound_tested=false,_test_channel=-1,_sound_gain=audio_sound_get_gain(sndPistol)
    global.ntte_merge_muffle=[]
    try {
        _p.x=8000; _p.y=8000; _p.hspeed=2*timescale; _p.vspeed=3*timescale
        _p.wepangle=1; _p.wkick=-7; _p.reload=5; _p.infammo=0; _p.race=Race.Fish
        _p.accuracy=0; _p.gunangle=0; _p.ammo=array_create(Ammo.NUM_AMMO_TYPES,100); GameCont.rad=100
        UberCont.opt_shake=1; UberCont.opt_freeze=1
        with(BackCont) { shake=2; viewx2=3; viewy2=4 }
        var _weapon=scrNTTEFullWeaponMerge(wep_revolver,wep_wrench),
            _stock=scrNTTEFullMergeFireFrame(_weapon,_p)
        scrNTTEFullMergeTransactionBegin(_p,_p,_stock)
        assert(_p.wkick==0 && UberCont.opt_shake==0 && UberCont.opt_freeze==0
            && _p.ammo[Ammo.Bullets]==100 && GameCont.rad==100,
            "Native no-precharge transaction manufactured a refund or failed temporary stock options/kick")
        with(_p) scrFire(wep_revolver,false)
        assert(scrNTTEFullMergeTransactionEnd(_stock) && !_stock.shot_is_delayed,
            "Transaction failed to detect actual native Revolver projectile")
        assert(_p.ammo[Ammo.Bullets]==100 && GameCont.rad==100 && _p.wkick==4
            && UberCont.opt_shake==1 && UberCont.opt_freeze==1,
            "Native stock transaction lost ammo/rad rollback, actual recoil, or restored options")
        with(BackCont) assert(shake==2 && viewx2==3 && viewy2==4,
            "Stock-side native screenshift/screenshake escaped its disabled option")
        _p.x+=2; _p.hspeed+=3*timescale; _p.wkick=-9; _p.wepangle=-4
        with(BackCont) { shake+=5; viewx2+=6 }
        var _front=scrNTTEFullMergeFireFrame(_weapon,_p,_stock)
        scrNTTEFullMergeTransactionBegin(_p,_p,_front,true)
        assert(_p.x==8000 && abs(_p.hspeed-2*timescale)<0.0001 && _p.wepangle==4,
            "Same-frame nested front did not restore main actor position/motion/melee side")
        with(BackCont) assert(shake==2 && viewx2==3,"Same-frame front failed main camera restoration")
        _p.ammo[Ammo.Bullets]-=2; GameCont.rad-=3
        with(_p) scrFire(wep_wrench,false)
        assert(scrNTTEFullMergeTransactionEnd(_front),"Transaction failed actual native melee front")
        assert(_p.x==8002 && abs(_p.hspeed-11*timescale)<0.0001 && _p.wkick== -9 && _p.wepangle== -4,
            "Nested native wrench front lost source combined motion, strongest signed kick, or melee side")
        assert(_p.ammo[Ammo.Bullets]==98 && GameCont.rad==97,
            "Front post-firing transaction undid actual replacement charges")
        with(BackCont) assert(shake==8 && viewx2==21 && viewy2==4,
            "Nested native front did not combine original camera and earlier stock movement")
        var _front_x=_p.x,_front_hspeed=_p.hspeed
        assert(scrNTTEFullMergeTransactionEnd(_front) && _p.x==_front_x && _p.hspeed==_front_hspeed,
            "Closing one native firing transaction twice repeated its motion")
        // A fresh deferred frame updates the root baseline rather than moving
        // its actual actor back to a past shot's coordinates/options/resources.
        current_frame+=2
        _p.x=8100; _p.y=8120; _p.hspeed=7*timescale; _p.vspeed=8*timescale
        _p.ammo[Ammo.Bullets]=91; GameCont.rad=92; _p.wkick=6
        with(BackCont) { shake=9; viewx2=10; viewy2=11 }
        var _later=scrNTTEFullMergeFireFrame(_weapon,_p,_stock)
        scrNTTEFullMergeTransactionBegin(_p,_p,_later,true)
        assert(_p.x==8100 && _stock.x==8100 && _stock.y==8120 && _stock.frame==current_frame
            && _stock.ammo[Ammo.Bullets]==91 && _stock.rads==92,
            "Deferred merged emission reused stale main position/ammo/rad frame")
        with(_p) scrFire(wep_revolver,false)
        scrNTTEFullMergeTransactionEnd(_later)
        assert(_p.x==8100 && abs(_p.hspeed-7*timescale)<0.0001,
            "Deferred native emission doubled earlier main motion")
        // Explicit legacy callers already paid before entering the pre-hook.
        var _legacy=scrNTTEFullMergeFireFrame(_weapon,_p)
        _p.ammo[_legacy.ammo_type]-=_legacy.ammo_cost; GameCont.rad-=_legacy.rads_cost
        var _expect_ammo=_p.ammo[_legacy.ammo_type]+_legacy.ammo_cost,
            _expect_rads=GameCont.rad+_legacy.rads_cost
        scrNTTEFullMergeTransactionBegin(_p,_p,_legacy,false,true)
        assert(_p.ammo[_legacy.ammo_type]==_expect_ammo && GameCont.rad==_expect_rads,
            "Explicit legacy precharge did not refund exactly its own initial cost")
        scrNTTEFullMergeTransactionEnd(_legacy,false)
        // Real owner resources may differ from the actual firing actor/proxy.
        var _actor=instance_create(8400,8400,Player)
        _actor.race=Race.Fish; _actor.index=_p.index; _actor.gunangle=0; _actor.accuracy=0
        var _separate=scrNTTEFullMergeFireFrame(_weapon,_p),_owner_x=_p.x,
            _owner_ammo=scrNTTEFullArrayCopy(_p.ammo),_owner_rads=GameCont.rad
        scrNTTEFullMergeTransactionBegin(_actor,_p,_separate)
        _p.ammo[Ammo.Bullets]-=7; GameCont.rad-=8
        with(_actor) scrFire(wep_revolver,false)
        scrNTTEFullMergeTransactionEnd(_separate)
        assert(_separate.actor==_actor && _p.x==_owner_x
            && _p.ammo[Ammo.Bullets]==_owner_ammo[Ammo.Bullets] && GameCont.rad==_owner_rads,
            "Stock transaction confused its actual actor with the owner's ammo/rad/body")
        // Seal a real explosive stock before the unsuccessful front. Cleanup
        // must avoid Grenade.Destroy and exclude later unrelated instances.
        var _explosive=scrNTTEFullMergeFireFrame(scrNTTEFullWeaponMerge(wep_grenade_launcher,wep_revolver),_p)
        scrNTTEFullMergeTransactionBegin(_p,_p,_explosive)
        with(_p) scrFire(wep_grenade_launcher,false)
        scrNTTEFullMergeTransactionEnd(_explosive)
        var _grenade=noone
        for(var _i=0;_i<array_length(_explosive.assets);++_i)
            if(instance_exists(_explosive.assets[_i]) && instance_is(_explosive.assets[_i],Grenade)) _grenade=_explosive.assets[_i]
        assert(instance_exists(_grenade),"Native failure fixture lost actual stock Grenade")
        var _unrelated=instance_create(_p.x+100,_p.y,Dust),_explosions=instance_number(Explosion),
            _failed=scrNTTEFullMergeFireFrame(_weapon,_p,_explosive)
        scrNTTEFullMergeTransactionBegin(_p,_p,_failed,true)
        _p.wkick=0; _p.reload=0
        assert(!scrNTTEFullMergeTransactionEnd(_failed,false)
            && !instance_exists(_grenade) && instance_exists(_unrelated) && instance_number(Explosion)==_explosions,
            "Failed native front did not erase sealed stock assets without destruction side effects")
        assert(_p.reload>=timescale && UberCont.opt_shake==1 && UberCont.opt_freeze==1,
            "Failed front lost minimum reload repair or outer option restoration")
        // Exercise source per-asset attenuation and restore using an actual
        // independent silent looping channel. Headless audio may be absent;
        // report that explicitly instead of claiming an audio runtime pass.
        var _minimum=scrNTTEFullMergeTransactionSoundMarker()
        _test_channel=audio_play_sound(sndPistol,1,true,0)
        var _maximum=scrNTTEFullMergeTransactionSoundMarker()
        if(_test_channel>=0 && audio_is_playing(_test_channel)) {
            scrNTTEFullMergeTransactionMuffle(_minimum,_maximum)
            assert(array_length(global.ntte_merge_muffle)>0 && audio_sound_get_gain(sndPistol)==_sound_gain,
                "First failed stock sound was not registered at its original asset gain")
            current_frame+=2
            scrNTTEFullMergeTransactionMuffle(_minimum,_maximum)
            assert(abs(audio_sound_get_gain(sndPistol)-lerp(_sound_gain,_sound_gain*0.1,0.2))<0.0001,
                "Repeated stock failure did not apply source once-per-frame sound attenuation")
            audio_stop_sound(_test_channel)
            var _other_channel=audio_is_playing(sndPistol),_attenuated=audio_sound_get_gain(sndPistol)
            scrNTTEFullMergeTransactionMuffleStep()
            var _expected=_other_channel && _sound_gain!=0 ? lerp(_attenuated,_sound_gain,0.1):_sound_gain
            if(_sound_gain!=0 && abs(1-_expected/_sound_gain)<=0.1) _expected=_sound_gain
            assert(abs(audio_sound_get_gain(sndPistol)-_expected)<0.0001,
                "Expired failed-stock channel did not use source gain restoration step")
            scrNTTEFullMergeTransactionMuffleRestore()
            assert(audio_sound_get_gain(sndPistol)==_sound_gain,
                "Merged sound cleanup did not restore its original asset gain")
            _sound_tested=true
        }
    } finally {
        if(_test_channel>=0) audio_stop_sound(_test_channel)
        scrNTTEFullMergeTransactionMuffleRestore(); global.ntte_merge_muffle=_muffles
        audio_sound_gain(sndPistol,_sound_gain,0)
        current_frame=_tick
        var _all=scrNTTEFullInstances(all)
        for(var _i=array_length(_all)-1;_i>=0;--_i) if(array_get_index(_before,_all[_i])<0 && instance_exists(_all[_i])) instance_destroy(_all[_i],false)
        scrNTTEFullAreaGeneratorRestore(_players); scrNTTEFullAreaGeneratorRestore(_game)
        scrNTTEFullAreaGeneratorRestore(_back); scrNTTEFullAreaGeneratorRestore(_uber)
    }
    scrNTTESmokeLog("FULL MERGED TRANSACTION: actual native revolver/wrench/grenade, no/legacy precharge, actor/owner isolation, same/deferred frame motion/kick/camera/resources, no-destruct stock rollback, idempotency and options/reload restoration OK")
    scrNTTESmokeLog(_sound_tested ? "FULL MERGED TRANSACTION SOUND: real silent channel range, first/repeated failure muffle and expired-channel gain restoration OK":"FULL MERGED TRANSACTION SOUND: native audio device unavailable; sound runtime assertions not executed")
}
