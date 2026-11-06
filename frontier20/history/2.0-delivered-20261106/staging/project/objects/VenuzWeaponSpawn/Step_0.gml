scrNTTEFullChestDropBegin();
with (scrWeaponPickupCreate(x, y, scrDecideWep(6), true)) {
	roll=true
	motion_add(random_angle, (10) * timescale)
}
scrNTTEFullChestDropEnd();
