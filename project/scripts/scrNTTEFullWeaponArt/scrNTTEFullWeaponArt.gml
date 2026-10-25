// Original weapon module sprite metadata, including HUD-specific origins.
function scrNTTEFullWeaponArtInit() {
    wep_mele[wep_ntte_clam_shield]=false;
    wep_swap[wep_ntte_clam_shield]=sndSwapHammer;
    wep_sprt[wep_ntte_bubble_bat]=scrNTTERefSprite("Weapon.bubble bat.sprWep");
    wep_sprt[wep_ntte_bubble_rifle]=scrNTTERefSprite("Weapon.bubble rifle.sprWep");
    wep_sprt[wep_ntte_bubble_shotgun]=scrNTTERefSprite("Weapon.bubble shotgun.sprWep");
    wep_sprt[wep_ntte_bubble_minigun]=scrNTTERefSprite("Weapon.bubble minigun.sprWep");
    wep_sprt[wep_ntte_bubble_cannon]=scrNTTERefSprite("Weapon.bubble cannon.sprWep");
    wep_sprt[wep_ntte_hyper_bubbler]=scrNTTERefSprite("Weapon.hyper bubbler.sprWep");
    wep_sprt[wep_ntte_electroplasma_rifle]=scrNTTERefSprite("Weapon.electroplasma rifle.sprWep");
    wep_sprt[wep_ntte_electroplasma_shotgun]=scrNTTERefSprite("Weapon.electroplasma shotgun.sprWep");
    wep_sprt[wep_ntte_electroplasma_cannon]=scrNTTERefSprite("Weapon.electroplasma cannon.sprWep");
    wep_sprt[wep_ntte_dematerializer]=scrNTTERefSprite("Weapon.dematerializer.sprWep");
    wep_sprt[wep_ntte_energy_bat]=scrNTTERefSprite("Weapon.energy bat.sprWep");
    wep_sprt[wep_ntte_tesla_coil]=scrNTTERefSprite("Weapon.tesla coil.sprWep");
    wep_sprt[wep_ntte_vampire]=scrNTTERefSprite("Weapon.bat tether.sprWep");
    wep_sprt[wep_ntte_sawblade_gun]=scrNTTERefSprite("Weapon.bat disc launcher.sprWep");
    wep_sprt[wep_ntte_sawblade_cannon]=scrNTTERefSprite("Weapon.bat disc cannon.sprWep");
    wep_sprt[wep_ntte_pizza_cutter]=scrNTTERefSprite("Weapon.pizza cutter.sprWep");
    wep_sprt[wep_ntte_harpoon_launcher]=scrNTTERefSprite("Weapon.harpoon launcher.sprWep");
    wep_sprt[wep_ntte_net_launcher]=scrNTTERefSprite("Weapon.net launcher.sprWep");
    wep_sprt[wep_ntte_clam_shield]=scrNTTERefSprite("Weapon.clam shield.sprWep");
    wep_sprt[wep_ntte_teleport_gun]=scrNTTERefSprite("Weapon.teleport gun.sprWep");
    wep_lout[wep_ntte_teleport_gun]=scrNTTERefSprite("Weapon.teleport gun.sprWepLoadout");
    wep_sprt[wep_ntte_super_teleport_gun]=scrNTTERefSprite("Weapon.super teleport gun.sprWep");
    wep_sprt[wep_ntte_quasar_blaster]=scrNTTERefSprite("Weapon.quasar blaster.sprWep");
    wep_sprt[wep_ntte_quasar_rifle]=scrNTTERefSprite("Weapon.quasar rifle.sprWep");
    wep_sprt[wep_ntte_quasar_cannon]=scrNTTERefSprite("Weapon.quasar cannon.sprWep");
    wep_sprt[wep_ntte_ultra_quasar_rifle]=scrNTTERefSprite("Weapon.ultra quasar rifle.sprWep");
    wep_sprt[wep_ntte_bone]=scrNTTERefSprite("Weapon.crabbone.sprWep");
    wep_sprt[wep_ntte_bone_scythe]=scrNTTERefSprite("Weapon.scythe.sprWep");
    wep_sprt[wep_ntte_bone_shotbow]=scrNTTERefSprite("Weapon.scythe.sprShotbow");
    wep_sprt[wep_ntte_bone_slugbow]=scrNTTERefSprite("Weapon.scythe.sprSlugbow");
    wep_sprt[wep_ntte_trident]=scrNTTERefSprite("Weapon.trident.sprWep");
    wep_lout[wep_ntte_trident]=scrNTTERefSprite("Weapon.trident.sprWepLoadout");
    wep_sprt[wep_ntte_annihilator]=scrNTTERefSprite("Weapon.annihilator.sprWep");
    wep_sprt[wep_ntte_entangler]=scrNTTERefSprite("Weapon.entangler.sprWep");
    wep_sprt[wep_ntte_tunneller]=scrNTTERefSprite("Weapon.tunneller.sprWep");
    wep_lout[wep_ntte_tunneller]=scrNTTERefSprite("Weapon.tunneller.sprWepLoadout");
    wep_sprt[wep_ntte_golden_teleport_gun]=scrNTTERefSprite("Weapon.teleport gun.sprWepGold");
    wep_lout[wep_ntte_golden_teleport_gun]=scrNTTERefSprite("Weapon.teleport gun.sprWepGoldLoadout");
    wep_sprt[wep_ntte_golden_trident]=scrNTTERefSprite("Weapon.trident.sprWepGold");
    wep_lout[wep_ntte_golden_trident]=scrNTTERefSprite("Weapon.trident.sprWepGoldLoadout");
    wep_sprt[wep_ntte_golden_tunneller]=scrNTTERefSprite("Weapon.tunneller.sprWepGold");
    wep_lout[wep_ntte_golden_tunneller]=scrNTTERefSprite("Weapon.tunneller.sprWepGoldLoadout");
    wep_sprt[wep_ntte_rogue_carbine]=scrNTTERefSprite("Weapon.rogue carbine.sprWep");
    wep_sprt[wep_ntte_venom_rifle]=scrNTTERefSprite("Weapon.venom rifle.sprWep");
    wep_sprt[wep_ntte_beetle_blaster]=scrNTTERefSprite("Weapon.beetle pistol.sprWep");
    wep_lout[wep_ntte_beetle_blaster]=scrNTTERefSprite("Weapon.beetle pistol.sprWepLoadout");
    wep_sprt[wep_ntte_lightring_launcher]=scrNTTERefSprite("Weapon.lightring launcher.sprWep");
    wep_sprt[wep_ntte_lightring_cannon]=scrNTTERefSprite("Weapon.super lightring launcher.sprWep");
    wep_sprt[wep_ntte_ancient_artifact]=scrNTTERefSprite("QuestArtifact",0);
    wep_sprt[wep_ntte_guarded_artifact]=scrNTTERefSprite("QuestArtifact",1);
    wep_sprt[wep_ntte_stolen_artifact]=scrNTTERefSprite("QuestArtifact",2);
    wep_sprt[wep_ntte_missing_artifact]=scrNTTERefSprite("QuestArtifact",3);
}
function scrNTTEFullWeaponHUDSprite(_weapon) {
    if(is_struct(_weapon) || scrNTTEFullWeaponIsNative(_weapon)) return scrNTTEFullWeaponNativeSprite(_weapon,false,undefined,true)
    if(scrNTTEFullBoneWeaponMetadataHas(_weapon)) return scrNTTEFullBoneWeaponMetadata(_weapon,"hud",mskNone)
    switch(_weapon) {
        case wep_ntte_pizza_cutter: return scrNTTERefSprite("Weapon.pizza cutter.sprWepHUD");
        case wep_ntte_clam_shield: return scrNTTERefSprite("Weapon.clam shield.sprWepHUD");
        case wep_ntte_bone_scythe: return scrNTTERefSprite("Weapon.scythe.sprWepHUD");
        case wep_ntte_bone_shotbow: return scrNTTERefSprite("Weapon.scythe.sprShotbow");
        case wep_ntte_bone_slugbow: return scrNTTERefSprite("Weapon.scythe.sprSlugbowHUD");
        case wep_ntte_annihilator:case wep_ntte_entangler:
            return scrNTTEFullRedWeaponHUD(_weapon);
        case wep_ntte_tunneller:case wep_ntte_golden_tunneller:
            return scrNTTEFullTunnellerMetadata(_weapon,"hud",scrNTTERefSprite("Weapon.tunneller.sprWepHUD"));
    }
    return scr_weapon_get_sprite(_weapon);
}
function scrNTTEFullWeaponStateSprite(_weapon,_state) {
    if(is_struct(_state) && _state.weapon==_weapon) {
        if(scrNTTEIsTrident(_weapon) && !scrNTTEFullValue(_state,"visible",true)) return mskNone;
        if(!scrNTTEFullWeaponAvailable(_weapon)) return scrNTTEFullWeaponLockedSprite(_weapon);
        if(_weapon==wep_ntte_clam_shield) return scrNTTEFullClamSourceSprite(_weapon,_state,scr_weapon_get_sprite(_weapon));
        var _module; switch(_weapon) {
            case wep_ntte_sawblade_gun: _module="bat disc launcher"; break;
            case wep_ntte_sawblade_cannon: _module="bat disc cannon"; break;
            case wep_ntte_pizza_cutter: _module="pizza cutter"; break;
            default: return scr_weapon_get_sprite(_weapon);
        }
        var _frames=scrNTTERefSprite("Weapon."+_module+".sprWepImage");
        var _cost=_weapon==wep_ntte_sawblade_cannon?7:1;
        var _ammo=_state.loaded?_state.ammo:0;
        if(_weapon!=wep_ntte_pizza_cutter && _ammo<_cost) {
            var _identity=scrNTTEFullValue(_state,"ntte_physical_state",_state),_returning=false;
            with(NTTEFullBatDisc) if(wep==_identity && image_index==1) {_returning=true;break;}
            if(_returning) return scrNTTERefSprite("Weapon."+_module+".sprWepHoming");
        }
        return _frames[ceil(clamp((floor(_ammo/_cost)*_cost)/_state.capacity,0,1)*(array_length(_frames)-1))];
    }
    return scr_weapon_get_sprite(_weapon);
}
