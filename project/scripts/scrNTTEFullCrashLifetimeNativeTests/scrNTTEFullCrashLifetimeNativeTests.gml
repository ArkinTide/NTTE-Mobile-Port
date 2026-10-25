// Reported mobile stacks exercised through real Step/Destroy/hit entry points.
function scrNTTEFullTrenchChunkDestroyNativeTests() {
    var _before=scrNTTEFullInstances(all),_game=scrNTTEFullAreaGeneratorSnapshot(GameCont),
        _seed=random_get_seed(),_hidden=scrNTTEFullInstances([Floor,Wall,GenCont,LevCont]),
        _old_grid=variable_global_exists("ntte_full_trench_pit_grid")?global.ntte_full_trench_pit_grid:-1,
        _grid=ds_grid_create(16,16),_checks=0,_old_particles=UberCont.opt_prtcls
    for(var _i=0;_i<array_length(_hidden);++_i) instance_deactivate_object(_hidden[_i])
    global.ntte_full_trench_pit_grid=_grid;GameCont.ntte_full_active_coast=false
    try {
        for(var _particles=0;_particles<=1;++_particles)
        for(var _pit=0;_pit<=1;++_pit) for(var _debris=0;_debris<=1;++_debris) {
            UberCont.opt_prtcls=_particles
            ds_grid_clear(_grid,_pit)
            var _start=scrNTTEFullInstances(all),_chunk=instance_create(128,128,NTTEFullTrenchFloorChunk)
            _chunk.ntte_full_debris=_debris;_chunk.direction=73;_chunk.speed=2.5*timescale
            _chunk.image_angle=47;_chunk.ntte_full_z=-1;_chunk.ntte_full_zspeed=0
            var _sprite=_chunk.sprite_index,_image=_chunk.image_index,
                _angle=47+_chunk.ntte_full_rotation*timescale
            with(_chunk) event_perform(ev_step,ev_step_normal)
            assert(!instance_exists(_chunk),"Actual expired floor chunk failed Step -> Destroy lifecycle")
            var _items=scrNTTEFullInstances(all),_pieces=0,_smoke=0
            for(var _j=0;_j<array_length(_items);++_j) if(array_get_index(_start,_items[_j])<0) with(_items[_j]) {
                if(object_index==Debris) {
                    _pieces++
                    // Builtin angle storage rounds to float32. Scale the same
                    // 0.00001 tolerance above GML's absolute comparison epsilon
                    // so a sub-microdegree rounding delta can actually pass.
                    if(_pit) assert(sprite_index==_sprite && image_index==_image && abs(image_angle-_angle)*1000000<10
                        && abs(direction-73)*1000000<10 && abs(speed-2.5*timescale)*1000000<10,
                        "Pit debris lost the destroyed chunk's authored sprite/rotation/motion")
                    else {
                        assert(depth==-7,"Ground chunk fragment outside Floor lost airborne depth")
                        if(_debris) assert(abs(image_angle-_angle)*1000000<10,"Single debris fragment lost parent rotation actual="+string_format(image_angle,0,12)+" expected="+string_format(_angle,0,12)+" delta="+string_format(image_angle-_angle,0,12))
                    }
                }
                if(object_index==Smoke) _smoke++
            }
            assert(_pieces==(_pit?1:(_debris?1:3)) && _smoke==_particles*(_pit?(_debris?0:3):(_debris?1:3)),
                "Chunk destruction changed original pit/ground fragment and dust quantities")
            _checks++
            for(var _j=array_length(_items)-1;_j>=0;--_j)
                if(array_get_index(_start,_items[_j])<0 && instance_exists(_items[_j])) instance_destroy(_items[_j],false)
        }
    } finally {
        var _all=scrNTTEFullInstances(all)
        for(var _i=array_length(_all)-1;_i>=0;--_i) if(array_get_index(_before,_all[_i])<0 && instance_exists(_all[_i])) instance_destroy(_all[_i],false)
        global.ntte_full_trench_pit_grid=_old_grid;ds_grid_destroy(_grid);UberCont.opt_prtcls=_old_particles
        for(var _i=0;_i<array_length(_hidden);++_i) instance_activate_object(_hidden[_i])
        scrNTTEFullAreaGeneratorRestore(_game);random_set_seed(_seed)
    }
    scrNTTESmokeLog("PASS TRENCH CHUNK DESTROY actual Step->Destroy pit/ground, whole/debris art/motion/counts, particles ON/OFF and Create-time FX deletion checks="+string(_checks)+" @"+string(30/timescale))
}

