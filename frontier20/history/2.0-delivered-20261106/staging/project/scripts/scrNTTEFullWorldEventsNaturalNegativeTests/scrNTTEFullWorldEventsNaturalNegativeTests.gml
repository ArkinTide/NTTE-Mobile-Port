// Real native context providers and GenCont.Create; no synthetic chance
// context, forced event activation or callback substitution. Depends on the
// independent natural-world capture/configuration helpers for full restoration.
function scrNTTEFullWorldEventsNaturalNegativeProfiles() {
    return [
        [area_sewers,2,101013,"crime locked",["GatorDen"]],
        [area_city,2,103038,"coast locked",["SealPlaza"]],
        [scrNTTEFullAreaId("trench"),2,108079,"trench locked",["EelGrave"]],
        [area_labs,2,104041,"empty pet history",["MutantVats"]],
        [area_desert,2,100004,"unmarked Scorpion",["ScorpionCity"]],
        [area_desert,2,100004,"crime bounty two",["GatorAmbush"]],
        [area_palace,3,106058,"unsafe final Palace",["GatorAmbush","PalaceShrine","PopoAmbush"]],
        [area_scrapyards,3,102029,"Scrap final subarea",["FirePit"]],
        [scrNTTEFullAreaId("coast"),3,107067,"Coast final subarea",["SeaCreature","BuriedVault"]],
        [area_palace,1,105049,"Shrine wrong subarea",["PalaceShrine"]],
        [area_palace,2,106058,"Popo wrong subarea",["PopoAmbush"]],
        [area_palace,1,105049,"police level five",["PopoAmbush"]],
        [area_palace,2,106058,"owned unarmed blessing",["PalaceShrine"]]]
}
function scrNTTEFullWorldEventsNaturalNegativeTests() {
    if(os_type!=os_windows || !scrNTTEFullSmokeEnabled()) throw "Natural negative fixture requires explicit desktop full smoke"
    var _state=scrNTTEFullWorldEventsNaturalWorldCapture(),_profiles=scrNTTEFullWorldEventsNaturalNegativeProfiles(),
        _fixture_skills=ds_list_create()
    try {
        assert(!instance_exists(Revive),"No-blessing native fixture requires no parked Revive loadout")
        for(var _p=0;_p<array_length(_profiles);++_p) {
            var _case=_profiles[_p]
            for(var _attempt=0;_attempt<32;++_attempt) {
                scrNTTEFullWorldEventsNaturalWorldConfigure(_state,_case,_case[2]+_attempt)
                global.ntte_full_sync_generation=true
                switch(_case[3]) {
                    case "crime locked":variable_struct_set(global.ntte_full_progress.unlocks,"crown:crime",false);break
                    case "coast locked":variable_struct_set(global.ntte_full_progress.unlocks,"pack:coast",false);break
                    case "trench locked":variable_struct_set(global.ntte_full_progress.unlocks,"pack:trench",false);break
                    case "empty pet history":GameCont.ntte_pet_history=[];break
                    case "unmarked Scorpion":with(NTTEFullPet) scorpion_city=0;break
                    case "crime bounty two":GameCont.ntte_crime_bounty=2;break
                    case "police level five":GameCont.popolevel=5;break
                    case "owned unarmed blessing":
                        // Original wep_none offers Last Wish. Having that real
                        // mutation already owned removes the sole unarmed
                        // candidate; empty slots alone are not a zero pool.
                        with(Player) {wep=wep_none;bwep=wep_none}
                        ds_list_clear(_fixture_skills);ds_list_add(_fixture_skills,mut_last_wish)
                        GameCont.skills=_fixture_skills;GameCont.ntte_full_native_skill_counts={}
                        break
                }
                var _gen=instance_create(0,0,GenCont)
                assert(_gen.ntte_full_sync_generation && _gen.ntte_full_events_setup,
                    "Negative real GenCont.Create bypassed original pre-generation selection")
                if(_case[3]=="unsafe final Palace") assert(!_gen.safespawn,
                    "Real Palace final-subarea safe-spawn prerequisite differs from its source")
                if(_case[3]=="owned unarmed blessing") {
                    assert(scrNTTEFullSkillGet(mut_last_wish)>0,"Actual unarmed fixture lost its already-owned Last Wish")
                    assert(array_length(scrNTTEFullPalaceShrineSkills())==0,
                        "Actual already-owned unarmed blessing provider unexpectedly supplied another skill")
                }
                for(var _i=0;_i<array_length(_case[4]);++_i)
                    assert(!instance_exists(scrNTTEFullWorldEventGet(_case[4][_i])),
                        "Natural forbidden event "+_case[4][_i]+" selected for "+_case[3]+" seed="+string(_case[2]+_attempt))
                scrNTTEFullWorldEventsCleanup()
                scrNTTEFullMergedRuntimeTestCleanup(_state.before)
            }
            scrNTTESmokeLog("WORLD NATURAL NEGATIVE "+_case[3]+" actual GenCont/context providers x32 OK")
        }
    }
    finally {scrNTTEFullWorldEventsNaturalWorldRestore(_state);ds_list_destroy(_fixture_skills)}
    scrNTTESmokeLog("FULL WORLD NATURAL NEGATIVES real native unlocks/pet history/Scorpion marker/bounty/safe spawn/subareas/police/blessings OK @"+string(30/timescale))
}
