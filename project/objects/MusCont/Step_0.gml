if lockstep_stop
	exit

if (instance_exists(SpiralCont) || scrGameIsPaused()) {
    if (ambfilter > 0.2) ambfilter -= (0.1) * timescale
}
else {
	if (ambfilter < 1) ambfilter += (0.1) * timescale
}

audio_master_gain(UberCont.opt_volume)

if (audio_exists(song)) audio_sound_gain(song, UberCont.opt_musvol, 0)
if (audio_exists(amb)) audio_sound_gain(amb, UberCont.opt_ambvol * ambfilter, 0)
scrNTTEFullMusicStep();

// BEGIN NTTE CUZ AUDIO TEST REAL MUSIC STEP
if(os_type==os_windows && scrNTTEFullSmokeEnabled() && instance_exists(NTTEFullCuzConnectedTest) && variable_instance_exists(instance_find(NTTEFullCuzConnectedTest,0),"ntte_cuz_audio")) try { var _ntte_cuz_audio_event_receiver=id; with(instance_find(NTTEFullCuzConnectedTest,0)) { scrNTTEFullCuzMusicControllerStep(_ntte_cuz_audio_event_receiver); } } catch(_ntte_cuz_audio_error) { with(instance_find(NTTEFullCuzConnectedTest,0)) scrNTTEFullCuzConnectedAbort(_ntte_cuz_audio_error); }
// END NTTE CUZ AUDIO TEST REAL MUSIC STEP