function scrNTTEFullWorldExplosionTests() {
    var _before=scrNTTEFullInstances(all),_players=scrNTTEFullAreaGeneratorSnapshot(Player),
        _game=scrNTTEFullAreaGeneratorSnapshot(GameCont),_back=scrNTTEFullAreaGeneratorSnapshot(BackCont),
        _seed=random_get_seed(),_tick=current_frame,_owner=instance_find(Player,0),
        _skills=ds_list_create()
    GameCont.skills=_skills;GameCont.ntte_full_native_skill_counts={}
    try {
        current_frame=8;GameCont.crown=Crown.None
        _owner.x=91000;_owner.y=91000
        var _smokes=instance_number(Smoke),_dusts=instance_number(Dust),_scorches=instance_number(Scorch),
            _small=instance_create(91000,91000,NTTEFullBubbleExplosionSmall)
        assert(abs(_small.x-91000)<=0.251 && abs(_small.y-91000)<=0.251
            && _small.alarm[0]==3 && _small.alarm[1]==-1 && _small.team==team_none
            && _small.knockback_speed==timescale && _small.damage==3
            && instance_number(Smoke)==_smokes && instance_number(Dust)==_dusts
            && instance_number(Scorch)==_scorches,
            "Original SmallExplosion constructor gained large jitter, parent debris, wrong alarm/team or scorch")
        var _big=instance_create(91100,91000,NTTEFullBubbleExplosion)
        _big.team=team_player;_small.team=team_player
        assert(_big.alarm[0]==-1 && _big.alarm[1]==-1 && abs(_big.x-91100)<=2.01
            && abs(_big.y-91000)<=2.01 && _big.knockback_speed==timescale,
            "BubbleExplosion original no-scorch/no-native-crown constructor changed")
        var _victim=instance_create(_big.x+8,_big.y,Bandit)
        _victim.team=team_enemy;_victim.hp=20;_victim.nexthurt=current_frame+1000
        _victim.speed=0;_victim.friction=0.2*timescale*timescale
        with(_victim) with(_big) event_perform(ev_collision,hitme)
        var _minimum=16*timescale-_victim.friction*(1/timescale-1)
        assert(_victim.hp==17 && abs(_victim.speed-_minimum)<0.0001
            && _victim.sprite_index==_victim.spr_hurt && _victim.nexthurt==current_frame+6,
            "Popo native explosion lost raw3 damage, ignored enemy iframe, FT6/speed_min16 or scrHurt")
        _victim.hp=0;_victim.speed=25*timescale;_victim.direction=0
        with(_victim) with(_big) event_perform(ev_collision,hitme)
        assert(_victim.hp==-3 && _victim.speed>30*timescale,
            "Popo added hp>0 eligibility gate or incorrectly capped already-fast target at16")
        _victim.hp=20;_victim.speed=0;_victim.team=team_player
        with(_victim) with(_big) event_perform(ev_collision,hitme)
        assert(_victim.hp==20 && _victim.speed==0,"Popo explosion hurt its own faction")
        _victim.team=team_enemy;_victim.hp=20;_victim.speed=0;_victim.x=_small.x+8;_victim.y=_small.y
        with(_victim) with(_small) event_perform(ev_collision,hitme)
        var _small_force=timescale+(1-timescale)*_victim.friction/2
        assert(_victim.hp==17 && abs(_victim.speed-_small_force)<0.0001,
            "SmallExplosion did not use distinct actual force1 PushHit and FT friction compensation")
        if(timescale<1) {
            current_frame=8+timescale
            with(_victim) with(_small) event_perform(ev_collision,hitme)
            with(_victim) with(_big) event_perform(ev_collision,hitme)
            assert(_victim.hp==17,"Original explosions multiplied logical30Hz damage across physical frames")
        }
        current_frame=8
        var _custom=instance_create(_big.x+8,_big.y,NTTEFullCatBoss)
        _custom.hp=100;_custom.ntte_full_super_time=29;_custom.ntte_full_super_max=30
        _custom.sprite_index=_custom.spr_idle;_custom.image_index=2;_custom.speed=0
        with(_custom) with(_big) event_perform(ev_collision,hitme)
        assert(_custom.hp==97 && _custom.ntte_full_super_time==29
            && _custom.sprite_index==_custom.spr_idle && _custom.image_index==2
            && _custom.nexthurt==current_frame+6 && _custom.speed>15*timescale,
            "Popo direct inherited damage incorrectly entered CustomEnemy on_hurt or changed its animation")
        _owner.x=_big.x+8;_owner.y=_big.y;_owner.hp=10;_owner.nexthurt=current_frame+1000
        _owner.speed=0;_owner.team=team_enemy;_owner.sprite_index=_owner.spr_idle
        var _damage_taken=_owner.totdamagetaken
        with(_owner) with(_big) event_perform(ev_collision,hitme)
        assert(_owner.hp==7 && _owner.ntte_last_hit==_big.hitid && _owner.totdamagetaken==_damage_taken,
            "Original Popo raw Player hit gained iframe/player damage procs or lost source hitid")
        ds_list_add(GameCont.skills,mut_boiling_veins)
        _owner.hp=5;_owner.veinsthreshold=6;_owner.sprite_index=_owner.spr_idle;_owner.speed=0
        with(_owner) with(_big) event_perform(ev_collision,hitme)
        assert(_owner.hp==4 && _owner.smoke==30,
            "Original Popo BoilingVeins did not preserve hardcoded4 threshold distinct from Small boilcap")
        _owner.hp=2;_owner.sprite_index=_owner.spr_idle
        with(_owner) with(_big) event_perform(ev_collision,hitme)
        assert(_owner.hp==2,"Popo BoilingVeins healed or damaged a Player already below4")
        _owner.hp=10;_owner.sprite_index=_owner.spr_hurt;_owner.speed=0;_owner.smoke=0
        with(_owner) with(_big) event_perform(ev_collision,hitme)
        assert(_owner.hp==10 && _owner.speed==0 && _owner.smoke==0,
            "Popo ignored original BoilingVeins hurt-animation gate")
        _owner.x=_small.x+8;_owner.y=_small.y;_owner.hp=7;_owner.veinsthreshold=6
        _owner.sprite_index=_owner.spr_idle;_owner.speed=0
        with(_owner) with(_small) event_perform(ev_collision,hitme)
        assert(_owner.hp==6 && _owner.smoke==30,"Small explosion lost original mutable boilcap6")
        _owner.hp=3;_owner.sprite_index=_owner.spr_idle
        with(_owner) with(_small) event_perform(ev_collision,hitme)
        assert(_owner.hp==3,"Small boiling explosion healed a Player below boilcap")
        _owner.hp=10;_owner.speed=0;_owner.sprite_index=_owner.spr_hurt
        with(_owner) with(_small) event_perform(ev_collision,hitme)
        assert(_owner.hp==10 && _owner.speed==0,"Small boiling hurt animation incorrectly applied damage/force")
        var _zero=instance_create(_big.x,_big.y,EnemyBullet1),
            _grenade=instance_create(_big.x,_big.y,Grenade),_friend=instance_create(_big.x,_big.y,EnemyBullet1)
        _zero.team=team_enemy;_zero.typ=0;_grenade.team=team_enemy;_friend.team=_big.team
        with(_zero) with(_big) event_perform(ev_collision,projectile)
        with(_grenade) with(_big) event_perform(ev_collision,projectile)
        with(_friend) with(_big) event_perform(ev_collision,projectile)
        assert(!instance_exists(_zero) && !instance_exists(_grenade) && instance_exists(_friend),
            "Popo native projectile collision incorrectly excluded opposing typ0/Grenade or killed own faction")
        _small.x=91200;_small.y=91200;_small.image_index=1
        var _other=instance_create(_small.x-4,_small.y-3,NTTEFullBubbleExplosionSmall),
            _sx=_small.x,_sy=_small.y,_ox=_other.x,_oy=_other.y,
            _expected_x=_sx+lengthdir_x(6*timescale,point_direction(_ox,_oy,_sx,_sy)),
            _expected_y=_sy+lengthdir_y(6*timescale,point_direction(_ox,_oy,_expected_x,_sy))
        _small.speed=0;_small.team=_other.team
        with(_other) with(_small) event_perform(ev_collision,SmallExplosion)
        scrNTTESmokeLog("WORLD REPULSION DIAG ts="+string(timescale)
            +" source="+string_format(_sx,0,9)+","+string_format(_sy,0,9)
            +" other_before="+string_format(_ox,0,9)+","+string_format(_oy,0,9)
            +" actual="+string_format(_small.x,0,9)+","+string_format(_small.y,0,9)
            +" expected="+string_format(_expected_x,0,9)+","+string_format(_expected_y,0,9)
            +" delta="+string_format(_small.x-_expected_x,0,9)+","+string_format(_small.y-_expected_y,0,9)
            +" speed="+string_format(_small.speed,0,9)
            +" other_after="+string_format(_other.x,0,9)+","+string_format(_other.y,0,9))
        // Engine instance coordinates round to float32: at91200 one ULP is
        // 0.0078125, while local expected calculations retain double precision.
        // Sequential-vs-cached direction differs by>0.1 even at120Hz.
        assert(abs(_small.x-_expected_x)<=0.008 && abs(_small.y-_expected_y)<=0.008
            && _small.speed==0 && _other.x==_ox && _other.y==_oy,
            "SmallExplosion native repulsion lost sequential-x/y direction, source6*FT or gained team/speed changes")
        // Existing smoke validates both real active/inactive small masks,
        // opposing typ filters, crown child count/team/once and PlasmaImpact.
        scrNTTEFullMergedRuntimeTestCleanup(_before)
        scrNTTEFullWorldExplosionSmoke()
    }
    finally {
        scrNTTEFullMergedRuntimeTestCleanup(_before)
        scrNTTEFullAreaGeneratorRestore(_players);scrNTTEFullAreaGeneratorRestore(_game);scrNTTEFullAreaGeneratorRestore(_back)
        ds_list_destroy(_skills)
        current_frame=_tick;random_set_seed(_seed)
    }
    scrNTTESmokeLog("FULL WORLD EXPLOSION: native Popo raw hp/FT6/speed_min16, CustomEnemy presentation, Small Push/boilcap, phase/team, no-debris small constructor, opposing typ0/grenade, native repulsion and crown OK")
}
