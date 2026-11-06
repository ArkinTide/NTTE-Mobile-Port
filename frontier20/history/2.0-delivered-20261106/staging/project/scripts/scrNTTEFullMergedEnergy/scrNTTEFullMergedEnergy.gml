// Original temerge4328..4558,4611..4640: plasma chains and blood trail.
function scrNTTEFullMergedEnergyInit() {
    scrNTTEFullMergedEffectsInit()
    var _registry=global.ntte_full_merge_effect_registry
    if(scrNTTEFullValue(_registry,"ntte_energy_events_ready",false)) return;
    _registry.ntte_energy_events_ready=true
    scrNTTEFullMergedEffectAddEvent("plasma","setup",scrNTTEFullMergedPlasmaSetup)
    scrNTTEFullMergedEffectAddEvent("plasma","step",scrNTTEFullMergedPlasmaStep)
    scrNTTEFullMergedEffectAddEvent("plasma_trail","setup",scrNTTEFullMergedPlasmaTrailSetup)
    scrNTTEFullMergedEffectAddEvent("plasma_trail","step",scrNTTEFullMergedPlasmaTrailStep)
    scrNTTEFullMergedEffectAddEvent("blood_trail","setup",scrNTTEFullMergedBloodTrailSetup)
    scrNTTEFullMergedEffectAddEvent("blood_trail","step",scrNTTEFullMergedBloodTrailStep)
}
function scrNTTEFullMergedPlasmaSetup(_instances,_extra=0) {
    for(var _i=0;_i<array_length(_instances);++_i) if(instance_exists(_instances[_i])) with(_instances[_i]) {
        if(!variable_instance_exists(id,"temerge_plasma")) {
            temerge_plasma={extra_amount:0}
            scrNTTEFullMergedProjectileAddEvent(id,"destroy",scrNTTEFullMergedPlasmaDestroy)
        }
        else ++temerge_plasma.extra_amount
        temerge_plasma.extra_amount+=_extra
    }
}
function scrNTTEFullMergedPlasmaStep(_instances) {
    for(var _i=0;_i<array_length(_instances);++_i) if(instance_exists(_instances[_i]) && _instances[_i].speed>0) with(_instances[_i]) {
        if(random(128)<speed*power(damage,1/2)) instance_create(random_range(bbox_left,bbox_right),random_range(bbox_top,bbox_bottom),PlasmaTrail)
    }
}
function scrNTTEFullMergedPlasmaDelayCreate() {
    visible=false;scale=1;time=0;team=team_none;creator=noone
}
function scrNTTEFullMergedPlasmaDelayStep() {
    if(time>0) time-=timescale
    else {
        var _impact=scrNTTEFullMergedBasicProjectileCreate(x,y,PlasmaImpact)
        if(instance_exists(_impact)) { _impact.image_xscale=scale;_impact.image_yscale=scale }
        instance_destroy()
    }
}
function scrNTTEFullMergedPlasmaDelay(_x,_y,_scale,_time,_perform_step=true) {
    var _delay=instance_create(_x,_y,NTTEFullMergedPlasmaDelay)
    _delay.scale=_scale;_delay.time=_time;_delay.team=team;_delay.creator=creator
    if(_perform_step) with(_delay) event_perform(ev_step,ev_step_normal)
    return _delay
}
function scrNTTEFullMergedPlasmaDestroy() {
    if((object_index==Lightning || object_index==EnemyLightning) && (ammo%4)>=1) return;
    var _ex=x,_ey=y,_angle=random(360),_turn=20*choose(-1,1),_count=abs(damage/15)+temerge_plasma.extra_amount
    if(_count>1) {
        if(position_meeting(_ex,_ey,Wall)) {
            var _floor=noone,_nearest=infinity
            with(Floor) {
                var _distance=distance_to_point(_ex,_ey)
                if(_distance<_nearest) { _floor=id;_nearest=_distance }
            }
            if(instance_exists(_floor)) {
                _angle=point_direction(x,y,(_floor.bbox_left+_floor.bbox_right-1)/2,(_floor.bbox_top+_floor.bbox_bottom-1)/2);_turn=0
            }
        }
        else {
            var _target=noone,_nearest=infinity,_team=team
            with(hitme) if(team!=_team && team!=team_none) {
                var _distance=point_distance(_ex,_ey,x,y)
                if(_distance<_nearest) { _target=id;_nearest=_distance }
            }
            if(instance_exists(_target) && !collision_line(_target.x,_target.y,x,y,Wall,false,false)) {
                _angle=point_direction(x,y,_target.x,_target.y);_turn*=0.5
            }
        }
    }
    for(var _i=0;_i<_count;++_i) {
        scrNTTEFullMergedPlasmaDelay(_ex,_ey,lerp(0.5,1,min(_count-_i,1)),sqrt(_i)*3)
        for(var _move_index=0;_move_index<2;++_move_index) {
            var _length=lerp(8,16,min(_count-(_i+_move_index),1)),
                _dx=lengthdir_x(_length,_angle),_dy=lengthdir_y(_length,_angle)
            if(!position_meeting(_ex+_dx,_ey+_dy,Floor) && position_meeting(_ex,_ey,Floor)) {
                if(!position_meeting(_ex+_dx,_ey,Floor)) _dx*=-1
                else if(!position_meeting(_ex,_ey+_dy,Floor)) _dy*=-1
                else { _dx*=-1;_dy*=-1 }
            }
            _angle=point_direction(0,0,_dx,_dy);_ex+=_dx;_ey+=_dy;_angle+=_turn+orandom(60)
        }
        _turn+=orandom(30)
    }
    if(_count>2) instance_create(x,y,PortalClear)
    snd_play_hit_big(_count>2?(scrNTTEFullMergedProjectileHasEffect(id,"plasma_trail")?sndDevastatorExplo:sndPlasmaBigExplode):sndPlasmaHit,0.3)
}
function scrNTTEFullMergedPlasmaTrailSetup(_instances) {
    for(var _i=0;_i<array_length(_instances);++_i) if(instance_exists(_instances[_i])) with(_instances[_i]) {
        if(!variable_instance_exists(id,"temerge_plasma_trail_scale")) {
            temerge_plasma_trail_scale=1/28;temerge_plasma_trail_amount=0
            scrNTTEFullMergedProjectileAddEvent(id,"hit",scrNTTEFullMergedPlasmaTrailHit)
        }
        else temerge_plasma_trail_scale*=2
        ++temerge_plasma_trail_amount
    }
}
function scrNTTEFullMergedPlasmaTrailStep(_instances) {
    for(var _i=0;_i<array_length(_instances);++_i) if(instance_exists(_instances[_i])) with(_instances[_i]) {
        var _amount=abs(damage)*temerge_plasma_trail_scale
        if(random(1)>=_amount*timescale) continue
        var _scale=lerp(0.5,1,min(abs(_amount),1)),_length=random(16),_angle=random(360),
            _delay=scrNTTEFullMergedPlasmaDelay(x+lengthdir_x(_length,_angle),y+lengthdir_y(_length,_angle),_scale,0,false),
            _copies=temerge_plasma_trail_amount
        with(_delay) {
            if(_amount>1 && _length>0) { mask_index=mskPlasma;move_contact_solid(_angle,_length*(_amount-1)) }
            for(var _copy_i=1;_copy_i<_copies;++_copy_i) with(scrNTTEFullMergedNativeCopy(false)) {
                x+=orandom(2);y+=orandom(2);time+=15*(_copy_i+random(1))
                event_perform(ev_step,ev_step_normal)
            }
            event_perform(ev_step,ev_step_normal)
        }
    }
}
function scrNTTEFullMergedPlasmaTrailHit() {
    if(!scrNTTEFullMergedProjectileCanHit(other.id) || !current_frame_active) return;
    var _scale=lerp(0.5,1,min(abs(damage)*temerge_plasma_trail_scale,1))
    for(var _i=0;_i<temerge_plasma_trail_amount;++_i)
        scrNTTEFullMergedPlasmaDelay(random_range(other.bbox_left,other.bbox_right),random_range(other.bbox_top,other.bbox_bottom),_scale,15*_i)
}
function scrNTTEFullMergedBloodTrailSetup(_instances) {
    for(var _i=0;_i<array_length(_instances);++_i) if(instance_exists(_instances[_i])
        && !scrNTTEFullMergedProjectileHasEffect(_instances[_i],"blood_trail"))
        scrNTTEFullMergedProjectileAddEvent(_instances[_i],"hit",scrNTTEFullMergedBloodTrailHit)
}
function scrNTTEFullMergedBloodTrailStep(_instances) {
    for(var _i=0;_i<array_length(_instances);++_i) if(instance_exists(_instances[_i])) with(_instances[_i])
        if(random(270)<(damage+(knockback_speed>=3*timescale))*timescale)
            scrNTTEFullMergedBasicProjectileCreate(x+orandom(5),y+orandom(5),MeatExplosion)
}
function scrNTTEFullMergedBloodTrailHit() {
    // Recovered original scrMeleeCanHit005ea0e0. It compares target team and
    // target nexthurt only: unlike generic CanHit, dead targets and neutral
    // same-team targets do not have invented health/team exceptions.
    if(instance_exists(other.id) && other.team!=team && other.nexthurt<=current_frame && current_frame_active)
        scrNTTEFullMergedBasicProjectileCreate(x+orandom(5),y+orandom(5),MeatExplosion)
}

