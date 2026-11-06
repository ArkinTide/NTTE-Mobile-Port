// Focused production callback regression. No particle/factory replacements.
// An integer current_frame makes the read-only active-frame macro true at real30/60.
function scrNTTEFullNativeEffectLifetimeTests() {
    assert(os_type==os_windows && scrNTTEFullSmokeEnabled() && !instance_exists(GenCont)
        && !instance_exists(Menu) && instance_exists(GameCont) && instance_exists(Player),
        "Native effect lifetime regression requires a settled desktop room")
    assert(variable_global_exists("ntte_full_progress") && is_struct(global.ntte_full_progress),
        "Native effect fixture requires initialized original progress")
    var _snapshot=scrNTTEFullInstances(all),_game=scrNTTEFullAreaGeneratorSnapshot(GameCont),
        _players=scrNTTEFullAreaGeneratorSnapshot(Player),_back=scrNTTEFullAreaGeneratorSnapshot(BackCont),
        _particles=UberCont.opt_prtcls,_seed=random_get_seed(),_stop=lockstep_stop,
        _frame=current_frame,_rng_states=scrNTTEFullArrayCopy(global.rng_state),
        _progress=global.ntte_full_progress,_progress_json=json_stringify(global.ntte_full_progress),
        _graph={nodes:[]}
    scrNTTEFullAreaSnapshotContainer(_progress,_graph)
    try {
        lockstep_stop=false;current_frame=floor(current_frame)
        assert(current_frame_active,"Integer native clock did not select an authored active frame")
        GameCont.area=area_desert;GameCont.lastarea=area_desert;GameCont.underwater=false
        for(var _off=0;_off<2;++_off) {
            UberCont.opt_prtcls=(_off==0)
            var _before=scrNTTEFullInstances(all),_smoke_count=instance_number(Smoke),
                _probe=instance_create(60000,60000,Smoke)
            assert(instance_exists(_probe)==(_off==0),"Actual Smoke constructor particles lifetime differs")
            scrNTTESmokeLog("NATIVE EFFECT ACTUAL SMOKE off="+string(_off)+" returned="+string(_probe)+" live="+string(instance_exists(_probe)))
            scrNTTEFullMergedRuntimeTestCleanup(_before)

            // Actual Alarm splits the remaining two magazine credits. Its
            // optional Smoke must not prevent zeroing parent refund, native
            // parent Destroy/Cleanup, or child Cleanup returning exactly two.
            var _owner=instance_find(Player,0),_state=scrNTTENewState(wep_ntte_sawblade_cannon),
                _disc=noone,_discs=instance_number(NTTEFullBatDisc)
            _state.ammo=7;_state.outstanding=2
            with(_owner) _disc=scrNTTEFullMergedBasicProjectileCreate(60000+128*_off,60000,NTTEFullBatDisc,0)
            scrNTTEFullBatDiscBind(_disc,_state,2);_disc.big=true;_disc.walled=true
            with(_disc) event_perform(ev_alarm,0)
            assert(!instance_exists(_disc) && instance_number(NTTEFullBatDisc)==_discs+2
                && _state.ammo==7 && _state.outstanding==2,
                "Actual BatDisc optional Smoke prevented split/destroy or prematurely refunded parent")
            var _count=0
            with(NTTEFullBatDisc) if(state==_state) {
                assert(ammo==1 && refund==1 && walled && creator==_owner && team==_owner.team,
                    "Actual split child lost source physical credit/creator/team")
                _count++
            }
            assert(_count==2,"Actual parent Alarm did not leave exactly two physical children")
            if(_off==0) assert(instance_number(Smoke)>=_smoke_count+3 && instance_number(Smoke)<=_smoke_count+5,
                "Live split/parent death Smoke count changed")
            else assert(instance_number(Smoke)==_smoke_count,"Disabled Smoke survived constructor")
            with(NTTEFullBatDisc) if(state==_state) instance_destroy()
            assert(_state.ammo==9 && _state.outstanding==0 && instance_number(NTTEFullBatDisc)==_discs,
                "Actual child Destroy/Cleanup after optional Smoke lost/doubled magazine credits")
            scrNTTEFullMergedRuntimeTestCleanup(_before)
        }

        UberCont.opt_prtcls=true
        for(var _water=0;_water<2;++_water) {
            GameCont.underwater=(_water==1)
            var _before=scrNTTEFullInstances(all),_x=60400+_water*128,_y=60000,
                _bubbles=instance_number(Bubble),_flame=instance_create(_x,_y,Flame)
            assert(instance_exists(_flame)==(_water==0)
                && instance_number(Bubble)==_bubbles+_water,
                "Actual Flame constructor did not preserve ground/water Bubble replacement")
            scrNTTESmokeLog("NATIVE EFFECT ACTUAL FLAME water="+string(_water)+" returned="+string(_flame)+" live="+string(instance_exists(_flame)))
            scrNTTEFullMergedRuntimeTestCleanup(_before)

            // Genuine source pet species construction and actual native Step
            // call its registered Salamander hook. Charge2 is a valid active
            // dash setup, not a replacement combat or projectile factory.
            var _pet=scrNTTEFullPetCreate(_x,_y,"Salamander")
            _pet.team=team_player;_pet.dash=true;_pet.dash_charging=false
            _pet.dash_charge=2;_pet.dash_direction=0;_pet.direction=0;_pet.speed=0
            var _enemy_round=instance_create(_x,_y,Bullet1),_ally_round=instance_create(_x,_y,Bullet1),
                _grenade=instance_create(_x,_y,Grenade)
            _enemy_round.team=team_enemy;_ally_round.team=team_player;_grenade.team=team_enemy
            var _flames=instance_number(Flame),_bubbles=instance_number(Bubble)
            with(_pet) event_perform(ev_step,ev_step_normal)
            assert(instance_exists(_pet) && _pet.dash && abs(_pet.dash_charge-(2-_pet.dash_add*timescale))<0.0001
                && _pet.speed>0,"Actual Salamander native Step lost independent dash continuation")
            assert(!instance_exists(_enemy_round) && instance_exists(_ally_round) && instance_exists(_grenade),
                "Optional underwater Flame interrupted hostile projectile interception or changed friendly/grenade exclusions")
            assert(instance_number(Flame)==_flames+(_water==0?2:0)
                && instance_number(Bubble)==_bubbles+(_water==1?2:0),
                "Actual Salamander intercept+trail must yield two ground Flames or two underwater Bubbles")
            if(_water==0) {
                var _found=0
                with(Flame) if(array_get_index(_before,id)<0) {
                    assert(sprite_index==sprSalamanderBullet && creator==_pet && team==team_player,
                        "Live Flame art/creator/team changed while guarding water replacement")
                    _found++
                }
                assert(_found==2,"Actual ground Salamander Step did not retain two live Flames")
            }
            scrNTTESmokeLog("NATIVE EFFECT REAL CALLBACKS actual BatDisc Alarm/Destroy/Cleanup on/off; native Salamander.Step intercept+trail water="+string(_water)+" faction/grenade exclusion/dash continuation OK")
            scrNTTEFullMergedRuntimeTestCleanup(_before)
        }
    }
    finally {
        scrNTTEFullMergedRuntimeTestCleanup(_snapshot)
        scrNTTEFullAreaGeneratorRestore(_game);scrNTTEFullAreaGeneratorRestore(_players)
        scrNTTEFullAreaGeneratorRestore(_back)
        scrNTTEFullAreaGeneratorRestore({instances:[],containers:_graph.nodes})
        global.ntte_full_progress=_progress;global.rng_state=_rng_states
        UberCont.opt_prtcls=_particles;lockstep_stop=_stop;current_frame=_frame;random_set_seed(_seed)
    }
    assert(json_stringify(global.ntte_full_progress)==_progress_json,"Native effect regression leaked pet progress changes")
    scrNTTESmokeLog("NATIVE EFFECT LIFETIME actual Smoke on/off and Flame ground/water constructors + native BatDisc split/refund + native Salamander Step intercept/dash/ownership/exclusions OK @"+string(30/timescale)+"; remaining caller branches/campaign/iPhone not certified")
}