function scrNTTEFullSawTrapAttachmentNativeTests() {
    var _before=scrNTTEFullInstances(all),_game=scrNTTEFullAreaGeneratorSnapshot(GameCont),
        _seed=random_get_seed(),_hidden=scrNTTEFullInstances([enemy,prop,Wall,Portal,PortalShock,GenCont,LevCont])
    for(var _i=0;_i<array_length(_hidden);++_i) instance_deactivate_object(_hidden[_i])
    GameCont.ntte_full_active_coast=false;GameCont.ntte_harpoon_rope=[]
    try {
        var _saw=instance_create(58000,58000,NTTEFullSawTrap),
            _a=instance_create(58300,58000,Bandit),_b=instance_create(58350,58000,Bandit),
            _rope=scrNTTEFullHarpoonRope(_a,_b),_controller=_rope.controller,
            _bare=instance_create(58000,58000,BoltStick),
            _attached=instance_create(58000,58000,NTTEFullHarpoonStick),
            _elsewhere=instance_create(58000,58000,BoltStick)
        assert(!instance_is(_controller,BoltStick) && !variable_instance_exists(_controller,"target"),
            "Independent rope reentered attached-bolt inheritance")
        _attached.target=_saw;_attached.depth=-20
        _elsewhere.target=_a;_elsewhere.depth=-20
        _saw.ntte_saw_wait=0;_saw.active=true;_saw.spd=0
        with(_saw) event_perform(ev_step,ev_step_normal)
        assert(instance_exists(_saw) && _attached.depth==_saw.depth && _elsewhere.depth==-20
            && instance_exists(_bare) && !variable_instance_exists(_bare,"target")
            && instance_exists(_controller) && !variable_instance_exists(_controller,"target"),
            "Actual saw Step failed targetless/rope exclusion or genuine attached-bolt depth following")
    } finally {
        var _all=scrNTTEFullInstances(all)
        for(var _i=array_length(_all)-1;_i>=0;--_i) if(array_get_index(_before,_all[_i])<0 && instance_exists(_all[_i])) instance_destroy(_all[_i],false)
        for(var _i=0;_i<array_length(_hidden);++_i) instance_activate_object(_hidden[_i])
        scrNTTEFullAreaGeneratorRestore(_game);random_set_seed(_seed)
    }
    scrNTTESmokeLog("PASS SAW ATTACHMENT actual Step with independent rope, targetless native bolt and real matching/nonmatching attached harpoons @"+string(30/timescale))
}

