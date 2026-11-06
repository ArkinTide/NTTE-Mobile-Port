function scrNTTEFullWeaponSkinNativeTests() {
    assert(scrNTTESmokeEnabled(),"Weapon skin purchase fixture requires the explicit smoke harness")
    // The physical registry is intentionally lazy in production; an ordinary
    // fresh game need not have created any LWO before the first coat purchase.
    scrNTTEFullWeaponNativeInit()
    var _before=scrNTTEFullInstances(all),_players=scrNTTEFullAreaGeneratorSnapshot(Player),
        _pinst=scr_playerinstance_find(instance_find(Player,0).index),_oldSkin=_pinst.skin,
        _game=scrNTTEFullAreaGeneratorSnapshot(GameCont),
        _keys=scrNTTEFullAreaGeneratorSnapshot(KeyCont),_back=scrNTTEFullAreaGeneratorSnapshot(BackCont),
        _uber=scrNTTEFullAreaGeneratorSnapshot(UberCont),_progress=global.ntte_full_progress,
        _models=scrNTTEFullArrayCopy(global.ntte_full_native_weapon_models),_seed=random_get_seed(),
        _frame=current_frame,_stop=lockstep_stop,_directory=game_directory,
        _scratch=working_directory+"weapon-skin-native-fixture/",
        _parked=scrNTTEFullInstances([NTTEFullChestShop,NTTEFullPrompt,WepPickup])
    directory_create(_scratch);game_directory=_scratch
    for(var _i=0;_i<array_length(_parked);++_i) instance_deactivate_object(_parked[_i])
    global.ntte_full_progress={schema:1,unlocks:{},loadouts:{},stats:{}}
    try {
        assert(variable_global_exists("ntte_full_weapon_skin") && is_callable(global.ntte_full_weapon_skin),
            "Real GameCont Create failed to bind the coat weapon adapter")
        lockstep_stop=false
        var _p=instance_find(Player,0),_shop=noone,_siblings=[]
        _p.x=149000;_p.y=149000;_p.xprevious=_p.x;_p.yprevious=_p.y
        _p.race=Race.Venuz;_p.bskin=0;_p.wep=wep_revolver;_p.bwep=wep_none
        _p.speed=0;_p.visible=true;_p.can_pick=true;_p.max_extra_weps=0;_p.extra_weps=[]
        _p.ntte_state=scrNTTENewState(wep_revolver);_p.bntte_state=undefined
        KeyCont.hold_fire[_p.index]=false;KeyCont.hold_spec[_p.index]=false;KeyCont.press_pick[_p.index]=false
        GameCont.crown=Crown.None;GameCont.loops=0;GameCont.hard=3
        random_set_seed(271828)
        // Genuine CatChest opening uses its original weighted, without-
        // replacement pool. Repeat real chests until the eligible coat appears.
        for(var _attempt=0;_attempt<32 && !instance_exists(_shop);++_attempt) {
            var _cat=scrNTTEFullLairChestCreate(_p.x,_p.y,"CatChest",true),_cat_id=_cat,_choices=[]
            with(_cat) scrNTTEFullCustomChestOpen(_p)
            with(NTTEFullChestShop) if(creator==_cat_id) {
                scrNTTEFullChestShopSetup();array_push(_choices,id)
                if(drop=="coat") _shop=id
            }
            if(instance_exists(_shop)) _siblings=_choices
            else for(var _i=0;_i<array_length(_choices);++_i) with(_choices[_i]) instance_destroy()
        }
        assert(instance_exists(_shop) && array_length(_siblings)==3 && !scrNTTEFullUnlockGet("skin:coat venuz"),
            "Natural Venuz CatChest pool did not expose the source coat offer")
        // Actual per-frame shop/prompt events publish visibility and follow
        // the real shop after CatChest moved its three choices apart.
        with(_shop) event_perform(ev_step,ev_step_normal)
        with(_shop.prompt) event_perform(ev_step,ev_step_normal)
        _p.x=_shop.x;_p.y=_shop.y;_p.xprevious=_p.x;_p.yprevious=_p.y
        KeyCont.press_pick[_p.index]=true
        with(_p) event_perform(ev_step,ev_step_normal)
        assert(_shop.prompt.pick==_p.index,"Native Player pickup input did not select the actual coat shop prompt")
        KeyCont.press_pick[_p.index]=false
        with(_shop) event_perform(ev_step,ev_step_normal)
        var _drop=noone
        with(WepPickup) if(array_get_index(_before,id)<0 && scrNTTEFullWeaponSkinKey(wep)=="coat venuz") _drop=id
        assert(instance_exists(_drop) && _drop.ammo && _p.bskin==203 && scrNTTEFullUnlockGet("skin:coat venuz"),
            "Actual coat purchase failed body skin/unlock or its genuine tagged golden revolver product")
        for(var _i=0;_i<array_length(_siblings);++_i)
            assert(_siblings[_i].open==0,"Real coat purchase did not consume sibling shop stock")
        var _handle=_drop.wep,_model=scrNTTEFullWeaponModel(_handle),_physical=_drop.ntte_state
        assert(scrNTTEFullWeaponIsNative(_handle) && scrNTTEFullWeaponRaw(_handle)==wep_golden_revolver
            && scr_weapon_get_sprite(_handle)==scrNTTERefSprite("CoatRevolver")
            && scr_weapon_get_name(_handle)=="COAT REVOLVER"
            && scr_weapon_get_cost(_handle)==scr_weapon_get_cost(wep_golden_revolver),
            "Coat purchase flattened its source physical skin wrapper or altered native stats")
        // A purchase closes stock now; the actual following shop frame hides
        // its prompt. Native weapon collision correctly yields to a visible
        // interaction prompt until that real event has run.
        for(var _i=0;_i<array_length(_siblings);++_i)
            with(_siblings[_i]) event_perform(ev_step,ev_step_normal)
        _p.x=_drop.x;_p.y=_drop.y
        _drop.speed=0;_drop.autopick=true
        with(_drop) with(_p) event_perform(ev_collision,WepPickup)
        scrNTTESmokeLog("COAT PICKUP DIAG "+json_stringify({dropExists:instance_exists(_drop),
            held:_p.wep,expected:_handle,sameState:_p.ntte_state==_physical,canPick:_p.can_pick,
            prompt:scrNTTEFullPromptWinner(_p),nearest:instance_nearest(_p.x,_p.y,WepPickup),
            curse:_p.curse,back:_p.bwep,stop:lockstep_stop}))
        assert(!instance_exists(_drop) && _p.wep==_handle && _p.ntte_state==_physical,
            "Actual native pickup failed to equip the purchased physical coat weapon/state")
        with(_p) scrSwapWeps(false)
        assert(_p.bwep==_handle && _p.bntte_state==_physical,"Coat tag/state failed real native weapon swap")
        with(_p) scrSwapWeps(false)
        // Actual raw native fire comparisons preserve mechanics and hitboxes.
        // A different custom owner must not repaint a physical coat weapon.
        _p.race=Race.Robot;_p.bskin=202;_p.gunangle=0;_p.accuracy=0;_p.infammo=0
        _p.ammo=array_create(Ammo.NUM_AMMO_TYPES,100);GameCont.rad=100
        var _shot_before=scrNTTEFullInstances(all),_raw_bolt=noone
        with(_p) scrFire(wep_golden_crossbow,false)
        with(Bolt) if(array_get_index(_shot_before,id)<0) _raw_bolt=id
        // The owner currently repaints the raw weapon; compare native shape
        // against the original explicit collision mask when one is present.
        var _mask=_raw_bolt.mask_index,_damage=_raw_bolt.damage,_speed=_raw_bolt.speed
        var _cross=global.ntte_full_weapon_skin(wep_golden_crossbow,"coat venuz",id)
        _p.wep=_cross;_p.ntte_state=scrNTTEFullWeaponNativeState(_cross)
        _shot_before=scrNTTEFullInstances(all)
        with(_p) scrFire(_cross,false)
        var _bolt=noone
        with(Bolt) if(array_get_index(_shot_before,id)<0) _bolt=id
        assert(instance_exists(_bolt) && _bolt.creator==_p && _bolt.sprite_index==scrNTTERefSprite("CoatBolt")
            && _bolt.mask_index==(_mask<0?sprBoltGold:_mask) && _bolt.damage==_damage && _bolt.speed==_speed,
            "Actual physical coat bolt lost owner independence, original collision shape or native damage/speed")
        var _disc_weapon=global.ntte_full_weapon_skin(wep_golden_disc_gun,"coat venuz",id)
        _p.wep=_disc_weapon;_p.ntte_state=scrNTTEFullWeaponNativeState(_disc_weapon)
        _shot_before=scrNTTEFullInstances(all)
        with(_p) scrFire(_disc_weapon,false)
        var _disc=noone
        with(Disc) if(array_get_index(_shot_before,id)<0) _disc=id
        scrNTTESmokeLog("COAT DISC DIAG "+json_stringify({exists:instance_exists(_disc),
            sprite:scrNTTEFullValue(_disc,"sprite_index",-1),expectedSprite:scrNTTERefSprite("CoatDisc"),
            hitid:scrNTTEFullValue(_disc,"hitid",undefined),nativeDisc:HitId.Disc,
            weapon:_disc_weapon,tag:scrNTTEFullWeaponSkinKey(_disc_weapon)}))
        assert(instance_exists(_disc) && _disc.sprite_index==scrNTTERefSprite("CoatDisc")
            && is_array(_disc.hitid) && _disc.hitid[0]==scrNTTERefSprite("CoatDisc") && _disc.hitid[1]=="COAT DISC",
            "Actual golden disc failed original source hitid101 cause-of-death remapping")
        assert(scrNTTEFullWeaponSkinName(_handle,"golden X GOLDEN")=="COAT X COAT"
            && scrNTTEFullWeaponSkinName(_handle,"GOLDENISH")=="COAT GOLDENISH"
            && scrNTTEFullWeaponSkinName(_handle,"COAT X")=="COAT X"
            && global.ntte_full_weapon_skin(wep_revolver,"coat venuz",id)==wep_revolver,
            "Skin wrapper name words, no-double-prefix or unremapped ordinary weapon semantics differ from source")
        // Actual native Burst stock followed by physical golden-crossbow front:
        // all three genuine emissions pass the real deferred event dispatcher.
        var _merge=scrNTTEFullWeaponMerge(wep_golden_assault_rifle,wep_golden_crossbow),
            _merged=global.ntte_full_weapon_skin(_merge,"coat venuz",id)
        _p.wep=_merged;_p.ntte_state=scrNTTEFullWeaponNativeState(_merged)
        _p.ammo=array_create(Ammo.NUM_AMMO_TYPES,100)
        _shot_before=scrNTTEFullInstances(all)
        with(_p) scrFire(_merged,false)
        var _burst=noone
        with(Burst) if(array_get_index(_shot_before,id)<0) _burst=id
        assert(instance_exists(_burst) && _burst.ntte_merged_runtime_at.part==_merge
            && scrNTTEFullWeaponSkinKey(_merge)=="coat venuz"
            && scrNTTEFullWeaponSkinKey(scrNTTEFullWeaponMergedPart(_merge))=="coat venuz",
            "Skinning active merge lost stock/front physical identity or actual delayed controller part")
        current_frame+=2;with(_burst) event_perform(ev_alarm,0)
        current_frame+=2;with(_burst) event_perform(ev_alarm,0)
        var _count=0
        with(Bolt) if(array_get_index(_shot_before,id)<0) {
            ++_count
            assert(sprite_index==scrNTTERefSprite("CoatBolt") && creator==_p,
                "Actual deferred merged front fired an owner-reskinned or unskinned bolt")
        }
        assert(_count==3,"Physical coat merge did not preserve all three actual native burst emissions")
        // Source only wraps when the currently available weapon sprite has a
        // skin remap. A locked Red-pack Tunneller correctly has no gold art.
        global.ntte_full_progress.unlocks[$ "pack:red"]=true
        var _tunnel=global.ntte_full_weapon_skin(wep_ntte_golden_tunneller,"coat venuz",id)
        scrNTTESmokeLog("COAT HUD DIAG "+json_stringify({weapon:_tunnel,tag:scrNTTEFullWeaponSkinKey(_tunnel),
            sprite:scr_weapon_get_sprite(_tunnel),hud:scrNTTEFullWeaponNativeSprite(_tunnel,false,undefined,true),
            expected:scrNTTERefSprite("CoatTunnellerHUD"),available:scrNTTEFullWeaponAvailable(_tunnel)}))
        assert(scrNTTEFullWeaponNativeSprite(_tunnel,false,undefined,true)==scrNTTERefSprite("CoatTunnellerHUD"),
            "Physical weapon skin HUD failed the source-specific TunnellerHUD remap")
        // Global callback dispatch must preserve the real caller instance.
        // Source Super Teleport Gun's drop area reads the caller's curse;
        // this unmapped struct still refreshes its physical native metadata.
        var _contextModel={wep:wep_ntte_super_teleport_gun},_contextHandle=wep_none
        _p.curse=1
        global.ntte_full_weapon_skin_debug_context=true
        with(_p) _contextHandle=global.ntte_full_weapon_skin(_contextModel,"coat venuz",id)
        global.ntte_full_weapon_skin_debug_context=false
        // Alias the actual compatibility table so the legacy-read rewriter
        // cannot turn this cache assertion into a fresh out-of-context getter.
        var _contextAreas=wep_area
        var _contextDirectRaw=-999,_contextDirectModel=-999
        with(_p) {
            _contextDirectRaw=scr_weapon_get_area(wep_ntte_super_teleport_gun)
            _contextDirectModel=scr_weapon_get_area(_contextHandle)
        }
        scrNTTESmokeLog("COAT CONTEXT DIAG "+json_stringify({weapon:_contextHandle,player:_p.id,
            playerCurse:_p.curse,cachedArea:_contextAreas[_contextHandle],
            directPlayerRawArea:_contextDirectRaw,directPlayerModelArea:_contextDirectModel,
            raw:scrNTTEFullWeaponRaw(_contextHandle),sameModel:scrNTTEFullWeaponModel(_contextHandle)==_contextModel}))
        assert(_contextAreas[_contextHandle]==13,
            "Global weapon skin callback lost the actual cursed Player getter context")
        _p.curse=0
        with(_p) _contextHandle=global.ntte_full_weapon_skin(_contextHandle,"coat venuz",id)
        _contextAreas=wep_area
        assert(_contextAreas[_contextHandle]==-1,
            "Global weapon skin callback reused a bound/stale Player curse context")
        // Real JSON graph persistence must retain tags without callable loss.
        _physical.ammo=7
        var _serialized=json_parse(json_stringify(scrNTTEFullWeaponNativeExport()))
        scrNTTEFullWeaponNativeImport(_serialized)
        assert(scrNTTEFullWeaponSkinKey(_handle)=="coat venuz"
            && scr_weapon_get_name(_handle)=="COAT REVOLVER"
            && scr_weapon_get_sprite(_handle)==scrNTTERefSprite("CoatRevolver")
            && scrNTTEFullWeaponNativeState(_handle).ammo==7
            && scrNTTEFullWeaponSkinKey(scrNTTEFullWeaponMergedPart(_merged))=="coat venuz",
            "Native JSON weapon continuation lost persistent stock/front skin wrapper tags")
    }
    finally {
        global.ntte_full_weapon_skin_debug_context=false
        scrNTTEFullMergedRuntimeTestCleanup(_before)
        for(var _i=0;_i<array_length(_parked);++_i) instance_activate_object(_parked[_i])
        scrNTTEFullAreaGeneratorRestore(_players);_pinst.skin=_oldSkin
        scrNTTEFullAreaGeneratorRestore(_game);scrNTTEFullAreaGeneratorRestore(_keys)
        scrNTTEFullAreaGeneratorRestore(_back);scrNTTEFullAreaGeneratorRestore(_uber)
        global.ntte_full_native_weapon_models=_models;global.ntte_full_progress=_progress
        game_directory=_directory;lockstep_stop=_stop;current_frame=_frame;random_set_seed(_seed)
    }
    scrNTTESmokeLog("FULL PHYSICAL WEAPON SKIN: real CatChest weighted coat offer/native Player input/purchase/body unlock/tagged pickup+swap, native independent-owner bolt+disc shape/death identity, merged Burst delayed fronts, HUD and JSON persistence OK @"+string(30/timescale))
}
