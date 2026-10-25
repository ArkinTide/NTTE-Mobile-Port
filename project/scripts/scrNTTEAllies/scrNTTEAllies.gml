function scrNTTEAimTargetAllowed(_target,_team) {
    if (instance_exists(_target) && instance_is(_target,NTTECat) && !_target.ntte_cat_active) return false
    return instance_exists(_target) && variable_instance_exists(_target,"team")
        && _target.team!=_team && _target.hp>0
}

function scrNTTENearestAimEnemy(_x,_y,_team) {
    var _nearest=noone,_best=infinity
    with (enemy) {
        if (!scrNTTEAimTargetAllowed(id,_team)) continue
        var _distance=point_distance(x,y,_x,_y)
        if (_distance<_best) { _nearest=id; _best=_distance }
    }
    return _nearest
}

function scrNTTEAllyPortalStep() {
    if (!global.is_server || !instance_exists(Player) || instance_exists(GenCont) || instance_exists(Portal)) return;
    if (!variable_instance_exists(id,"ntte_ally_portal_timer")) ntte_ally_portal_timer=0
    ntte_ally_portal_timer-=timescale
    if (ntte_ally_portal_timer>0) return;
    ntte_ally_portal_timer=30
    var _ally=false
    with (enemy) if (team==team_player && hp>0) { _ally=true; break }
    if (!_ally || scr_check_enemies()) return;
    // Reuse the native portal alarm and all of its area, boss and tutorial guards.
    // This also handles charm changes after the last corpse animation has ended.
    var _corpse=instance_find(Corpse,0)
    if (!instance_exists(_corpse)) {
        var _p=instance_find(Player,0)
        _corpse=instance_create(_p.x,_p.y,Corpse)
        _corpse.visible=false
        _corpse.sprite_index=sprBanditDead
        _corpse.image_index=0
        _corpse.image_speed=0
    }
    if (_corpse.alarm[0]<0) _corpse.alarm[0]=30
}

// BEGIN FOLLOWUP73 LAST HOSTILE TIMEOUT
// User-requested last-hostile timeout. Terrain and wall membership are irrelevant.
function scrNTTELastEnemyTimeoutReset() {
    ntte_last_enemy_target=noone
    ntte_last_enemy_time=0
}
function scrNTTELastEnemyTimeoutStep() {
    // Pause preserves elapsed combat time; it never advances the countdown.
    if(lockstep_stop) return;
    if(!variable_instance_exists(id,"ntte_last_enemy_target")) scrNTTELastEnemyTimeoutReset()
    if(!global.is_server || room!=romGame || is_level_ended
        || instance_exists(GenCont) || instance_exists(Portal) || instance_exists(Menu)
        || instance_exists(SitDown) || instance_exists(Credits) || instance_exists(Cinematic)
        || instance_exists(GameOver)) {scrNTTELastEnemyTimeoutReset();return;}
    var _living_player=false
    with(Player) if(hp>0) {_living_player=true;break}
    if(!_living_player) {scrNTTELastEnemyTimeoutReset();return;}
    var _count=0,_target=noone
    with(enemy) {
        // Match native completion's friendly/vehicle/missile exclusions.
        if(hp<=0 || team==team_player || instance_is(id,Van) || instance_is(id,BigDogMissile)) continue;
        _target=id
        if(++_count>1) break;
    }
    if(_count==1) with(becomenemy) {
        if(variable_instance_exists(id,"team") && team==team_player) continue;
        // Transforming/spawning hostiles also block native level completion.
        _count=2;break;
    }
    if(_count!=1 || scrEnemyIsBoss(_target)) {scrNTTELastEnemyTimeoutReset();return;}
    if(ntte_last_enemy_target!=_target) {
        ntte_last_enemy_target=_target
        ntte_last_enemy_time=0
    }
    // Native gameplay uses 30 logical ticks/second at both 30 and 60 FPS.
    ntte_last_enemy_time+=timescale
    if(ntte_last_enemy_time>60*30) {
        // Let the actor's normal Step/Destroy run its own death, drops and
        // corpse/portal logic. No forced portal or no-event deletion is used.
        _target.hp=0
        scrNTTELastEnemyTimeoutReset()
    }
}

