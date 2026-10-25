scrNTTEFullChestDropBegin();
with (scrWeaponPickupCreate(x, y, scrDecideWep(6), true)) {
	motion_add(random_angle, (10) * timescale)
}
scrNTTEFullChestDropEnd();
