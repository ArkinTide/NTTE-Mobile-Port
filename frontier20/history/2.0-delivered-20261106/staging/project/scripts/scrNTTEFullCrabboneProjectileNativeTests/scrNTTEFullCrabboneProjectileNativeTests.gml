function scrNTTEFullCrabboneProjectileNativeTests() {
    scrNTTEFullWeaponNativeInit()
    var _before=scrNTTEFullInstances(all),_players=scrNTTEFullAreaGeneratorSnapshot(Player),
        _game=scrNTTEFullAreaGeneratorSnapshot(GameCont),_uber=scrNTTEFullAreaGeneratorSnapshot(UberCont),
        _seed=random_get_seed(),_frame=current_frame,_models=global.ntte_full_native_weapon_models,
        _skills=ds_list_create()
    GameCont.skills=_skills;GameCont.ntte_full_native_skill_counts={};GameCont.area=1;GameCont.underwater=false
    current_frame=2
    try {
        var _p=instance_find(Player,0)
        _p.x=4000;_p.y=4000;_p.xprevious=_p.x;_p.yprevious=_p.y;_p.speed=0;_p.race=Race.Fish
        _p.team=team_player;_p.curse=1;_p.gunangle=0;_p.accuracy=0
        var _model={wep:wep_crossbow},_pickups=instance_number(WepPickup),_shards=instance_number(NTTEBoneShard),
            _shot=scrNTTEFullCrabboneQuestBreak(_p,_model,45)
        assert(instance_is(_shot,NTTEFullCrabboneBone) && _shot.wep==_model && _shot.creator==_p
            && _shot.team==team_player && _shot.broken && _shot.curse==1
            && abs(_shot.speed-16*timescale)<0.001 && _shot.sprite_index==scr_weapon_get_sprite(wep_crossbow),
            "Quest final unlock did not emit original arbitrary physical part as16speed cursed broken actual Bone")
        instance_destroy(_shot)
        assert(instance_number(WepPickup)==_pickups && instance_number(NTTEBoneShard)==_shards+2,
            "Broken arbitrary Quest stock was incorrectly returned as a weapon pickup")
        _model=scrNTTEFullCrabboneCreateModel(-1)
        _shot=scrNTTEFullCrabboneProjectileCreate(_p,_model,0,16)
        _shards=instance_number(NTTEBoneShard);_shot.speed=0
        with(_shot) event_perform(ev_step,ev_step_normal)
        assert(!instance_exists(_shot) && instance_number(NTTEBoneShard)==_shards
            && instance_number(WepPickup)==_pickups+1,
            "Harmless ordinary Bone landing must return intact physical weapon without shards")
        scrNTTEFullBoneImpactFollowupTests(_p)
        // Invoke genuine collision events, retaining their native other
        // context. Friendly contact must never consume even an artifact.
        var _friendly=instance_create(4100,4000,Bandit)
        _friendly.team=team_player;_friendly.hp=1000;_friendly.nexthurt=0
        _model=scrNTTEFullCrabboneCreateModel(1)
        _shot=scrNTTEFullCrabboneProjectileCreate(_p,_model,23,16)
        var _friendly_epoch=scrNTTEFullInstances(all)
        with(_friendly) with(_shot) event_perform(ev_collision,hitme)
        assert(instance_exists(_shot) && _friendly.hp==1000
            && array_length(scrNTTEFullMergedRuntimeNew(_friendly_epoch))==0,
            "Genuine friendly Bone collision consumed a physical part or emitted artifact side effects")
        _shot.broken=true;instance_destroy(_shot);instance_destroy(_friendly)
        // Source ordinary Bone can charm the actual ScrapBoss for300ticks;
        // instance_delete semantics must bypass break shards and pickup.
        var _dog=instance_create(4200,4000,ScrapBoss)
        _dog.team=team_enemy;_dog.hp=1000;_dog.nexthurt=0
        _model=scrNTTEFullCrabboneCreateModel(-1)
        _shot=scrNTTEFullCrabboneProjectileCreate(_p,_model,0,16)
        _shards=instance_number(NTTEBoneShard);_pickups=instance_number(WepPickup)
        with(_dog) with(_shot) event_perform(ev_collision,hitme)
        assert(!instance_exists(_shot) && _dog.hp==1000 && _dog.team==team_player
            && _dog.ntte_charm.charmed && _dog.ntte_charm.time==300
            && instance_number(NTTEBoneShard)==_shards && instance_number(WepPickup)==_pickups,
            "Actual ScrapBoss Bone secret lost300tick charm, bypassed native delete semantics or dealt damage")
        scrNTTEFullMergedRuntimeTestCleanup(_before)
        // Chicken's source piercing is governed by native melee nexthurt,
        // allowing another hit after that guard expires rather than a
        // permanent projectile-local list of previously hit instances.
        var _pierce_target=instance_create(4100,4000,Bandit)
        _pierce_target.team=team_enemy;_pierce_target.hp=1000;_pierce_target.nexthurt=0
        _p.race=Race.Chicken;ds_list_add(_skills,mut_throne_butt)
        GameCont.ntte_full_native_skill_counts[$ string(mut_throne_butt)]=1
        _shot=scrNTTEFullCrabboneProjectileCreate(_p,scrNTTEFullCrabboneCreateModel(-1),0,16)
        with(_pierce_target) with(_shot) event_perform(ev_collision,hitme)
        assert(instance_exists(_shot) && _pierce_target.hp==966,"Chicken TB Bone lost genuine first piercing hit")
        _pierce_target.nexthurt=current_frame+6
        with(_pierce_target) with(_shot) event_perform(ev_collision,hitme)
        assert(instance_exists(_shot) && _pierce_target.hp==966,"Chicken TB Bone ignored native melee nexthurt gate")
        _pierce_target.nexthurt=0
        with(_pierce_target) with(_shot) event_perform(ev_collision,hitme)
        assert(instance_exists(_shot) && _pierce_target.hp==932,"Chicken TB Bone added non-source permanent once-only hit list")
        _p.race=Race.Fish;ds_list_clear(_skills);GameCont.ntte_full_native_skill_counts={}
        _shot.broken=true;instance_destroy(_shot)
        scrNTTEFullMergedRuntimeTestCleanup(_before)
        // Genuine hostile collision: guarded artifact emits five tethered
        // ElectroPlasma and its source safety zone, no substituted area damage.
        var _target=instance_create(4100,4000,Bandit)
        _target.team=team_enemy;_target.hp=1000;_target.max_hp=1000;_target.nexthurt=0;_target.speed=0
        _model=scrNTTEFullCrabboneCreateModel(1)
        _shot=scrNTTEFullCrabboneProjectileCreate(_p,_model,23,16);_shot.image_angle=23
        var _plasma_before=scrNTTEFullInstances(NTTEFullElectroPlasma),_zones=instance_number(NTTEBatScreech),
            _impacts=instance_number(NTTEFullElectroPlasmaImpact),_epoch=scrNTTEFullInstances(all)
        with(_shot) scrNTTEFullCrabboneBoneHit(_target)
        var _new=scrNTTEFullMergedRuntimeTestShots(scrNTTEFullMergedRuntimeNew(_epoch),NTTEFullElectroPlasma)
        assert(_target.hp==966 && array_length(_new)==5 && instance_number(NTTEBatScreech)==_zones+1
            && instance_number(NTTEFullElectroPlasmaImpact)==_impacts+1 && !instance_exists(_shot),
            "Guarded actual collision lost34direct damage/five genuine ElectroPlasma/safety zone/impact")
        var _prior=noone
        for(var _i=0;_i<array_length(_new);++_i) {
            var _v=_new[_i]
            scrNTTESmokeLog("CRABBONE GUARDED PLASMA DIAG "+json_stringify({i:_i,creator:_v.creator,
                expectedCreator:_p,team:_v.team,expectedTeam:team_player,speed:_v.speed,expectedSpeed:1.5*timescale,
                friction:_v.friction,expectedFriction:1.5*timescale*timescale/90,tether:_v.ntte_full_tether_inst,
                epsilon:math_get_epsilon(),creatorOK:_v.creator==_p,teamOK:_v.team==team_player,
                speedOK:abs(_v.speed-1.5*timescale)<0.001,
                frictionStrictOK:abs(_v.friction-1.5*timescale*timescale/90)<0.000001,
                frictionClosedOK:abs(_v.friction-1.5*timescale*timescale/90)<=0.000001}))
            // Closed tolerance also accepts GML epsilon equality; a strict
            // <1e-6 rejects even an exact zero at the default1e-5 epsilon.
            assert(_v.creator==_p && _v.team==team_player && abs(_v.speed-1.5*timescale)<0.001
                && abs(_v.friction-1.5*timescale*timescale/90)<=0.000001,
                "Guarded source projectile lost inherited owner/team or1.5speed/90friction")
            if(_v.ntte_full_tether_inst==noone) _prior=_v
        }
        assert(instance_exists(_prior),"Guarded source tether has no original first node")
        var _links=1
        repeat(4) {
            var _next=noone
            for(var _i=0;_i<array_length(_new);++_i) if(_new[_i].ntte_full_tether_inst==_prior) _next=_new[_i]
            assert(instance_exists(_next),"Guarded source five-node tether chain was broken")
            assert(abs(angle_difference(_next.direction,_prior.direction)-60)<0.001,
                "Guarded source tether lost60degree consecutive directions")
            _prior=_next;_links+=1
        }
        var _pickup=noone
        with(WepPickup) if(scrNTTEFullWeaponModel(wep)==_model) _pickup=id
        assert(instance_exists(_pickup) && _pickup.ntte_state==_model.ntte_native_state,
            "Guarded impact failed same physical artifact landing pickup/state")
        scrNTTEFullMergedRuntimeTestCleanup(_before)
        // Ancient impact fires the actual ProtoChest weapon from its barrel
        // using native actor dispatch, retaining the source player's context.
        _target=instance_create(4100,4000,Bandit);_target.team=team_enemy;_target.hp=1000;_target.nexthurt=0
        var _proto=instance_create(4000,4100,ProtoChest)
        _proto.wep=wep_crossbow;_model=scrNTTEFullCrabboneCreateModel(0)
        _shot=scrNTTEFullCrabboneProjectileCreate(_p,_model,0,16);_shot.image_angle=0
        _epoch=scrNTTEFullInstances(all)
        with(_shot) scrNTTEFullCrabboneBoneHit(_target)
        _new=scrNTTEFullMergedRuntimeTestShots(scrNTTEFullMergedRuntimeNew(_epoch),Bolt)
        assert(array_length(_new)==1 && _new[0].creator==_p && _new[0].team==team_player
            && abs(angle_difference(_new[0].direction,0))<0.001,
            "Ancient source impact did not fire actual ProtoChest Crossbow with original creator/team/direction")
        scrNTTEFullMergedRuntimeTestCleanup(_before)
        // Stolen impact inserts a real physical pickup without Trident's
        // extraction damage. Cannon follows it and emits genuine blue Laser.
        _target=instance_create(4100,4000,Bandit);_target.team=team_enemy;_target.hp=1000;_target.nexthurt=0;_target.size=2
        _model=scrNTTEFullCrabboneCreateModel(2)
        _shot=scrNTTEFullCrabboneProjectileCreate(_p,_model,0,16);_shot.image_angle=0
        _epoch=scrNTTEFullInstances(all)
        with(_shot) scrNTTEFullCrabboneBoneHit(_target)
        _new=scrNTTEFullMergedRuntimeTestShots(scrNTTEFullMergedRuntimeNew(_epoch),NTTEFullBoneArtifactLaserCannon)
        assert(array_length(_new)==1 && !instance_exists(_shot),"Stolen actual hit lost dedicated cannon or failed physical insertion")
        var _cannon=_new[0];_pickup=_cannon.target
        assert(instance_is(_pickup,NTTEFullWepPickupStick) && _pickup.stick_target==_target && _pickup.stick_damage==0
            && scrNTTEFullWeaponModel(_pickup.wep)==_model && _pickup.ntte_state==_model.ntte_native_state
            && _cannon.ammo==9 && _cannon.delay==27 && _cannon.creator==_p,
            "Stolen source size2=>9ammo/27delay, actual original model/state/stuck pickup or zero-extraction semantics changed")
        var _lasers=instance_number(NTTEFullPopoLaser)
        _cannon.delay=timescale
        with(_cannon) event_perform(ev_step,ev_step_normal)
        assert(_cannon.ammo==8 && _cannon.delay==2 && instance_number(NTTEFullPopoLaser)==_lasers+1
            && _target.speed>0 && _cannon.target==_pickup,
            "Stolen real Cannon Step failed blue laser2tick cadence, source ammo consumption, target follow or recoil")
        var _hp=_target.hp
        instance_destroy(_pickup)
        assert(_target.hp==_hp,"Stolen physical artifact pickup inherited unrelated Trident extraction damage")
        scrNTTEFullMergedRuntimeTestCleanup(_before)
        // Missing source impact creates orbiting target-bound Vlasma and uses
        // the shuffled actual Floor center, not an arbitrary x+16 heuristic.
        _target=instance_create(4100,4000,Bandit);_target.team=team_enemy;_target.hp=1000;_target.nexthurt=0
        var _floor=instance_create(4128,4032,Floor),_fx_count=instance_number(RecycleGland)
        _model=scrNTTEFullCrabboneCreateModel(3)
        _shot=scrNTTEFullCrabboneProjectileCreate(_p,_model,0,16);_shot.image_angle=0
        var _cx=(_floor.bbox_left+_floor.bbox_right-1)/2,_cy=(_floor.bbox_top+_floor.bbox_bottom-1)/2
        _epoch=scrNTTEFullInstances(all)
        with(_shot) scrNTTEFullCrabboneBoneHit(_target)
        _new=scrNTTEFullMergedRuntimeTestShots(scrNTTEFullMergedRuntimeNew(_epoch),NTTEFullVlasmaBullet)
        assert(array_length(_new)==4,"Missing actual impact lost four genuine Vlasma projectiles")
        _pickup=noone
        with(WepPickup) if(scrNTTEFullWeaponModel(wep)==_model) _pickup=id
        assert(instance_exists(_pickup) && abs(_pickup.x-_cx)<0.001 && abs(_pickup.y-_cy)<0.001
            && instance_number(RecycleGland)==_fx_count+2,
            "Missing original artifact teleport did not choose real free Floor center/two ChickenB effects")
        for(var _i=0;_i<4;++_i) assert(_new[_i].target==_pickup && _new[_i].creator==_p
            && _new[_i].team==team_player && _new[_i].speed==0,
            "Missing cleanup failed target redirection from physical projectile to same returned pickup")
        scrNTTESmokeLog("PASS actual source Bone/arbitrary Quest broken stock, ordinary non-pickable shards, original physical artifact landings, Ancient real ProtoChest fire, Guarded five ElectroPlasma tethers+safety, Stolen stick/cannon/blue Laser/recoil/no extraction, Missing four Vlasma+real Floor teleport/target redirection")
    }
    finally {
        with(NTTEFullCrabboneBone) if(array_get_index(_before,id)<0) broken=true
        with(NTTEFullWepPickupStick) if(array_get_index(_before,id)<0) stick_damage=0
        scrNTTEFullMergedRuntimeTestCleanup(_before)
        scrNTTEFullAreaGeneratorRestore(_players);scrNTTEFullAreaGeneratorRestore(_game);scrNTTEFullAreaGeneratorRestore(_uber)
        global.ntte_full_native_weapon_models=_models;current_frame=_frame;random_set_seed(_seed);ds_list_destroy(_skills)
    }
}

