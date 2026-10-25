function scrNTTEFullTunnellerGoldMetadataNativeTests() {
    scrNTTEFullWeaponNativeInit()
    var _models=scrNTTEFullArrayCopy(global.ntte_full_native_weapon_models),
        _progress=global.ntte_full_progress,_seed=random_get_seed(),_before=scrNTTEFullInstances(all),
        _players=scrNTTEFullAreaGeneratorSnapshot(Player)
    global.ntte_full_progress=json_parse(json_stringify(_progress))
    try {
        global.ntte_full_progress.unlocks[$ "pack:red"]=true
        var _normal={wep:wep_ntte_tunneller,gold:false},_gold={wep:wep_ntte_tunneller,gold:true},
            _n=scrNTTEFullWeaponNative(_normal),_g=scrNTTEFullWeaponNative(_gold),
            _goldSprite=scrNTTERefSprite("GoldTunneller"),_normalSprite=scrNTTERefSprite("Tunneller"),
            _goldLoadout=scrNTTERefSprite("GoldTunnellerLoadout"),_normalLoadout=scrNTTERefSprite("TunnellerLoadout")
        assert(scr_weapon_get_name(_n)=="TUNNELLER" && scr_weapon_get_name(_g)=="GOLDEN TUNNELLER"
            && scr_weapon_get_sprite(_n)==_normalSprite && scr_weapon_get_sprite(_g)==_goldSprite
            && scrNTTEFullWeaponNativeSprite(_g,true,scrNTTEFullWeaponNativeState(_g))==_goldSprite
            && scr_weapon_get_loadout_sprite(_n)==_normalLoadout && scr_weapon_get_loadout_sprite(_g)==_goldLoadout
            && scr_weapon_get_area(_n)==22 && scr_weapon_get_area(_g)==-1
            && scr_weapon_is_golden(_n)==0 && scr_weapon_is_golden(_g)==-1,
            "Canonical Tunneller LWO.gold failed source name/held/pickup art/loadout/area/gold metadata")
        assert(scr_weapon_get_name(wep_ntte_tunneller)==scr_weapon_get_name(_n)
            && scr_weapon_get_sprite(wep_ntte_tunneller)==scr_weapon_get_sprite(_n)
            && scr_weapon_get_loadout_sprite(wep_ntte_tunneller)==scr_weapon_get_loadout_sprite(_n)
            && scr_weapon_get_area(wep_ntte_tunneller)==scr_weapon_get_area(_n)
            && scr_weapon_get_name(wep_ntte_golden_tunneller)==scr_weapon_get_name(_g)
            && scr_weapon_get_sprite(wep_ntte_golden_tunneller)==scr_weapon_get_sprite(_g)
            && scr_weapon_get_loadout_sprite(wep_ntte_golden_tunneller)==scr_weapon_get_loadout_sprite(_g)
            && scr_weapon_get_area(wep_ntte_golden_tunneller)==-1
            && scr_weapon_is_golden(wep_ntte_golden_tunneller)!=0,
            "Physical gold metadata broke ordinary/separate golden native ID compatibility")
        var _color=string(scrAreaGetBackroundColor(scrNTTEFullAreaId("red"))),_seenNormal={},_seenGold={}
        for(var _tipSeed=0;_tipSeed<48;++_tipSeed) for(var _isGold=0;_isGold<2;++_isGold) {
            var _tipWeapon=_isGold?_g:_n
            random_set_seed(1000+_tipSeed)
            var _expected=_isGold?choose("GOLDEN GOD","@(color:"+_color+")KEY @sTO THE @wMULTIVERSE")
                :choose("@wUNLOCK @sTHE @(color:"+_color+")CONTINUUM","FULL CIRCLE","YET ANOTHER @(color:"+_color+")RED KEY"),
                _next=random(100000)
            random_set_seed(1000+_tipSeed)
            var _actual=scr_weapon_get_text(_tipWeapon),_actualNext=random(100000)
            assert(_actual==_expected && _actualNext==_next,"Physical Tunneller text changed original choice strings/count or random consumption")
            variable_struct_set(_isGold?_seenGold:_seenNormal,_actual,true)
            // Ordinary/separate-gold numeric IDs use the same source event.
            random_set_seed(1000+_tipSeed)
            assert(scr_weapon_get_text(_isGold?wep_ntte_golden_tunneller:wep_ntte_tunneller)==_expected
                && random(100000)==_next,"Raw native Tunneller text failed the same source choose consumption")
        }
        assert(array_length(variable_struct_get_names(_seenNormal))==3 && array_length(variable_struct_get_names(_seenGold))==2,
            "Tunneller text fixture did not exercise every original ordinary/gold tip")
        random_set_seed(71828);var _cacheNext=random(100000)
        random_set_seed(71828);scrNTTEFullWeaponNative({wep:wep_ntte_tunneller,gold:true})
        assert(random(100000)==_cacheNext,"Native physical registration compatibility caches consumed an extra source tip random draw")
        var _redHud=scrNTTERefSprite("TunnellerHUDRed"),_plainHud=scrNTTERefSprite("TunnellerHUD"),
            _hud=-1,_p=instance_find(Player,0)
        assert(scrNTTEFullWeaponHUDSprite(_n)==_redHud && scrNTTEFullWeaponHUDSprite(_g)==_plainHud
            && scrNTTEFullWeaponHUDSprite(wep_ntte_tunneller)==_redHud
            && scrNTTEFullWeaponHUDSprite(wep_ntte_golden_tunneller)==_plainHud,
            "Actual HUD getter failed ordinary red outline or gold normal outline outside Player context")
        _p.wep=_n;_p.bwep=wep_revolver;_p.curse=1;_p.bcurse=0
        with(_p) _hud=scrNTTEFullWeaponHUDSprite(_n)
        assert(_hud==_plainHud,"Tunneller HUD ignored actual cursed primary physical slot")
        _p.wep=wep_revolver;_p.bwep=_n;_p.curse=0;_p.bcurse=1
        with(_p) _hud=scrNTTEFullWeaponHUDSprite(_n)
        assert(_hud==_plainHud,"Tunneller HUD ignored actual cursed secondary physical slot")
        _p.wep=wep_revolver;_p.bwep=wep_none;_p.curse=1;_p.bcurse=1
        with(_p) _hud=scrNTTEFullWeaponHUDSprite(_n)
        assert(_hud==_redHud,"A different cursed weapon incorrectly changed the Tunneller HUD outline")
        var _radStock={wep:wep_ntte_tunneller,gold:false},_radMerge=scrNTTEFullWeaponNative(scrNTTEFullWeaponMerge(_radStock,wep_ultra_revolver))
        assert(scr_weapon_get_rads(_radMerge)>0
            && scrNTTEFullWeaponHUDSprite(_radMerge)==scrNTTEFullMergeSpriteList([_plainHud,scrNTTEFullWeaponHUDSprite(wep_ultra_revolver)]),
            "Tunneller stock HUD failed actual merged radiation cost context")
        // Public getters are live; changing a genuine LWO field must not depend
        // on stale native table caches or replace its physical state object.
        var _state=scrNTTEFullWeaponNativeState(_g)
        _state.ammo=9;_gold.gold=false
        assert(scr_weapon_get_name(_g)=="TUNNELLER" && scr_weapon_get_sprite(_g)==_normalSprite
            && scr_weapon_get_loadout_sprite(_g)==_normalLoadout && scr_weapon_get_area(_g)==22
            && scr_weapon_is_golden(_g)==0 && scrNTTEFullWeaponNativeState(_g)==_state,
            "Live Tunneller gold toggling used stale metadata or discarded physical state")
        _gold.gold=true
        var _pickup=scrWeaponPickupCreate(150000,150000,_g)
        assert(_pickup.wep==_g && _pickup.name=="GOLDEN TUNNELLER" && _pickup.sprite_index==_goldSprite
            && _pickup.ntte_state==_state,"Actual native pickup factory lost canonical golden Tunneller metadata/state")
        // Source temerge reducers operate on each original physical stock.
        var _merge=scrNTTEFullWeaponMerge(_gold,wep_golden_revolver),_m=scrNTTEFullWeaponNative(_merge)
        assert(scr_weapon_get_name(_m)==scrNTTEFullMergeNameStrings("GOLDEN TUNNELLER",scr_weapon_get_name(wep_golden_revolver))
            && scr_weapon_get_sprite(_m)==scrNTTEFullMergeSpriteList([_goldSprite,scr_weapon_get_sprite(wep_golden_revolver)])
            && scr_weapon_get_loadout_sprite(_m)==scrNTTEFullMergeLoadoutList([_goldLoadout,scr_weapon_get_loadout_sprite(wep_golden_revolver)])
            && scr_weapon_get_area(_m)==max(-1,scr_weapon_get_area(wep_golden_revolver))
            && scr_weapon_is_golden(_m)==min(-1,scr_weapon_is_golden(wep_golden_revolver)),
            "Actual merged Tunneller getters flattened the physical stock gold metadata or source reducers")
        scrNTTEFullWeaponMergeActive(_m,false)
        assert(scr_weapon_get_name(_m)=="GOLDEN TUNNELLER" && scr_weapon_get_sprite(_m)==_goldSprite
            && scr_weapon_get_loadout_sprite(_m)==_goldLoadout && scr_weapon_get_area(_m)==-1
            && scr_weapon_is_golden(_m)==-1,"Inactive merge failed original physical Tunneller stock gold metadata")
        // Actual physical skin wrapping now sees the source golden sprite of
        // canonical LWO.gold, rather than requiring the compatibility raw ID.
        var _coat=global.ntte_full_weapon_skin(_m,"coat venuz",id)
        assert(_coat==_m && scrNTTEFullWeaponModel(_coat)==_gold
            && scr_weapon_get_name(_coat)=="COAT TUNNELLER"
            && scr_weapon_get_sprite(_coat)==scrNTTERefSprite("CoatTunneller")
            && scr_weapon_get_loadout_sprite(_coat)==_goldLoadout
            && scrNTTEFullWeaponNativeSprite(_coat,false,undefined,true)==scrNTTERefSprite("CoatTunnellerHUD"),
            "Canonical gold Tunneller failed its original physical coat skin/HUD or invented skinned loadout art")
        global.ntte_full_progress.unlocks[$ "pack:red"]=false
        assert(scr_weapon_get_name(_n)=="LOCKED" && scr_weapon_get_name(_g)=="COAT LOCKED"
            && scr_weapon_get_sprite(_n)==scrNTTEFullWeaponLockedSprite(wep_ntte_tunneller)
            && scr_weapon_get_sprite(_g)==scrNTTEFullWeaponLockedSprite(wep_ntte_tunneller)
            && scr_weapon_get_loadout_sprite(_g)==_goldLoadout && scr_weapon_get_area(_n)==-1
            && scr_weapon_get_area(_g)==-1 && scr_weapon_is_golden(_g)==-1,
            "Source availability/locked art, unconditional loadout/gold or tagged name wrapper semantics diverged")
        global.ntte_full_progress.unlocks[$ "pack:red"]=true
        var _encoded=json_parse(json_stringify(scrNTTEFullWeaponNativeExport()))
        scrNTTEFullWeaponNativeImport(_encoded)
        assert(scrNTTEFullWeaponModel(_g).gold && scrNTTEFullWeaponNativeState(_g).ammo==9
            && scr_weapon_get_name(_g)=="COAT TUNNELLER"
            && scr_weapon_get_sprite(_g)==scrNTTERefSprite("CoatTunneller")
            && scr_weapon_is_golden(_g)==-1 && scr_weapon_get_area(_g)==-1,
            "Actual native JSON continuation lost live source gold metadata or persistent coat wrapper")
    }
    finally {
        scrNTTEFullMergedRuntimeTestCleanup(_before)
        scrNTTEFullAreaGeneratorRestore(_players)
        global.ntte_full_native_weapon_models=_models;global.ntte_full_progress=_progress;random_set_seed(_seed)
    }
    scrNTTESmokeLog("FULL TUNNELLER GOLD METADATA: physical gold live name/held+pickup art/loadout/area/gold, exact source text choices+RNG/cache neutrality, real normal/gold/radiation/primary+secondary curse HUD, raw/separate native ID compatibility, actual pickup state, source merged reducers/inactive stock, coat/locked skin and JSON persistence OK @"+string(30/timescale))
}
