/*	                
	This is the Muts package of Lib, for
	functions that help with making mutations
*/

/*
	Scripts:
		#define skill_get_category(mut)
		#define skill_set_category(mut, category)
		#define skill_get_avail(mut, ?includeobtained, ?checkmutscreen)
		#define get_skills(?is_avail, ?whitelist, ?category)
		#define get_ultras()
		#define skill_decide(?is_avail, ?whitelist, ?category)
		#define skill_get_image(_mut)
		#define skill_get_icon(_mut)
		#define skill_is_ultra(_mut)
*/

//For internal use, adds the script to be easily usable.
#define addScript(name)
	lq_set(instances_matching(CustomObject, "name", "libGlobal")[0].scriptReferences, name, ["mod", mod_current, name]);

#define init
	addScript("skill_get_category");
	addScript("skill_set_category");
	addScript("skill_get_avail");
	addScript("get_skills");
	addScript("get_ultras");
	addScript("skill_decide");
	addScript("skill_get_image");
	addScript("skill_get_icon");
	addScript("skill_is_ultra");
	script_ref_call(["mod", "lib", "updateRef"]);
	global.isLoaded = true;
	
	//Mutation categories, donated by wildebee from metamorphosis
	global.mut_categories = {
		offensive: [mut_gamma_guts, mut_scarier_face, mut_long_arms, mut_shotgun_shoulders, mut_laser_brain, mut_eagle_eyes, mut_impact_wrists, mut_bolt_marrow, mut_stress, mut_trigger_fingers, mut_sharp_teeth],
		defensive: [mut_rhino_skin, mut_bloodlust, mut_second_stomach, mut_boiling_veins, mut_strong_spirit],
		utility: [mut_extra_feet, mut_plutonium_hunger, mut_throne_butt, mut_euphoria, mut_last_wish, mut_patience, mut_hammerhead, mut_heavy_heart],
		ammo: [mut_rabbit_paw, mut_lucky_shot, mut_back_muscle, mut_recycle_gland, mut_open_mind]
	}

#define skill_get_category(mut)
	//If no category's found, it returns -1
	
	//I'm giving the global variable priority so that skill_set_category works
	for(var i = 0; i < lq_size(global.mut_categories); i++) {
		if(is_array(lq_get_value(global.mut_categories, i))){
			var length = array_length(lq_get_value(global.mut_categories, i));
			for(var i2 = 0; i2 < length; i2++) {
				if(array_find_index(lq_get_value(global.mut_categories, i), mut) != -1) {
					return lq_get_key(global.mut_categories, i);
				}
			}
		}
	}
	if(is_string(mut) and mod_script_call("skill", mut, "skill_type") != undefined) {
		var skill_type = mod_script_call("skill", mut, "skill_type");
		if(is_string(skill_type)) {
			return string_lower(skill_type);
		}else if(is_real(skill_type)){
			switch(skill_type){
				case 0:
					return "offensive";
					break;
				case 1:
					return "defensive";
					break;
				case 2:
					return "utility";
					break;
				case 3:
					return "ammo";
					break;
				default: 
					return skill_type;
			}
		}else{
			return skill_type;
		}
	}else if(is_string(mut) and skill_is_ultra(mut)){
		return "ultra";
	}
	//if it can't find a category for the mut it returns -1
	return -1;

#define skill_set_category(mut, category)
	//if you pass in arrays for both mut and category and the lengths match up, it'll set all of them
	//in addition, if mut is an array and category is not, it'll set all the mutations in the array to category
	//in essence, if you did skill_set_category([[mutA, mutB], mutC], ["ammo", "damage"]), 
	//it'd set mutA and mutB to ammo and mutC to damage.
	//note: mut and category do not have to be arrays.
	
	if(is_array(mut)){
		if(is_array(category) && array_length(category) != array_length(mut)){
			trace("Lib error! if you're passing arrays into skill_set_category, please keep the lengths the same and/or make category a single value.");
			return;
		}else if(is_array(category)){
			for(var i = 0; i < array_length(mut); i++){
				skill_set_category(mut[i], category[i])
			}
		}else{
			for(var i = 0; i < array_length(mut); i++){
				skill_set_category(mut[i], category)
			}
		}
	}else{
		if(is_array(category)){
			trace("Lib error! for skill_set_category, if mut is a single value category cannot be an array.");
			return;
		}else{
			array_push(lq_get(global.mut_categories, category), mut);
		}
	}

