function scrNTTEFullEarlySystemsLevelNativeTests() {
    assert(scrNTTESmokeEnabled(),"Early level systems require explicit desktop fixture")
    var _before=scrNTTEFullInstances(all),_game=scrNTTEFullAreaGeneratorSnapshot(GameCont),
        _players=scrNTTEFullAreaGeneratorSnapshot(Player),_seed=random_get_seed(),_skills=ds_list_create(),_heldFloor=noone,
        _hidden=scrNTTEFullInstances([enemy,Floor,Wall,InvisiWall,GenCont,LevCont,WepPickup,
            NTTEFullWorldEvent,PizzaEntrance,NTTEFullWepPickupGrounded,CrownObject])
    for(var _i=0;_i<array_length(_hidden);++_i) instance_deactivate_object(_hidden[_i])
    GameCont.skills=_skills;GameCont.ntte_full_native_skill_counts={}
    GameCont.ntte_full_skills={};GameCont.ntte_full_skill_order=[]
    GameCont.ultra_got=json_parse(json_stringify(GameCont.ultra_got))
    try {
        var _p=instance_find(Player,0)
        with(Player) {x=96000;y=96000;xprevious=x;yprevious=y;wep=wep_revolver;bwep=wep_none;race=Race.Fish;curse=0;bcurse=0;}
        GameCont.crown=Crown.None;GameCont.loops=0
        var _guitar=scrWeaponPickupCreate(91000,91000,wep_guitar),
            _sword=scrWeaponPickupCreate(91200,91000,wep_black_sword),
            _rolled=scrWeaponPickupCreate(91400,91000,wep_guitar),
            _ordinary=scrWeaponPickupCreate(91600,91000,wep_revolver)
        _guitar.roll=false;_sword.roll=false;_rolled.roll=true
        _guitar.x+=100;_sword.y+=100;_p.nearwep=_guitar
        assert(scrNTTEFullGroundedLevelStart()==2 && instance_number(NTTEFullWepPickupGrounded)==2
            && _p.nearwep==noone,"Natural source Guitar/Sword filter or stale near-weapon clearing changed")
        with(NTTEFullWepPickupGrounded) {
            assert(target==_guitar || target==_sword,"Grounded unrelated/rolling weapon")
            // Source placement first runs move_contact_solid and then a
            // separate 32px budge. Their sum has no 32px final-distance
            // bound. Native construction origins directly verify the source
            // xstart/ystart inputs without constraining its real placement.
            assert(xstart==target.xstart && ystart==target.ystart
                && (target.x!=xstart || target.y!=ystart),
                "Grounded wrapper used displaced pickup current position rather than original start")
            scrNTTEFullGroundedWeaponEndStep()
            assert(target.image_alpha==0 && target.speed==0,"Natural grounded wrapper did not own actual physical pickup")
        }
        // The original has two independent bounty if-statements: an active
        // bounty also executes the final 90/10 alert refresh of the second.
        GameCont.crown=NTTEFullCrown.Crime;GameCont.ntte_crime_bounty=2;GameCont.ntte_crime_active=true
        assert(scrNTTEFullCrimeLevelStart(true) && !GameCont.ntte_crime_active
            && GameCont.ntte_crime_enemy_count==2 && GameCont.ntte_crime_enemy_delay>=300
            && GameCont.ntte_crime_enemy_delay<=450,"Natural Crime entry lost hunters/delay/active reset")
        var _alerts=_p.ntte_crime_alert
        assert(array_length(_alerts)==2 && _alerts[0].alert_hold==90 && _alerts[1].blink==10
            && _alerts[0].snd_flash==sndAppear,"Crime normalized away source independent-if alert refresh")
        GameCont.ntte_crime_bounty=3;GameCont.ntte_crime_active=false
        scrNTTEFullCrimeLevelStart(true)
        assert(GameCont.ntte_crime_bounty==2 && _alerts[1].alert_hold==120
            && _alerts[1].snd_flash==sndIcicleBreak && _alerts[1].flash>=30,
            "Natural inactive Crime bounty did not decay with old-fill alert")
        var _ambush=instance_create(0,0,NTTEFullWorldEvent)
        _ambush.event_name="GatorAmbush"
        GameCont.ntte_crime_bounty=3;GameCont.ntte_crime_active=true
        scrNTTEFullCrimeLevelStart(true)
        assert(GameCont.ntte_crime_bounty==0 && GameCont.ntte_crime_enemy_count==3,
            "Natural Crime did not use actual GatorAmbush controller to clear bounty")
        instance_destroy(_ambush,false);GameCont.crown=Crown.None
        var _entrance=instance_create(92000,92000,PizzaEntrance),_mx=(_entrance.bbox_left+_entrance.bbox_right)/2,
            _my=(_entrance.bbox_top+_entrance.bbox_bottom)/2,_holes=instance_number(NTTEFullManhole)
        assert(scrNTTEFullManholeLevelStart()==1 && !instance_exists(_entrance)
            && instance_number(NTTEFullManhole)==_holes+1,"Natural PizzaEntrance was not replaced with source Manhole")
        var _hole=instance_nearest(_mx,_my,NTTEFullManhole)
        assert(_hole.x==_mx && _hole.y==_my && _hole.area==scrNTTEFullAreaId("pizza")
            && !_hole.contact && !_hole.ntte_full_loops,"Natural regular Manhole lost bbox position/default destination")
        // Source chance draw occurs even on a nonnormal area; no floor scan
        // or spawn can follow that false eligibility test.
        GameCont.hard=5;GameCont.area=area_desert
        random_set_seed(222);random(12);var _expected=random(1000)
        random_set_seed(222)
        assert(scrNTTEFullBackpackLevelStart(false)==0 && random(1000)==_expected,
            "Backpack checked normal-area eligibility before its source 1/12 draw")
        var _floor=instance_create(96200,96000,Floor),_backpacks=instance_number(NTTEFullBackpack),
            _corpses=instance_number(NTTEFullBackpacker),_clears=instance_number(PortalClear),_chosenSeed=-1
        for(var _s=1;_s<1000;++_s) {random_set_seed(_s);if(random(12)<1) {_chosenSeed=_s;break;}}
        assert(_chosenSeed>=0,"Could not select a native deterministic Backpack chance seed")
        GameCont.ntte_backpack_opened=false
        random_set_seed(_chosenSeed)
        assert(scrNTTEFullBackpackLevelStart(true)==1 && instance_number(NTTEFullBackpack)==_backpacks+1
            && instance_number(NTTEFullBackpacker)==_corpses+1 && instance_number(PortalClear)==_clears+1,
            "Natural normal-area Backpack lost exact ordinary chest, flavor corpse or PortalClear")
        var _corpse=instance_nearest(_floor.x,_floor.y,NTTEFullBackpacker)
        assert(_corpse.wep=="crabbone","Natural Backpacker lost original physical Crabbone source model")
        instance_deactivate_object(_floor);_heldFloor=_floor
        // Campfire counts both living/revivable Rogue bodies; source Open
        // Mind is a numeric stack and adds after max(1, Rogue body count).
        GameCont.area=area_campfire;GameCont.hard=5;GameCont.loops=1
        var _camp=instance_create(96600,96000,Floor),_revive=instance_create(96800,96000,Revive)
        _revive.race=Race.Rogue;_revive.wep=wep_none;_revive.bwep=wep_none
        _p.race=Race.Rogue;_p.wep=wep_rogue_rifle;_p.bwep=wep_revolver
        scr_skill_set(mut_open_mind,2)
        var _rogueCount=instance_number(NTTEFullRogueBackpack),_corpseCount=instance_number(NTTEFullBackpacker)
        assert(scrNTTEFullBackpackLevelStart(false)==4 && instance_number(NTTEFullRogueBackpack)==_rogueCount+4
            && instance_number(NTTEFullBackpacker)==_corpseCount,
            "Campfire did not count living+Revive Rogue/OpenMind stack or incorrectly made a corpse")
        var _rogue=instance_nearest(_camp.x,_camp.y,NTTEFullRogueBackpack),
            _wraps=instance_number(NTTEFullBackpackPickup),_explo=instance_number(PopoExplosion)
        with(_rogue) scrNTTEFullCustomChestOpen(_p)
        assert(!instance_exists(_rogue) && _p.wep==wep_ntte_rogue_carbine && _p.bwep==wep_revolver
            && is_struct(_p.ntte_state) && instance_number(NTTEFullBackpackPickup)==_wraps+2
            && instance_number(PopoExplosion)==_explo+1,"Actual Rogue backpack open lost real ammo wrappers or main rifle upgrade")
        var _blast=instance_nearest(_camp.x,_camp.y,PopoExplosion)
        assert(_blast.creator==_p && _blast.team==_p.team && _blast.sprite_index==sprRogueExplosion
            && _blast.mask_index==mskExplosion,"Rogue upgrade explosion lost player ownership/original art/mask")
        var _targets=0
        with(NTTEFullBackpackPickup) if(instance_is(target,RogueAmmo)) {_targets++;}
        assert(_targets==2,"Rogue backpack wrappers did not contain real native strike ammo")
        _p.wep=wep_revolver;_p.bwep=wep_rogue_rifle
        _rogue=instance_create(97000,96000,NTTEFullRogueBackpack)
        with(_rogue) scrNTTEFullCustomChestOpen(_p)
        assert(_p.wep==wep_revolver && _p.bwep==wep_ntte_rogue_carbine && is_struct(_p.bntte_state)
            && _p.drawemptyb==30,"Actual Rogue backpack did not upgrade the physical secondary slot")
        GameCont.ultra_got[Race.Rebel,UltraSkill.Riot]=2
        var _ally=instance_create(97200,96000,NTTEFullAllyBackpack)
        assert(_ally.ally==3 && _ally.curse==0 && _ally.sprite_index==scrNTTERefSprite("AllyBackpack")
            && _ally.spr_dead==scrNTTERefSprite("AllyBackpackOpen") && is_callable(_ally.on_open),
            "Actual AllyBackpack lost inherited rewards, source Riot stack, zero curse or artwork")
        scrNTTESmokeLog("PASS early natural Grounded Guitar/Sword/roll/start/quiet, Crime hunters+source independent-alert chain/decay/actual Ambush, PizzaEntrance->physical Manhole, Backpack source RNG/normal+Campfire candidates/Revive+OpenMind/corpse/clear, real Rogue main+secondary upgrades/ammo wrappers/player explosion, actual Ally Riot constructor")
    }
    finally {
        // The successful ordinary fixture floor was intentionally inactive.
        if(_heldFloor!=noone) instance_activate_object(_heldFloor)
        var _all=scrNTTEFullInstances(all)
        for(var _i=array_length(_all)-1;_i>=0;--_i)
            if(array_get_index(_before,_all[_i])<0 && instance_exists(_all[_i])) instance_destroy(_all[_i],false)
        for(var _i=0;_i<array_length(_hidden);++_i) instance_activate_object(_hidden[_i])
        scrNTTEFullAreaGeneratorRestore(_players);scrNTTEFullAreaGeneratorRestore(_game)
        random_set_seed(_seed);ds_list_destroy(_skills)
    }
}
