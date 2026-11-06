if lockstep_stop
	exit

if !instance_exists(GenCont) {
    if scrChestOpened()
		exit
	
	var p = instance_nearest(x, y, Player)
    scrNTTEFullChestDropBegin();
    instance_create(x, y, VenuzWeaponSpawn)
    scrNTTEFullChestDropEnd();
    snd_play(sndBigWeaponChest)
	
	if p {
		snd_play(p.snd_chst)
	}
	
	instance_destroy()
}