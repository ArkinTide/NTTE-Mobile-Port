function scrNTTEFullGatorStatueFixturePickups(_before,_expected) {
    var _pickups=scrNTTEFullInstances(WepPickup),_count=0
    for(var _i=0;_i<array_length(_pickups);++_i) if(array_get_index(_before,_pickups[_i])<0) {
        var _p=_pickups[_i]
        assert(_p.ammo && scrNTTEFullWeaponHasMerge(_p.wep)==true
            && scr_weapon_get_type(scrNTTEFullWeaponMergedPart(_p.wep))==Ammo.Shells,
            "Actual GatorStatue reward lost filled ammo/real merged model/guaranteed shell front")
        _count+=1
    }
    assert(_count==_expected,"GatorStatue source blessed/unblessed merged-reward count diverged: "+string(_count))
}
function scrNTTEFullGatorStatueNativeTests() {
    assert(scrNTTESmokeEnabled(),"GatorStatue fixture requires explicit desktop smoke harness")
    var _before=scrNTTEFullInstances(all),_game=scrNTTEFullAreaGeneratorSnapshot(GameCont),
        _players=scrNTTEFullAreaGeneratorSnapshot(Player),_seed=random_get_seed(),
        _hidden=scrNTTEFullInstances([Floor,Wall,enemy,WepPickup,GenCont,LevCont]),
        _active=scrNTTEFullValue(GameCont,"ntte_full_active_coast",false)
    for(var _i=0;_i<array_length(_hidden);++_i) instance_deactivate_object(_hidden[_i])
    GameCont.area=area_sewers;GameCont.subarea=1;GameCont.hard=10;GameCont.loops=0
    GameCont.crown=crwn_none;GameCont.ntte_full_active_coast=false
    var _p=instance_find(Player,0)
    _p.x=94016;_p.y=94016;_p.visible=true;_p.can_pick=true
    try {
        var _near=instance_create(94000,94000,Floor),_edge=instance_create(94032,94000,Floor),
            _far=instance_create(94400,94000,Floor),_blocked=instance_create(94064,94000,Floor),
            _wall=instance_create(94064,94000,Wall),
            _statue=scrNTTEFullSystemsCreate("GatorStatue",94116,94016),_statueId=_statue.id
        assert(instance_is(_statue,prop) && !instance_is(_statue,enemy) && _statue.hp==56
            && _statue.raddrop==8 && _statue.size==3 && _statue.team==team_enemy
            && _statue.mask_index==mskScorpion && _statue.spr_shadow==shd32 && _statue.spr_shadow_y==7
            && _statue.skill==mut_shotgun_shoulders && instance_exists(_statue.prompt)
            && _statue.prompt.visible && _statue.prompt.mask_index==mskReviveArea && _statue.prompt.yoff==-10,
            "GatorStatue genuine prop/source56HP/8rads/team1/collider/shadow/ShotgunShoulders blessing prompt diverged")
        var _orbs=instance_number(NTTEFullOrchidBall),_prompt=_statue.prompt
        _prompt.pick=_p.index
        with(_statue) scrNTTEFullGatorStatueStep()
        var _orb=instance_find(NTTEFullOrchidBall,_orbs)
        assert(instance_number(NTTEFullOrchidBall)==_orbs+1 && _orb.skill==mut_shotgun_shoulders
            && _orb.type=="portal" && _orb.creator==_statue && !_prompt.visible
            && _statue.sprite_index==_statue.spr_hurt,
            "Source actual GatorStatue blessing did not create genuine creator-bound portal mutation orb/hide prompt/hurt art")
        var _popup=noone;
        with(PopupText) if(array_get_index(_before,id)<0 && scrNTTEFullValue(id,"ntte_full_target",-1)==_p.index) _popup=id;
        assert(instance_exists(_popup) && _popup.mytext=="BLESSED!" && _popup.ntte_translate,
            "Gator blessing still writes NTT text/target instead of native popup fields");
        with(_popup) event_perform(ev_alarm,2);
        scrNTTEFullPopup78Draw(_popup);
        // Shared actual input resets a previously picked prompt, so the
        // blessing does not repeat on subsequent ordinary game steps.
        with(_p) scrNTTEFullPromptPlayerStep()
        with(_statue) scrNTTEFullGatorStatueStep()
        assert(instance_number(NTTEFullOrchidBall)==_orbs+1,"GatorStatue hidden prompt repeated a blessing")
        var _growBefore=instance_number(NTTEFullGatorStatueFlak),_superBefore=instance_number(NTTEFullCustomFlak)
        _statue.hp=0;instance_destroy(_statue)
        assert(!instance_exists(_statue) && !instance_exists(_prompt)
            && instance_number(NTTEFullGatorStatueFlak)==_growBefore+4
            && instance_number(NTTEFullCustomFlak)==_superBefore,
            "Blessed statue death lost four growing flak/prompt cleanup or added unblessed super-flak revenge")
        scrNTTEFullGatorStatueFixturePickups(_before,2)
        var _growing=scrNTTEFullInstances(NTTEFullGatorStatueFlak),_shot=_growing[0]
        assert(!_shot.visible && _shot.image_xscale==0 && _shot.image_yscale==0 && _shot.damage==4
            && _shot.typ==2 && _shot.ntte_flak_wait>=1 && _shot.ntte_flak_wait<=10
            && abs(_shot.grow-1/45)<=0.000001 && _shot.team==team_enemy && _shot.creator==_statueId
            && _shot.x==(_edge.bbox_left+_edge.bbox_right)/2 && _shot.y==(_edge.bbox_top+_edge.bbox_bottom)/2,
            "GatorStatue growing flak lost source invisible zero scale/delay1..10/4damage/1:45grow/owner or last qualifying shuffled Floor")
        var _hits=instance_number(ThrowHit)
        while(_shot.ntte_flak_wait>0) with(_shot) scrNTTEFullGatorStatueFlakStep()
        assert(_shot.visible && _shot.image_xscale==0 && instance_number(ThrowHit)==_hits+1,
            "Growing flak delay did not activate actual colored ThrowHit before its first growth step")
        repeat(round(44/timescale)) with(_shot) scrNTTEFullGatorStatueFlakStep()
        assert(instance_exists(_shot) && abs(_shot.image_xscale-44/45)<=0.0001,
            "Growing revenge flak lost source1/45 per logical tick growth at44ticks")
        var _flakBefore=instance_number(EnemyFlak),_shotX=_shot.x,_shotY=_shot.y
        repeat(ceil(3/timescale)) if(instance_exists(_shot)) with(_shot) scrNTTEFullGatorStatueFlakStep()
        assert(!instance_exists(_shot) && instance_number(EnemyFlak)==_flakBefore+1,
            "Growing flak >1 destruction did not create one genuine native enemy flak")
        var _released=instance_find(EnemyFlak,_flakBefore)
        assert(_released.creator==_statueId && _released.team==team_enemy && _released.sprite_index==sprEFlak
            && _released.x==_shotX && _released.y==_shotY,
            "Growing flak release lost original position/owner/team/source enemy sprite")

        _statue=scrNTTEFullSystemsCreate("GatorStatue",94116,94016);_statueId=_statue.id
        _statue.hp=0;instance_destroy(_statue)
        scrNTTEFullGatorStatueFixturePickups(_before,6)
        assert(instance_number(NTTEFullCustomFlak)==_superBefore+1,
            "Unblessed real statue death omitted genuine CustomFlak revenge")
        _shot=instance_find(NTTEFullCustomFlak,_superBefore)
        assert(_shot.super && _shot.damage==10 && _shot.bonus_damage==0 && _shot.typ==2
            && array_length(_shot.flak)==5 && _shot.flak[0]==EnemyFlak
            && abs(_shot.knockback_speed-8*timescale)<=0.000001
            && abs(_shot.friction-0.1/60*timescale*timescale)<=0.000001
            && _shot.sprite_index==scrNTTERefSprite("EnemySuperFlak") && _shot.team==team_enemy,
            "Unblessed statue revenge lost source10damage/force8/slow friction/super5enemyflak/hostile art")
        _flakBefore=instance_number(EnemyFlak);instance_destroy(_shot)
        assert(instance_number(EnemyFlak)==_flakBefore+5,"CustomFlak source super terminal event lost five genuine enemy flak children")
        var _angles=[]
        for(var _i=0;_i<5;++_i) {
            var _child=instance_find(EnemyFlak,_flakBefore+_i)
            assert(_child.creator==_statueId && _child.team==team_enemy && _child.sprite_index==sprEFlak
                && abs(_child.speed-12*timescale)<=0.000001,
                "CustomFlak source super ring lost genuine native children/creator/team/12logical speed")
            array_push(_angles,_child.direction)
        }
        for(var _i=1;_i<5;++_i) assert(abs(angle_difference(_angles[_i],_angles[_i-1])-72)<=0.0001,
            "CustomFlak five-way source super ring directions are not72degrees apart")
        // Friendly collisions must not spend a projectile or trigger revenge.
        var _victim=instance_create(94600,94016,Bandit)
        _victim.hp=100;_victim.team=team_enemy;_victim.nexthurt=0
        _shot=scr_projectile_create(94600,94016,NTTEFullCustomFlak);_shot.team=team_enemy
        var _health=_victim.hp,_children=instance_number(Bullet2)
        with(_shot) scrNTTEFullCustomFlakHit(_victim)
        assert(instance_exists(_shot) && _victim.hp==_health && instance_number(Bullet2)==_children,
            "Source CustomFlak same-team collision consumed/hit/exploded")
        _shot.team=team_player;_victim.nexthurt=0
        with(_shot) scrNTTEFullCustomFlakHit(_victim)
        assert(!instance_exists(_shot) && _victim.hp==_health-6 && instance_number(Bullet2)==_children+16,
            "Source CustomFlak initial4+2bonus hit lost actual damage/destruction/16shell children")

        // Exercise the existing natural DrainRooms request, rather than only
        // direct factory creation. Its actual room/light/decals remain native.
        var _entrance=instance_create(95000,95000,Floor),_statues=instance_number(NTTEFullGatorStatue)
        scrNTTEFullSewerDrainRoom("GatorStatue",_entrance)
        assert(instance_number(NTTEFullGatorStatue)==_statues+1,
            "Natural SewerDrain GatorStatue room still fails genuine statue creation")
    }
    finally {
        var _all=scrNTTEFullInstances(all)
        for(var _i=array_length(_all)-1;_i>=0;--_i)
            if(array_get_index(_before,_all[_i])<0 && instance_exists(_all[_i])) instance_destroy(_all[_i],false)
        for(var _i=0;_i<array_length(_hidden);++_i) instance_activate_object(_hidden[_i])
        scrNTTEFullAreaGeneratorRestore(_game);scrNTTEFullAreaGeneratorRestore(_players)
        GameCont.ntte_full_active_coast=_active;random_set_seed(_seed)
    }
    scrNTTESmokeLog("FULL GATOR STATUE NATIVE: actual Drain secret room/56HP prop+Prompt/portal ShotgunShoulders blessing, source2vs4 filled shell-front merges, four1:45growing revenge shots/real EnemyFlak, unblessed10damage super5way12speed ring, friendly gate and genuine4+2bonus damage/16shells OK @"+string(30/timescale))
}
