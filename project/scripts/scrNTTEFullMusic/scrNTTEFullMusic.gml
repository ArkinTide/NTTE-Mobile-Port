// Original ntte_music: intro plays while a looping main track is muted. The
// main track is reset to zero only when intro finishes. Handles are kept apart
// from asset IDs so changing the volume cannot unmute the main track early.
function scrNTTEFullMusicResolve(_sound) {
    return is_string(_sound) ? scrNTTERefSound(_sound):_sound;
}
function scrNTTEFullMusicCancelIntro() {
    if(variable_instance_exists(id,"ntte_full_music_intro") && ntte_full_music_intro>=0) {
        audio_stop_sound(ntte_full_music_intro);
    }
    ntte_full_music_intro=-1;
    ntte_full_music_target=-1;
    ntte_full_music_area=instance_exists(GameCont) ? GameCont.area:-1;
}
function scrNTTEFullMusicStart(_main,_intro="") {
    scrNTTEFullMusicCancelIntro();
    if(audio_exists(song)) audio_stop_sound(song);
    song=scrNTTEFullMusicResolve(_main);
    music_sound=snd_play_music(song,true);
    if(_intro!="" && music_sound>=0) {
        var _sound=scrNTTEFullMusicResolve(_intro);
        if(audio_exists(_sound)) {
            ntte_full_music_intro=audio_play_sound(_sound,128,false);
            ntte_full_music_target=music_sound;
            if(ntte_full_music_intro>=0) {
                audio_sound_gain(music_sound,0,0);
                audio_sound_gain(ntte_full_music_intro,UberCont.opt_musvol,0);
            } else ntte_full_music_target=-1;
        }
    }
}
function scrNTTEFullMusicBoss() {
    if(!instance_exists(GameCont)) return false;
    var _key=scrNTTEFullValue(GameCont,"ntte_full_boss_music_key",""),_main="",_intro="";
    // GameCont persists across areas. A previous custom boss must not replace
    // a native boss's track (for example PitSquid -> the Throne).
    if((_key=="CatBat" && GameCont.area!=204) || ((_key=="SealKing" || _key=="Palanking") && GameCont.area!=201)
        || (_key=="PitSquid" && GameCont.area!=205)
        || (_key=="Tesseract" && GameCont.area!=206 && !instance_exists(NTTEFullTesseract))) return false;
    switch(_key) {
        case "CatBat": _main="mus.BigShots"; _intro="mus.BigShotsIntro"; break;
        // Palanking is the source object's/intro art's name; SealKing is the track.
        case "Palanking": case "SealKing": _main="mus.SealKing"; break;
        case "Tesseract": _main="mus.Tesseract"; _intro="mus.TesseractIntro"; break;
        case "PitSquid":
            _main="mus.PitSquid"; _intro="mus.PitSquidIntro";
            // areas/trench.area.gml: inspect live bosses at the alarm, rather
            // than a persistent flag that can outlive a boss or never be set.
            var _pre=false;
            with(NTTEFullPitSquid) if(!ntte_full_intro && ntte_full_can_intro && ntte_full_rise_delay<=0) _pre=true;
            if(_pre) {
                _main="mus.PitSquidIntroLoop"; _intro="mus.PitSquidIntroStart";
            }
            break;
    }
    if(_main=="") return false;
    // Source sound_play_music keeps a playing identical cue. In particular,
    // the emergence/visual-intro callback must not replay the battle intro
    // already requested at the beginning of the 60-tick rise delay.
    if(song==scrNTTEFullMusicResolve(_main) && music_sound>=0 && audio_is_playing(music_sound)
        && scrNTTEFullValue(id,"ntte_full_music_area",-1)==GameCont.area) return true;
    if(audio_exists(amb)) audio_stop_sound(amb);
    scrNTTEFullMusicStart(_main,_intro);
    // Native boss-dead behavior remains responsible for the later cue.
    oldarea=-1;
    return true;
}
function scrNTTEFullMusicArea() {
    if(!instance_exists(GameCont)) return false;
    var _info=scrNTTEFullAreaInfo(GameCont.area);
    if(is_undefined(_info)) return false;
    if(oldarea!=GameCont.area || !audio_is_playing(song) || !audio_is_playing(amb)) {
        if(audio_exists(amb)) audio_stop_sound(amb);
        GameCont.ntte_full_boss_music_key="";
        scrNTTEFullMusicStart(GameCont.proto ? _info.music_b:_info.music);
        amb=_info.ambient;
        snd_play_ambience(amb,true);
        oldarea=GameCont.area;
    }
    return true;
}
function scrNTTEFullMusicStep() {
    if(!variable_instance_exists(id,"ntte_full_music_intro")) return;
    var _intro=ntte_full_music_intro,_target=ntte_full_music_target;
    if(_intro<0) return;
    // A native music transition or room change supersedes the intro.
    if(!instance_exists(GameCont) || GameCont.area!=ntte_full_music_area || music_sound!=_target || !audio_is_playing(_target)) {
        scrNTTEFullMusicCancelIntro();
        return;
    }
    if(audio_is_playing(_intro)
       && audio_sound_get_track_position(_intro)+1/room_speed<audio_sound_length(_intro)) {
        audio_sound_gain(_target,0,0);
        audio_sound_gain(_intro,UberCont.opt_musvol,0);
    } else {
        audio_sound_set_track_position(_target,0);
        audio_sound_gain(_target,UberCont.opt_musvol,0);
        scrNTTEFullMusicCancelIntro();
    }
}
