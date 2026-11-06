// Dedicated scheduled observer. Never advances image_index or invokes a
// production animation/Step/Alarm/Destroy event manually.
function scrNTTEFullTrenchBubbleLifecycleTests() {
    assert(os_type==os_windows && scrNTTEFullSmokeEnabled(),"Bubble lifecycle needs explicit desktop smoke")
    var _object=asset_get_index("NTTEFullTrenchBubbleLifecycleTest")
    assert(object_exists(_object) && !instance_exists(_object),"Bubble lifecycle observer missing/duplicated")
    var _observer=instance_create(0,0,_object)
    with(_observer) {
        restored=false;old_save_map=UberCont.saveData;fixture_save_map=ds_map_create()
        ds_map_copy(fixture_save_map,old_save_map);UberCont.saveData=fixture_save_map
        state=scrNTTEFullWorldEventsNaturalWorldCapture()
        rate=game_get_speed(gamespeed_fps)
        assert((rate==30 || rate==60) && abs(timescale-30/rate)<0.0001,"Bubble lifecycle requires actual30/60")
        player=instance_find(Player,0);phase=0;scenario=0;elapsed=0;draw_frames=0;draw_start=0
        peak_bubbles=0;peak_small=0;armor_triggers=0;next_shot=0
        global.ntte_full_progress=json_parse(json_stringify(state.progress))
        GameCont.area=area_desert;GameCont.lastarea=area_desert;GameCont.underwater=true
        GameCont.crown=Crown.None;GameCont.gocrib=false;GameCont.nochest=1;GameCont.noradch=1
        UberCont.opt_autopause=false;UberCont.paused=false;UberCont.want_pause=false
        UberCont.opt_freeze=0;UberCont.opt_bossintro=false;UberCont.opt_prtcls=true
        scrNTTEFullFloorResetStyle();scrNTTEFullFloorResetAlign()
        player.x=18000;player.y=18000;player.xprevious=player.x;player.yprevious=player.y
        player.speed=0;player.can_walk=false;player.can_aim=false
        player.hp=100000;player.max_hp=100000;player.nexthurt=current_frame+100000
        player.ntte_pet=[];player.ntte_pet_max=1
        scr_camera_set_position(player.x,player.y,fa_center,fa_middle)
        scrNTTEFullFloorFill(player.x,player.y,9,9)
    }
}
function scrNTTEFullTrenchBubbleLifecycleFinish() {
    if(restored) return;
    restored=true
    scrNTTEFullWorldEventsNaturalWorldRestore(state)
    UberCont.saveData=old_save_map
    if(ds_exists(fixture_save_map,ds_type_map)) ds_map_destroy(fixture_save_map)
}
function scrNTTEFullTrenchBubbleLifecycleEmpty() {
    return instance_number(Bubble)==0 && instance_number(NTTEFullBubbleExplosion)==0
        && instance_number(NTTEFullBubbleExplosionSmall)==0
}
function scrNTTEFullTrenchBubbleLifecycleStepBody() {
    assert(game_get_speed(gamespeed_fps)==rate && abs(timescale-30/rate)<0.0001,
        "Bubble lifecycle changed native30/60 rate")
    player.speed=0;player.can_walk=false;player.can_aim=false
    player.hp=100000;player.nexthurt=current_frame+100000
    if(phase==0) {
        assert(scrNTTEFullTrenchBubbleLifecycleEmpty(),"Bubble lifecycle started with unrelated live bubbles")
        elapsed=0;draw_start=draw_frames;peak_bubbles=0;peak_small=0
        GameCont.crown=scenario==1?Crown.Death:Crown.None
        var _big=instance_create(player.x+64,player.y,NTTEFullBubbleExplosion),
            _small=instance_create(player.x+96,player.y,NTTEFullBubbleExplosionSmall)
        _big.team=team_player;_small.team=team_player
        assert(instance_number(Bubble)==35 && instance_number(NTTEFullBubbleExplosion)==1
            && instance_number(NTTEFullBubbleExplosionSmall)==1,
            "Actual underwater large/small constructors changed source30+5 cosmetic count")
        phase=1;return;
    }
    elapsed+=timescale
    assert(elapsed<600,"Bubble natural lifecycle timed out phase="+string(phase))
    peak_bubbles=max(peak_bubbles,instance_number(Bubble))
    peak_small=max(peak_small,instance_number(NTTEFullBubbleExplosionSmall))
    if(phase==1) {
        if(scenario==0) assert(peak_small<=1 && peak_bubbles<=35,"Uncrowned bubbles replicated without an emitter")
        else assert(peak_small<=4 && peak_bubbles<=50,"Death crown generated more than one2/3-small child wave")
        if(elapsed<90) return;
        assert(scrNTTEFullTrenchBubbleLifecycleEmpty() && draw_frames-draw_start>=30,
            "Real Bubble/Explosion animation-end events did not clear within90 source ticks")
        if(scenario==1) assert(peak_small>=3,"Actual large-bubble EndStep omitted source death-crown children")
        scrNTTESmokeLog("BUBBLE NATURAL animation/crown="+string(scenario)+" peaks="+string([peak_bubbles,peak_small])
            +" allCleared90ticks=true actualDraws="+string(draw_frames-draw_start)+" @"+string(rate))
        if(++scenario<2) {phase=0;return;}
        GameCont.crown=Crown.None
        pet_inst=scrNTTEFullPetCreate(player.x+24,player.y,"Slaughter")
        assert(scrNTTEFullPetTake(pet_inst,player),"Natural bubble fixture could not take source Slaughterfish")
        initial_bites=pet_inst.stat.bites;elapsed=0;phase=2;return;
    }
    assert(instance_exists(pet_inst),"Measured Slaughterfish disappeared")
    if(phase==2) {
        if(pet_inst.sprite_index==pet_inst.spr_spwn) return;
        enemy_witness=instance_create(pet_inst.x+24,pet_inst.y,Bandit)
        enemy_witness.hp=1000;enemy_witness.max_hp=1000;enemy_witness.alarm[1]=-1
        // A stationary, non-shooting external target. Pet alarm, target choice,
        // animation and bite frame remain controlled by production code.
        phase=3;elapsed=0;return;
    }
    if(phase==3) {
        enemy_witness.speed=0;enemy_witness.walk=0;enemy_witness.alarm[1]=-1
        if(pet_inst.stat.bites==initial_bites) return;
        assert(pet_inst.stat.bites==initial_bites+1 && instance_number(NTTEFullBubbleExplosionSmall)==3,
            "Natural Slaughterfish bite did not produce exactly three source small explosions")
        instance_destroy(enemy_witness,false)
        phase=4;elapsed=0;return;
    }
    if(phase==4) {
        if(elapsed<90) return;
        assert(scrNTTEFullTrenchBubbleLifecycleEmpty(),"Natural bite particles accumulated after external target removal")
        phase=5;elapsed=0;next_shot=0;armor_triggers=0;last_armor=pet_inst.nextexplo
        peak_bubbles=0;peak_small=0;return;
    }
    if(phase==5) {
        if(pet_inst.nextexplo!=last_armor) {
            assert(pet_inst.nextexplo>=last_armor+6,"Slaughterfish bubble armor reentered within six source ticks")
            last_armor=pet_inst.nextexplo;armor_triggers++
        }
        if(elapsed<180) {
            if(elapsed>=next_shot) {
                next_shot=elapsed+1
                var _shot=instance_create(pet_inst.x,pet_inst.y,EnemyBullet1)
                _shot.team=team_enemy;_shot.speed=0;_shot.creator=noone
            }
            return;
        }
        assert(armor_triggers>=5,"Scheduled real hostile projectile collisions did not exercise sustained source bubble armor")
        // Stop the external fire; do not destroy a measured bubble or change
        // its animation. Every remaining emitter/particle must expire itself.
        phase=6;elapsed=0;return;
    }
    if(phase==6) {
        if(elapsed<120) return;
        assert(scrNTTEFullTrenchBubbleLifecycleEmpty(),"Slaughterfish bubbles stayed/replicated after real incoming fire stopped")
        var _rate=rate,_triggers=armor_triggers,_peaks=[peak_bubbles,peak_small],_draws=draw_frames
        scrNTTEFullTrenchBubbleLifecycleFinish()
        scrNTTESmokeLog("FULL TRENCH BUBBLE NATURAL actual30/60 animation-end + single death-crown wave + source three-small bite + sustained real projectile armor/6tick gate + post-fire total extinction OK @"
            +string(_rate)+" armorTriggers="+string(_triggers)+" peaks="+string(_peaks)+" Draws="+string(_draws)+"; mobile device not tested")
        instance_destroy(id,false)
    }
}
function scrNTTEFullTrenchBubbleLifecycleStep() {
    try {scrNTTEFullTrenchBubbleLifecycleStepBody()}
    catch(_error) {scrNTTEFullTrenchBubbleLifecycleFinish();throw _error}
}
