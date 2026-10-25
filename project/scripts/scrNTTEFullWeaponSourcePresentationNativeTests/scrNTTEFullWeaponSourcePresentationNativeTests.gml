function scrNTTEFullSourcePresentationFindClam(_state) {
    var _found=noone
    with(NTTEFullClamShield) if(variable_instance_exists(id,"ntte_clam_state") && ntte_clam_state==_state) {
        _found=id
        break
    }
    return _found
}
function scrNTTEFullWeaponSourcePresentationNativeTests() {
    scrNTTEFullWeaponNativeInit()
    var _models=scrNTTEFullArrayCopy(global.ntte_full_native_weapon_models),_progress=global.ntte_full_progress,
        _seed=random_get_seed(),_before=scrNTTEFullInstances(all),_players=scrNTTEFullAreaGeneratorSnapshot(Player),
        _p=instance_find(Player,0)
    global.ntte_full_progress=json_parse(json_stringify(_progress))
    try {
        global.ntte_full_progress.unlocks[$ "pack:red"]=true
        global.ntte_full_progress.unlocks[$ "pack:coast"]=true
        global.ntte_full_progress.unlocks[$ "pack:cave"]=true
        global.ntte_full_progress.unlocks[$ "race:beetle"]=true
        var _color=string(scrAreaGetBackroundColor(scrNTTEFullAreaId("red"))),
            _raws=[wep_ntte_entangler,wep_ntte_ultra_quasar_rifle],_seen=[{},{}]
        for(var _i=0;_i<2;++_i) {
            var _handle=scrNTTEFullWeaponNative({wep:_raws[_i]})
            for(var _tipSeed=0;_tipSeed<48;++_tipSeed) {
                random_set_seed(11300+_tipSeed)
                var _expected=_i==0?choose("@wSPLIT @sTHE @(color:"+_color+")CONTINUUM","MAKING NEW FRIENDS")
                    :choose("THE GREEN SUN","ROCKET POWERED RECOIL DAMPENING"),_next=random(100000)
                random_set_seed(11300+_tipSeed)
                var _actual=scr_weapon_get_text(_raws[_i])
                assert(_actual==_expected && random(100000)==_next,"Raw weapon tip changed original strings, choose count or RNG consumption")
                variable_struct_set(_seen[_i],_actual,true)
                random_set_seed(11300+_tipSeed)
                assert(scr_weapon_get_text(_handle)==_expected && random(100000)==_next,
                    "Physical weapon tip consumed a second raw tip choice or lost original text")
            }
            assert(array_length(variable_struct_get_names(_seen[_i]))==2,"Weapon source tip fixture missed an original choice")
            random_set_seed(6234);var _cacheNext=random(100000)
            random_set_seed(6234);scrNTTEFullWeaponNative({wep:_raws[_i]})
            assert(random(100000)==_cacheNext,"Physical registration consumed an extra source random tip event")
        }
        var _annihilatorText="@wBEND @sTHE @(color:"+_color+")CONTINUUM",
            _ann=scrNTTEFullWeaponNative({wep:wep_ntte_annihilator})
        random_set_seed(331);var _fixedNext=random(100000)
        random_set_seed(331)
        assert(scr_weapon_get_text(wep_ntte_annihilator)==_annihilatorText
            && scr_weapon_get_text(_ann)==_annihilatorText && random(100000)==_fixedNext,
            "Annihilator source dynamic color text changed or consumed random draws")
        assert(scr_weapon_get_text(wep_ntte_sawblade_gun)=="LIKE DISCS BUT @ySMARTER"
            && scr_weapon_get_text(scrNTTEFullWeaponNative({wep:wep_ntte_sawblade_gun}))=="LIKE DISCS BUT @ySMARTER",
            "Sawblade Gun source yellow emphasis was removed from its tip")
        for(var _i=0;_i<2;++_i) {
            var _raw=_i==0?wep_ntte_entangler:wep_ntte_annihilator,_module=_i==0?"entangler":"annihilator",
                _model={wep:_raw},_w=scrNTTEFullWeaponNative(_model),_different=scrNTTEFullWeaponNative({wep:_raw}),
                _red=scrNTTERefSprite("Weapon."+_module+".sprWepHUDRed"),
                _normal=scrNTTERefSprite("Weapon."+_module+".sprWepHUD"),_hud=-1
            assert(_red!=_normal && scrNTTEFullWeaponHUDSprite(_raw)==_red && scrNTTEFullWeaponHUDSprite(_w)==_red,
                "Uncursed ordinary red weapon HUD failed its distinct original red outline")
            _p.wep=_w;_p.bwep=wep_revolver;_p.curse=1;_p.bcurse=0
            with(_p) _hud=scrNTTEFullWeaponHUDSprite(_w)
            assert(_hud==_normal,"Red weapon HUD ignored the matching cursed primary physical slot")
            with(_p) _hud=scrNTTEFullWeaponHUDSprite(_different)
            assert(_hud==_red,"A different physical red weapon borrowed another slot's curse")
            _p.wep=wep_revolver;_p.bwep=_w;_p.curse=0;_p.bcurse=1
            with(_p) _hud=scrNTTEFullWeaponHUDSprite(_w)
            assert(_hud==_normal,"Red weapon HUD ignored the matching cursed secondary physical slot")
            var _radModel=scrNTTEFullWeaponMerge({wep:_raw},wep_ultra_revolver),_rad=scrNTTEFullWeaponNative(_radModel)
            assert(scr_weapon_get_rads(_rad)>0 && scrNTTEFullWeaponHUDSprite(_rad)
                ==scrNTTEFullMergeSpriteList([_normal,scrNTTEFullWeaponHUDSprite(wep_ultra_revolver)]),
                "Red stock HUD used its raw cost instead of the source merged radiation cost")
            scrNTTEFullWeaponMergeActive(_rad,false)
            assert(scrNTTEFullWeaponHUDSprite(_rad)==_red,"Inactive merge incorrectly retained a front part's radiation HUD outline")
            var _front={wep:_raw},_frontMerge=scrNTTEFullWeaponNative(scrNTTEFullWeaponMerge(wep_revolver,_front))
            _p.wep=_frontMerge;_p.curse=1;_p.bwep=wep_none;_p.bcurse=0
            with(_p) _hud=scrNTTEFullWeaponHUDSprite(_frontMerge)
            assert(_hud==scrNTTEFullMergeSpriteList([scrNTTEFullWeaponHUDSprite(wep_revolver),_red]),
                "A nested red front incorrectly inherited its outer physical slot's curse")
        }
        // Genuine state-slot Step creates the physical shield. Native held
        // handles return before the old raw-only Clam hiding path.
        var _clamModel={wep:wep_ntte_clam_shield},_clam=scrNTTEFullWeaponNative(_clamModel),
            _clamState=scrNTTEFullWeaponNativeState(_clam),_clamSprite=scrNTTERefSprite("Weapon.clam shield.sprWep"),
            _clamHUD=scrNTTERefSprite("Weapon.clam shield.sprWepHUD"),_held=-1,_visible=-1
        _p.wep=_clam;_p.bwep=wep_none;_p.ntte_state=_clamState;_p.bntte_state=undefined;_p.race=Race.Fish
        with(_p) scrNTTEFullMergedRuntimeStateStepSlots()
        var _shield=scrNTTEFullSourcePresentationFindClam(_clamState)
        assert(instance_exists(_shield) && _shield.creator==_p,"Actual canonical Clam slot Step did not create its physical source shield")
        with(_p) {_held=scrNTTEHeldSprite(_clam);_visible=scr_weapon_get_sprite(_clam)}
        assert(_held==mskNone && _visible==mskNone && scrNTTEFullWeaponHUDSprite(_clam)==_clamHUD,
            "Canonical Clam physical sprite remained visible behind its shield or hid the unconditional source HUD")
        var _differentClam=scrNTTEFullWeaponNative({wep:wep_ntte_clam_shield})
        with(_p) _visible=scrNTTEHeldSprite(_differentClam)
        scrNTTESmokeLog("CLAM PHYSICAL VIEW DIAG "+json_stringify({stock:_clam,different:_differentClam,
            stockHasShield:instance_exists(_shield),differentHasState:is_struct(scrNTTEFullValue(scrNTTEFullWeaponModel(_differentClam),"ntte_native_state",undefined)),
            visible:_visible,expectedVisible:_clamSprite,stockStateStillSame:scrNTTEFullWeaponNativeState(_clam)==_clamState}))
        assert(_visible==_clamSprite,"An unrelated physical Clam borrowed the live shield of another weapon")
        var _pickup=scrWeaponPickupCreate(154000,154000,_clam)
        assert(_pickup.sprite_index==_clamSprite && _pickup.ntte_state==_clamState,
            "Actual Clam WepPickup context was incorrectly hidden by its live shield")
        // Test a real nested front, both before its first Step and afterwards.
        var _unsteppedFront={wep:wep_ntte_clam_shield},
            _unstepped=scrNTTEFullWeaponNative(scrNTTEFullWeaponMerge(_clamModel,_unsteppedFront))
        with(_p) _held=scrNTTEHeldSprite(_unstepped)
        assert(_held==scrNTTEFullMergeSpriteList([mskNone,_clamSprite]),
            "Unstepped nested Clam borrowed the top stock's fallback physical shield state")
        _p.wep=_unstepped
        with(_p) scrNTTEFullMergedRuntimeStateStepSlots()
        var _frontState=scrNTTEFullWeaponNativeState(_unsteppedFront),_frontShield=scrNTTEFullSourcePresentationFindClam(_frontState)
        assert(instance_exists(_frontShield) && _frontShield!=_shield && _frontShield.ntte_clam_state!=_clamState,
            "Actual merged front Clam Step lost its independent physical shield identity")
        with(_p) _held=scrNTTEHeldSprite(_unstepped)
        assert(_held==scrNTTEFullMergeSpriteList([mskNone,mskNone]),
            "Merged stock/front Clam source sprites were drawn over their genuine shield entities")
        instance_destroy(_frontShield)
        with(_p) _held=scrNTTEHeldSprite(_unstepped)
        assert(_held==scrNTTEFullMergeSpriteList([mskNone,_clamSprite]),
            "Destroying a front shield failed to restore only that physical part's visible source sprite")
        // Original availability takes priority over physical invisibility.
        global.ntte_full_progress.unlocks[$ "pack:coast"]=false
        scrNTTEFullWeaponMergeActive(_unstepped,false)
        with(_p) _held=scrNTTEHeldSprite(_unstepped)
        assert(_held==scrNTTEFullWeaponLockedSprite(wep_ntte_clam_shield),
            "Live shield incorrectly hid source locked Clam art")
    }
    finally {
        scrNTTEFullMergedRuntimeTestCleanup(_before)
        scrNTTEFullAreaGeneratorRestore(_players)
        global.ntte_full_native_weapon_models=_models;global.ntte_full_progress=_progress;random_set_seed(_seed)
    }
    scrNTTESmokeLog("FULL WEAPON SOURCE PRESENTATION: raw/physical exact randomized+colored source tips and RNG/cache neutrality, red/normal physical curse+radiation/inactive+front HUD, genuine canonical+merged Clam shield Step, per-part art hiding/reappearance, pickup/locked/HUD contexts OK @"+string(30/timescale))
}