// BEGIN IMPACT ONLY BONE TESTS
function scrNTTEFullBoneImpactFollowupTests(_p) {
    var _before=scrNTTEFullInstances(all),_pickups=instance_number(WepPickup),
        _shards=instance_number(NTTEBoneShard),_model=scrNTTEFullCrabboneCreateModel(-1),
        _shot=scrNTTEFullCrabboneProjectileCreate(_p,_model,0,16),
        _wall=instance_create(_p.x+96,_p.y,Wall)
    try {
        _shot.x=_wall.x;_shot.y=_wall.y
        with(_wall) with(_shot) event_perform(ev_collision,Wall)
        assert(!instance_exists(_shot) && instance_number(NTTEBoneShard)==_shards+2
            && instance_number(WepPickup)==_pickups,"Ordinary wall impact must shatter exactly once, never return pickup")
        _shards=instance_number(NTTEBoneShard)
        var _enemy=instance_create(_p.x+192,_p.y,Bandit)
        _enemy.team=team_enemy;_enemy.hp=1000;_enemy.nexthurt=0
        _shot=scrNTTEFullCrabboneProjectileCreate(_p,scrNTTEFullCrabboneCreateModel(-1),0,16)
        with(_enemy) with(_shot) event_perform(ev_collision,hitme)
        assert(!instance_exists(_shot) && _enemy.hp==966 && instance_number(NTTEBoneShard)==_shards+2
            && instance_number(WepPickup)==_pickups,"Ordinary hostile impact lost source34 damage or two non-pickable shards")
        _enemy.team=team_player;_enemy.nexthurt=0
        _shot=scrNTTEFullCrabboneProjectileCreate(_p,scrNTTEFullCrabboneCreateModel(-1),0,16)
        _shards=instance_number(NTTEBoneShard)
        with(_enemy) with(_shot) event_perform(ev_collision,hitme)
        assert(instance_exists(_shot) && !_shot.broken && _enemy.hp==966
            && instance_number(NTTEBoneShard)==_shards,"Friendly ordinary contact must not break or damage")
        _shot.x=_p.x+128;_shot.y=_p.y+128;_shot.speed=0
        _model=_shot.wep
        with(_shot) event_perform(ev_step,ev_step_normal)
        var _pickup=noone
        with(WepPickup) if(ntte_state==_model.ntte_native_state) _pickup=id
        assert(!instance_exists(_shot) && instance_exists(_pickup) && _pickup.ntte_state==_model.ntte_native_state
            && _pickup.wep==scrNTTEFullWeaponNative(_model) && _pickup.x==_p.x+128 && _pickup.y==_p.y+128
            && instance_number(NTTEBoneShard)==_shards && instance_number(WepPickup)==_pickups+1,
            "Intact ordinary bone failed physical landing after harmless friendly contact")
        _shot=scrNTTEFullCrabboneProjectileCreate(_p,scrNTTEFullCrabboneCreateModel(1),0,16)
        with(_wall) with(_shot) event_perform(ev_collision,Wall)
        assert(instance_exists(_shot) && !_shot.broken,"Ordinary-only wall override changed artifact bounce")
    } finally {
        with(NTTEFullCrabboneBone) if(array_get_index(_before,id)<0) broken=true
        scrNTTEFullMergedRuntimeTestCleanup(_before)
    }
    scrNTTESmokeLog("BONE IMPACT ONLY: actual wall and hostile collisions shatter; friendly and harmless landing return exact physical bone; artifact bounce retained")
}