function scrNTTELastEnemyTimeoutNativeTests() {
    assert(os_type==os_windows && scrNTTEFullSmokeEnabled() && room==romGame && !lockstep_stop,
        "Last-enemy timeout requires settled unpaused desktop gameplay")
    var _state=scrNTTEFullVanillaFixtureBegin(),_players=scrNTTEFullAreaGeneratorSnapshot(Player),
        _uber=scrNTTEFullAreaGeneratorSnapshot(UberCont),_back=scrNTTEFullAreaGeneratorSnapshot(BackCont),
        _extra=scrNTTEFullInstances([Portal,becomenemy,Corpse,LastDie,NTTEFullPet]),
        _stop=lockstep_stop,_frame=current_frame,_progress=global.ntte_full_progress,
        _rate=30/timescale,_steps=round(1800/timescale),_p=instance_find(Player,0)
    for(var _i=0;_i<array_length(_extra);++_i) instance_deactivate_object(_extra[_i])
    global.ntte_full_progress=json_parse(json_stringify(_progress))
    try {
        GameCont.area=area_desert;GameCont.subarea=1;GameCont.is_level_ended=false
        GameCont.killenemies=0;GameCont.rad=0;GameCont.ntte_full_active_coast=false
        _p.hp=max(1,_p.hp);_p.race=Race.Fish
        var _floor=instance_create(62000,62000,Floor),_enemy=instance_create(62016,62016,Bandit),
            _ally=instance_create(62144,62016,Bandit)
        _ally.team=team_player
        with(GameCont) scrNTTELastEnemyTimeoutReset()
        // Real production hook starts this clock; the complete minute uses the
        // same per-frame callback, without changing timescale or its counter.
        with(GameCont) event_perform(ev_step,ev_step_normal)
        assert(GameCont.ntte_last_enemy_target==_enemy && GameCont.ntte_last_enemy_time==timescale,
            "Actual GameCont.Step did not start the lone hostile timer, or counted a living ally")
        repeat(_steps-1) with(GameCont) scrNTTELastEnemyTimeoutStep()
        assert(_enemy.hp>0 && GameCont.ntte_last_enemy_time==1800 && !instance_exists(Portal),
            "Lone hostile died before strictly exceeding a full minute, or directly opened a portal")
        var _hp=_enemy.hp
        lockstep_stop=true
        repeat(4) with(GameCont) event_perform(ev_step,ev_step_normal)
        with(GameCont) scrNTTELastEnemyTimeoutStep()
        assert(_enemy.hp==_hp && GameCont.ntte_last_enemy_time==1800,
            "Paused native Step advanced the lone-hostile combat clock")
        lockstep_stop=false
        var _kills=GameCont.kills,_corpses=instance_number(CorpseActive)
        with(GameCont) event_perform(ev_step,ev_step_normal)
        assert(instance_exists(_enemy) && _enemy.hp==0 && !instance_exists(Portal)
            && GameCont.ntte_last_enemy_target==noone && GameCont.ntte_last_enemy_time==0,
            "Timeout did not set native HP0 once, or bypassed native death with a forced portal")
        with(_enemy) event_perform(ev_step,ev_step_normal)
        assert(!instance_exists(_enemy) && GameCont.kills==_kills+1 && instance_number(CorpseActive)==_corpses+1,
            "Timed-out actor failed actual native Step/Destroy kill credit and corpse generation")
        var _corpse=instance_find(CorpseActive,0)
        with(_corpse) event_perform(ev_alarm,0)
        assert(instance_exists(Portal) && _ally.hp>0,
            "Normal corpse portal alarm did not complete the level with only a living ally")
        scrNTTEFullCavesFixtureCleanup(_state.baseline)

        // A second enemy immediately cancels accumulated time. Replacing the
        // sole identity starts a new minute rather than inheriting old time.
        var _a=instance_create(63000,63000,Bandit)
        with(GameCont) scrNTTELastEnemyTimeoutReset()
        repeat(_steps-1) with(GameCont) scrNTTELastEnemyTimeoutStep()
        var _b=instance_create(63128,63000,Bandit)
        with(GameCont) scrNTTELastEnemyTimeoutStep()
        assert(_a.hp>0 && _b.hp>0 && GameCont.ntte_last_enemy_target==noone && GameCont.ntte_last_enemy_time==0,
            "A second hostile failed to reset elapsed lone-enemy time")
        instance_destroy(_b,false)
        with(GameCont) scrNTTELastEnemyTimeoutStep()
        assert(GameCont.ntte_last_enemy_target==_a && GameCont.ntte_last_enemy_time==timescale,
            "Returning to one hostile did not start a fresh minute")
        instance_destroy(_a,false)
        var _b=instance_create(63128,63000,Bandit)
        with(GameCont) scrNTTELastEnemyTimeoutStep()
        assert(GameCont.ntte_last_enemy_target==_b && GameCont.ntte_last_enemy_time==timescale,
            "A different sole hostile inherited the previous actor's time")
        _b.team=team_player
        with(GameCont) scrNTTELastEnemyTimeoutStep()
        assert(_b.hp>0 && GameCont.ntte_last_enemy_target==noone,
            "Charm conversion failed to remove the former hostile from timeout eligibility")
        scrNTTEFullCavesFixtureCleanup(_state.baseline)

        // True native and explicitly flagged MOD bosses remain alive beyond
        // the complete minute. Wall residents use only the same time rule.
        for(var _case=0;_case<3;++_case) {
            var _e=instance_create(64000,64000,_case==0?BanditBoss:Bandit)
            if(_case==1) _e.boss=true
            if(_case==2) _e.boss=false
            var _hp=_e.hp
            with(GameCont) scrNTTELastEnemyTimeoutReset()
            assert(!position_meeting(_e.x,_e.y,Floor),"Floorless timeout fixture unexpectedly has ground")
            repeat(_steps) with(GameCont) scrNTTELastEnemyTimeoutStep()
            assert(_e.hp==_hp,"Boss or living wall resident was killed within the full minute")
            with(GameCont) scrNTTELastEnemyTimeoutStep()
            assert(_case<2 ? (_e.hp==_hp && GameCont.ntte_last_enemy_time==0):_e.hp==0,
                "Boss exclusion or strict floor-independent timeout failed after one minute")
            instance_destroy(_e,false)
        }

        var _e=instance_create(65000,65000,Bandit)
        with(GameCont) scrNTTELastEnemyTimeoutStep()
        var _spawn=instance_create(65064,65000,becomenemy)
        with(GameCont) scrNTTELastEnemyTimeoutStep()
        assert(_e.hp>0 && GameCont.ntte_last_enemy_target==noone,
            "Pending hostile transformation did not block lone-enemy timeout")
        instance_destroy(_spawn,false)
        with(GameCont) scrNTTELastEnemyTimeoutStep()
        _p.hp=0
        with(GameCont) scrNTTELastEnemyTimeoutStep()
        assert(GameCont.ntte_last_enemy_target==noone,"No living player failed to reset timeout")
        _p.hp=1
        with(GameCont) scrNTTELastEnemyTimeoutStep()
        GameCont.is_level_ended=true
        with(GameCont) scrNTTELastEnemyTimeoutStep()
        assert(GameCont.ntte_last_enemy_target==noone,"Finished level failed to reset timeout")
        GameCont.is_level_ended=false
        with(GameCont) scrNTTELastEnemyTimeoutStep()
        with(GameCont) event_perform(ev_other,4)
        assert(GameCont.ntte_last_enemy_target==noone && GameCont.ntte_last_enemy_time==0 && _e.hp>0,
            "Actual RoomStart failed to clear previous level's last-hostile identity/time")
        scrNTTESmokeLog("LAST ENEMY TIMEOUT actual GameCont.Step -> full "+string(_steps)+" frames @"+string(_rate)
            +" -> HP0 -> native enemy.Step/Destroy -> corpse.Alarm0 portal; allies, extra/replaced enemy, charm, native/explicit bosses, floorless resident, pause, spawn guard, dead player, completed level and RoomStart reset OK")
    }
    finally {
        lockstep_stop=_stop;current_frame=_frame;global.ntte_full_progress=_progress
        scrNTTEFullAreaGeneratorRestore(_players);scrNTTEFullAreaGeneratorRestore(_uber);scrNTTEFullAreaGeneratorRestore(_back)
        scrNTTEFullVanillaFixtureEnd(_state)
        for(var _i=0;_i<array_length(_extra);++_i) instance_activate_object(_extra[_i])
    }
}
