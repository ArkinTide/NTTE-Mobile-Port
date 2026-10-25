function scrNTTEFullDynamicWeaponAutoTests() {
    var _before=scrNTTEFullInstances(all),_players=scrNTTEFullAreaGeneratorSnapshot(Player),
        _game=scrNTTEFullAreaGeneratorSnapshot(GameCont),_back=scrNTTEFullAreaGeneratorSnapshot(BackCont),
        _uber=scrNTTEFullAreaGeneratorSnapshot(UberCont),_keys=scrNTTEFullAreaGeneratorSnapshot(KeyCont),
        _seed=random_get_seed(),_frame=current_frame,_skills=ds_list_create()
    scrNTTEFullWeaponNativeInit()
    var _models=scrNTTEFullArrayCopy(global.ntte_full_native_weapon_models)
    GameCont.skills=_skills;GameCont.ntte_full_native_skill_counts={};GameCont.area=1;GameCont.underwater=false
    current_frame=2
    try {
        var _p=instance_find(Player,0),_auto=undefined
        _p.x=96000;_p.y=96000;_p.xprevious=_p.x;_p.yprevious=_p.y;_p.speed=0
        _p.wep=wep_ntte_pizza_cutter;_p.bwep=wep_none;_p.ntte_state=scrNTTENewState(_p.wep)
        _p.gunangle=0;_p.accuracy=0;_p.wepangle=120;_p.wkick=0;_p.race=Race.Fish;_p.infammo=0
        _p.reloadspeed=1;_p.reload=0;_p.can_shoot=true;_p.clicked=false;_p.visible=true;_p.specfiring=false
        _p.ammo=array_create(Ammo.NUM_AMMO_TYPES,100);GameCont.rad=100
        var _state=_p.ntte_state,_slash_count=instance_number(Slash)
        _state.ammo=0;_state.loaded=false;_state.outstanding=1
        KeyCont.hold_fire[_p.index]=true;KeyCont.press_fire[_p.index]=false
        with(_p) {_auto=scr_weapon_is_auto(wep);scrPlayerFiring()}
        assert(!_auto && instance_number(Slash)==_slash_count && _state.charge==0 && _p.can_shoot,
            "Actual PlayerFiring ignored empty Pizza physical auto=false and repeated held discless attacks")
        KeyCont.press_fire[_p.index]=true
        with(_p) scrPlayerFiring()
        var _slashes=scrNTTEFullMergedRuntimeTestShots(scrNTTEFullMergedRuntimeNew(_before),Slash)
        assert(array_length(_slashes)==1 && _slashes[0].damage==8 && _slashes[0].force==6,
            "Actual PlayerFiring press did not retain Pizza discless single-click attack")
        // Return an actual owned blade. Public auto updates immediately from
        // that physical state without re-registering a model or editing tables.
        var _disc=noone
        with(_p) _disc=scrNTTEFullMergedBasicProjectileCreate(x,y,NTTEFullBatDisc,0)
        scrNTTEFullBatDiscBind(_disc,_state,1);instance_destroy(_disc)
        _p.can_shoot=true;_p.reload=0;_p.clicked=false;KeyCont.press_fire[_p.index]=false
        with(_p) {_auto=scr_weapon_is_auto(wep);scrPlayerFiring()}
        assert(_auto && _state.ammo==1 && _state.outstanding==0 && _state.chrg_num==0
            && instance_number(Slash)==_slash_count+2 && _p.ntte_charge_primary.phase==1,
            "Actual disc cleanup did not make Pizza auto=true and perform the requested ordinary attack before held charging")
        scrNTTEFullMergedRuntimeTestCleanup(_before)
        // Same raw ID, different physical slots: the native real slot swap
        // changes the getter to exactly the active firing state.
        _state.charge=0;_state.chrg_num=0;_state.chrg=0;_state.loaded=false
        _p.bwep=wep_ntte_pizza_cutter;_p.bntte_state=scrNTTENewState(_p.bwep)
        with(_p) _auto=scr_weapon_is_auto(wep)
        assert(!_auto,"Ordinary empty Pizza borrowed secondary identical-raw magazine")
        with(_p) {scrSwapWeps(false);_auto=scr_weapon_is_auto(wep)}
        assert(_auto && _p.ntte_state!=_state,"Actual native secondary swap did not expose its own loaded Pizza auto")
        with(_p) scrSwapWeps(false)
        assert(_p.ntte_state==_state,"Auto-property evaluation changed actual native inventory state")
        // Two canonical physical models of the same type cannot share auto.
        var _a={wep:wep_ntte_pizza_cutter},_b={wep:wep_ntte_pizza_cutter},
            _ha=scrNTTEFullWeaponNative(_a),_hb=scrNTTEFullWeaponNative(_b),
            _sa=scrNTTEFullWeaponNativeState(_a),_sb=scrNTTEFullWeaponNativeState(_b),_autoa=false,_autob=false
        _sa.loaded=false;_sb.loaded=true
        with(_p) {_autoa=scr_weapon_is_auto(_ha);_autob=scr_weapon_is_auto(_hb)}
        assert(!_autoa && _autob,"Canonical Pizza models of identical type shared live stock auto")
        _sa.loaded=true;_sb.loaded=false
        with(_p) {_autoa=scr_weapon_is_auto(_ha);_autob=scr_weapon_is_auto(_hb)}
        assert(_autoa && !_autob,"Canonical Pizza live auto depended on stale native registration tables")
        var _model_count=array_length(global.ntte_full_native_weapon_models)
        repeat(5) with(_p) {_autoa=scr_weapon_is_auto(_ha);_autob=scr_weapon_is_auto(_hb)}
        assert(array_length(global.ntte_full_native_weapon_models)==_model_count,
            "Source dynamic auto query registered replacement physical weapons")
        // Preserve every original reducer boundary: physical front only
        // overrides a nonautomatic stock when the actual fire reload <=8.
        var _weapon=scrNTTEFullWeaponMerge(wep_revolver,_a),_handle=scrNTTEFullWeaponNative(_weapon)
        _weapon.temerge.wep_fire_reload=8
        with(_p) _auto=scr_weapon_is_auto(_handle)
        assert(_auto,"Physical Pizza auto was lost at exact merged source reload8 boundary")
        _weapon.temerge.wep_fire_reload=8.25
        with(_p) _auto=scr_weapon_is_auto(_handle)
        assert(!_auto,"Dynamic physical stock change widened original merged reload8 boundary")
        _weapon.temerge.wep_fire_reload=8;_sa.loaded=false
        with(_p) _auto=scr_weapon_is_auto(_handle)
        assert(!_auto,"Empty physical front retained loaded Pizza auto through original merge reducer")
        _sa.loaded=true;scrNTTEFullWeaponMergeActive(_weapon,false)
        with(_p) _auto=scr_weapon_is_auto(_handle)
        assert(!_auto,"Inactive merge still read its dynamic front auto")
        var _part=scrNTTEFullWeaponMerge(wep_none,_a),_part_handle=scrNTTEFullWeaponNative(_part)
        with(_p) _auto=scr_weapon_is_auto(_part_handle)
        assert(_auto==-1,"Physical auto property discarded original incomplete part sentinel -1")
        // Annihilator/Entangler inspect real creator resources each time. Same
        // registered handle changes at its own source2/source1 thresholds.
        var _ann=scrNTTEFullWeaponNative({wep:wep_ntte_annihilator}),_ent=scrNTTEFullWeaponNative({wep:wep_ntte_entangler}),
            _auto_ann=true,_auto_ent=true
        _p.ntte_red_ammo=0
        with(_p) {_auto_ann=scr_weapon_is_auto(_ann);_auto_ent=scr_weapon_is_auto(_ent)}
        assert(!_auto_ann && !_auto_ent,"Red weapon auto ignored absence of real owner's red ammo")
        _p.ntte_red_ammo=1
        with(_p) {_auto_ann=scr_weapon_is_auto(_ann);_auto_ent=scr_weapon_is_auto(_ent)}
        assert(!_auto_ann && _auto_ent,"Red weapon live auto lost distinct source two/one resource thresholds")
        _p.ntte_red_ammo=2
        with(_p) {_auto_ann=scr_weapon_is_auto(_ann);_auto_ent=scr_weapon_is_auto(_ent)}
        assert(_auto_ann && _auto_ent,"Red weapon live auto remained false after real owner's resource changed")
        // Real native firing proxy carries source ownership explicitly; live
        // auto must never inspect the temporary Player's unrelated red stash.
        var _actor=instance_create(96100,96000,Bandit),_proxy=instance_create(96200,96000,Player)
        _actor.ntte_red_ammo=1;_proxy.ntte_red_ammo=99;_proxy.ntte_actor_mount={owner:_actor}
        with(_proxy) {_auto_ann=scr_weapon_is_auto(_ann);_auto_ent=scr_weapon_is_auto(_ent)}
        assert(!_auto_ann && _auto_ent,"Dynamic source auto read temporary Player's resources instead of actual actor owner")
        // Actual no-red native Player firing must require a press for its
        // ordinary uncharged swing rather than force held automatic behavior.
        _p.wep=wep_ntte_annihilator;_p.ntte_state=scrNTTENewState(_p.wep);_p.ntte_red_ammo=0
        _p.can_shoot=true;_p.reload=0;_p.clicked=false;KeyCont.hold_fire[_p.index]=true;KeyCont.press_fire[_p.index]=false
        var _red_count=instance_number(NTTEFullRedSlash)
        with(_p) scrPlayerFiring()
        assert(instance_number(NTTEFullRedSlash)==_red_count,
            "Actual PlayerFiring forced no-red Annihilator into repeated automatic melee")
        KeyCont.press_fire[_p.index]=true
        with(_p) scrPlayerFiring()
        assert(instance_number(NTTEFullRedSlash)==_red_count+1,
            "Actual no-red Annihilator lost source single press melee after live auto fix")
        scrNTTESmokeLog("PASS dynamic source physical Pizza stock/front auto, real PlayerFiring hold/press/return, exact merged reload8/inactive/part, red owner2/1 thresholds/native proxy ownership; no re-registration")
    }
    finally {
        scrNTTEFullMergedRuntimeTestCleanup(_before)
        scrNTTEFullAreaGeneratorRestore(_players);scrNTTEFullAreaGeneratorRestore(_game)
        scrNTTEFullAreaGeneratorRestore(_back);scrNTTEFullAreaGeneratorRestore(_uber);scrNTTEFullAreaGeneratorRestore(_keys)
        global.ntte_full_native_weapon_models=_models;random_set_seed(_seed);current_frame=_frame;ds_list_destroy(_skills)
    }
}
