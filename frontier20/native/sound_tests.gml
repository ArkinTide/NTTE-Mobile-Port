// Resource-copy compatibility plus one muted native playback/loop cycle.
function scrFRSoundAssignmentTests() {
    var _saved=global.fr_sound_replacements,_volume=UberCont.opt_sndvol,_voice=-1,_loop=-1;
    global.fr_sound_replacements={};
    var _a=sndWallBreakRock,_b=sndWallBreakLabs,_c=sndShotgun;
    try {
        // Actual Cove area_setup:237 performs this self-copy before walls
        // can be broken. It must not create an alias cycle or a new entry.
        scrFRSoundAssign(_a,_a);
        assert(scrFRSoundResolve(_a)==_a
            && !variable_struct_exists(global.fr_sound_replacements,string(_a)),
            "Cove sound self-copy changed the original wall sample");
        scrFRSoundAssign(_a,_b);
        scrFRSoundAssign(_a,_a);
        assert(scrFRSoundResolve(_a)==_b,"Self-copy discarded an assigned sample");
        scrFRSoundAssign(_b,_c);
        assert(scrFRSoundResolve(_a)==_b && scrFRSoundResolve(_b)==_c,
            "Sound assignment retained a live alias instead of a sample snapshot");
        scrFRSoundAssign(_b,_a);
        assert(scrFRSoundResolve(_a)==_b && scrFRSoundResolve(_b)==_b,
            "Reciprocal sound copy formed a logical alias cycle");
        scrFRSoundAssign(_c,_b);
        scrFRSoundRestore(_a);
        scrFRSoundRestore(_b);
        assert(scrFRSoundResolve(_a)==_a && scrFRSoundResolve(_b)==_b && scrFRSoundResolve(_c)==_b,
            "Restoring a sound changed previously copied samples");
        // Exercise the production rock->labs and Cove self-copy through the
        // native audio backend. Zero option gain keeps the fixture silent.
        global.fr_sound_replacements={};UberCont.opt_sndvol=0;
        scrFRSoundAssign(_a,_b);scrFRSoundAssign(_a,_a);
        _voice=scrFRSoundPlay(_a);
        assert(_voice!=-1 && audio_is_playing(_voice) && abs(audio_sound_get_gain(_voice))<0.0001,
            "Assigned sound did not create a muted native audio voice");
        audio_stop_sound(_voice);_voice=-1;
        _loop=scrFRSoundLoop(_a);
        assert(_loop>=0 && _loop!=_b && audio_is_playing(_loop) && audio_is_playing(_b),
            "Assigned sound loop did not return the actual voice of its captured physical sample");
        var _previous_loop=_loop;
        _loop=scrFRSoundLoop(_a);
        assert(_loop!=_previous_loop && !audio_is_playing(_previous_loop) && audio_is_playing(_loop),
            "Source sound_loop failed to stop and restart its assigned sample with a new voice");
        scrFRSoundStop(_loop);
        assert(!audio_is_playing(_loop),"Source sound_stop did not accept its actual loop voice");
        var _stopped_loop=_loop;
        _loop=scrFRSoundLoop(_a);
        assert(!audio_is_playing(_stopped_loop) && audio_is_playing(_loop),
            "A later loop of the same sample aliased an earlier stopped event voice");
        scrFRSoundStop(_a);_loop=-1;
        assert(!audio_is_playing(_b),"Source sound_stop did not stop its assigned physical sample");
        scrFRSoundHitExtTests();
        scrFRSoundSourceGainTests();
        scrFRSoundVoiceLifetimeTests();
        scrNTTESmokeLog("PASS FRONTIER packaged sound self-copy, snapshot, reciprocal assignment and independent restore");
    } finally {
        if(_voice!=-1) audio_stop_sound(_voice);
        if(_loop!=-1) audio_stop_sound(_loop);
        UberCont.opt_sndvol=_volume;global.fr_sound_replacements=_saved;
    }
}

function scrFRSoundVoiceLifetimeTests() {
    var _volume=UberCont.opt_sndvol,_emitter_gain=audio_emitter_get_gain(UberCont.mainsound),
        _voice=-1,_other=-1,_loop=-1;
    audio_emitter_gain(UberCont.mainsound,0);
    try {
        UberCont.opt_sndvol=1;
        // CarHonkController calls sound_volume before its first every() pulse.
        assert(scrFRSoundVolume(noone,.7)==noone && scrFRSoundVolume(-1,.7)==-1,
            "An authored not-yet-started sound acquired a native audio target");
        _voice=scrFRSoundPlay(sndShotgun);
        assert(_voice>=0 && audio_exists(_voice) && audio_is_playing(_voice),
            "Sound lifetime fixture did not obtain a real audio voice");
        scrFRSoundVolume(_voice,.65);
        assert(abs(audio_sound_get_gain(_voice)-.65)<.0001,
            "Sound lifetime guard rejected a live voice gain update");
        audio_stop_sound(_voice);
        assert(!audio_exists(_voice) && !audio_is_playing(_voice),
            "Stopped source sound voice did not retire from the native audio backend");
        _other=scrFRSoundPlay(sndShotgun);
        assert(_other>=0 && _other!=_voice && audio_is_playing(_other),
            "Sound lifetime fixture reused an expired voice as its next playback");
        var _gain=audio_sound_get_gain(_other),_pitch=audio_sound_get_pitch(_other);
        scrFRSoundVolume(_voice,0);scrFRSoundSetPitch(_voice,.5);
        scrFRSoundPosition(_voice,0);scrFRSoundStop(_voice);
        assert(audio_is_playing(_other) && abs(audio_sound_get_gain(_other)-_gain)<.0001
            && abs(audio_sound_get_pitch(_other)-_pitch)<.0001,
            "An expired sound handle edited or stopped a later voice of its sample");
        _loop=scrFRSoundLoop(sndWallBreakRock);
        scrFRSoundVolume(_loop,.4);
        assert(audio_is_playing(_loop) && abs(audio_sound_get_gain(_loop)-.4)<.0001,
            "Sound lifetime guard rejected a valid looping event voice");
        scrNTTESmokeLog("PASS FRONTIER silent noone / live / retired / restarted / looping voice controls");
    } finally {
        if(_voice>=0 && audio_exists(_voice)) audio_stop_sound(_voice);
        if(_other>=0 && audio_exists(_other)) audio_stop_sound(_other);
        if(_loop>=0 && audio_exists(_loop)) audio_stop_sound(_loop);
        UberCont.opt_sndvol=_volume;audio_emitter_gain(UberCont.mainsound,_emitter_gain);
    }
}

