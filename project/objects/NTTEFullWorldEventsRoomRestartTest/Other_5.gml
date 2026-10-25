room_ends++;
if(!restored && scrNTTEFullValue(id,"ntte_pet_transient_test",false)) scrNTTEFullPetTransientLifecycleRoomEnd();
// NTTE SPIDER RESTART TEST HOOK
if(!restored && scrNTTEFullValue(id,"ntte_pet_spider_restart_test",false)) scrNTTEFullPetSpiderRestartRoomEnd();
