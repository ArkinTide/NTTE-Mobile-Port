// Audio-only addon to the frozen, actual native Cuz connected chain.
// Observations never request playback or modify gameplay/controller fields.
function scrNTTEFullCuzMusicOwner() {
    var _o=instance_find(NTTEFullCuzConnectedTest,0)
    if(!instance_exists(_o) || !variable_instance_exists(_o,"ntte_cuz_audio")) return noone
    return _o
}
function scrNTTEFullCuzMusicAudioRequired() {
    for(var _i=1;_i<=parameter_count();++_i)
        assert(parameter_string(_i)!="-noaudio","CUZ AUDIO PRECONDITION: -noaudio forbidden; run -EnableAudio")
    assert(audio_exists(custom_sound_check(mus107)),"CUZ AUDIO PRECONDITION: resolved mus107 is not loaded")
}
function scrNTTEFullCuzMusicConnectedTests() {
    assert(os_type==os_windows && scrNTTEFullSmokeEnabled(),"Cuz audio requires dedicated Windows smoke")
    scrNTTEFullCuzMusicAudioRequired()
    scrNTTEFullCuzConnectedTests()
    var _o=instance_find(NTTEFullCuzConnectedTest,0)
    _o.ntte_cuz_audio={current:undefined,passed:[]}
    scrNTTESmokeLog("CUZ AUDIO armed frozen connected chain; -noaudio rejected; actual30/60 required; no audible/iPhone claim")
}
function scrNTTEFullCuzMusicSnapshot(_stage) {
    // Hooks bind this entire call chain to the surviving persistent observer.
    var _o=id,_m=instance_find(MusCont,0)
    assert(instance_exists(_o) && object_index==NTTEFullCuzConnectedTest
        && variable_instance_exists(_o,"ntte_cuz_audio"),"CUZ AUDIO OBSERVER: snapshot must execute on the live persistent observer")
    var _a=_o.ntte_cuz_audio.current
    assert(is_struct(_a),"CUZ AUDIO OBSERVER: snapshot lacks current measured audio record")
    var _voice=_a.voice,_playing=_voice>=0 && audio_is_playing(_voice)
    var _out={stage:_stage,frame:current_frame,pass:_o.pass_index,rate:_o.rates[_o.pass_index],
        phase:_o.phase,muscont:_m,controllers:instance_number(MusCont),target:_a.target,
        target_loaded:audio_exists(_a.target),target_playing:audio_is_playing(_a.target),
        voice:_voice,voice_playing:_playing,position:_playing?audio_sound_get_track_position(_voice):-1,
        gen:instance_exists(GenCont),gen_creates:_o.gen_creates,gen_destroys:_o.gen_destroys,
        room_starts:_o.room_starts,room_ends:_o.room_ends}
    if(instance_exists(_m)) {
        _out.song=_m.song;_out.song_resolved=custom_sound_check(_m.song);_out.music_sound=_m.music_sound
        _out.amb=_m.amb;_out.amb_playing=audio_is_playing(_m.amb);_out.oldarea=_m.oldarea
        _out.alarms=[_m.alarm[0],_m.alarm[1],_m.alarm[2],_m.alarm[3],_m.alarm[4],_m.alarm[5],_m.alarm[6],_m.alarm[11]]
        _out.intro=scrNTTEFullValue(_m,"ntte_full_music_intro",-1)
        _out.intro_target=scrNTTEFullValue(_m,"ntte_full_music_target",-1)
    }
    _out.area=instance_exists(GameCont)?GameCont.area:-1
    scrNTTESmokeLog("CUZ AUDIO OBS "+json_stringify(_out))
    return _out
}
function scrNTTEFullCuzMusicDeathBefore(_who) {
    var _o=scrNTTEFullCuzMusicOwner()
    if(!instance_exists(_o) || !_o.measuring || _who!=_o.owner) return;
    scrNTTEFullCuzMusicAudioRequired()
    assert(instance_number(MusCont)==1,"CUZ AUDIO PRECONDITION: exactly one actual music controller required")
    var _m=instance_find(MusCont,0),_target=custom_sound_check(mus107),_old=custom_sound_check(_m.song)
    assert(_old!=_target && !audio_is_playing(_target),"CUZ AUDIO PRECONDITION: mus107 already selected/playing before death")
    assert(audio_exists(_old) && audio_is_playing(_old),"CUZ AUDIO PRECONDITION: actual prior area music must be playing")
    var _a={pass:_o.pass_index,target:_target,old_song:_old,controller:_m,voice:-1,calls:[],
        before:undefined,returned:undefined,in_takeover:false,steps:0,initial_position:-1,passed:false}
    _o.ntte_cuz_audio.current=_a
    _a.death_before=scrNTTEFullCuzMusicSnapshot("Player.Destroy.before")
}
function scrNTTEFullCuzMusicDeathAfter(_who) {
    var _o=scrNTTEFullCuzMusicOwner()
    if(!instance_exists(_o) || _who!=_o.owner || !is_struct(_o.ntte_cuz_audio.current)) return;
    _o.ntte_cuz_audio.current.death_after=scrNTTEFullCuzMusicSnapshot("Player.Destroy.after")
}
function scrNTTEFullCuzMusicTakeoverBefore(_pet) {
    var _o=scrNTTEFullCuzMusicOwner()
    if(!instance_exists(_o) || !_o.measuring || _pet!=_o.pet) return;
    var _a=_o.ntte_cuz_audio.current
    assert(is_struct(_a) && _a.pass==_o.pass_index && !is_struct(_a.before),"CUZ AUDIO missing real owner-death observation/duplicate takeover")
    _a.in_takeover=true;_a.before=scrNTTEFullCuzMusicSnapshot("Takeover.before")
    assert(!_a.before.target_playing,"CUZ AUDIO target was already playing before the actual takeover cue")
}
function scrNTTEFullCuzMusicNativeCall(_asset,_looped,_voice) {
    var _o=scrNTTEFullCuzMusicOwner()
    if(!instance_exists(_o) || !is_struct(_o.ntte_cuz_audio.current)) return;
    var _a=_o.ntte_cuz_audio.current
    if(!_a.in_takeover) return;
    var _call={asset:_asset,looped:_looped,voice:_voice,frame:current_frame}
    array_push(_a.calls,_call);_a.voice=_voice
    scrNTTESmokeLog("CUZ AUDIO NATIVE CALL "+json_stringify(_call))
}
function scrNTTEFullCuzMusicPetReturn(_pet) {
    var _o=scrNTTEFullCuzMusicOwner()
    if(!instance_exists(_o) || _pet!=_o.pet || !is_struct(_o.ntte_cuz_audio.current)) return;
    var _a=_o.ntte_cuz_audio.current
    if(!_a.in_takeover || instance_exists(_pet)) return;
    _a.returned=scrNTTEFullCuzMusicSnapshot("Pet.Step.return");_a.in_takeover=false
    assert(array_length(_a.calls)==1,"SOURCE CUZ AUDIO: actual takeover must issue exactly one real native music call for missing mus107 cue")
    var _call=_a.calls[0],_r=_a.returned
    assert(is_struct(_r),"CUZ AUDIO OBSERVER: actual Pet.Step return snapshot was not captured")
    assert(_call.asset==_a.target && _call.looped && _call.voice>=0 && _r.voice_playing
        && _r.music_sound==_call.voice && _r.song_resolved==_a.target && _r.target_playing
        && !audio_is_playing(_a.old_song),"SOURCE CUZ AUDIO: real target/loop/voice/controller/old-song stop mismatch")
    _a.initial_position=_r.position
}
function scrNTTEFullCuzMusicControllerStep(_controller) {
    var _o=scrNTTEFullCuzMusicOwner()
    if(!instance_exists(_o) || !is_struct(_o.ntte_cuz_audio.current)) return;
    var _a=_o.ntte_cuz_audio.current
    if(_a.passed || !is_struct(_a.returned) || _a.pass!=_o.pass_index) return;
    assert(_controller==_a.controller,"CUZ AUDIO actual controller identity changed before witness completed")
    var _r=scrNTTEFullCuzMusicSnapshot("MusCont.Step.after")
    assert(is_struct(_r),"CUZ AUDIO OBSERVER: actual controller Step snapshot was not captured")
    assert(_r.voice_playing && _r.music_sound==_a.voice && _r.song_resolved==_a.target && _r.target_playing,
        "CUZ AUDIO real music voice/controller lost during subsequent actual Steps")
    _a.steps++
    if(_a.steps>=8) {
        assert(_r.position>_a.initial_position,"CUZ AUDIO real voice did not advance over eight actual controller Steps")
        _a.passed=true;array_push(_o.ntte_cuz_audio.passed,_o.rates[_o.pass_index])
        scrNTTESmokeLog("PASS CUZ AUDIO real owner Destroy/actual Pet.Step takeover/native resolved mus107 loop voice/controller/old-song stop/eight actual MusCont Steps+position @"+string(_o.rates[_o.pass_index])+"; audible quality/iPhone not covered")
    }
}
function scrNTTEFullCuzMusicAlarm(_label) {
    var _o=scrNTTEFullCuzMusicOwner()
    if(instance_exists(_o) && is_struct(_o.ntte_cuz_audio.current)) scrNTTEFullCuzMusicSnapshot(_label)
}
function scrNTTEFullCuzMusicPassDone() {
    var _o=scrNTTEFullCuzMusicOwner()
    if(!instance_exists(_o)) return;
    var _a=_o.ntte_cuz_audio.current
    assert(is_struct(_a) && _a.pass==_o.pass_index && _a.passed && _a.steps>=8,
        "CUZ AUDIO connected gameplay PASS cannot substitute for missing real audio acceptance")
    if(_o.pass_index==array_length(_o.rates)-1)
        assert(array_length(_o.ntte_cuz_audio.passed)==2 && _o.ntte_cuz_audio.passed[0]==30
            && _o.ntte_cuz_audio.passed[1]==60,"CUZ AUDIO requires complete actual30/60 witnesses")
}
