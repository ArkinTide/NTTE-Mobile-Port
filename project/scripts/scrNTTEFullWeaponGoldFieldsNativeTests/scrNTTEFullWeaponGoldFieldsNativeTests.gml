function scrNTTEFullWeaponGoldFieldsNativeTests() {
    scrNTTEFullWeaponNativeInit()
    var _models=scrNTTEFullArrayCopy(global.ntte_full_native_weapon_models),_progress=global.ntte_full_progress,
        _before=scrNTTEFullInstances(all),_players=scrNTTEFullAreaGeneratorSnapshot(Player),
        _game=scrNTTEFullAreaGeneratorSnapshot(GameCont),_keys=scrNTTEFullAreaGeneratorSnapshot(KeyCont),
        _back=scrNTTEFullAreaGeneratorSnapshot(BackCont),_seed=random_get_seed(),_p=instance_find(Player,0)
    global.ntte_full_progress=json_parse(json_stringify(_progress))
    try {
        global.ntte_full_progress.unlocks[$ "pack:coast"]=true
        var _rows=[
            [wep_ntte_teleport_gun,wep_ntte_golden_teleport_gun,"TELEPORT GUN","TeleportGun","TeleportGunLoadout","DON'T BLINK","LUXURY TRAVEL"],
            [wep_ntte_trident,wep_ntte_golden_trident,"TRIDENT","Trident","TridentLoadout","SCEPTER OF THE @bSEA","SHINE THROUGH THE SKY"]],
            _handles=[]
        for(var _i=0;_i<2;++_i) for(var _gold=0;_gold<2;++_gold) {
            var _row=_rows[_i],_model={wep:_row[0],gold:_gold!=0},_handle=scrNTTEFullWeaponNative(_model),
                _name=(_gold?"GOLDEN ":"")+_row[2],_sprite=scrNTTERefSprite((_gold?"Gold":"")+_row[3]),
                _loadout=scrNTTERefSprite((_gold?"Gold":"")+_row[4])
            array_push(_handles,_handle)
            assert(scr_weapon_get_name(_handle)==_name && scr_weapon_get_sprite(_handle)==_sprite
                && scrNTTEFullWeaponNativeSprite(_handle,true,scrNTTEFullWeaponNativeState(_handle))==_sprite
                && scrNTTEFullWeaponHUDSprite(_handle)==_sprite && scr_weapon_get_loadout_sprite(_handle)==_loadout
                && scr_weapon_get_area(_handle)==(_gold?-1:7) && scr_weapon_is_golden(_handle)==(_gold?-1:0)
                && scr_weapon_get_text(_handle)==_row[_gold?6:5],
                "Physical Teleport Gun/Trident gold field failed original live name/art/HUD/loadout/area/gold/text")
            assert(scr_weapon_get_name(_row[_gold?1:0])==_name && scr_weapon_get_sprite(_row[_gold?1:0])==_sprite
                && scr_weapon_get_text(_row[_gold?1:0])==_row[_gold?6:5],
                "Gold LWO metadata broke ordinary/separate golden native compatibility IDs")
            var _pickup=scrWeaponPickupCreate(152000+64*_i,152000+64*_gold,_handle)
            assert(_pickup.wep==_handle && _pickup.sprite_index==_sprite && _pickup.name==_name
                && _pickup.ntte_state==scrNTTEFullWeaponNativeState(_handle),
                "Actual native Teleport/Trident pickup factory lost physical golden metadata/state")
        }
        var _trident=_handles[3],_tridentState=scrNTTEFullWeaponNativeState(_trident)
        _tridentState.visible=false
        assert(scr_weapon_get_sprite(_trident)==mskNone
            && scrNTTEFullWeaponNativeSprite(_trident,true,_tridentState)==mskNone
            && scrNTTEFullWeaponHUDSprite(_trident)==mskNone
            && scrNTTEFullWeaponSwapSound(_trident)==sndSwapCursed
            && scr_weapon_get_name(_trident)=="GOLDEN TRIDENT"
            && scr_weapon_get_loadout_sprite(_trident)==scrNTTERefSprite("GoldTridentLoadout"),
            "Actual invisible Trident physical state lost source mask/swap semantics or hid unrelated metadata")
        _tridentState.visible=true
        assert(scrNTTEFullWeaponSwapSound(_trident)==sndSwapSword,
            "Visible Trident physical state failed source normal swap sound")
        assert(scrNTTEFullWeaponSwapSound(_handles[1])==sndSwapShotgun,
            "Actual Teleport Gun swap failed source base sound alongside its CrystalTB hook")
        for(var _i=0;_i<2;++_i) {
            var _goldHandle=_handles[2*_i+1],_same=scrNTTEFullWeaponModel(_goldHandle),
                _coat=global.ntte_full_weapon_skin(_goldHandle,"coat venuz",id)
            assert(_coat==_goldHandle && scrNTTEFullWeaponModel(_coat)==_same
                && scr_weapon_get_sprite(_coat)==scrNTTERefSprite(_i?"CoatTrident":"CoatTeleportGun")
                && scr_weapon_get_name(_coat)==(_i?"COAT TRIDENT":"COAT TELEPORT GUN")
                && scr_weapon_get_loadout_sprite(_coat)==scrNTTERefSprite(_i?"GoldTridentLoadout":"GoldTeleportGunLoadout"),
                "Canonical physical gold failed exact Coat wrapping, identity, name or original unwrapped loadout")
        }
        global.ntte_full_progress.unlocks[$ "pack:coast"]=false
        global.ntte_full_progress.unlocks[$ "wep:trident"]=false
        assert(scr_weapon_get_name(_handles[2])=="LOCKED" && scr_weapon_get_area(_handles[2])==-1
            && scr_weapon_get_sprite(_handles[2])==scrNTTEFullWeaponLockedSprite(wep_ntte_trident)
            && scr_weapon_get_name(_handles[0])=="TELEPORT GUN" && scr_weapon_get_area(_handles[0])==7,
            "Source Trident availability was lost or incorrectly applied to the always available Teleport Gun")
        global.ntte_full_progress.unlocks[$ "wep:trident"]=true
        assert(scr_weapon_get_name(_handles[2])=="TRIDENT" && scr_weapon_get_area(_handles[2])==7,
            "Source per-weapon Trident unlock failed its pack alternative")
        // Genuine native scrFire: a canonical golden physical object must
        // produce the same fast portal, payload and RNG consumption as the
        // source-compatible separate native golden ID.
        _p.x=153000;_p.y=153000;_p.xprevious=_p.x;_p.yprevious=_p.y
        _p.race=Race.Fish;_p.bskin=0;_p.ntte_native_race=-1;_p.ntte_race_ultra=0
        _p.gunangle=0;_p.accuracy=0;_p.infammo=1;_p.bwep=wep_revolver
        _p.ammo=array_create(Ammo.NUM_AMMO_TYPES,100);GameCont.rad=100
        KeyCont.hold_fire[_p.index]=false;KeyCont.hold_spec[_p.index]=false
        var _fireHandles=[wep_ntte_golden_teleport_gun,scrNTTEFullWeaponNative({wep:wep_ntte_teleport_gun,gold:true})],
            _reference=undefined
        for(var _i=0;_i<2;++_i) {
            var _fireBefore=scrNTTEFullInstances(all),_weapon=_fireHandles[_i]
            _p.wep=_weapon;_p.ntte_state=scrNTTENewState(_weapon)
            _p.hspeed=0;_p.vspeed=0;_p.reload=0;_p.can_shoot=true;_p.wepangle=0;_p.wkick=0
            random_set_seed(314159)
            with(_p) scrFire(_weapon,false,true)
            var _shot=noone,_count=0
            with(NTTEFullPortalBullet) if(array_get_index(_fireBefore,id)<0) {_shot=id;++_count}
            assert(_count==1 && _shot.image_index>=2 && _shot.damage==25 && _shot.mask==mskPlasma
                && _shot.creator==_p && _shot.ntte_portal_state==_p.ntte_state,
                "Actual canonical gold Teleport Gun failed source fast portal/payload/physical state/creator")
            var _result={frame:_shot.image_index,speed:_shot.speed,direction:_shot.direction,next:random(100000)}
            if(_i==0) _reference=_result
            else assert(_result.frame==_reference.frame && _result.speed==_reference.speed
                && _result.direction==_reference.direction && _result.next==_reference.next,
                "Canonical gold Teleport actual fire differed from native golden source speed/frame or sound RNG draw")
            scrNTTEFullMergedRuntimeTestCleanup(_fireBefore)
        }
        var _serialized=json_parse(json_stringify(scrNTTEFullWeaponNativeExport()))
        scrNTTEFullWeaponNativeImport(_serialized)
        assert(scrNTTEFullWeaponModel(_handles[1]).gold && scrNTTEFullWeaponModel(_handles[3]).gold
            && scr_weapon_get_name(_handles[1])=="COAT TELEPORT GUN"
            && scr_weapon_get_name(_handles[3])=="COAT TRIDENT"
            && scr_weapon_get_sprite(_handles[3])==scrNTTERefSprite("CoatTrident"),
            "Actual native graph continuation lost gold fields, restored Trident visibility or persistent Coat wrappers")
    }
    finally {
        scrNTTEFullMergedRuntimeTestCleanup(_before)
        scrNTTEFullAreaGeneratorRestore(_players);scrNTTEFullAreaGeneratorRestore(_game)
        scrNTTEFullAreaGeneratorRestore(_keys);scrNTTEFullAreaGeneratorRestore(_back)
        global.ntte_full_native_weapon_models=_models;global.ntte_full_progress=_progress;random_set_seed(_seed)
    }
    scrNTTESmokeLog("FULL GOLD LWO FIELDS: canonical Teleport/Trident live metadata/text/art/HUD/loadout/area/gold, real native pickup, Trident physical invisibility+swap, source unlock rules, actual Coat wrappers, genuine fast gold portal/state/creator/sound RNG and graph continuation OK @"+string(30/timescale))
}
