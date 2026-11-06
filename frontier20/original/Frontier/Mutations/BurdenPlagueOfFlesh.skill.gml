#define init

	 // Sprites:
	global.sprSkillIcon         = sprite_add("../sprites/mutations/sprBurden.png", 1, 12, 16)
	global.sprSkillHud          = sprite_add("../sprites/mutations/sprBurdenPelagicPredicamentIcon.png", 1, 8, 8)

#define skill_name			return "VISCERA VICISSITUDE";
#define skill_text			return "@q@(color:2964142)IT HUNGERS";
#define skill_tip			return "SMELLS OF CARRION";
#define skill_button		sprite_index = global.sprSkillIcon;
#define skill_icon			return global.sprSkillHud;
#define skill_avail			return 0;
#define skill_wepspec		return 0;
#define skill_sacrifice		return false;
#define skill_burden		return true;


/*
	im probably just gonna have the PoF stuff be handled by events so I don't need to actually put anything in this file
*/
	
	