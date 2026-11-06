function scrNTTEFullTeslaTests() {
    var _before=scrNTTEFullInstances(all),_players=scrNTTEFullAreaGeneratorSnapshot(Player),
        _game=scrNTTEFullAreaGeneratorSnapshot(GameCont),_back=scrNTTEFullAreaGeneratorSnapshot(BackCont),
        _seed=random_get_seed(),_tick=current_frame,_p=instance_find(Player,0),_skills=ds_list_create()
    GameCont.skills=_skills;GameCont.ntte_full_native_skill_counts={};current_frame=8
    try {
        _p.x=83000;_p.y=83000;_p.team=team_player;_p.gunangle=0;_p.accuracy=0
        _p.race=Race.Fish;_p.infammo=0;_p.wep=wep_ntte_tesla_coil
        _p.ntte_state=scrNTTENewState(_p.wep);_p.ammo=array_create(Ammo.NUM_AMMO_TYPES,100)
        var _generic=instance_number(NTTEAttack),_coils=[]
        with(_p) scrFire(wep,true)
        _coils=scrNTTEFullBubbleWeaponTestNew(_before,NTTEFullTeslaCoil)
        assert(array_length(_coils)==1 && instance_number(NTTEAttack)==_generic
            && _p.ammo[Ammo.Energy]==98 && _p.reload==8,
            "Tesla normal scrFire lost actual coil/cost2/load8 or retained generic attack")
        var _first=_coils[0],_fx=scrNTTEFullBubbleWeaponTestNew(_before,LightningHit)
        assert(_first.creator==_p && _first.team==_p.team && _first.damage==14
            && _first.typ==0 && _first.knockback_speed==4*timescale && _first.ntte_full_primary
            && _first.ntte_full_offx==17 && _first.ntte_full_offy==2 && _first.ntte_full_range==96
            && _first.ntte_full_time>=8 && _first.ntte_full_time<=16 && _first.num==3
            && array_length(_fx)==1 && _fx[0].hspeed>0,
            "Tesla first-ball source physical constructor/ownership/one-shot appear FX changed")
        var _kick=_p.wkick,_fxcount=instance_number(LightningHit)
        with(_p) scrFire(wep,true)
        assert(instance_number(NTTEFullTeslaCoil)==2 && instance_number(LightningHit)==_fxcount
            && _p.wkick==_kick && _p.ammo[Ammo.Energy]==96,
            "Tesla subsequent ball repeated source first-coil-only post/appear effect")
        // Secondary coil has source's two distinct four-pixel adjustments:
        // offy becomes-2 then the actual follow Step adds y-4 separately.
        var _second=noone
        with(_p) _second=scrNTTEFullTeslaWeaponFire(false)
        assert(!_second.ntte_full_primary && _second.ntte_full_offy==-2,
            "Tesla secondary source offy adjustment changed")
        _second.ntte_full_target_delay=-1;_second.ntte_full_time=100
        _second.target=noone;_second.ntte_full_target_x=_p.x+50;_second.ntte_full_target_y=_p.y
        _p.bwkick=0;_p.right=1;_p.hspeed=2*timescale;_p.vspeed=timescale
        with(_second) event_perform(ev_step,ev_step_normal)
        assert(abs(_second.x-(_p.x+_p.hspeed+17))<=0.008
            && abs(_second.y-(_p.y+_p.vspeed-6))<=0.008
            && _second.xprevious==_second.x && _second.yprevious==_second.y && _p.bwkick==3,
            "Tesla actual secondary Step lost physical creator lead, recoil/mirror mount or previous position")
        // Actual native hit event: source melee eligibility, direct BulletHit,
        // directional FT4/min16, enemy iframe, no added hp or phase filter.
        var _victim=instance_create(_second.x,_second.y+8,Bandit)
        _victim.hp=30;_victim.team=team_enemy;_victim.nexthurt=0
        _victim.speed=0;_victim.friction=0.2*timescale*timescale;_second.direction=0
        current_frame=8+timescale
        with(_victim) with(_second) event_perform(ev_collision,hitme)
        assert(_victim.hp==16 && abs(angle_difference(_victim.direction,0))<0.0001
            && abs(_victim.speed-(16*timescale-_victim.friction*(1/timescale-1)))<0.0001,
            "Tesla source melee/BulletHit lost14 damage, directional FT4 or native minimum16")
        with(_victim) with(_second) event_perform(ev_collision,hitme)
        assert(_victim.hp==16,"Tesla source melee hit ignored enemy six-frame iframe")
        _victim.hp=0;_victim.nexthurt=0
        with(_victim) with(_second) event_perform(ev_collision,hitme)
        assert(_victim.hp==-14,"Tesla source melee eligibility gained hp>0 gate")
        _victim.hp=30;_victim.nexthurt=0;_victim.team=_second.team
        with(_victim) with(_second) event_perform(ev_collision,hitme)
        assert(_victim.hp==30,"Tesla hit its own faction")
        // Source target search does not discard zero-health opposing hitme;
        // it uses real bbox distance, mask visibility and the literal priority.
        scrNTTEFullMergedRuntimeTestCleanup(_before)
        var _coil=noone
        with(_p) _coil=scrNTTEFullMergedBasicProjectileCreate(83100,83100,NTTEFullTeslaCoil)
        _victim=instance_create(83120,83100,Bandit)
        _victim.team=team_enemy;_victim.hp=0
        _p.x=83100;_p.y=83100;_p.hspeed=0;_p.vspeed=0
        var _time=_coil.ntte_full_time
        with(_coil) scrNTTEFullTeslaCoilTarget()
        assert(_coil.target==_victim && abs(_coil.ntte_full_time-_time*1.5)<0.0001,
            "Tesla source real-target selection, hp0 eligibility or time1.5 changed")
        _coil.ntte_full_target_delay=-1;_coil.ntte_full_purple=true;_coil.damage=6
        var _arc_before=scrNTTEFullInstances(all)
        with(_coil) event_perform(ev_step,ev_step_normal)
        var _arcs=scrNTTEFullBubbleWeaponTestNew(_arc_before,NTTEFullTrenchLightning)
        assert(array_length(_arcs)>0,"Tesla actual source Step emitted no native lightning")
        for(var _i=0;_i<array_length(_arcs);++_i) assert(_arcs[_i].damage==14
            && _arcs[_i].sprite_index==scrNTTERefSprite("ElectroPlasmaTether")
            && _arcs[_i].creator==_p && _arcs[_i].team==_p.team,
            "Purple Tesla lost actual lightning source floor(damage*7/3), sprite/team/owner")
        instance_destroy(_victim,false)
        _coil.ntte_full_time=20
        with(_coil) event_perform(ev_step,ev_step_normal)
        assert(_coil.target==noone && abs(_coil.ntte_full_time-(8-timescale))<0.0001,
            "Tesla deleted-target fallback failed source min8 then logical countdown")
        _coil.ntte_full_time=timescale
        with(_coil) event_perform(ev_step,ev_step_normal)
        assert(!instance_exists(_coil),"Tesla logical lifetime failed actual Step destruction")
        // Actual ActorFire synchronous proxy must keep durable ownership while
        // grouping first-ball appearance, and leave no extra player behind.
        scrNTTEFullMergedRuntimeTestCleanup(_before)
        var _npc=instance_create(83300,83300,Bandit),_player_count=instance_number(Player)
        _npc.team=team_enemy;_npc.gunangle=0
        var _result=scrNTTEFullActorFire(_npc,wep_ntte_tesla_coil,0,0,false)
        _coils=scrNTTEFullMergedRuntimeTestShots(_result.shots,NTTEFullTeslaCoil)
        assert(array_length(_coils)==1 && _coils[0].creator==_npc && _coils[0].team==team_enemy
            && instance_number(Player)==_player_count
            && instance_number(LightningHit)>0,
            "NPC Tesla lost first-coil effect/real owner/team or leaked temporary firing proxy")
    }
    finally {
        scrNTTEFullMergedRuntimeTestCleanup(_before)
        scrNTTEFullAreaGeneratorRestore(_players);scrNTTEFullAreaGeneratorRestore(_game);scrNTTEFullAreaGeneratorRestore(_back)
        ds_list_destroy(_skills);current_frame=_tick;random_set_seed(_seed)
    }
    scrNTTESmokeLog("FULL TESLA: actual normal fire/native costs, source first-coil effects/grouping/secondary mount, melee BulletHit, target/real arcs/purple damage/lifetime and NPC durable owner OK")
}