#define skill_get_avail
//mut, ?includeobtained, ?checkmutscreen
/* Creator: Golden Epsilon
Description: 
	Checks to see if the given mutation can be picked at random.
	Can take either a vanilla mutation (number) or a modded mutation (string)
	Can also take an array, returns false if any of the mutations are not available.
	the optional argument includes mutations you already have if it's set to true
*/

var includeobtained = 0;
if(argument_count > 1 && argument[1]){
	includeobtained = 1;
}

if(is_array(argument[0])){
	with(argument[0]){
		if(!skill_get_avail(self)){
			return false;
		}
	}
	return true;
}
if(argument_count > 2 && argument[2]){
	with(SkillIcon){
		if(skill == argument[0]){
			return false;
		}
	}
}
if(is_real(argument[0])){
	return (includeobtained || !skill_get(argument[0])) && skill_get_active(argument[0]);
}
if(is_string(argument[0])){
	var avail = true;
	if(!mod_exists("skill", argument[0])){
		avail = false;
	}else if(mod_script_exists("skill", argument[0], "skill_avail") && !mod_script_call("skill", argument[0], "skill_avail")){
		avail = false;
	}
	return avail && (includeobtained || !skill_get(argument[0])) && skill_get_active(argument[0]);
}
return false;

#define get_skills
//?is_avail, ?whitelist, ?category
/* Creator: Golden Epsilon
Description: 
	Returns all mutations that exist.
	if is_avail is true, only returns mutations that can be chosen by the game.
	whitelist can only be used if category is also being used,
	it determines whether category is a whitelist or blacklist.
	category can either be a single category or an array of categories,
	and is either a whitelist or blacklist of categories
*/

var allskills=[]
var modskills = mod_get_names("skill");
var categories = [];
if(argument_count > 2){
	if(is_array(argument[2])){
		categories = argument[2];
	}else if(is_real(argument[2])){
		switch(argument[2]){
			case 0:
				categories = ["offensive"];
				break;
			case 1:
				categories = ["defensive"];
				break;
			case 2:
				categories = ["utility"];
				break;
			case 3:
				categories = ["ammo"];
				break;
			default: 
				categories = [argument[2]];
		}
	} else {
		categories = [argument[2]];
	}
}
for (var i = 1; i <= 29; i += 1){
	var whitelist = false;
	if(argument_count > 2){
		whitelist = argument[1];
	}
	var nope = whitelist;
	with(categories){
		if(skill_get_category(i) == self && whitelist){
			nope = false;
			break;
		}else if(skill_get_category(i) != self && !whitelist){
			nope = true;
			break;
		}
	}
	if(nope){continue;}
	
	if(argument_count > 0 && argument[0]){
		if(skill_get_avail(i, 0, 1)){
			array_push(allskills,i);
		}
	}else{
		array_push(allskills,i);
	}
}
for(i = 0; i < array_length_1d(modskills); i++){
	if(mod_exists("skill", modskills[i])){
		if(mod_script_exists("skill", modskills[i], "skill_ultra")){
			//var ult = mod_script_call("skill", modskills[i], "skill_ultra");
			//if(is_string(ult) && (mod_exists("race", ult) || string_count(string_lower(ult), "fish crystal eyes melting plant venuz steroids robot chicken rebel horror rogue skeleton frog")) || is_real(ult) && ult != -1){
				continue;
			//}
		}
		
		var whitelist = false;
		if(argument_count > 2){
			whitelist = argument[1];
		}
		var nope = whitelist;
		with(categories){
			if(skill_get_category(modskills[i]) == self && whitelist){
				nope = false;
				break;
			}else if(skill_get_category(modskills[i]) != self && !whitelist){
				nope = true;
				break;
			}
		}
		if(nope){continue;}
		
		if(argument_count > 0 && argument[0]){
			if(skill_get_avail(modskills[i], 0, 1)){
				array_push(allskills,modskills[i]);
			}
		}else{
			array_push(allskills,modskills[i]);
		}
	}
}
return allskills;

