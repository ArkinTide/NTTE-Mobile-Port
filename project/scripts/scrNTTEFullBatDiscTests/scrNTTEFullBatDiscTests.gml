function scrNTTEFullBatDiscTests() {
    var _before=scrNTTEFullInstances(all),_game=scrNTTEFullAreaGeneratorSnapshot(GameCont),
        _players=scrNTTEFullAreaGeneratorSnapshot(Player),_back=scrNTTEFullAreaGeneratorSnapshot(BackCont),
        _seed=random_get_seed(),_frame=current_frame,_skills=ds_list_create()
    GameCont.skills=_skills;GameCont.ntte_full_native_skill_counts={};GameCont.area=1;GameCont.underwater=false
    current_frame=2
    try {
        var _owner=instance_find(Player,0),_state=scrNTTENewState(wep_ntte_sawblade_cannon)
        _owner.x=87000;_owner.y=87000;_owner.team=team_player;_owner.ntte_state=_state
        _state.ammo=7;_state.outstanding=7
        var _disc=noone
        with(_owner) _disc=scrNTTEFullMergedBasicProjectileCreate(87040,87000,NTTEFullBatDisc,0)
        scrNTTEFullBatDiscBind(_disc,_state,7);_disc.big=true
        assert(_disc.damage==2 && _disc.typ==2 && _disc.mask_index==mskFlakBullet
            && abs(_disc.speed-12*timescale)<0.0001 && abs(_disc.friction-0.4*timescale*timescale)<0.0001,
            "Physical BatDisc source defaults changed or big disc inherited generic damage8/plasma mask")
        with(_disc) event_perform(ev_step,ev_step_end)
        assert(!_disc.setup && _disc.sprite_index==scrNTTERefSprite("BatDiscBig") && _disc.alarm[0]==30
            && _disc.damage==2,"Big BatDisc source EndStep setup lost original sprite/alarm/damage")
        var _discs=instance_number(NTTEFullBatDisc)
        with(_disc) event_perform(ev_alarm,0)
        assert(!instance_exists(_disc) && instance_number(NTTEFullBatDisc)==_discs+6
            && _state.ammo==7 && _state.outstanding==7,
            "Big BatDisc did not create seven actual children or prematurely returned source magazine")
        var _children=scrNTTEFullInstances(NTTEFullBatDisc),_found=0,_angles=[]
        for(var _i=0;_i<array_length(_children);++_i) {
            var _child=_children[_i]
            if(_child.state!=_state) continue
            ++_found;array_push(_angles,_child.direction)
            assert(!_child.big && _child.ammo==1 && _child.refund==1 && _child.damage==2
                && _child.mask_index==mskFlakBullet && _child.creator==_owner && _child.team==team_player,
                "BatDisc radial child lost physical class, source state, damage, hit mask or ownership")
            instance_destroy(_child)
        }
        assert(_found==7 && _state.ammo==14 && _state.outstanding==0,"Actual blade Cleanup failed exact magazine credits")
        _state=scrNTTENewState(wep_ntte_sawblade_gun);_state.ammo=2;_state.outstanding=1
        _owner.ntte_state=_state
        with(_owner) _disc=scrNTTEFullMergedBasicProjectileCreate(87040,87000,NTTEFullBatDisc,0)
        scrNTTEFullBatDiscBind(_disc,_state,1)
        _disc.speed=4*timescale
        with(_disc) event_perform(ev_step,ev_step_normal)
        assert(_disc.returning && _disc.target==_owner,"Blade no longer returns at source logical speed5 or lost exact firing-state target")
        _disc.x=_owner.x;_disc.y=_owner.y
        with(_disc) event_perform(ev_step,ev_step_normal)
        assert(!instance_exists(_disc) && _state.ammo==3 && _state.outstanding==0,"Physical blade arrival did not close magazine lifecycle")
        with(_owner) _disc=scrNTTEFullMergedBasicProjectileCreate(87100,87000,NTTEFullBatDisc,0)
        _disc.target=_owner
        with(_disc) scrNTTEFullBatDiscWall()
        assert(_disc.returning && !_disc.walled,"Fresh small blade failed source first-wall bounce/return")
        _disc.has_hit=true
        with(_disc) scrNTTEFullBatDiscWall()
        assert(_disc.walled,"Post-hit blade failed original wall-entry phase")
        var _hostile=instance_create(87500,87000,NTTEBabyGator)
        _hostile.hp=40;_hostile.team=team_enemy;_hostile.nexthurt=current_frame+100
        _disc.team=team_player;_disc.speed=10*timescale;_disc.seek=60
        with(_disc) scrNTTEFullBatDiscHit(_hostile)
        assert(_hostile.hp==38 && _disc.has_hit && abs(_disc.seek-48)<0.0001 && abs(_disc.speed-9*timescale)<0.0001,
            "Blade true hit lost pure team gate, damage2, per-hit speed0.9 or seek0.8")
        var _same=instance_create(87600,87000,NTTEBabyGator)
        _same.hp=40;_same.team=team_player
        with(_disc) scrNTTEFullBatDiscHit(_same)
        assert(_same.hp==40,"Blade hit a friendly actor")
        _disc.x=_owner.x;_disc.y=_owner.y-100;_disc.walled=false;_disc.seek=60;_disc.speed=10*timescale
        _hostile.x=_disc.x;_hostile.y=_disc.y-20;_hostile.mask_index=mskRat
        _disc.direction=90
        var _expected_seek_speed=10*timescale-_disc.friction*timescale+timescale*timescale
        with(_disc) event_perform(ev_step,ev_step_normal)
        assert(_disc.image_index==1 && abs(_disc.speed-_expected_seek_speed)<0.0001,
            "BatDisc source speed minus friction_raw lost logical setter conversion or motion_add_ct scale")
        var _slash=instance_create(_disc.x,_disc.y,Slash)
        _slash.direction=90
        _disc.walled=false;_disc.returning=true;_disc.seek=0
        with(_disc) event_perform(ev_step,ev_step_normal)
        assert(!_disc.returning && !_disc.has_hit && _disc.deflected && _disc.direction==90
            && _disc.speed>12*timescale,"Actual overlapping Slash did not bat the physical blade")
        var _stale=scrNTTENewState(wep_ntte_sawblade_gun)
        _stale.ammo=2;_stale.outstanding=1
        scrNTTEFullBatDiscBind(_disc,_stale,1);_stale.epoch+=1
        instance_destroy(_disc)
        assert(_stale.ammo==2 && _stale.outstanding==1,"Blade credited an obsolete loaded inventory epoch")
    }
    finally {
        var _all=scrNTTEFullInstances(all)
        for(var _i=array_length(_all)-1;_i>=0;--_i) if(array_get_index(_before,_all[_i])<0) instance_destroy(_all[_i],false)
        scrNTTEFullAreaGeneratorRestore(_game);scrNTTEFullAreaGeneratorRestore(_players);scrNTTEFullAreaGeneratorRestore(_back)
        ds_list_destroy(_skills);random_set_seed(_seed);current_frame=_frame
    }
    scrNTTESmokeLog("FULL BAT DISC: original damage/mask, radial children, wall phases, same-state return/credits, actual slash baseball and team gate OK @"+string(30/timescale))
}
function scrNTTEFullEnergyBatTests() {
    var _before=scrNTTEFullInstances(all),_game=scrNTTEFullAreaGeneratorSnapshot(GameCont),
        _players=scrNTTEFullAreaGeneratorSnapshot(Player),_back=scrNTTEFullAreaGeneratorSnapshot(BackCont),
        _seed=random_get_seed(),_frame=current_frame,_skills=ds_list_create()
    GameCont.skills=_skills;GameCont.ntte_full_native_skill_counts={};GameCont.area=1;GameCont.underwater=false
    current_frame=2
    try {
        var _owner=instance_find(Player,0),_levels=[0,1,3,-1,-3],_slash=noone
        ds_list_add(_skills,mut_laser_brain)
        for(var _i=0;_i<array_length(_levels);++_i) {
            var _level=_levels[_i]
            variable_struct_set(GameCont.ntte_full_native_skill_counts,string(mut_laser_brain),_level)
            with(_owner) _slash=scrNTTEFullMergedBasicProjectileCreate(88000+100*_i,88000,NTTEFullEnergyBatSlash,0,2)
            var _expected=0.4/(_level>0?1+_level:power(2,_level))*timescale
            assert(_slash.damage==18 && _slash.mask_index==mskSlash && _slash.knockback_speed==12*timescale
                && abs(_slash.image_speed-_expected)<0.0001,"EnergyBat native source lost damage/force/mask or signed multi-level LaserBrain divisor")
        }
        variable_struct_set(GameCont.ntte_full_native_skill_counts,string(mut_laser_brain),0)
        _slash.team=team_player
        var _friendly=instance_create(88000,88000,Bullet1)
        _friendly.team=team_player
        with(_slash) scrNTTEFullEnergyBatProjectile(_friendly)
        assert(instance_exists(_friendly),"EnergyBat ignored original CustomSlash same-team collision gate")
        var _incoming=instance_create(88100,88000,EnemyBullet1)
        _incoming.team=team_enemy;_incoming.creator=_owner;_incoming.damage=100
        var _vlasma_count=instance_number(NTTEFullVlasmaBullet),_cannons=instance_number(NTTEFullVlasmaCannon),
            _impacts=instance_number(NTTEFullPlasmaImpactSmall)
        with(_slash) scrNTTEFullEnergyBatProjectile(_incoming)
        assert(!instance_exists(_incoming) && instance_number(NTTEFullVlasmaBullet)==_vlasma_count+1
            && instance_number(NTTEFullVlasmaCannon)==_cannons && instance_number(NTTEFullPlasmaImpactSmall)==_impacts+1,
            "EnergyBat guessed cannon from damage instead of actual destroyed projectile descendants")
        var _vlasma=instance_find(NTTEFullVlasmaBullet,_vlasma_count)
        assert(_vlasma.creator==_owner && _vlasma.team==team_player && _vlasma.target==_owner
            && _vlasma.damage==2 && _vlasma.cannon==0,"EnergyBat reflected vector plasma lost source metadata/defaults")
        var _rocket=instance_create(88200,88000,FlakBullet)
        _rocket.team=team_enemy;_rocket.creator=_owner;_rocket.damage=10
        _cannons=instance_number(NTTEFullVlasmaCannon)
        with(_slash) scrNTTEFullEnergyBatProjectile(_rocket)
        assert(!instance_exists(_rocket) && instance_number(NTTEFullVlasmaCannon)==_cannons+1,
            "Real FlakBullet destroy descendants did not cause EnergyBat vector cannon conversion")
        var _cannon=instance_find(NTTEFullVlasmaCannon,_cannons)
        assert(_cannon.cannon==15 && _cannon.damage==4,"EnergyBat cannon count was not incoming damage*1.5")
        _vlasma_count=instance_number(NTTEFullVlasmaBullet)
        with(_cannon) instance_destroy()
        assert(instance_number(NTTEFullVlasmaBullet)==_vlasma_count+14,"Actual vector cannon death did not emit exact 15 radial children")
        var _deflection=instance_create(88300,88000,EnemyBullet1)
        _deflection.team=team_enemy;_slash.candeflect=false
        _vlasma_count=instance_number(NTTEFullVlasmaBullet)
        with(_slash) scrNTTEFullEnergyBatProjectile(_deflection)
        assert(!instance_exists(_deflection) && instance_number(NTTEFullVlasmaBullet)==_vlasma_count,
            "EnergyBat candeflect=false still created a reflected vector projectile")
        variable_struct_set(GameCont.ntte_full_native_skill_counts,string(mut_laser_brain),3)
        var _shot=instance_create(89000,88000,NTTEFullVlasmaBullet)
        _shot.creator=_owner;_shot.team=team_player
        with(_shot) scrNTTEFullVlasmaSetup()
        assert(_shot.damage==16 && abs(_shot.image_xscale-power(1.2,3))<0.0001,
            "Real vector plasma source lost multiplicative LaserBrain damage/scale")
        with(_shot) scrNTTEFullVlasmaAnim()
        assert(_shot.image_index==_shot.image_number-1 && _shot.image_speed==0,"Vector plasma source must finish startup animation before flight/hit")
        _shot.target=_owner;_owner.x=89200;_owner.y=88100
        _owner.gunangle=0;_shot.speed=0
        with(_shot) event_perform(ev_step,ev_step_normal)
        assert(_shot.target_y==_owner.y && _shot.target_x>_owner.x && abs(_shot.speed-0.4*timescale*timescale)<0.0001,
            "Vector plasma lost creator gun-tip target or logical acceleration0.4")
        var _victim=instance_create(_slash.x+100,_slash.y,NTTEBabyGator)
        _victim.team=team_enemy;_victim.hp=40;_victim.nexthurt=0
        with(_slash) scrNTTEFullEnergyBatHit(_victim)
        assert(_victim.hp==22,"EnergyBat true native melee hit lost damage18")
        _victim.hp=40;_victim.nexthurt=current_frame+100
        _shot.image_speed=0.4*timescale
        with(_shot) scrNTTEFullVlasmaHit(_victim)
        assert(_victim.hp==40,"Vector plasma damaged before its actual startup animation completed")
        _shot.image_speed=0
        with(_shot) scrNTTEFullVlasmaHit(_victim)
        assert(_victim.hp==24,"Vector plasma source NP pipeline incorrectly applied enemy hurt interval or lost damage16")
        _victim.team=team_player;_victim.hp=40
        with(_shot) scrNTTEFullVlasmaHit(_victim)
        assert(_victim.hp==40,"Vector plasma NP hit ignored source friendly-team filter")
    }
    finally {
        var _all=scrNTTEFullInstances(all)
        for(var _i=array_length(_all)-1;_i>=0;--_i) if(array_get_index(_before,_all[_i])<0) instance_destroy(_all[_i],false)
        scrNTTEFullAreaGeneratorRestore(_game);scrNTTEFullAreaGeneratorRestore(_players);scrNTTEFullAreaGeneratorRestore(_back)
        ds_list_destroy(_skills);random_set_seed(_seed);current_frame=_frame
    }
    scrNTTESmokeLog("FULL ENERGY BAT: original signed Brain, real destroyed-descendant cannon conversion, vector plasma startup/homing/split, friendly/candeflect gates OK @"+string(30/timescale))
}
