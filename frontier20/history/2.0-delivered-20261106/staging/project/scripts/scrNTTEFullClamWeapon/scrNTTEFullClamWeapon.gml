// clam shield.wep.gml and tecoast.mod.gml::ClamShieldSlash_create.
// The physical slot state owns the shield; instance IDs remain transient.
function scrNTTEFullClamEnsure(_state) {
    if(!is_struct(_state)) return noone;
    var _shield=noone,_owner=id;
    with(NTTEFullClamShield) if(creator==_owner && variable_instance_exists(id,"ntte_clam_state") && ntte_clam_state==_state) _shield=id;
    if(!instance_exists(_shield)) {
        _shield=scr_projectile_create(x,y,NTTEFullClamShield,gunangle,0);
        _shield.ntte_clam_state=_state;
        _shield.wep=_state.weapon;
    }
    return _shield;
}
function scrNTTEFullClamSlot(_primary) {
    var _weapon=_primary?wep:bwep,_key=_primary?"ntte_state":"bntte_state";
    if(scrNTTEFullWeaponRaw(_weapon)!=wep_ntte_clam_shield) return undefined;
    var _state=scrNTTEFullValue(id,_key,undefined);
    if(!is_struct(_state) || _state.weapon!=_weapon) {
        _state=scrNTTENewState(_weapon); variable_instance_set(id,_key,_state);
    }
    return _state;
}
function scrNTTEFullClamSlashCreate() {
    sprite_index=scrNTTERefSprite("ClamShieldSlash"); mask_index=scrNTTERefSprite("msk.ClamShieldSlash");
    depth=-3; friction=0.2*timescale*timescale; damage=10; knockback_speed=16*timescale;
}
function scrNTTEFullClamFire(_state) {
    scrNTTEFullClamEnsure(_state);
    if(!variable_struct_exists(_state,"clam_frame") || _state.clam_frame!=current_frame) {
        _state.clam_frame=current_frame; _state.clam_shots=0;
    }
    var _owner=id,_shields=[];
    with(NTTEFullClamShield) if(creator==_owner && variable_instance_exists(id,"ntte_clam_state") && ntte_clam_state==_state) array_push(_shields,id);
    for(var _i=0;_i<array_length(_shields);++_i) {
        var _dir=_shields[_i].image_angle,_long=scr_skill_get(mut_long_arms),_len=lerp(8,14,_long)+8*_state.clam_shots;
        var _slash=scr_projectile_create(x,y,NTTEFullClamShieldSlash,_dir,lerp(2,4.5,_long));
        with(_slash) {
            var _tx=x+lengthdir_x(_len,_dir)+_owner.hspeed/timescale,_ty=y+lengthdir_y(_len,_dir)+_owner.vspeed/timescale;
            var _tl=point_distance(x,y,_tx,_ty),_td=point_direction(x,y,_tx,_ty),_ox=lengthdir_x(1,_td),_oy=lengthdir_y(1,_td);
            for(var _j=0;_j<_tl && !position_meeting(x+_ox,y+_oy,Wall);++_j) { x+=_ox; y+=_oy; }
            x+=lengthdir_x(16,_dir); y+=lengthdir_y(16,_dir); xprevious=x; yprevious=y;
            repeat(2) with(instance_create(x+orandom(2),y+orandom(2),Dust)) speed+=2*timescale;
        }
        var _pitch=1+orandom(0.2);
        snd_play(sndCrystalJuggernaut,_pitch*0.7,0.7);
        snd_play(sndOasisExplosionSmall,_pitch*2,0.7);
        snd_play(sndOasisExplosion,_pitch*4,0.7);
        snd_play(sndOasisMelee,_pitch); snd_play(sndHammer,_pitch);
        // NTT ref_weapon_post args are kick, camera shift, shake.
        scr_weapon_post(_dir,12,0,-(4+_len)); motion_add(_dir,2*timescale); sleep(40);
    }
    _state.clam_shots+=1;
}
function scrNTTEFullClamHeld(_state) {
    if(!is_struct(_state)) return false;
    var _held=false,_owner=id;
    with(NTTEFullClamShield) if(creator==_owner && variable_instance_exists(id,"ntte_clam_state") && ntte_clam_state==_state) _held=true;
    return _held;
}
function scrNTTEFullClamWeaponTests() {
    var _p=instance_find(Player,0),_before=scrNTTEFullInstances(all),_saved={wep:_p.wep,bwep:_p.bwep,state:_p.ntte_state,back:scrNTTEFullValue(_p,"bntte_state",undefined),race:_p.race,hs:_p.hspeed,vs:_p.vspeed,kick:_p.wkick};
    with(_p) {
        wep=wep_ntte_clam_shield; bwep=wep_ntte_clam_shield; race=Race.Steroids;
        ntte_state=scrNTTENewState(wep); bntte_state=scrNTTENewState(bwep); hspeed=0; vspeed=0;
        var _a=scrNTTEFullClamEnsure(ntte_state),_b=scrNTTEFullClamEnsure(bntte_state);
        with(_a) scrNTTEFullClamShieldStep();
        with(_b) scrNTTEFullClamShieldStep();
        assert(_a!=_b && _a.ntte_clam_state!=_b.ntte_clam_state,"Dual Clam shields must keep independent physical states");
        with(_a) assert(!scrNTTEFullClamShieldBackSlot(),"Front identical Clam shield mistaken for back slot");
        with(_b) assert(scrNTTEFullClamShieldBackSlot(),"Back identical Clam shield lost its physical slot");
        assert(scrNTTEHeldSprite(wep)==mskNone && scrNTTEHeldSprite(bwep,true)==mskNone,"Held Clam shield weapon art must hide behind shield entity");
        _a.image_angle=gunangle;
        var _count=instance_number(NTTEFullClamShieldSlash);
        scrNTTEFullClamFire(ntte_state);
        assert(instance_number(NTTEFullClamShieldSlash)==_count+1 && ntte_state.clam_shots==1,"Clam bash must fire once per physical shield");
        var _slash=instance_find(NTTEFullClamShieldSlash,instance_number(NTTEFullClamShieldSlash)-1);
        assert(_slash.damage==10 && _slash.knockback_speed==16*timescale && _slash.mask_index==scrNTTERefSprite("msk.ClamShieldSlash") && _slash.depth==-3,"Clam bash original damage/force/mask/depth changed");
        assert(abs(_slash.friction-0.2*timescale*timescale)*1000000<=1,"Clam bash friction lost logical frame scaling");
        race=Race.Fish; with(_b) scrNTTEFullClamShieldStep();
        assert(!instance_exists(_b),"Non-Steroids back shield must disappear");
    }
    _p.wep=_saved.wep; _p.bwep=_saved.bwep; _p.ntte_state=_saved.state; _p.bntte_state=_saved.back; _p.race=_saved.race; _p.hspeed=_saved.hs; _p.vspeed=_saved.vs; _p.wkick=_saved.kick;
    var _all=scrNTTEFullInstances(all);
    for(var _i=0;_i<array_length(_all);++_i) if(array_get_index(_before,_all[_i])<0) instance_destroy(_all[_i],false);
    scrNTTESmokeLog("PASS Clam physical shield state, identical dual slots, original bash projectile and held artwork");
}
