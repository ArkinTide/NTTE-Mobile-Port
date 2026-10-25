function scrNTTEFullWeaponMimicFixtureNew(_object,_before) {
    var _out=[],_all=scrNTTEFullInstances(_object)
    for(var _i=0;_i<array_length(_all);++_i) if(array_get_index(_before,_all[_i])<0) array_push(_out,_all[_i])
    return _out
}
function scrNTTEFullWeaponMimicBossNativeTests() {
    assert(scrNTTESmokeEnabled(),"Weapon Mimic fixture requires native desktop harness")
    var _before=scrNTTEFullInstances(all),_game=scrNTTEFullAreaGeneratorSnapshot(GameCont),
        _players=scrNTTEFullAreaGeneratorSnapshot(Player),_top=scrNTTEFullAreaGeneratorSnapshot(TopCont),
        _seed=random_get_seed(),_p=instance_find(Player,0),_hidden=scrNTTEFullInstances([enemy,Floor,Wall,GenCont,LevCont,SitDown]),
        _active=scrNTTEFullValue(GameCont,"ntte_full_active_coast",false),
        _stats=global.ntte_full_progress.stats,_oldStat=scrNTTEFullValue(_stats,"pet:Weapon.petlib.mod",undefined)
    for(var _i=0;_i<array_length(_hidden);++_i) instance_deactivate_object(_hidden[_i])
    GameCont.ntte_full_active_coast=false;GameCont.loops=0;GameCont.hard=6;GameCont.crown=crwn_none
    if(!instance_exists(TopCont)) { GameCont.area=area_desert;instance_create(0,0,TopCont) }
    _p.x=96100;_p.y=96000;_p.visible=true
    try {
        var _become=instance_create(96000,96000,NTTEFullPetWeaponBecome),_prompt=_become.prompt
        assert(instance_exists(_prompt) && _prompt.text=="BATTLE" && _become.sprite_index==scrNTTERefSprite("PetWeaponChst")
            && !_become.curse,"Weapon Mimic genuine battle chest/default crown/Prompt initialization differs from source")
        _become.curse=1;with(_become) scrNTTEFullWeaponMimicBecomeStep()
        assert(_become.sprite_index==scrNTTERefSprite("PetWeaponCursedChst"),"Weapon Mimic battle chest failed cursed skin update")
        _become.curse=0;_become.type=Ammo.Bullets;_prompt.pick=_p.index;GameCont.nochest=9
        with(_become) scrNTTEFullWeaponMimicBecomeStep()
        var _boss=instance_find(NTTEFullPetWeaponBoss,0)
        assert(instance_exists(_boss) && !instance_exists(_become) && !instance_exists(_prompt) && GameCont.nochest==0
            && _boss.hp==scrNTTEFullSewerBossHP(120) && _boss.max_hp==_boss.hp && !_boss.corpse
            && _boss.team==team_enemy && _boss.type==Ammo.Bullets && _boss.ntte_mimic_alarm1==60
            && _boss.mask_index==mskFrogEgg && _boss.snd_hurt==sndMimicHurt,
            "Battle Prompt failed actual boss/type/HP/shared Weapon initialization or source cleanup/reset")
        assert(abs(angle_difference(_boss.direction,180))<=0.001 && abs(_boss.speed-3*timescale)<=0.001,
            "Weapon Mimic battle chest did not push boss away from activating player")
        _boss.stat={found:0,owned:0,battle:[0,0]};_boss.speed=0
        var _normal=[wep_wrench,wep_revolver,wep_shotgun,wep_crossbow,wep_grenade_launcher,wep_laser_cannon],
            _loop=[wep_energy_sword,wep_heavy_revolver,wep_eraser,wep_auto_crossbow,wep_blood_launcher,wep_plasma_cannon]
        for(var _loops=0;_loops<2;++_loops) for(var _kind=0;_kind<6;++_kind) {
            GameCont.loops=_loops
            with(_boss) { type=_kind;wep=wep_none;bwep=wep_none;curse=0;scrNTTEFullPetWeaponSetup() }
            assert(_boss.wep==(_loops==0?_normal[_kind]:_loop[_kind]),"Weapon Mimic actual shared six-type/loop loadout table differs: "+string(_kind))
        }
        GameCont.loops=0
        with(_boss) { wep=wep_none;bwep=wep_none;curse=1;scrNTTEFullPetWeaponSetup();sprite_index=spr_hide;scrNTTEFullWeaponMimicSharedAnim() }
        assert(_boss.wep==wep_super_disc_gun && _boss.type==Ammo.Shells && _boss.sprite_index==_boss.spr_spwn,
            "Weapon Mimic cursed weapon or actual hidden-to-spawn targeting path failed")
        _boss.curse=0
        for(var _kind=0;_kind<6;++_kind) {
            with(_boss) {
                type=_kind;wep=_normal[_kind];bwep=wep_none;scrNTTEFullPetWeaponSetup()
                sprite_index=spr_idle;gunangle=0;gunangle_goal=0;direction=0
                cover_delay=0;cover_peek=false;scrNTTEFullWeaponMimicBossDecision()
            }
            assert(_boss.target==_p && _boss.target_visible && _boss.ntte_mimic_alarm1>0,
                "Weapon Mimic genuine six-type native-target AI failed kind "+string(_kind))
        }
        assert(scrNTTEFullWeaponMimicLaserSight(wep_crossbow) && !scrNTTEFullWeaponMimicLaserSight(wep_disc_gun)
            && !scrNTTEFullWeaponMimicLaserSight(wep_shotgun) && !scrNTTEFullWeaponMimicLaserSight(wep_ntte_net_launcher),
            "Weapon Mimic sight differs from recovered native NTT type3/excludedID18 getter or source NetLauncher override")
        var _plainFront=scrNTTEFullWeaponMerge(wep_shotgun,wep_crossbow),
            _nestedFront=scrNTTEFullWeaponMerge(wep_shotgun,scrNTTEFullWeaponMerge(wep_crossbow,wep_revolver)),
            _part=scrNTTEFullWeaponMerge(wep_none,wep_crossbow)
        assert(!scrNTTEFullWeaponMimicLaserSight(_plainFront) && scrNTTEFullWeaponMimicLaserSight(_nestedFront)
            && !scrNTTEFullWeaponMimicLaserSight(_part),"Weapon Mimic original temerge sight recursion/empty-part macros were flattened")
        // The bolt AI charges while concealed near its selected cover even
        // with no target/leader line of sight, using the genuine pet method.
        with(_boss) {
            type=Ammo.Bolts;wep=wep_crossbow;bwep=wep_none;setup=false
            target=noone;leader=noone;cover_x=x;cover_y=y;reload=0;can_shoot=0;wep_laser=0
            scrNTTEFullPetWeaponStep()
        }
        assert(abs(_boss.wep_laser-timescale/5)<=0.001,"Weapon Mimic lost original cover charging in shared actual Weapon code")
        // Shotgun windup is nine logical ticks with a real original alert.
        _p.x=_boss.x+64;_p.y=_boss.y
        with(_boss) { type=Ammo.Shells;wep=wep_shotgun;bwep=wep_none;scrNTTEFullPetWeaponSetup();sprite_index=spr_idle;gunangle=0;reload=0;can_shoot=0;scrNTTEFullWeaponMimicBossShoot() }
        var _alerts=scrNTTEFullWeaponMimicFixtureNew(NTTEAlert,_before),_warning=noone
        for(var _i=0;_i<array_length(_alerts);++_i) if(_alerts[_i].target==_boss) _warning=_alerts[_i]
        assert(_boss.reload==9 && _boss.can_shoot>=1 && instance_exists(_warning) && _warning.alert_hold==14
            && _warning.blink==10 && _warning.flash==2 && _warning.snd_flash==sndShotReload,
            "Weapon Mimic shell source nine-tick warning/real alert changed")
        // Preserve all six native mutations across actual shared native fire.
        var _muts=[mut_long_arms,mut_recycle_gland,mut_shotgun_shoulders,mut_bolt_marrow,mut_boiling_veins,mut_laser_brain],_old=[]
        for(var _i=0;_i<array_length(_muts);++_i) { array_push(_old,scr_skill_get(_muts[_i]));scr_skill_set(_muts[_i],2) }
        _boss.wep=wep_revolver;_boss.bwep=wep_revolver;_boss.ntte_state=undefined;_boss.bntte_state=undefined
        _boss.reload=0;_boss.breload=0;_boss.can_shoot=1;_boss.bcan_shoot=1;_boss.setup=false
        var _shotsBefore=scrNTTEFullInstances(all)
        with(_boss) scrNTTEFullPetWeaponStep()
        var _bullets=scrNTTEFullWeaponMimicFixtureNew(EnemyBullet4,_shotsBefore)
        assert(array_length(_bullets)==2 && _boss.can_shoot==0 && _boss.bcan_shoot==0 && _boss.reload>0 && _boss.breload>0,
            "Weapon Mimic genuine shared akimbo fire failed actual hostile native revolver projectiles")
        for(var _i=0;_i<2;++_i) assert(_bullets[_i].creator==_boss && _bullets[_i].team==team_enemy
            && _bullets[_i].damage==3 && _bullets[_i].knockback_speed==8*timescale && _bullets[_i].spr_fade==sprEnemyBulletHit
            && _bullets[_i].hitid==_boss.hitid && _bullets[_i].sprite_index==scrNTTERefSprite("EnemyBullet"),
            "Weapon Mimic real bullet lost source owner/team/damage/deathcause/skin")
        for(var _i=0;_i<array_length(_muts);++_i) { assert(scr_skill_get(_muts[_i])==2,"Weapon Mimic native fire leaked temporary mutation state");scr_skill_set(_muts[_i],_old[_i]) }
        // Source creates an extra DiverHarpoon instead of deleting its Bolt.
        _shotsBefore=scrNTTEFullInstances(all)
        var _fire=scrNTTEFullWeaponMimicSharedFire(_boss,wep_crossbow,0,1,false,0),
            _bolts=scrNTTEFullWeaponMimicFixtureNew(Bolt,_shotsBefore),_harpoons=scrNTTEFullWeaponMimicFixtureNew(NTTEFullDiverHarpoon,_shotsBefore)
        assert(array_length(_bolts)==1 && array_length(_harpoons)==1 && _harpoons[0].damage==_bolts[0].damage
            && _harpoons[0].creator==_boss && _harpoons[0].team==team_enemy,
            "Weapon Mimic source Bolt Marrow replacement must retain native Bolt and duplicate its mutable state into actual DiverHarpoon")
        // Real deferred Burst must inherit hostile class/owner as it emits.
        _fire=scrNTTEFullWeaponMimicSharedFire(_boss,wep_assault_rifle,0,1,false,0)
        var _burst=noone
        for(var _i=0;_i<array_length(_fire.shots);++_i) if(instance_is(_fire.shots[_i],Burst)) _burst=_fire.shots[_i]
        assert(instance_exists(_burst),"Weapon Mimic did not produce genuine deferred native Burst")
        _shotsBefore=scrNTTEFullInstances(all);with(_burst) event_perform(ev_alarm,0)
        _bullets=scrNTTEFullWeaponMimicFixtureNew(EnemyBullet4,_shotsBefore)
        assert(array_length(_bullets)>=1 && _bullets[0].creator==_boss && _bullets[0].hitid==_boss.hitid,
            "Weapon Mimic delayed native Burst bypassed original boss projectile setup")
        // Native countdown50/60 is Epsilon lead10. Each hand passes the
        // remaining burst count explicitly, independent of primary counter.
        var _nade=instance_create(_boss.x,_boss.y,Grenade)
        TopCont.darkness=false;scrNTTEFullWeaponMimicGrenadeTime(_nade,2,30)
        assert(_nade.alarm[0]==120 && _nade.flash_at==10,"Weapon Mimic grenade fuse extension mistook absolute flash alarm50 for remaining lead10")
        TopCont.darkness=true;_nade.alarm[0]=60;_nade.flash_at=10;scrNTTEFullWeaponMimicGrenadeTime(_nade,1,30)
        assert(_nade.alarm[0]==90 && _nade.flash_at==50,"Weapon Mimic dark grenade flash must advance40ticks and keep extended fuse")
        _nade.alarm[0]=5;_nade.flash_at=10;scrNTTEFullWeaponMimicGrenadeTime(_nade,2,30)
        assert(_nade.alarm[0]==65 && _nade.flash_at==10,"Already-flashing source grenade was rescheduled")
        // Genuine custom conversions retain gameplay fields, cover heavy
        // bullet, both slugs, both flaks and all three sizes of plasma.
        var _classes=[HeavyBullet,Slug,HeavySlug,FlakBullet,SuperFlakBullet,PlasmaBall,PlasmaBig,PlasmaHuge],
            _expected=[NTTEFullCustomBullet,NTTEFullCustomShell,NTTEFullCustomShell,NTTEFullCustomFlak,NTTEFullCustomFlak,NTTEFullCustomPlasma,NTTEFullCustomPlasma,NTTEFullCustomPlasma],
            _sourceForce=[12,9,32,6,8,4,8,8]
        for(var _i=0;_i<array_length(_classes);++_i) {
            var _shot=instance_create(_boss.x,_boss.y,_classes[_i])
            _shot.creator=_boss;_shot.team=team_enemy;_shot.damage=23;_shot.speed=7*timescale
            _shot.image_angle=37;_shot.image_alpha=0.7;_shot.image_xscale=1.23;_shot.alarm[9]=17
            var _mask=_shot.mask_index
            scrNTTEFullWeaponMimicProjectileSetup(_shot,_boss)
            assert(_shot.object_index==_expected[_i] && _shot.damage==23 && _shot.speed==7*timescale
                && _shot.creator==_boss && _shot.team==team_enemy && _shot.mask_index==_mask
                && _shot.image_angle==37 && abs(_shot.image_alpha-0.7)<=0.000001 && abs(_shot.image_xscale-1.23)<=0.000001 && _shot.alarm[9]==17
                && abs(_shot.knockback_speed-_sourceForce[_i]*timescale)<=0.000001,
                "Weapon Mimic source team class conversion lost native mutable fields for "+object_get_name(_classes[_i]))
            if(_classes[_i]==HeavySlug) assert(_shot.bonus==true && _shot.bonus_damage==10 && _shot.knockback_speed==32*timescale,
                "Weapon Mimic HeavySlug did not translate mobile numerical bonus10 back to original boolean bonus1/force32")
        }
        var _shell=instance_create(_boss.x,_boss.y,Bullet2);_shell.creator=_boss;_shell.team=team_enemy
        scrNTTEFullWeaponMimicProjectileSetup(_shell,_boss)
        assert(_shell.object_index==EnemyBullet3 && _shell.damage==2 && _shell.knockback_speed==3*timescale && _shell.spr_fade==sprEBullet3Disappear,
            "Weapon Mimic source basic shell force3/hostile fading sprite differs from recovered native defaults")
        // Raw signed damage, explicit projectile force and source randomized
        // backwards recoil use the actual shared public hurt entry points.
        _boss.type=Ammo.Bullets;_boss.hp=100;_boss.speed=0
        var _attacker=instance_create(_boss.x,_boss.y,Bullet1);_attacker.direction=90;_attacker.hitid=HitId.None
        with(_attacker) scr_projectile_hit(_boss,3,2*timescale,0)
        assert(_boss.hp==97 && abs(angle_difference(_boss.direction,0))<=0.001
            && abs(_boss.speed-2*timescale)<=0.001,"Weapon Mimic explicit projectile direction/force was lost")
        _boss.type=Ammo.None;_boss.speed=0
        with(_attacker) scr_projectile_hit(_boss,2,2*timescale,0)
        assert(_boss.hp==95 && abs(angle_difference(_boss.direction,180))<=90.001,
            "Weapon Mimic melee/shell recoil did not reverse with original random90 spread")
        with(_attacker) scr_hit(_boss,-2,HitId.None,1)
        assert(_boss.hp==97,"Weapon Mimic raw source hurt rejected signed healing")
        _boss.stat={found:0,owned:0,battle:[0,0]};var _battle=_boss.stat
        _boss.wep=wep_eraser;_boss.bwep=wep_revolver;_boss.curse=1;_boss.hp=-3
        _boss.direction=23;_boss.speed=timescale;_shotsBefore=scrNTTEFullInstances(NTTEFullPet)
        instance_destroy(_boss)
        var _pets=scrNTTEFullWeaponMimicFixtureNew(NTTEFullPet,_shotsBefore),_reward=noone
        for(var _i=0;_i<array_length(_pets);++_i) if(_pets[_i].pet=="Weapon") _reward=_pets[_i]
        assert(instance_exists(_reward) && _battle.battle[0]==1 && _reward.wep==wep_eraser && _reward.bwep==wep_revolver
            && _reward.curse==1 && _reward.hp==-3 && _reward.direction==23 && _reward.speed==timescale,
            "Weapon Mimic actual native death lost source battle-win/pet reward/weapons/curse/health/motion")
    }
    finally {
        var _after=scrNTTEFullInstances(all)
        for(var _i=0;_i<array_length(_after);++_i) if(array_get_index(_before,_after[_i])<0) instance_destroy(_after[_i],false)
        for(var _i=0;_i<array_length(_hidden);++_i) instance_activate_object(_hidden[_i])
        scrNTTEFullAreaGeneratorRestore(_game);scrNTTEFullAreaGeneratorRestore(_players);scrNTTEFullAreaGeneratorRestore(_top)
        GameCont.ntte_full_active_coast=_active;variable_struct_set(_stats,"pet:Weapon.petlib.mod",_oldStat);random_set_seed(_seed)
    }
    scrNTTESmokeLog("WEAPON MIMIC NATIVE: battle chest, six type/loop shared loadouts and AI, cover sight/warning, actual hostile dual fire/mutation restoration, Bolt duplicate, deferred Burst, timed grenade, eight genuine class conversions, public recoil and real reward OK")
}
function scrNTTEFullWeaponMimicArenaNativeTests() {
    scrNTTEFullFloorInit()
    var _before=scrNTTEFullInstances(all),_game=scrNTTEFullAreaGeneratorSnapshot(GameCont),
        _seed=random_get_seed(),_hidden=scrNTTEFullInstances([enemy,Floor,Wall,WeaponChest,GenCont,LevCont]),
        _active=scrNTTEFullValue(GameCont,"ntte_full_active_coast",false),
        _style=global.ntte_full_floor_style,_area=global.ntte_full_floor_area,
        _aw=global.ntte_full_floor_aw,_ah=global.ntte_full_floor_ah,_ax=global.ntte_full_floor_ax,_ay=global.ntte_full_floor_ay
    for(var _i=0;_i<array_length(_hidden);++_i) instance_deactivate_object(_hidden[_i])
    GameCont.ntte_full_active_coast=false;GameCont.hard=2;GameCont.loops=0;GameCont.crown=crwn_none
    scrNTTEFullFloorResetStyle();scrNTTEFullFloorSetAlign(32,32,0,0)
    try {
        var _enemy=instance_create(98216,98016,Bandit),_near=instance_create(10200,10200,WeaponChest),
            _far=instance_create(98000,98000,WeaponChest)
        _far.curse=1;GameCont.nochest=8
        GameCont.hard=1;random_set_seed(6721);var _expected=random(100000);random_set_seed(6721)
        assert(scrNTTEFullWeaponMimicArenaLevelStart()==noone && random(100000)==_expected
            && instance_exists(_far),"Weapon Mimic arena consumed RNG or chest outside normal hard gate")
        GameCont.hard=2;GameCont.nochest=4
        assert(scrNTTEFullWeaponMimicArenaLevelStart()==noone && instance_exists(_far),
            "Weapon Mimic natural zero-chance nochest4 gate spawned")
        GameCont.nochest=8
        random_set_seed(6721);_expected=random(100000);random_set_seed(6721)
        assert(scrNTTEFullWeaponMimicArenaLevelStart(false)==noone && random(100000)==_expected
            && instance_exists(_far),"Frozen non-normal source snapshot was overwritten by an early-spawned enemy")
        instance_destroy(_enemy,false)
        // Keep frozen normal eligibility even after the last enemy disappears.
        // Source nochest8 guarantees the actual chest conversion.
        var _become=scrNTTEFullWeaponMimicArenaLevelStart(true)
        assert(instance_exists(_become) && instance_is(_become,NTTEFullPetWeaponBecome) && !instance_exists(_far)
            && instance_exists(_near) && _become.curse==1 && _become.xstart==98000 && _become.ystart==98000
            && instance_number(Floor)>=5 && GameCont.nochest==8,
            "Natural Weapon Mimic arena lost farthest real chest/curse/source room/default tier or wrongly reset nochest before activation")
        _enemy=instance_create(98216,98016,Bandit)
        var _clear=scrNTTEFullInstances(PortalClear)
        for(var _i=0;_i<array_length(_clear);++_i)
            assert(_clear[_i].xstart!=_become.xstart || _clear[_i].ystart!=_become.ystart,
                "Weapon Mimic arena failed original PortalClear xstart/ystart cleanup")
        // Natural constructor chooses all six source room geometries. Sweep
        // deterministic seeds, disposing only objects created by this pass.
        var _seen=array_create(6,false)
        for(var _seedTry=1;_seedTry<=120;++_seedTry) {
            var _local=scrNTTEFullInstances(all),_chest=instance_create(99000+_seedTry*256,99000,WeaponChest)
            _chest.curse=0;random_set_seed(_seedTry)
            var _roomBoss=scrNTTEFullWeaponMimicArenaLevelStart()
            assert(instance_exists(_roomBoss),"Weapon Mimic guaranteed nochest8 natural arena failed seeded constructor")
            _seen[_roomBoss.type]=true
            var _floors=scrNTTEFullWeaponMimicFixtureNew(Floor,_local),_num=array_length(_floors),
                _minX=1000000,_maxX=-1000000,_minY=1000000,_maxY=-1000000
            for(var _j=0;_j<_num;++_j) {
                _minX=min(_minX,_floors[_j].bbox_left);_maxX=max(_maxX,_floors[_j].bbox_right)
                _minY=min(_minY,_floors[_j].bbox_top);_maxY=max(_maxY,_floors[_j].bbox_bottom)
            }
            var _size=(_roomBoss.type==Ammo.None || _roomBoss.type==Ammo.Shells)?96:160
            assert(_maxX-_minX==_size && _maxY-_minY==_size,
                "Weapon Mimic natural source melee/shell3 or bullet/bolt/explosive/energy5 geometry lost extent; type="+string(_roomBoss.type)+" size="+string([_maxX-_minX,_maxY-_minY]))
            var _new=scrNTTEFullWeaponMimicFixtureNew(all,_local)
            for(var _j=0;_j<array_length(_new);++_j) instance_destroy(_new[_j],false)
            var _complete=true
            for(var _j=0;_j<6;++_j) _complete=_complete && _seen[_j]
            if(_complete) break
        }
        for(var _i=0;_i<6;++_i) assert(_seen[_i],"Weapon Mimic natural RNG sweep missed one of the six room types")
    }
    finally {
        var _after=scrNTTEFullInstances(all)
        for(var _i=0;_i<array_length(_after);++_i) if(array_get_index(_before,_after[_i])<0) instance_destroy(_after[_i],false)
        for(var _i=0;_i<array_length(_hidden);++_i) instance_activate_object(_hidden[_i])
        scrNTTEFullAreaGeneratorRestore(_game);GameCont.ntte_full_active_coast=_active;random_set_seed(_seed)
        scrNTTEFullFloorSetStyle(_style,_area);scrNTTEFullFloorSetAlign(_aw,_ah,_ax,_ay)
    }
    scrNTTESmokeLog("WEAPON MIMIC ARENA: normal hard/RNG/nochest gates, farthest actual chest/curse, six source room geometries and PortalClear cleanup OK")
}
