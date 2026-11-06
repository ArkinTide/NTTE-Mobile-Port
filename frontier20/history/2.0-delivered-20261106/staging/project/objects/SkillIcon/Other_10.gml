// BEGIN NTTE LAIR BATTLE EXIT READONLY PROBE SkillIcon.Select.before
if(os_type==os_windows && scrNTTEFullSmokeEnabled() && instance_exists(id)
    && instance_exists(NTTEFullLairBattleExitNaturalTest))
    scrNTTEFullLairBattleExitProbe("SkillIcon.Select.before");
// END NTTE LAIR BATTLE EXIT READONLY PROBE SkillIcon.Select.before
/// @description Select

GameCont.skillpoints --

scr_skill_set(skill, scr_skill_get(skill) + 1)
scrNTTEFullRerollChosen(skill)
snd_play(GameCont.underwater ? sndOasisShoot : scr_skill_get_sound(skill))
scrLevelUpScreenSubmit(loc("Skills", skill, "Name", scr_skill_get_name(skill)))

// BEGIN NTTE LAIR BATTLE EXIT READONLY PROBE SkillIcon.Select.after
if(os_type==os_windows && scrNTTEFullSmokeEnabled()
    && instance_exists(NTTEFullLairBattleExitNaturalTest))
    scrNTTEFullLairBattleExitProbe("SkillIcon.Select.after");
// END NTTE LAIR BATTLE EXIT READONLY PROBE SkillIcon.Select.after