function scrFRSoundHitExtTests() {
    var _volume=UberCont.opt_sndvol,_positional=UberCont.opt_3Dsound,
        _emitter_gain=audio_emitter_get_gain(UberCont.mainsound),_seed=random_get_seed(),_voice=-1;
    // Compare real native hit voices with nonzero per-voice gain, while the
    // emitter itself remains silent for the entire synchronous fixture.
    audio_emitter_gain(UberCont.mainsound,0);
    try {
        UberCont.opt_3Dsound=false;UberCont.opt_sndvol=0.5;
        _voice=snd_play_hit(sndAssassinGetUp,0);
        assert(_voice!=-1 && audio_is_playing(_voice),"Frontier hit gain fixture requires a real native voice");
        var _native_gain=audio_sound_get_gain(_voice);
        assert(_native_gain>0,"Frontier hit gain fixture cannot accept a silent per-voice negative control");
        audio_stop_sound(_voice);_voice=-1;
        _voice=scrFRSoundHitExt(sndAssassinGetUp,1.35,1.2);
        assert(_voice!=-1 && audio_is_playing(_voice)
            && abs(audio_sound_get_gain(_voice)-_native_gain*1.2)<0.0001
            && abs(audio_sound_get_pitch(_voice)-1.35)<0.0001
            && audio_emitter_get_gain(UberCont.mainsound)==0,
            "Frontier extended hit did not multiply the actual native voice gain and source emphasis");
        scrNTTESmokeLog("PASS FRONTIER silent native hit gain baseline multiplied by source 1.2 with pitch preserved");
    } finally {
        if(_voice!=-1) audio_stop_sound(_voice);
        UberCont.opt_sndvol=_volume;UberCont.opt_3Dsound=_positional;
        audio_emitter_gain(UberCont.mainsound,_emitter_gain);random_set_seed(_seed);
    }
}

function scrFRSoundSourceGainTests() {
    var _volume=UberCont.opt_sndvol,_emitter_gain=audio_emitter_get_gain(UberCont.mainsound),_voice=-1;
    // The author uses gains above one. Exercise real channel values and the
    // lower boundary while the native emitter remains physically muted.
    audio_emitter_gain(UberCont.mainsound,0);
    try {
        UberCont.opt_sndvol=1;
        var _values=[1.2,2,-0.75];
        for(var _i=0;_i<array_length(_values);++_i) {
            var _gain=_values[_i],_expected=max(0,_gain);
            _voice=scrFRSoundPitchVolume(sndShotgun,1.15,_gain);
            assert(_voice!=-1 && audio_is_playing(_voice)
                && abs(audio_sound_get_gain(_voice)-_expected)<0.0001
                && abs(audio_sound_get_pitch(_voice)-1.15)<0.0001
                && audio_emitter_get_gain(UberCont.mainsound)==0,
                "Frontier source pitch/volume gain was truncated or its silent emitter changed");
            audio_stop_sound(_voice);_voice=-1;
        }
        _voice=scrFRSoundPlay(sndShotgun);
        assert(_voice!=-1 && audio_is_playing(_voice),"Frontier source volume fixture requires a real voice");
        for(var _i=0;_i<array_length(_values);++_i) {
            var _gain=_values[_i],_expected=max(0,_gain);
            assert(scrFRSoundVolume(_voice,_gain)==_voice
                && abs(audio_sound_get_gain(_voice)-_expected)<0.0001
                && audio_emitter_get_gain(UberCont.mainsound)==0,
                "Frontier source sound_volume did not retain authored gain or negative lower boundary");
        }
        var _pitches=[0,0.5,1.25];
        for(var _i=0;_i<array_length(_pitches);++_i) {
            var _pitch=_pitches[_i];
            audio_sound_pitch(_voice,_pitch);
            var _native_pitch=audio_sound_get_pitch(_voice);
            audio_sound_pitch(_voice,1);
            assert(scrFRSoundSetPitch(_voice,_pitch)==_voice
                && abs(audio_sound_get_pitch(_voice)-_native_pitch)*1000000<1,
                "Source sound_pitch changed the native backend's authored zero/fractional pitch behavior");
        }
        scrNTTESmokeLog("PASS FRONTIER silent native source gain1.2/2 and negative lower boundary, pitch/volume+live voice volume");
    } finally {
        if(_voice!=-1) audio_stop_sound(_voice);
        UberCont.opt_sndvol=_volume;audio_emitter_gain(UberCont.mainsound,_emitter_gain);
    }
}
