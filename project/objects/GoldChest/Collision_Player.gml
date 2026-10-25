if lockstep_stop
	exit

if scrChestOpened()
	exit

scrNTTEFullChestDropBegin();

scrNTTEFullGoldChestLoot();

snd_play(sndGoldChest)

scrNTTEFullChestDropEnd();
instance_destroy()