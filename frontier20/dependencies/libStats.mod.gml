/*	                 Stats
	This is the Stats package of Lib, for any and
	all modifications of player stats.
*/

/*
	Scripts:
		#define change_health(obj, amount)
		#define change_ammo(player, type, amount)
		#define change_max_hp(player, amount)
		#define change_accuracy(player, amount)
		#define change_speed(player, amount)
*/

//For internal use, adds the script to be easily usable.
#define addScript(name)
	lq_set(instances_matching(CustomObject, "name", "libGlobal")[0].scriptReferences, name, ["mod", mod_current, name]);

#define init
	addScript("change_health");
	addScript("change_ammo");
	addScript("change_max_hp");
	addScript("change_accuracy");
	addScript("change_speed");
	script_ref_call(["mod", "lib", "updateRef"]);
	global.isLoaded = true;

#define change_health(obj, amount)
/* Creator: Golden Epsilon
Description: 
	Heals/removes health from a hitme by the amount.
	Does not heal past the hitme's Max HP, and sets lsthealth if removing health.
*/
obj.my_health = min(obj.my_health + amount, obj.maxhealth);
if("lsthealth" in obj && amount < 0){
	obj.lsthealth = obj.my_health;
}

#define change_ammo(player, type, amount)
/* Creator: Golden Epsilon
Description: 
	Adds/removes ammo from the player, respecting typ_amax and 0
*/
player.ammo[@type] = max(min(player.ammo[@type] + amount, typ_amax[@type]), 0);

#define change_max_hp(player, amount)
/* Creator: Golden Epsilon
Description: 
	Changes a player's Maximum HP by the amount.
	Heals the player if Max HP increases, cannot kill by removing max HP.
*/
player.maxhealth += amount;
player.maxhealth = max(player.maxhealth, 1);
player.my_health = min(player.my_health, player.maxhealth);

#define change_accuracy(player, amount)
/* Creator: Golden Epsilon
Description: 
	Changes a player's Accuracy by the amount.
	A value of 0.5 means the player has double the accuracy.
	A value of 2 means the player has half the accuracy.
*/
player.accuracy *= amount;

#define change_speed(player, amount)
/* Creator: Golden Epsilon
Description: 
	Changes a player's Speed by the amount.
	Speed cannot be reduced below 0.1 for sanity's sake
	(Does not clamp speed if the player already has a slower max speed)
*/
if(player.maxspeed > 0.1){
	player.maxspeed += amount;
	player.maxspeed = max(player.maxspeed, 0.1);
}