function scrNTTEFullChestHatredCauseNativeTests() {
    var _before=scrNTTEFullInstances(all),_game=scrNTTEFullAreaGeneratorSnapshot(GameCont),
        _players=scrNTTEFullAreaGeneratorSnapshot(Player),_back=scrNTTEFullAreaGeneratorSnapshot(BackCont),
        _seed=random_get_seed(),_skills=ds_list_create(),_checks=0
    GameCont.skills=_skills;GameCont.ntte_full_native_skill_counts={};GameCont.crown=Crown.Hatred
    try {
        var _p=instance_find(Player,0)
        _p.x=57000;_p.y=57000;_p.hp=20;_p.max_hp=20;_p.race=Race.Fish;_p.nexthurt=current_frame-1
        // The actual Backpack subclass has no projectile-only hitid field.
        var _bag=instance_create(57000,57000,NTTEFullBackpack)
        _bag.num=0;_bag.raddrop=0;_bag.ally=0;_bag.curse=false
        assert(!variable_instance_exists(_bag,"hitid"),"Fixture no longer covers a nonprojectile chest")
        var _rads=instance_number(Rad)
        with(_bag) event_perform(ev_step,ev_step_normal)
        assert(!instance_exists(_bag) && _p.hp==19 && instance_number(Rad)==_rads+16
            && GameCont.deathcause==HitId.CrownOfHatred && _p.ntte_last_hit==HitId.CrownOfHatred,
            "Backpack Step -> open lost Hatred1HP/16rads or explicit crown attribution")
        _checks++
        var _chest=instance_create(57400,57000,NTTEFullCustomChest),_shock=instance_create(57400,57000,PortalShock)
        _rads=instance_number(Rad)
        with(_chest) scrNTTEFullCustomChestOpen(_shock)
        assert(!instance_exists(_chest) && _p.hp==19 && instance_number(Rad)==_rads+16,
            "PortalShock chest opener incorrectly damaged the remote player")
        _checks++
        _chest=instance_create(57800,57000,NTTEFullCustomChest)
        with(_chest) scr_projectile_hit(_p,1)
        assert(_p.hp==18 && _p.ntte_last_hit==HitId.None,"Generic nonprojectile damage failed safe default cause")
        _checks++
        var _bullet=instance_create(57800,57000,Bullet1),_cause=_bullet.hitid
        with(_bullet) scr_projectile_hit(_p,1)
        assert(_p.hp==17 && _p.ntte_last_hit==_cause,"Normal projectile lost original hit cause")
        with(_bullet) scr_projectile_hit(_p,1,0,undefined,false,HitId.CrownOfHatred)
        assert(_p.hp==16 && _p.ntte_last_hit==HitId.CrownOfHatred,"Explicit cause failed to override projectile field")
        _checks+=2
    } finally {
        var _all=scrNTTEFullInstances(all)
        for(var _i=array_length(_all)-1;_i>=0;--_i) if(array_get_index(_before,_all[_i])<0 && instance_exists(_all[_i])) instance_destroy(_all[_i],false)
        scrNTTEFullAreaGeneratorRestore(_players);scrNTTEFullAreaGeneratorRestore(_game);scrNTTEFullAreaGeneratorRestore(_back)
        ds_list_destroy(_skills);random_set_seed(_seed)
    }
    scrNTTESmokeLog("PASS CHEST HATRED CAUSE actual Backpack.Step/open, 1HP/16rads, shock no damage and fallback/projectile/explicit cause checks="+string(_checks)+" @"+string(30/timescale))
}

function scrNTTEFullBoneArtifactExplosionNativeTests() {
    var _before=scrNTTEFullInstances(all),_game=scrNTTEFullAreaGeneratorSnapshot(GameCont),
        _back=scrNTTEFullAreaGeneratorSnapshot(BackCont),_seed=random_get_seed()
    try {
        var _cannon=instance_create(56000,56000,NTTEFullBoneArtifactLaserCannon),
            _blast=instance_create(56000,56000,PopoExplosion)
        _cannon.team=team_player;_blast.team=team_enemy
        assert(variable_instance_exists(_cannon,"typ") && _cannon.typ==0,
            "Actual artifact cannon constructor lacks its nondestructible projectile type")
        repeat(3) with(_cannon) with(_blast) event_perform(ev_collision,projectile)
        assert(instance_exists(_cannon),"Native hostile PopoExplosion incorrectly destroyed anchored artifact cannon")
        var _lasers=instance_number(NTTEFullPopoLaser)
        _cannon.delay=timescale
        with(_cannon) event_perform(ev_step,ev_step_normal)
        assert(_cannon.ammo==4 && instance_number(NTTEFullPopoLaser)==_lasers+1,
            "Artifact cannon did not retain its real delayed blue laser after explosion collision")
        var _bullet=instance_create(56000,56000,Bullet1)
        _bullet.team=team_player
        with(_bullet) with(_blast) event_perform(ev_collision,projectile)
        assert(!instance_exists(_bullet),"Type fix changed native hostile bullet destruction")
        _bullet=instance_create(56000,56000,Bullet1);_bullet.team=_blast.team
        with(_bullet) with(_blast) event_perform(ev_collision,projectile)
        assert(instance_exists(_bullet),"Type fix changed native same-team bullet exemption")
        var _grenade=instance_create(56000,56000,PopoNade)
        _grenade.team=team_player
        with(_grenade) with(_blast) event_perform(ev_collision,projectile)
        assert(instance_exists(_grenade),"Type fix changed native Grenade subclass exemption")
    } finally {
        scrNTTEFullMergedRuntimeTestCleanup(_before)
        scrNTTEFullAreaGeneratorRestore(_game);scrNTTEFullAreaGeneratorRestore(_back);random_set_seed(_seed)
    }
    scrNTTESmokeLog("PASS ARTIFACT EXPLOSION actual cannon constructor/PopoExplosion collisions/delayed blue laser, hostile bullet and same-team/grenade controls @"+string(30/timescale))
}
