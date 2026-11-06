room_starts++;
if(!restored && scrNTTEFullValue(id,"ntte_pet_transient_test",false)) scrNTTEFullPetTransientLifecycleRoomStart();
// NTTE SPIDER RESTART TEST HOOK
if(!restored && scrNTTEFullValue(id,"ntte_pet_spider_restart_test",false)) scrNTTEFullPetSpiderRestartRoomStart();
