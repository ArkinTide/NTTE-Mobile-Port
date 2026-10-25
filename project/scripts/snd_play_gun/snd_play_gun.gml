/// @function snd_play_gun
/// @param {Asset.GMSound} sound_index
/// @param random_pitch=0.2
function snd_play_gun(_sound_index, _random_pitch = 0.2) {
    if scr_test_is_fps_uncapped() return -1
	
	if GameCont.underwater && _sound_index != sndOasisMelee {
        _sound_index = sndOasisShoot
	}
	
    _sound_index = custom_sound_check(_sound_index)
    
    with UberCont {
        mainvol = 0.3
	    audio_emitter_gain(mainsound, mainvol)
    }

    audio_stop_sound(_sound_index)
    
    var _pitch = ((1 + random(_random_pitch)) - (_random_pitch / 2))
    if(scrNTTEFullChestPreviewSoundMuted() || !audio_exists(_sound_index)) return -1;
    return audio_play_sound(_sound_index, 2, false, UberCont.opt_sndvol, 0, _pitch)
}
function scrNTTEFullWeaponSoundNativeTests() {
    var _uber=scrNTTEFullAreaGeneratorSnapshot(UberCont),_game=scrNTTEFullAreaGeneratorSnapshot(GameCont),
        _gain=audio_emitter_get_gain(UberCont.mainsound),_seed=random_get_seed(),_voice=-1;
    try {
        GameCont.underwater=false;UberCont.opt_sndvol=0.5;
        var _functions=[snd_play_gun,snd_play_gun_big,snd_play_gun_small],_ducks=[0.3,0.33,0.6];
        for(var _i=0;_i<array_length(_functions);++_i) {
            _voice=_functions[_i](sndShotgun,0);
            assert(_voice!=-1 && audio_is_playing(_voice),"Weapon sound test needs real audio backend");
            assert(abs(audio_sound_get_gain(_voice)-0.5)<0.001 && audio_sound_get_pitch(_voice)==1,
                "Weapon sound applied option volume twice or changed pitch");
            assert(abs(UberCont.mainvol-_ducks[_i])<0.001,"Weapon sound changed authored background ducking");
            audio_stop_sound(_voice);_voice=-1;
        }
        scrNTTESmokeLog("WEAPON AUDIO: 3 real independent voices, option gain0.5 applied once/pitch1 and background duck unchanged; phone listening untested");
    } finally {
        if(_voice!=-1) audio_stop_sound(_voice);
        scrNTTEFullAreaGeneratorRestore(_uber);scrNTTEFullAreaGeneratorRestore(_game);
        audio_emitter_gain(UberCont.mainsound,_gain);random_set_seed(_seed);
    }
}
