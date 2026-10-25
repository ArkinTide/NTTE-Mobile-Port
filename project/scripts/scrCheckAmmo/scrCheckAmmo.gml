function scrCheckAmmo(wep, mult = 1) {
	return (scr_weapon_get_cost(wep) <= 0 || global.__debug_infammo || (ammo[scr_weapon_get_type(wep)] >= scr_weapon_get_cost(wep) * mult))
}

function scrCheckRads(wep, mult = 1) {
	return (scr_weapon_get_rads(wep) <= 0 || global.__debug_infammo || (GameCont.rad >= scr_weapon_get_rads(wep) * mult))
}

function scrCheckCanShoot(wep, mult = 1) {
	return scrCheckAmmo(wep, mult) && scrCheckRads(wep, mult)
}