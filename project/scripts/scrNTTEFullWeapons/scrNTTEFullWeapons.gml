// telib.weapon_decide:3946..4055. Use the current native weapon registry,
// including ported MOD IDs. Unlike scrDecideWep this takes absolute bounds,
// does not reseed RNG, and accepts an exclusion list for arena rewards.
function scrNTTEFullWeaponBounds(_min,_max) {
    var _hardmode=UberCont.hardmode ? 1:0;
    _max+=ceil((GameCont.hard-_hardmode*13)/(1+_hardmode*2))-GameCont.hard;
    _max+=scrPlayerCountRace(Race.Robot);
    _min+=5*scr_ultra_get(Race.Robot,UltraSkill.RefinedTaste);
    _max=max(_max,0); _min=min(_min,_max);
    return [_min,_max];
}
function scrNTTEFullWeaponCandidate(_weapon,_gold,_exclude,_context=self) {
    if(_weapon==_exclude || (is_array(_exclude) && array_get_index(_exclude,_weapon)>=0)) return false;
    // Preserve the source's literal negative branch, despite its comment
    // describing the opposite. Current MOD callers use false/true only.
    if((_gold>0 && !scr_weapon_is_golden(_weapon)) || (_gold<0 && !scr_weapon_is_golden(_weapon))) return false;
    switch(_weapon) {
        case wep_super_disc_gun:return scrNTTEFullValue(_context,"curse",0)>0;
        case wep_golden_nuke_launcher:case wep_golden_disc_gun:return UberCont.hardmode;
        case wep_gun_gun:return scrCrownCheck(crwn_guns);
    }
    return true;
}
function scrNTTEFullWeaponDecide(_min=0,_max=GameCont.hard,_gold=false,_exclude=undefined,_context=self) {
    var _bounds=scrNTTEFullWeaponBounds(_min,_max);
    // Providers invoked through a global struct need the actual caller passed
    // explicitly; looking up id there reads the global struct instead.
    var _decided=scrNTTEFullValue(_context,"wep",wep_none);
    if(_decided==wep_none) {
        _decided=wep_screwdriver;
        if(_gold>0) {
            _decided=choose(wep_golden_wrench,wep_golden_machinegun,wep_golden_shotgun,wep_golden_crossbow,wep_golden_grenade_launcher,wep_golden_laser_pistol);
            if(GameCont.loops>0 && random(2)<1)
                _decided=choose(wep_golden_screwdriver,wep_golden_assault_rifle,wep_golden_slugger,wep_golden_splinter_gun,wep_golden_bazooka,wep_golden_plasma_gun);
        }
    }
    var _list=ds_list_create();
    for(var _w=1;_w<=maxwep;++_w) {
        var _area=scr_weapon_get_area(_w);
        if(_area>=_bounds[0] && _area<=_bounds[1]) ds_list_add(_list,_w);
    }
    ds_list_shuffle(_list);
    for(var _i=0;_i<ds_list_size(_list);++_i) {
        var _w=_list[|_i];
        if(scrNTTEFullWeaponCandidate(_w,_gold,_exclude,_context)) { _decided=_w; break; }
    }
    ds_list_destroy(_list);
    return _decided;
}
function scrNTTEFullWeaponDecideInit() { global.ntte_full_weapon_decide=scrNTTEFullWeaponDecide; }
function scrNTTEFullWeaponDecideTests() {
    var _hard=GameCont.hard,_mode=UberCont.hardmode,_crown=GameCont.crown;
    GameCont.hard=19; UberCont.hardmode=true;
    var _bounds=scrNTTEFullWeaponBounds(2,20);
    assert(_bounds[0]==2 && _bounds[1]==3,"Absolute weapon bounds lost source hardmode ceil adjustment");
    UberCont.hardmode=false; GameCont.hard=7;
    var _all=[],_allow=wep_ntte_venom_rifle;
    for(var _w=1;_w<=maxwep;++_w) if(_w!=_allow) array_push(_all,_w);
    var _selected=scrNTTEFullWeaponDecide(7,7,false,_all);
    assert(_selected==_allow,"Arena absolute difficulty/exclusion selector omitted registered MOD weapons");
    assert(!scrNTTEFullWeaponCandidate(wep_golden_nuke_launcher,false,undefined)
        && !scrNTTEFullWeaponCandidate(wep_gun_gun,false,undefined),"Weapon special hardmode/crown conditions changed");
    GameCont.crown=Crown.Guns;
    assert(scrNTTEFullWeaponCandidate(wep_gun_gun,false,undefined),"Crown of Guns did not admit Gun Gun");
    assert(!scrNTTEFullWeaponCandidate(_allow,true,undefined) && !scrNTTEFullWeaponCandidate(_allow,false,[_allow]),
        "Weapon gold or exclusion conditions ignored");
    GameCont.hard=_hard; UberCont.hardmode=_mode; GameCont.crown=_crown;
    scrNTTESmokeLog("FULL WEAPON DECIDE: original absolute bounds/hardmode ceil, registry MOD selection, exclusion/gold and crown exceptions OK");
}
function scrNTTEFullIsPortalWeapon(_weapon) {
    return _weapon==wep_ntte_teleport_gun || _weapon==wep_ntte_golden_teleport_gun || _weapon==wep_ntte_super_teleport_gun;
}
// Called in the same temporarily-swapped firing-slot context as scrNTTEState.
// Scan transient projectiles instead of saving instance handles inside weapons.
function scrNTTEFullPortalWeaponBusy(_state) {
    var _owner=id,_busy=false;
    with(NTTEFullPortalBullet) if(creator==_owner && ntte_portal_state==_state) { _busy=true; break; }
    if(_busy) { reload=max(reload,scr_weapon_get_load(_state.weapon)); can_shoot=false; }
    return _busy;
}
function scrNTTEFullPortalWeaponFire(_weapon,_primary,_state) {
    var _physical_gold=scrNTTEFullWeaponGoldFiring(_weapon);
    var _count=_weapon==wep_ntte_super_teleport_gun ? 4:1;
    for(var _i=0;_i<_count;++_i) {
        var _off=_count==1 ? 0:lerp(-1,1,_i/3);
        var _bullet=scr_projectile_create(x,y,NTTEFullPortalBullet,gunangle+15*_off*accuracy,random_range(11,13));
        _bullet.mask=mskPlasma; _bullet.damage=25;
        _bullet.spec=!_primary; _bullet.primary=_primary;
        _bullet.ntte_portal_state=_state;
        _bullet.ntte_portal_last_owner_angle=gunangle;
        if(_count==4) _bullet.offset=20-2*abs(_off);
        if(_physical_gold) _bullet.image_index+=2;
    }
    snd_play_hit(sndGuardianAppear,0.2);
    var _sound=snd_play_hit(_count==4 ? sndCrystalJuggernaut:sndClick,0);
    if(_sound>=0) {
        audio_sound_pitch(_sound,_count==4 ? 1.2+random(0.2):1.5);
        audio_sound_gain(_sound,(_count==4 ? 1.3:0.7)*audio_sound_get_gain(_sound),0);
    }
    _sound=scrNTTEFullCustomProjectileGunSound(sndCrystalTB,0,_count==4 ? -0.5:0.5);
    if(_sound>=0) {
        audio_sound_pitch(_sound,(_count==4 ? 0.4:0.6)+random(0.2));
        audio_sound_gain(_sound,1.5*audio_sound_get_gain(_sound),0);
    }
    if(_physical_gold) snd_play(sndSwapGold,random_range(0.8,1),1.7);
}
function scrNTTEFullPortalWeaponSmoke() {
    var _player=instance_find(Player,0),_saved={wep:_player.wep,bwep:_player.bwep,state:_player.ntte_state,
        bstate:_player.bntte_state,angle:_player.gunangle,hold:KeyCont.hold_fire[_player.index],
        spec:KeyCont.hold_spec[_player.index],x:_player.x,y:_player.y,reload:_player.reload,can:_player.can_shoot};
    instance_destroy(projectile,false);
    with(_player) {
        x=10016; y=10016; wep=wep_ntte_teleport_gun; ntte_state=scrNTTENewState(wep);
        gunangle=20; KeyCont.hold_fire[index]=true;
        scrNTTEFullPortalWeaponFire(wep,true,ntte_state);
        var _bullet=instance_find(NTTEFullPortalBullet,0),_state=ntte_state;
        assert(instance_number(NTTEFullPortalBullet)==1 && _bullet.damage==25 && _bullet.mask==mskPlasma,"Portal weapon emitted incorrect original payload");
        with(_bullet) scrNTTEFullPortalBulletAnimate();
        repeat(ceil(60/timescale)) with(_bullet) scrNTTEFullPortalBulletStep();
        assert(_bullet.hold,"Portal gun released while fire remained held");
        reload=0; can_shoot=true;
        assert(scrNTTEHandleInput(wep,true) && !can_shoot && reload>=scr_weapon_get_load(wep),"Portal weapon refired while existing projectile lived");
        var _old=_bullet.direction;
        gunangle+=40;
        with(_bullet) scrNTTEFullPortalBulletStep();
        assert(abs(angle_difference(_bullet.direction,_old+40))<0.001,"Held portal did not turn with player's aim");
        KeyCont.hold_fire[index]=false;
        with(_bullet) scrNTTEFullPortalBulletStep();
        assert(!_bullet.hold,"Portal gun failed release on fire-up");
        instance_destroy(projectile,false);
        wep=wep_ntte_golden_teleport_gun; ntte_state=scrNTTENewState(wep);
        scrNTTEFullPortalWeaponFire(wep,true,ntte_state);
        assert(instance_find(NTTEFullPortalBullet,0).image_index==2,"Golden portal lost faster spawn");
        instance_destroy(projectile,false);
        wep=wep_ntte_super_teleport_gun; ntte_state=scrNTTENewState(wep);
        scrNTTEFullPortalWeaponFire(wep,true,ntte_state);
        assert(instance_number(NTTEFullPortalBullet)==4,"Super teleport gun fan count differs from original");
        with(NTTEFullPortalBullet) {
            assert(damage==25 && offset>=18 && offset<20,"Super portal fan offset changed");
            assert(abs(angle_difference(direction,other.gunangle))<=15*other.accuracy+0.001,"Super portal spread changed");
        }
        instance_destroy(projectile,false);
        wep=_saved.wep; bwep=_saved.bwep; ntte_state=_saved.state; bntte_state=_saved.bstate;
        gunangle=_saved.angle; x=_saved.x; y=_saved.y; reload=_saved.reload; can_shoot=_saved.can;
        KeyCont.hold_fire[index]=_saved.hold; KeyCont.hold_spec[index]=_saved.spec;
    }
    scrNTTESmokeLog("PASS portal weapon hold/release/aim/busy/gold/super original branches @"+string(30/timescale));
}
