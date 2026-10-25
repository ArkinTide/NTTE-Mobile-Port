// BEGIN NTTE CUZ AUDIO TEST REAL PET STEP BEFORE
var _ntte_cuz_audio_pet_receiver=id;
// END NTTE CUZ AUDIO TEST REAL PET STEP BEFORE
// BEGIN NTTE CUZ CONNECTED TEST PET STEP BEFORE
var _ntte_cuz_step_receiver=id;
// END NTTE CUZ CONNECTED TEST PET STEP BEFORE
scrNTTEFullPetStep()

// BEGIN NTTE CUZ CONNECTED TEST PET STEP RETURN
if(os_type==os_windows && scrNTTEFullSmokeEnabled() && instance_exists(NTTEFullCuzConnectedTest)) try { scrNTTEFullCuzConnectedProbe("Pet.Step.return",_ntte_cuz_step_receiver); }
catch(_ntte_cuz_connected_error) { scrNTTEFullCuzConnectedAbort(_ntte_cuz_connected_error); }
// END NTTE CUZ CONNECTED TEST PET STEP RETURN
// BEGIN NTTE CUZ AUDIO TEST REAL PET STEP AFTER
if(os_type==os_windows && scrNTTEFullSmokeEnabled() && instance_exists(NTTEFullCuzConnectedTest) && variable_instance_exists(instance_find(NTTEFullCuzConnectedTest,0),"ntte_cuz_audio")) try { var _ntte_cuz_audio_event_receiver=id; with(instance_find(NTTEFullCuzConnectedTest,0)) { scrNTTEFullCuzMusicPetReturn(_ntte_cuz_audio_pet_receiver); } } catch(_ntte_cuz_audio_error) { with(instance_find(NTTEFullCuzConnectedTest,0)) scrNTTEFullCuzConnectedAbort(_ntte_cuz_audio_error); }
// END NTTE CUZ AUDIO TEST REAL PET STEP AFTER