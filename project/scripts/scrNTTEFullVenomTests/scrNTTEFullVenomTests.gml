function scrNTTEFullVenomTests() {
    var _before=scrNTTEFullInstances(all),_players=scrNTTEFullAreaGeneratorSnapshot(Player),
        _game=scrNTTEFullAreaGeneratorSnapshot(GameCont),_back=scrNTTEFullAreaGeneratorSnapshot(BackCont),
        _seed=random_get_seed(),_frame=current_frame,_skills=ds_list_create(),_p=instance_find(Player,0)
    GameCont.skills=_skills;GameCont.ntte_full_native_skill_counts={};current_frame=8
    try {
        _p.x=6000;_p.y=6000;_p.gunangle=0;_p.accuracy=0;_p.race=Race.Fish;_p.infammo=0
        _p.wep=wep_ntte_venom_rifle;_p.ntte_state=scrNTTENewState(_p.wep)
        _p.ammo=array_create(Ammo.NUM_AMMO_TYPES,100)
        with(_p) scrFire(wep,true)
        var _shots=scrNTTEFullBubbleWeaponTestNew(_before,NTTEVenomPellet)
        assert(array_length(_shots)==3 && _p.ammo[Ammo.Bullets]==98 && _p.reload==3 && _p.wkick==4,
            "Venom ordinary fire lost3 real pellets/cost2/load3/source recoil4")
        for(var _i=0;_i<3;++_i) {
            var _s=_shots[_i],_a=120*_i
            scrNTTESmokeLog("VENOM FIRE DIAG "+json_stringify({i:_i,x:_s.x,y:_s.y,direction:_s.direction,
                speed:_s.speed,image_speed:_s.image_speed,sprite:_s.sprite_index,appear:_s.spr_spwn,
                owner:_s.creator==_p,team:_s.team,expectedTeam:_p.team,bloom:_s.ntte_bloom,
                expectedX:_p.x+lengthdir_x(6,_a)+16*(1-timescale),expectedY:_p.y+lengthdir_y(6,_a)}))
            assert(_s.creator==_p && _s.team==_p.team && _s.direction==0 && _s.speed==16*timescale
                && _s.image_speed==timescale && _s.sprite_index==_s.spr_spwn && _s.ntte_bloom==0.2
                && abs(_s.x-(_p.x+lengthdir_x(6,_a)+16*(1-timescale)))<=0.002
                && abs(_s.y-(_p.y+lengthdir_y(6,_a)))<=0.002,
                "Venom source shared direction/radius9/telib launch lead or constructor changed")
        }
        var _now=scrNTTEFullInstances(all)
        ds_list_add(_skills,mut_shotgun_shoulders)
        GameCont.ntte_full_native_skill_counts={}
        // Skill keys are numeric native mutation IDs, as in the other source fixtures.
        variable_struct_set(GameCont.ntte_full_native_skill_counts,string(mut_shotgun_shoulders),2)
        _p.wep=wep_ntte_beetle_blaster;_p.ntte_state=scrNTTENewState(_p.wep)
        _p.ammo=array_create(Ammo.NUM_AMMO_TYPES,100)
        with(_p) scrFire(wep,true)
        _shots=scrNTTEFullBubbleWeaponTestNew(_now,NTTEVenomPellet)
        assert(array_length(_shots)==2 && _p.ammo[Ammo.Bullets]==99 && _p.reload==13 && _p.wkick==5,
            "Beetle ordinary fire lost2 real pellets/cost1/load13/source recoil5")
        for(var _i=0;_i<2;++_i) {
            var _s=_shots[_i]
            assert(_s.direction==0 && _s.speed>=13*timescale && _s.speed<=15*timescale
                && abs(_s.y-(_p.y+(_i==0?4:-4)))<=0.002 && _s.wallbounce==8,
                "Beetle side geometry/speed13..15 or4*Shoulders changed")
        }
        // Actual native collision: first non-Player bypasses melee immunity,
        // second contact obeys it; each separate pellet has a private list.
        var _victim=instance_create(6200,6200,Bandit),_s=_shots[0],_s2=_shots[1]
        _victim.hp=20;_victim.team=_s.team;_victim.nexthurt=current_frame+100
        var _samefx=instance_number(ScorpionBulletHit)
        with(_victim) with(_s) event_perform(ev_collision,hitme)
        assert(_victim.hp==20 && array_length(_s.hit_list)==0 && instance_number(ScorpionBulletHit)==_samefx,
            "Venom actual outer CustomProjectile team gate admitted source first-hit shortcut")
        _victim.hp=20;_victim.team=team_enemy;_victim.nexthurt=current_frame+100
        _s.x=6200;_s.y=6200;_s.direction=0;_s.speed=14*timescale
        var _x=_s.x
        with(_victim) with(_s) event_perform(ev_collision,hitme)
        assert(_victim.hp==18 && array_length(_s.hit_list)==1 && abs(_s.x-(_x-14*timescale))<=0.002
            && abs(_s.speed-13.25*timescale)<=0.0001,
            "Venom first contact failed raw NP damage/private hitlist or source catch displacement/friction")
        with(_victim) with(_s) event_perform(ev_collision,hitme)
        assert(_victim.hp==18,"Venom repeated contact bypassed source melee iframe")
        with(_victim) with(_s2) event_perform(ev_collision,hitme)
        assert(_victim.hp==16,"Venom separate pellet incorrectly shared first-hit immunity")
        _victim.nexthurt=current_frame
        with(_victim) with(_s) event_perform(ev_collision,hitme)
        assert(_victim.hp==14 && array_length(_s.hit_list)==1,"Venom expired melee contact or unique private list changed")
        _p.hp=20;_p.nexthurt=current_frame+100;_p.team=team_player;_s.team=team_enemy
        with(_p) with(_s) event_perform(ev_collision,hitme)
        assert(_p.hp==20 && !array_contains(_s.hit_list,_p),"Venom first-hit shortcut incorrectly admitted immune Player")
        // First contact does not invent an extra positive-health condition.
        _victim.hp=0;_victim.nexthurt=current_frame;_victim.team=team_player;_s.hit_list=[]
        with(_victim) with(_s) event_perform(ev_collision,hitme)
        assert(_victim.hp==-2,"Venom source first contact acquired a positive-health gate")
        _s.speed=3.9*timescale;_s.sprite_index=_s.spr_idle;_s.image_index=2
        with(_s) event_perform(ev_step,ev_step_normal)
        assert(_s.sprite_index==_s.spr_fade && _s.image_index==0,"Venom source minspeed fade threshold changed")
        var _effects=instance_number(ScorpionBulletHit)
        with(_s) event_perform(ev_other,ev_animation_end)
        assert(!instance_exists(_s) && instance_number(ScorpionBulletHit)==_effects,"Venom fade emitted terminal impact")
        _s=_s2;_s.speed=10*timescale;_s.wallbounce=8
        var _wall=instance_create(6300,6300,Wall)
        with(_wall) with(_s) event_perform(ev_collision,Wall)
        assert(instance_exists(_s) && abs(_s.speed-16*timescale)<=0.0001 && _s.wallbounce==7.6,
            "Venom actual wall contact lostsource .8speed+Shoulders and .95attenuation")
        _s.wallbounce=0
        with(_wall) with(_s) event_perform(ev_collision,Wall)
        assert(!instance_exists(_s),"Venom ordinary non-bounce wall did not destroy")
        // Actual ActorFire and merged-front constructors retain this class.
        var _npc=instance_create(6400,6400,Bandit),_players_count=instance_number(Player)
        _npc.team=team_enemy
        var _result=scrNTTEFullActorFire(_npc,wep_ntte_venom_rifle,20,0,false)
        _shots=scrNTTEFullMergedRuntimeTestShots(_result.shots,NTTEVenomPellet)
        assert(array_length(_shots)==3 && _shots[0].creator==_npc && _shots[0].team==team_enemy
            && _shots[0].direction==20 && instance_number(Player)==_players_count,
            "Venom actual NPC owner/team/direction or synchronous proxy cleanup changed")
        var _weapon=scrNTTEFullWeaponMerge(wep_revolver,wep_ntte_venom_rifle),_handle=scrNTTEFullWeaponNative(_weapon)
        _p.wep=_handle;_p.ntte_state=scrNTTEFullWeaponNativeState(_weapon)
        _p.ammo=array_create(Ammo.NUM_AMMO_TYPES,100)
        _result=scrNTTEFullMergedRuntimePlayerFire(_p,_handle,{creator:_p})
        _shots=scrNTTEFullMergedRuntimeTestShots(_result.shots,NTTEVenomPellet)
        assert(array_length(_shots)==3 && _shots[0].creator==_p && variable_instance_exists(_shots[0],"temerge_vars_list"),
            "Venom merged front lost actual native pellet family/inherited source metadata")
    } finally {
        scrNTTEFullMergedRuntimeTestCleanup(_before)
        scrNTTEFullAreaGeneratorRestore(_players);scrNTTEFullAreaGeneratorRestore(_game)
        scrNTTEFullAreaGeneratorRestore(_back);ds_list_destroy(_skills)
        random_set_seed(_seed);current_frame=_frame
    }
    scrNTTESmokeLog("FULL VENOM/BEETLE: actual ordinary geometry/cost/reload/recoil, per-pellet first-hit/melee split, raw NP/catch/fade/wall, NPC ownership and merged front OK @"+string(30/timescale))
}
