// tegeneral.mod.gml2201..2293: genuine two-phase delayed FireCharge controller.
function scrNTTEFullRedFireChargeRefresh(_state,_primary) {
    var _controller=noone
    with(NTTEFullRedFireCharge) if(wep==_state) {_controller=id;break}
    if(!instance_exists(_controller)) {
        _controller=instance_create(x,y,NTTEFullRedFireCharge)
        _controller.wep=_state
    }
    _controller.x=x;_controller.y=y;_controller.direction=gunangle
    _controller.accuracy=accuracy;_controller.team=team
    _controller.creator=scrNTTEFullRedWeaponOwner();_controller.primary=_primary;_controller.fire=false
    return _controller
}
function scrNTTEFullRedFireChargeHeld(_owner,_state,_primary) {
    if(!instance_exists(_owner)) return false
    var _weapon=scrNTTEFullValue(_owner,_primary?"wep":"bwep",_state.weapon),
        _slot=scrNTTEFullValue(_owner,_primary?"ntte_state":"bntte_state",undefined)
    // Original compares LWO identity. Native numeric weapons keep that same
    // physical identity in their slot state, never just a shared raw weapon ID.
    if(is_struct(_slot)) return _slot==_state && _slot.weapon==_weapon
    return _weapon==_state.weapon
}
function scrNTTEFullRedFireChargeStep() {
    // NTTE source custom-event physical mount for charged merged parts.
    if(variable_instance_exists(id,"ntte_merged_state_part")) {scrNTTEFullMergedRuntimeChargeStep();return;}
    if(lockstep_stop) return;
    if(!fire) {fire=true;return;}
    if(is_struct(wep)) {
        var _state=wep
        scrNTTEFullRedWeaponState(_state)
        if(_state.chrg!=0) {
            _state.chrg=-1
            if(instance_exists(creator) && creator.visible && scrNTTEFullRedFireChargeHeld(creator,_state,primary)) {
                x=creator.x;y=creator.y
                var _owner=creator,_primary=primary,_team=team,_accuracy=accuracy,_direction=direction
                if(instance_is(_owner,Player)) {
                    var _controller=id
                    with(_owner) {
                        if(!_primary) scrSwapWeps(false)
                        try {
                            if(infammo!=0 || (ammo[scr_weapon_get_type(wep)]>=scr_weapon_get_cost(wep)
                                && GameCont.rad>=scr_weapon_get_rads(wep))) {
                                var _oldteam=team,_oldaccuracy=accuracy,_oldangle=gunangle
                                team=_team;accuracy=_accuracy;gunangle=_direction
                                try {scrFire(wep,true,_primary)}
                                finally {
                                    if(team==_team) team=_oldteam
                                    if(accuracy==_accuracy) accuracy=_oldaccuracy
                                    else if(_accuracy!=0) accuracy=_oldaccuracy*(accuracy/_accuracy)
                                    gunangle=_oldangle
                                }
                            }
                            else {
                                wkick=-2;clicked=false;drawempty=30
                                snd_play(ammo[scr_weapon_get_type(wep)]<scr_weapon_get_cost(wep)?sndEmpty:sndUltraEmpty)
                            }
                        }
                        finally {if(!_primary) scrSwapWeps(false)}
                    }
                }
                else {
                    // Original non-Player player_fire_ext uses the creator's
                    // current position and the controller's captured direction.
                    var _oldstate=scrNTTEFullValue(_owner,"ntte_state",undefined)
                    _owner.ntte_state=_state
                    try {scrNTTEFullActorFire(_owner,_state.weapon,_direction,_accuracy,false,_owner,
                        {position:{x:x,y:y},direction_owner:noone,direction_rotation:0,accuracy_dynamic:false,
                            team_override:_team,creator_override:_owner})}
                    finally {_owner.ntte_state=_oldstate}
                }
            }
            _state.chrg=0
        }
        _state.chrg_num=0;_state.charge=0
    }
    instance_destroy()
}