#define get_ultras
/* Creator: Golden Epsilon
Description: 
	Returns all ultras that exist.
	Vanilla mutations give their index, 
	modded mutations give either the name of the ultra mutation (cultras)
	or an array with the info related to the custom characters' ultra
*/

var ultraskills=[]
var modskills = mod_get_names("skill");
for(var i = char_fish; i <= char_frog; i++){
	for(var i2 = 1; i2 <= ultra_count(i); i2++){
		array_push(ultraskills, i*3+i2-4);
	}
}
with(mod_get_names("race")){
	var num = 1;
	while(mod_script_call("race", self, "race_ultra_name", num) != "" && mod_script_call("race", self, "race_ultra_name", num) != 0){
		array_push(ultraskills,[self, num, mod_script_call("race", self, "race_ultra_name", num), mod_script_call("race", self, "race_ultra_text", num)]);
		num++;
	}
}
for(i = 0; i < array_length_1d(modskills); i++){
	if(mod_exists("skill", modskills[i])){
		if(mod_script_exists("skill", modskills[i], "skill_ultra")){
			var ult = mod_script_call("skill", modskills[i], "skill_ultra");
			if(is_string(ult) && (mod_exists("race", ult) || string_count(string_lower(ult), "fish crystal eyes melting plant venuz steroids robot chicken rebel horror rogue skeleton frog")) || is_real(ult) && ult != -1){
				array_push(ultraskills,modskills[i]);
			}
		}
	}
}
return ultraskills;

#define skill_decide
//?is_avail, ?whitelist, ?category
/* Creator: Golden Epsilon
Description: 
	Returns a mutation out of the pool.
	The optional arguments, whitelist and category, pass themselves
	in as an argument to get_skills, so check that for more context.
*/

var skills;
if(argument_count >= 3){
	skills = get_skills(argument[0], argument[1], argument[2]);
}else if(argument_count >= 2){
	skills = get_skills(argument[0], argument[1]);
}else if(argument_count >= 1){
	skills = get_skills(argument[0]);
}else{
	skills = get_skills(true);
}

if(array_length(skills) == 0){
	return mut_last_wish;
}

return skills[irandom(array_length(skills) - 1)];

#define skill_get_image(_mut)
/* Creator: Golden Epsilon
Description: 
	Takes _mut as an input (number or string)
	Returns the button image for a mutation and image index in an array
	([sprite_index, image_index])
	Just for mutations, does not work with ultras
Usage:
	var temp = script_ref_call(["mod", "libMuts", "skill_get_image"], 5);
	draw_sprite(temp[0], temp[1], x, y);
*/

var retVal = [sprSkillIcon, 0];
//Using Effect to not mess with Update
with(instance_create(0,0,Effect)){
	if(is_real(_mut)){
			retVal = [sprSkillIcon, _mut]
	}else{
		sprite_index=sprSkillIcon;
		with(GameCont){t_mutindex = mutindex;}
		mod_script_call("skill",_mut,"skill_button")
		with(GameCont){mutindex = t_mutindex;}
		var retVal = [sprite_index, image_index];
	}
	instance_destroy();
}
return retVal;

#define skill_get_icon(_mut)
	/*
		Returns an array containing the [sprite_index, image_index] of a mutation's HUD icon
	*/
	
	if(is_real(_mut)){
		return [sprSkillIconHUD, _mut];
	}
	
	if(is_string(_mut) && mod_script_exists("skill", _mut, "skill_icon")){
		return [mod_script_call("skill", _mut, "skill_icon"), 0];
	}
	
	return [sprEGIconHUD, 2];

#define skill_is_ultra(_mut)
//returns whether the mut passed in is an ultra
if(is_real(_mut)){
	for(var i = char_fish; i <= char_frog; i++){
		for(var i2 = 1; i2 <= ultra_count(i); i2++){
			if(_mut == i*3+i2-4){
				return true;
			}
		}
	}
	return false;
}
if(mod_script_exists("skill", _mut, "skill_ultra")){
	var ult = mod_script_call("skill", _mut, "skill_ultra");
	if(is_string(ult) && (mod_exists("race", ult) || string_count(string_lower(ult), "fish crystal eyes melting plant venuz steroids robot chicken rebel horror rogue skeleton frog")) || is_real(ult) && ult != -1){
		return true;
	}
}
return false;