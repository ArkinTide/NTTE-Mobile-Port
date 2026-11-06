if lockstep_stop
	exit

if !instance_exists(GenCont) {
    if scrChestOpened() exit
    scrNTTEFullChestDropBegin();
    instance_create(x, y, VenuzAmmoSpawn)
    scrNTTEFullChestDropEnd();
    snd_play(sndBigWeaponChest)
    with (instance_nearest(x, y, Player)) {
		snd_play(snd_chst)
	}
    instance_destroy()
}

