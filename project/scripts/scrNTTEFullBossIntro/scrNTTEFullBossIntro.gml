// Reuse the native intro animation and pause controller. Only its three art
// lookups are redirected; the shared original sprites are never modified.
function scrNTTEFullBossIntro(_key, _allow_loop=false) {
    if (!instance_exists(GameCont) || !instance_exists(UberCont)) return false
    GameCont.ntte_full_boss_music_key=_key
    with (MusCont) { alarm[2]=1; alarm[3]=-1 }
    if (_key=="" || (!_allow_loop && GameCont.loops>0)) return false
    UberCont.ntte_full_intro_key=_key
    // Epsilon's equivalent of NTT BanditBoss Alarm6 is the native scrBossIntro.
    var _old_intro=UberCont.opt_bossintro;
    UberCont.opt_bossintro=scrNTTEFullOptionGet("intros");
    try {scrBossIntro(0)} finally {UberCont.opt_bossintro=_old_intro}
    if (!UberCont.bossintro) { UberCont.ntte_full_intro_key=""; return false }
    return true
}

function scrNTTEFullBossIntroActive() {
    return instance_exists(UberCont) && UberCont.bossintro
        && variable_instance_exists(UberCont,"ntte_full_intro_key")
        && UberCont.ntte_full_intro_key!=""
}

function scrNTTEFullBossIntroTick() {
    if (instance_exists(UberCont) && !UberCont.bossintro) UberCont.ntte_full_intro_key=""
}

function scrNTTEFullBossIntroSprite(_native_sprite) {
    if (!scrNTTEFullBossIntroActive()) return _native_sprite
    var _suffix=""
    if (_native_sprite==sprBossIntro) _suffix="Main"
    else if (_native_sprite==sprBossIntroBackLayer) _suffix="Back"
    else if (_native_sprite==sprBossName) _suffix="Name"
    else return _native_sprite
    return scrNTTERefSprite("Intro."+UberCont.ntte_full_intro_key+"."+_suffix)
}

function scrNTTEFullBossIntroFrame(_native_frame) {
    return scrNTTEFullBossIntroActive() ? 0:_native_frame
}

