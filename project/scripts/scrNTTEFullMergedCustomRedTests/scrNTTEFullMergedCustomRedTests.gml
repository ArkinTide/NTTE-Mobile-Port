function scrNTTEFullMergedCustomRedTests() {
    var _before=scrNTTEFullInstances(all),_game=scrNTTEFullAreaGeneratorSnapshot(GameCont),
        _players=scrNTTEFullAreaGeneratorSnapshot(Player),_back=scrNTTEFullAreaGeneratorSnapshot(BackCont),
        _registry=variable_global_exists("ntte_full_merge_effect_registry")?global.ntte_full_merge_effect_registry:undefined,
        _initialized=variable_global_exists("ntte_full_merge_effect_initialized")?global.ntte_full_merge_effect_initialized:false,
        _mode=variable_global_exists("ntte_merge_native_collision_mode") && global.ntte_merge_native_collision_mode,
        _stack=variable_global_exists("ntte_merge_native_collision_stack")?global.ntte_merge_native_collision_stack:[],
        _frame=current_frame,_seed=random_get_seed()
    global.ntte_full_merge_effect_registry={};global.ntte_full_merge_effect_initialized=false
    global.ntte_merge_native_collision_mode=true;global.ntte_merge_native_collision_stack=[]
    GameCont.temerge_effect_vars_map={};GameCont.temerge_effect_call_step_instance_list=[]
    GameCont.annihilation_list=[];GameCont.annihilation_skill=noone;current_frame=2
    try {
        scrNTTEFullMergedEffectsInit()
        var _owner=instance_find(Player,0),_source=instance_create(19000,19000,NTTEFullRedBullet),
            _source2=instance_create(19100,19000,NTTEFullRedBullet)
        _source.speed=16*timescale;_source.creator=_owner;_source.team=team_player
        var _info=_source.temerge_red_info,_info2=_source2.temerge_red_info
        assert(scrNTTEFullMergedRedBulletBind(_source)==_info && _info!=_info2
            && _source.damage==400 && _source.bonus_damage==40 && _source.minspeed==8
            && _source.maxspeed==16 && _source.friction==timescale*timescale,
            "RedBullet source closure identity or actual CustomShell constructor differs from original")
        repeat(ceil(2/timescale)) with(_source) event_perform(ev_step,ev_step_normal)
        assert(!_source.bonus,"RedBullet source bonus duration is not two logical ticks")
        _source.wallbounce=7;_source.speed=16*timescale
        with(_source) event_perform(ev_collision,Wall)
        assert(_source.bonus && _source.ntte_red_bonus_alarm==2 && abs(_source.wallbounce-6.65)<0.0001
            && abs(_source.speed-16*timescale)<0.0001,"RedBullet wall lost original cap, bonus reset or .95 decay")
        _source.speed=7*timescale
        with(_source) event_perform(ev_step,ev_step_normal)
        assert(_source.sprite_index==_source.spr_fade && _source.image_speed==0.4*timescale,
            "RedBullet shell did not enter source fade below speed eight")

        var _a=instance_create(19300,19000,Bullet1),_b=instance_create(19320,19000,Bullet1),
            _victim=instance_create(19300,19000,Bandit),_same=instance_create(19500,19000,Bandit)
        _a.team=team_player;_a.creator=_owner;_a.damage=4;_a.speed=0
        _b.team=team_player;_b.creator=_owner;_b.damage=4;_b.speed=4*timescale;_b.direction=0
        _victim.name="ntte_test_red";_victim.team=team_enemy;_victim.hp=1000;_victim.nexthurt=0;_victim.speed=0;_victim.solid=false
        _same.name="ntte_test_red";_same.team=team_enemy;_same.hp=1000;_same.nexthurt=0;_same.speed=0;_same.solid=false
        var _merge={speed_factor:1,on_setup:_source.temerge_on_setup,on_hit:_source.temerge_on_hit,setup_vars:{}}
        scrNTTEFullMergeApplyEffects([_a,_b],_merge)
        var _red=scrAreaGetBackroundColor(scrNTTEFullAreaId("red")),_fx_before=scrNTTEFullInstances(BulletHit)
        assert(array_length(_info.annihilate_instance_list)==2 && _a.image_blend==_red && _b.image_blend==_red,
            "Red replacement setup lost source tint or shared membership")
        with(_victim) with(_a) event_perform(ev_collision,hitme)
        assert(!instance_exists(_a) && !_info.can_annihilate && _info2.can_annihilate && _b.image_blend==c_white
            && _victim.hp==800 && _same.hp==800 && _victim.annihilation_check && _same.annihilation_check
            && array_length(GameCont.annihilation_list)==1 && GameCont.annihilation_list[0].ammo==2,
            "Red native hit must consume one shared charge and perform real type-wide annihilation instead of ordinary/generic damage")
        var _effects=scrNTTEFullInstances(BulletHit),_poofs=0
        for(var _i=0;_i<array_length(_effects);++_i) if(array_get_index(_fx_before,_effects[_i])<0) {
            var _fx=_effects[_i]
            if(_fx.sprite_index==sprThrowHit) {
                ++_poofs
                assert(_fx.image_blend==_red && _fx.depth==_b.depth+1 && _fx.x==_b.x+_b.hspeed
                    && _fx.y==_b.y+_b.vspeed,"Red sibling clearing poof lost source position, depth or tint")
            }
        }
        assert(_poofs==1,"Red shared consumption should poof exactly one surviving sibling")
        _victim.nexthurt=0
        with(_victim) with(_b) event_perform(ev_collision,hitme)
        // Original callback return true removes that callback; it does not
        // suppress the replacement's ordinary native collision handler.
        assert(!instance_exists(_b) && _victim.hp==796 && !array_length(global.ntte_merge_native_collision_stack),
            "Spent Red callback must unregister itself and retain ordinary native damage without reannihilating")
        var _future=instance_create(19700,19000,Bandit)
        _future.name="ntte_test_red";_future.team=team_enemy;_future.hp=1000;_future.nexthurt=0;_future.speed=0;_future.solid=false
        scrNTTEFullAnnihilationStep()
        assert(_future.hp==800 && _future.annihilation_check && _victim.hp==796,
            "Red annihilation did not affect future same-type spawn exactly once")
        scrNTTEFullAnnihilationPortalTick()
        assert(GameCont.annihilation_list[0].ammo==1,"Red type-wide effect lost first portal tick")
        scrNTTEFullAnnihilationPortalTick()
        assert(!array_length(GameCont.annihilation_list),"Red type-wide effect survived beyond original two portal ticks")

        // Unmerged physical shell first applies min(400+40,hp), then the real
        // type-wide 200 explosion. This is intentionally distinct from merge.
        var _physical=instance_create(20000,19000,NTTEFullRedBullet),_pv=instance_create(20000,19000,Bandit),
            _peer=instance_create(20200,19000,Bandit)
        _physical.team=team_player;_physical.creator=_owner;_physical.speed=16*timescale
        _pv.name="ntte_test_red_physical";_pv.team=team_enemy;_pv.hp=1000;_pv.nexthurt=0;_pv.speed=0;_pv.solid=false
        _peer.name="ntte_test_red_physical";_peer.team=team_enemy;_peer.hp=1000;_peer.nexthurt=0;_peer.speed=0;_peer.solid=false
        with(_pv) with(_physical) event_perform(ev_collision,hitme)
        assert(!instance_exists(_physical) && _pv.hp==360 && _peer.hp==800,
            "Physical RedBullet lost original capped direct damage followed by actual type-wide annihilation")
        // Tesseract is the explicit hostile exception: local explosion only.
        var _boss=instance_create(20500,19000,Bandit),_proxy=instance_create(20500,19000,Bullet1)
        _boss.name="Tesseract";_boss.team=team_enemy
        var _entry_count=array_length(GameCont.annihilation_list),_explosions=instance_number(NTTEFullRedExplosion)
        with(_proxy) scrNTTEFullRedBulletAnnihilate(_boss)
        assert(array_length(GameCont.annihilation_list)==_entry_count && instance_number(NTTEFullRedExplosion)==_explosions+1,
            "Red Tesseract exception must create local explosion, not register type-wide annihilation")
    }
    finally {
        var _all=scrNTTEFullInstances(all)
        for(var _i=array_length(_all)-1;_i>=0;--_i) if(array_get_index(_before,_all[_i])<0 && instance_exists(_all[_i])) instance_destroy(_all[_i],false)
        scrNTTEFullAreaGeneratorRestore(_game);scrNTTEFullAreaGeneratorRestore(_players);scrNTTEFullAreaGeneratorRestore(_back)
        global.ntte_full_merge_effect_registry=_registry;global.ntte_full_merge_effect_initialized=_initialized
        global.ntte_merge_native_collision_mode=_mode;global.ntte_merge_native_collision_stack=_stack
        current_frame=_frame;random_set_seed(_seed)
    }
    scrNTTESmokeLog("FULL MERGED CUSTOM RED: actual shell bonus/fade/bounce, per-source shared tint/consumption, sibling poof, real current/future type-wide annihilation/two portal expiry and Tesseract exception OK @"+string(30/timescale))
}
