function scrNTTEFullRogueCarbineTests() {
    var _before=scrNTTEFullInstances(all),_players=scrNTTEFullAreaGeneratorSnapshot(Player),
        _game=scrNTTEFullAreaGeneratorSnapshot(GameCont),_back=scrNTTEFullAreaGeneratorSnapshot(BackCont),
        _seed=random_get_seed(),_frame=current_frame,_skills=ds_list_create(),_p=instance_find(Player,0)
    GameCont.skills=_skills;GameCont.ntte_full_native_skill_counts={};current_frame=8
    try {
        _p.x=6500;_p.y=6500;_p.gunangle=0;_p.accuracy=0;_p.race=Race.Fish;_p.infammo=0
        _p.wep=wep_ntte_rogue_carbine;_p.ntte_state=scrNTTENewState(_p.wep)
        _p.ammo=array_create(Ammo.NUM_AMMO_TYPES,100)
        var _oldburst=instance_number(NTTERogueCarbineBurst)
        with(_p) scrFire(wep,true)
        var _shots=scrNTTEFullBubbleWeaponTestNew(_before,NTTERogueCarbineBullet),
            _bursts=scrNTTEFullBubbleWeaponTestNew(_before,NTTEFullNativeFireBurst)
        assert(array_length(_shots)==1 && array_length(_bursts)==1 && instance_number(NTTERogueCarbineBurst)==_oldburst
            && _p.ammo[Ammo.Bullets]==96 && _p.reload==5 && _p.wkick==5,
            "Rogue Carbine ordinary fire lost exact first shot/real FireBurst/single cost4/load5/recoil5")
        var _shot=_shots[0],_burst=_bursts[0]
        assert(_shot.creator==_p && _shot.team==_p.team && _shot.damage==7 && _shot.force==12
            && _shot.gland==2 && _shot.mask_index==mskBullet1 && _shot.temerge_object==HeavyBullet
            && _shot.direction==0 && _shot.speed==16*timescale && _shot.ntte_bloom==0.1
            && _shot.sprite_index==sprNTTEIDPDHeavyBullet && _shot.spr_dead==sprNTTEIDPDHeavyBulletHit
            && _burst.time_max==2 && _burst.time>2-timescale && _burst.time<=2 && _burst.ammo==1 && _burst.burst==1,
            "Rogue Carbine source CustomBullet/art/force/gland/HeavyBullet alias or2tick jitter changed")
        _p.x=6600;_p.y=6600;_p.gunangle=90
        repeat(ceil(5/timescale)) if(instance_exists(_burst)) with(_burst) event_perform(ev_step,ev_step_normal)
        _shots=scrNTTEFullBubbleWeaponTestNew(_before,NTTERogueCarbineBullet)
        assert(array_length(_shots)==2 && !instance_exists(_burst) && _p.ammo[Ammo.Bullets]==96
            && _shots[1].creator==_p && _shots[1].direction==90
            && abs(_shots[1].x-6600)<=0.002 && abs(_shots[1].y-(6600-16*(1-timescale)))<=0.002,
            "Rogue delayed round lost current creator position/angle/source lead or debited ammo twice")
        var _victim=instance_create(6700,6700,Bandit)
        _victim.team=team_enemy;_victim.hp=30;_victim.nexthurt=current_frame+100
        _victim.friction=0.2*timescale*timescale;_victim.speed=0
        var _effects=instance_number(BulletHit)
        with(_victim) with(_shot) event_perform(ev_collision,hitme)
        assert(!instance_exists(_shot) && _victim.hp==23
            && abs(_victim.speed-(16*timescale-_victim.friction*(1/timescale-1)))<=0.0001
            && instance_number(BulletHit)==_effects+1,
            "Rogue source BulletCanHit/7damage/min16/terminal impact incorrectly obeyed enemy iframe")
        _shot=_shots[1];_victim.team=_shot.team
        with(_victim) with(_shot) event_perform(ev_collision,hitme)
        assert(instance_exists(_shot) && _victim.hp==23,"Rogue source bullet hit same faction")
        _victim.team=team_enemy;_victim.hp=0
        ds_list_add(_skills,mut_recycle_gland)
        variable_struct_set(GameCont.ntte_full_native_skill_counts,string(mut_recycle_gland),2)
        _p.ammo[Ammo.Bullets]=100;var _recycle=instance_number(RecycleGland)
        with(_victim) with(_shot) event_perform(ev_collision,hitme)
        assert(!instance_exists(_shot) && _victim.hp==-7 && _p.ammo[Ammo.Bullets]==102
            && instance_number(RecycleGland)==_recycle+1,
            "Rogue source bullet gained hp gate or lost guaranteed stacked Recycle Gland2 refund")
        repeat(2) {
            var _full=_p.ammo[Ammo.Bullets]>=typ_amax[Ammo.Bullets]
            _p.ammo[Ammo.Bullets]=_full?typ_amax[Ammo.Bullets]:typ_amax[Ammo.Bullets]-1
            _shot=instance_create(_p.x,_p.y,NTTERogueCarbineBullet)
            _shot.creator=_p;_shot.team=team_player;_victim.hp=30;_victim.team=team_enemy
            _recycle=instance_number(RecycleGland)
            with(_victim) with(_shot) event_perform(ev_collision,hitme)
            assert(_p.ammo[Ammo.Bullets]==typ_amax[Ammo.Bullets]
                && instance_number(RecycleGland)==_recycle+(_full?0:1),
                "Rogue recycle lost native capacity clamp or created a proc while ammo was full")
        }
        var _npc=instance_create(6800,6800,Bandit),_players_count=instance_number(Player)
        _npc.team=team_enemy
        var _result=scrNTTEFullActorFire(_npc,wep_ntte_rogue_carbine,20,0,false)
        _shots=scrNTTEFullMergedRuntimeTestShots(_result.shots,NTTERogueCarbineBullet)
        _bursts=scrNTTEFullMergedRuntimeTestShots(_result.shots,NTTEFullNativeFireBurst)
        assert(array_length(_shots)==1 && array_length(_bursts)==1 && _shots[0].creator==_npc
            && _shots[0].team==team_enemy && _shots[0].direction==20 && _bursts[0].creator==_npc
            && instance_number(Player)==_players_count,
            "Rogue NPC source bullet/burst lost durable owner/team or leaked firing proxy")
        var _weapon=scrNTTEFullWeaponMerge(wep_revolver,wep_ntte_rogue_carbine),_handle=scrNTTEFullWeaponNative(_weapon)
        _p.wep=_handle;_p.ntte_state=scrNTTEFullWeaponNativeState(_weapon)
        _p.ammo=array_create(Ammo.NUM_AMMO_TYPES,100)
        _result=scrNTTEFullMergedRuntimePlayerFire(_p,_handle,{creator:_p})
        _shots=scrNTTEFullMergedRuntimeTestShots(_result.shots,NTTERogueCarbineBullet)
        _bursts=scrNTTEFullMergedRuntimeTestShots(_result.shots,NTTEFullNativeFireBurst)
        assert(array_length(_shots)==1 && array_length(_bursts)==1 && _shots[0].creator==_p
            && variable_instance_exists(_shots[0],"temerge_vars_list") && _shots[0].temerge_object==HeavyBullet,
            "Rogue merged front lost actual source CustomBullet/HeavyBullet alias or deferred burst capture")
    } finally {
        scrNTTEFullMergedRuntimeTestCleanup(_before)
        scrNTTEFullAreaGeneratorRestore(_players);scrNTTEFullAreaGeneratorRestore(_game)
        scrNTTEFullAreaGeneratorRestore(_back);ds_list_destroy(_skills)
        random_set_seed(_seed);current_frame=_frame
    }
    scrNTTESmokeLog("FULL ROGUE CARBINE: exact two-shot2tick FireBurst/single ammo4, real CustomBullet/7damage12force/HeavyBullet alias, source collision/recycle/impact, durable NPC and merged front OK @"+string(30/timescale))
}
