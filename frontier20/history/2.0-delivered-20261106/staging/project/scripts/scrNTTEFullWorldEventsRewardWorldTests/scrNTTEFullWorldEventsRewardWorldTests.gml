// Actual selected/generated Shrine and BuriedVault rewards. Native prompt input,
// object-scheduled altar/orb/vault/pedestal Steps, native contact chest opening,
// and actual guardian timers. No direct reward grant or source callback dispatch.
function scrNTTEFullWorldEventsRewardWorldTests() {
    if(os_type!=os_windows || !scrNTTEFullSmokeEnabled()) throw "Reward world fixture requires explicit desktop full smoke"
    var _object=asset_get_index("NTTEFullWorldEventsRewardWorldTest")
    assert(object_exists(_object) && !instance_exists(_object),"Reward world observer missing or already active")
    var _observer=instance_create(0,0,_object)
    with(_observer) {
        state=scrNTTEFullWorldEventsNaturalWorldCapture();fixture_skills=ds_list_create()
        player=instance_find(Player,0);old_pick=KeyCont.press_pick[player.index];want_pick=false
        profiles=[[area_palace,2,106058,"PalaceShrine"],[area_desert,2,100013,"BuriedVault"]]
        profile_index=0;phase=0;ticks=0;draw_frames=0;draw_start=0
        altar=noone;orb=noone;vault=noone;pedestal=noone;reward=noone;guard_count=0;discoveries=0
        selected_skill=0;skill_before=0;selected_prompts=[];airborne_before=0;expected_airborne=0
        visible=true;depth=-100000
    }
}
function scrNTTEFullWorldEventsRewardWorldInput() {
    if(instance_exists(player)) KeyCont.press_pick[player.index]=want_pick
}
function scrNTTEFullWorldEventsRewardWorldDrawWitness() {draw_frames++}
function scrNTTEFullWorldEventsRewardWorldStep() {
    with(Player) {hp=100000;max_hp=100000;nexthurt=current_frame+100000;speed=0;can_walk=false;can_aim=false;can_pick=true;visible=true}
    if(phase==0) {
        var _profile=profiles[profile_index],_found=false
        for(var _attempt=0;_attempt<512 && !_found;++_attempt) {
            scrNTTEFullWorldEventsNaturalWorldConfigure(state,_profile,_profile[2]+_attempt)
            ds_list_clear(fixture_skills);GameCont.skills=fixture_skills;GameCont.ntte_full_native_skill_counts={}
            var _gen=instance_create(0,0,GenCont)
            _found=instance_exists(scrNTTEFullWorldEventGet(_profile[3]))
            if(!_found) {scrNTTEFullWorldEventsCleanup();scrNTTEFullMergedRuntimeTestCleanup(state.before)}
        }
        assert(_found,"Reward world seed sweep did not naturally select "+_profile[3])
        ticks=0;phase=1;return;
    }
    ticks++
    assert(ticks<3600,"Actual generated reward/native input/Step chain timed out phase="+string(phase))
    if(phase==1) {
        if(instance_exists(GenCont) || instance_exists(FloorMaker)) return;
        assert(instance_number(Floor)>20,"Reward acceptance did not finish actual generated terrain")
        if(profile_index==0) {
            var _altars=scrNTTEFullInstances(NTTEFullPalaceAltar)
            assert(array_length(_altars)>0,"Naturally selected/generated Shrine omitted its real altars")
            altar=_altars[0];selected_skill=altar.skill;skill_before=scr_skill_get(selected_skill)
            assert(selected_skill!=0 && skill_before==0 && instance_exists(altar.prompt),
                "Generated Shrine altar does not expose a source-available unowned blessing/prompt")
            for(var _i=0;_i<array_length(_altars);++_i) array_push(selected_prompts,_altars[_i].prompt)
            player.x=altar.x;player.y=altar.y+12;player.xprevious=player.x;player.yprevious=player.y
            want_pick=true;ticks=0;phase=2;return;
        }
        vault=instance_find(NTTEFullBuriedVault,0)
        assert(instance_exists(vault),"Naturally selected/generated BuriedVault omitted its hidden real controller")
        phase=5;return;
    }
    if(phase==2) {
        if(instance_exists(altar) && altar.ntte_altar_break_left<0) return;
        want_pick=false;KeyCont.press_pick[player.index]=false
        with(NTTEFullPalaceAltar) {
            assert(ntte_altar_break_left>0 && !prompt.visible,"Actual native prompt selection did not disable all Shrine peers")
            if(id!=other.altar) assert(skill==0,"Unselected actual Shrine peer retained a second reward skill")
        }
        ticks=0;phase=3;return;
    }
    if(phase==3) {
        var _orbs=scrNTTEFullInstances(NTTEFullOrchidBall)
        if(array_length(_orbs)==0) return;
        assert(array_length(_orbs)==1,"One actual Shrine input produced multiple real blessing orbs")
        orb=_orbs[0]
        assert(orb.skill==selected_skill && orb.type=="portal" && orb.creator==altar,
            "Actual Shrine timer/death produced an incorrect temporary portal blessing orb")
        ticks=0;phase=4;return;
    }
    if(phase==4) {
        if(instance_exists(orb)) return;
        var _timers=scrNTTEFullInstances(NTTEFullOrchidSkill),_grants=0
        for(var _i=0;_i<array_length(_timers);++_i) if(_timers[_i].skill==selected_skill && _timers[_i].type=="portal") {
            assert(_timers[_i].ntte_applied && _timers[_i].time==2,"Actual Shrine blessing lost its source two-portal duration")
            _grants++
        }
        assert(_grants==1 && scr_skill_get(selected_skill)==skill_before+1,
            "Native orb contact did not grant exactly one source temporary blessing")
        assert(!instance_exists(NTTEFullPalaceAltar),"Actual Shrine peers did not finish their native destruction timers")
        for(var _i=0;_i<array_length(selected_prompts);++_i)
            assert(!instance_exists(selected_prompts[_i]),"Native altar CleanUp orphaned its persistent interaction prompt")
        scrNTTESmokeLog("WORLD SHRINE NATURAL actual native pickup input / scheduled peer disable+death / exactly1real portal orb / native contact grant / two-portal timer / prompt cleanup OK")
        lifetime_portal_timer=noone
        var _wanted=selected_skill
        with(NTTEFullOrchidSkill) if(skill==_wanted && type=="portal") other.lifetime_portal_timer=id
        assert(instance_exists(lifetime_portal_timer),"Actual Shrine reward lost its scheduled lifetime owner")
        lifetime_player_mask=player.mask_index
        lifetime_chest=instance_create(player.x,player.y,NTTEFullOrchidChest)
        lifetime_basic_timer=noone;lifetime_elapsed=0;lifetime_cycles=0
        ticks=0;phase=10;return;
    }
    if(phase==10) {
        if(instance_exists(lifetime_chest)) return;
        with(NTTEFullOrchidSkill) if(type=="basic" && !setup && ntte_applied) other.lifetime_basic_timer=id
        if(!instance_exists(lifetime_basic_timer)) return;
        assert(lifetime_basic_timer.time_max==600 && lifetime_basic_timer.time>0,"Orchid chest changed original twenty-second lifetime")
        lifetime_basic_skill=lifetime_basic_timer.skill
        lifetime_basic_before=scr_skill_get(lifetime_basic_skill)-lifetime_basic_timer.num
        lifetime_last_time=lifetime_basic_timer.time;lifetime_elapsed=0
        assert(!is_undefined(scrNTTEFullOrchidHUDState(lifetime_basic_skill)),"Actual grant omitted gold lifetime HUD")
        phase=11;return;
    }
    if(phase==11) {
        lifetime_elapsed+=timescale
        assert(lifetime_elapsed<610,"Scheduled basic mutation never expired after twenty seconds")
        if(instance_exists(lifetime_basic_timer)) {
            assert(!instance_exists(GenCont) && !instance_exists(LevCont),"Lifetime fixture entered loading or selection")
            if(lifetime_last_time>0) assert(lifetime_basic_timer.time<lifetime_last_time,"OrchidSkill Step was not scheduled")
            lifetime_last_time=lifetime_basic_timer.time;return;
        }
        assert(scr_skill_get(lifetime_basic_skill)==lifetime_basic_before,"Expiration left a permanent temporary layer")
        assert(instance_exists(lifetime_portal_timer) && lifetime_portal_timer.time==2,"Twenty seconds consumed portal-count blessing")
        phase=12;return;
    }
    if(phase==12) {
        assert(!instance_exists(Portal) && !scrNTTEFullValue(GameCont,"ntte_portal_closed",false),"Portal fixture lacks real empty EndStep")
        GameCont.is_level_ended=true;player.mask_index=lifetime_player_mask;player.visible=true
        lifetime_native_portal=instance_create(player.x,player.y,Portal)
        assert(lifetime_native_portal.endgame==100 && !lifetime_native_portal.close,"Fixture replaced native Portal constructor")
        phase=13;return;
    }
    if(phase==13) {
        if(instance_exists(lifetime_native_portal)) return;
        lifetime_cycles++
        if(lifetime_cycles==1) assert(instance_exists(lifetime_portal_timer) && lifetime_portal_timer.time==1,"First portal did not consume exactly one interval")
        else assert(!instance_exists(lifetime_portal_timer) && scr_skill_get(selected_skill)==skill_before,"Second portal left blessing permanent")
        phase=14;return;
    }
    if(phase==14) {
        if(scrNTTEFullValue(GameCont,"ntte_portal_closed",false)) return;
        if(lifetime_cycles<2) {phase=12;return;}
        player.mask_index=lifetime_player_mask;GameCont.is_level_ended=false
        scrNTTESmokeLog("WORLD ORCHID LIFETIME actual chest+orb / scheduled600tick expiry / source pre-grant counts restored / native Portal contact+animation twice / natural latch reset OK @"+string(30/timescale))
        phase=9;draw_start=draw_frames;return;
    }
    if(phase==5) {
        if(array_length(vault.layout)==0) return;
        assert(vault.area==area_vault && vault.obj_loot=="BuriedVaultPedestal",
            "Natural hidden vault lost its genuine destination area or original reward route")
        // Native explosive floor is the production wall-excavation result. The
        // actual hidden controller observes it in its registered normal Step.
        instance_create(vault.x,vault.y,FloorExplo)
        ticks=0;phase=6;return;
    }
    if(phase==6) {
        if(instance_exists(vault)) return;
        assert(GameCont.area==area_desert,"Actual buried excavation leaked its temporary destination area")
        var _peds=scrNTTEFullInstances([NTTEFullBuriedVaultPedestal,NTTEFullBuriedVaultCrownPed])
        assert(array_length(_peds)==1,"Actual natural vault excavation did not expose exactly one original pedestal")
        pedestal=_peds[0];reward=pedestal.target
        assert(instance_exists(reward) && (instance_is(reward,NTTEFullBuriedVaultChest) || instance_is(reward,BigWeaponChest)
            || instance_is(reward,ProtoChest) || instance_is(reward,ProtoStatue) || instance_is(reward,HostileHorror)),
            "Actual excavated pedestal selected a reward outside the original pool")
        guard_count=pedestal.spawn;discoveries=scrNTTEFullValue(GameCont,"buried_vaults",0)
        airborne_before=instance_number(NTTEFullBackpackPickup)
        expected_airborne=instance_is(reward,NTTEFullBuriedVaultChest)?reward.num:0
        player.x=reward.x;player.y=reward.y;player.xprevious=player.x;player.yprevious=player.y
        if(instance_is(reward,ProtoStatue)) reward.hp=floor(reward.max_hp*0.6)
        if(instance_is(reward,HostileHorror)) {
            assert(guard_count==0,"Real Horror pedestal branch incorrectly demanded source guardians")
            scrNTTESmokeLog("WORLD VAULT NATURAL actual hidden layout/explosive excavation/native Horror reward/source guardian waiver OK")
            phase=9;draw_start=draw_frames;return;
        }
        ticks=0;phase=7;return;
    }
    if(phase==7) {
        if(expected_airborne>0) {
            if(instance_exists(reward)) return;
            assert(instance_number(NTTEFullBackpackPickup)==airborne_before+expected_airborne,
                "Actual contact-open buried reward did not produce exactly3+OpenMind real airborne chests")
            expected_airborne=0
        }
        if(pedestal.spawn>0) return;
        assert(array_length(pedestal.spawn_inst)==guard_count && scrNTTEFullValue(GameCont,"buried_vaults",0)==discoveries+1,
            "Real scheduled pedestal did not finish its source30/10tick guardian count/discovery chain")
        for(var _i=0;_i<array_length(pedestal.spawn_inst);++_i)
            assert(instance_is(pedestal.spawn_inst[_i],CrownGuardian),"Actual source guardian timer did not create native CrownGuardian")
        scrNTTESmokeLog("WORLD VAULT NATURAL real hidden layout/native explosive excavation/actual pedestal reward/contact opening/scheduled guardians/discovery OK")
        phase=9;draw_start=draw_frames;return;
    }
    if(draw_frames-draw_start<8) return;
    scrNTTEFullWorldEventsNextRoomDispose(state)
    scrNTTEFullMergedRuntimeTestCleanup(state.before)
    if(++profile_index<array_length(profiles)) {phase=0;return;}
    var _state=state,_skills=fixture_skills,_player=player,_old_pick=old_pick
    scrNTTEFullWorldEventsNaturalWorldRestore(_state)
    ds_list_destroy(_skills);KeyCont.press_pick[_player.index]=_old_pick
    scrNTTESmokeLog("FULL WORLD NATURAL SHRINE+VAULT real generated reward chains / scheduled native object logic / actual input+contact / live Draw complete @"+string(30/timescale))
    instance_destroy(id,false)
}