function scrNTTEFullMergedEnergyUnitTests() {
    var _before=scrNTTEFullInstances(all),_game=scrNTTEFullAreaGeneratorSnapshot(GameCont),
        _players=scrNTTEFullAreaGeneratorSnapshot(Player),_back=scrNTTEFullAreaGeneratorSnapshot(BackCont),
        _registry=variable_global_exists("ntte_full_merge_effect_registry")?global.ntte_full_merge_effect_registry:undefined,
        _initialized=variable_global_exists("ntte_full_merge_effect_initialized")?global.ntte_full_merge_effect_initialized:false,
        _frame=current_frame,_seed=random_get_seed()
    global.ntte_full_merge_effect_registry={};global.ntte_full_merge_effect_initialized=false
    GameCont.temerge_effect_vars_map={};GameCont.temerge_effect_call_step_instance_list=[]
    GameCont.crown=Crown.None;GameCont.underwater=false;current_frame=2
    try {
        scrNTTEFullMergedBasicInit();scrNTTEFullMergedEnergyInit()
        var _owner=instance_find(Player,0),_source=instance_create(88500,88500,Bullet1)
        _source.creator=_owner;_source.team=team_player;_source.damage=15;_source.speed=0
        scrNTTEFullMergedProjectileAddEffect(_source,"plasma",[0.5])
        scrNTTEFullMergedProjectileAddEffect(_source,"plasma",[0.5])
        assert(_source.temerge_plasma.extra_amount==2 && array_length(_source.temerge_destroy_event_ref_list)==1,
            "Plasma setup lost first-versus-repeated extra count or unique destroy ref")
        var _copy=noone
        with(_source) _copy=scrNTTEFullMergedNativeCopy(false)
        _source.temerge_plasma.extra_amount=1.5
        assert(_copy.temerge_plasma.extra_amount==1.5,"Plasma source/copy lost shared extra amount")
        var _impacts=instance_number(PlasmaImpact),_delays=instance_number(NTTEFullMergedPlasmaDelay),_clear=instance_number(PortalClear)
        scrNTTEFullMergedEffectsCall(_source,_owner,scrNTTEFullMergedPlasmaDestroy)
        assert(instance_number(PlasmaImpact)==_impacts+1 && instance_number(NTTEFullMergedPlasmaDelay)==_delays+2
            && instance_number(PortalClear)==_clear+1,"Fractional plasma chain did not emit first impact, ceil count delayed remainder and native wall clear")
        var _pending=scrNTTEFullInstances(NTTEFullMergedPlasmaDelay),_saw_fraction=false
        for(var _i=0;_i<array_length(_pending);++_i) if(array_get_index(_before,_pending[_i])<0) {
            var _delay=_pending[_i],_initial_time=_delay.time
            if(_delay.scale==0.75) _saw_fraction=true
            assert(_delay.team==team_player && _delay.creator==_owner && _initial_time>0,
                "Delayed plasma lost source ownership or creation-frame countdown")
            var _remaining=ceil(_initial_time/timescale)
            repeat(_remaining) with(_delay) event_perform(ev_step,ev_step_normal)
            assert(instance_exists(_delay),"Delayed plasma emitted on the decrement-to-zero frame rather than following Step")
            with(_delay) event_perform(ev_step,ev_step_normal)
            assert(!instance_exists(_delay),"Delayed plasma failed to emit after its logical countdown")
        }
        assert(_saw_fraction && instance_number(PlasmaImpact)==_impacts+3,"Fractional plasma chain lost0.75 final scale or actual delayed impacts")
        var _checked=0
        with(PlasmaImpact) if(array_get_index(_before,id)<0 && point_distance(x,y,_source.x,_source.y)<150) {
            ++_checked
            assert(team==team_player && creator==_owner && (image_xscale==1 || image_xscale==0.75)
                && image_yscale==image_xscale,"Plasma impact lost native projectile ownership or delayed scale")
        }
        assert(_checked==3,"Plasma ownership/scale assertions did not observe all actual impacts")

        var _trail=instance_create(89000,88500,Bullet1)
        _trail.creator=_owner;_trail.team=team_player;_trail.damage=280;_trail.speed=0
        scrNTTEFullMergedProjectileAddEffect(_trail,"plasma_trail")
        scrNTTEFullMergedProjectileAddEffect(_trail,"plasma_trail")
        assert(_trail.temerge_plasma_trail_scale==1/14 && _trail.temerge_plasma_trail_amount==2
            && array_length(_trail.temerge_hit_event_ref_list)==1,"Plasma trail lost exponential scale, stacked delayed amount or unique hit ref")
        _impacts=instance_number(PlasmaImpact);_delays=instance_number(NTTEFullMergedPlasmaDelay)
        scrNTTEFullMergedPlasmaTrailStep([_trail])
        assert(instance_number(PlasmaImpact)==_impacts+1 && instance_number(NTTEFullMergedPlasmaDelay)==_delays+1,
            "Guaranteed plasma trail did not create real immediate impact plus copied delayed explosion")
        var _target=instance_create(_trail.x,_trail.y,NTTEBabyGator)
        _target.team=team_enemy;_target.hp=100;_target.nexthurt=0
        _impacts=instance_number(PlasmaImpact);_delays=instance_number(NTTEFullMergedPlasmaDelay)
        scrNTTEFullMergedEffectsCall(_trail,_target,scrNTTEFullMergedPlasmaTrailHit)
        assert(instance_number(PlasmaImpact)==_impacts+1 && instance_number(NTTEFullMergedPlasmaDelay)==_delays+1,
            "Plasma trail hit did not emit one immediate impact and one15-tick pending impact")
        var _fifteen=noone
        with(NTTEFullMergedPlasmaDelay) if(array_get_index(_before,id)<0 && point_distance(x,y,_target.x,_target.y)<20) {
            assert(team==team_player && creator==_owner,"Plasma trail hit used target ownership instead of projectile ownership")
            if(abs(time-(15-timescale))<0.0001) _fifteen=id
        }
        assert(instance_exists(_fifteen),"Plasma hit delay did not execute its creation-frame Step")

        var _blood=instance_create(89400,88500,Bullet1),_blood_target=instance_create(89400,88500,NTTEBabyGator)
        _blood.creator=_owner;_blood.team=team_player;_blood.damage=270/timescale;_blood.knockback_speed=0
        scrNTTEFullMergedProjectileAddEffect(_blood,"blood_trail")
        scrNTTEFullMergedProjectileAddEffect(_blood,"blood_trail")
        assert(array_length(_blood.temerge_hit_event_ref_list)==2,
            "Blood trail repeated setup lost literal source cleared-membership duplicate callback behavior")
        var _meat=instance_number(MeatExplosion)
        scrNTTEFullMergedBloodTrailStep([_blood])
        assert(instance_number(MeatExplosion)==_meat+1,"Guaranteed blood trail did not create actual owned native blood explosion")
        _blood_target.hp=0;_blood_target.team=team_enemy;_blood_target.nexthurt=current_frame
        scrNTTEFullMergedEffectsCall(_blood,_blood_target,scrNTTEFullMergedBloodTrailHit)
        assert(instance_number(MeatExplosion)==_meat+2,"Blood trail melee eligibility invented a health gate absent from original scrMeleeCanHit")
        _blood_target.nexthurt=current_frame+1
        scrNTTEFullMergedEffectsCall(_blood,_blood_target,scrNTTEFullMergedBloodTrailHit)
        _blood_target.nexthurt=current_frame;_blood_target.team=team_player
        scrNTTEFullMergedEffectsCall(_blood,_blood_target,scrNTTEFullMergedBloodTrailHit)
        assert(instance_number(MeatExplosion)==_meat+2,"Blood trail ignored original melee iframe or same-team exclusion")
    }
    finally {
        var _all=scrNTTEFullInstances(all)
        for(var _i=array_length(_all)-1;_i>=0;--_i) if(array_get_index(_before,_all[_i])<0) instance_destroy(_all[_i],false)
        scrNTTEFullAreaGeneratorRestore(_game);scrNTTEFullAreaGeneratorRestore(_players);scrNTTEFullAreaGeneratorRestore(_back)
        global.ntte_full_merge_effect_registry=_registry;global.ntte_full_merge_effect_initialized=_initialized
        current_frame=_frame;random_set_seed(_seed)
    }
    scrNTTESmokeLog("FULL MERGED ENERGY: shared plasma stack, fractional actual impact chain/scales, creation-frame logical delay, native PortalClear and stacked plasma trail/hit delays OK @"+string(30/timescale))
}
