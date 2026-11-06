#define init

	 // Sprites:
	global.sprSkillIcon 					= sprite_add("../sprites/mutations/sprSurgery.png", 1, 12, 16);
	global.sprSkillHud  					= sprite_add("../sprites/mutations/sprSurgeryIcon7.png", 1, 8, 8);
	global.sprSkillHud2  					= sprite_add("../sprites/mutations/sprSurgeryIcon8.png", 1, 8, 8);

	global.sprChosenIcon					= global.sprSkillHud;
	global.skillNameAdjective				= "";
	global.skillNameNoun					= "";
	global.skillGainText					= "";
	global.skillLoseText					= "";
	
	global.statGainType						= ["maxhealth"];
	global.statGainAmount					= 0;
	global.statLoseType						= ["maxhealth"];
	global.statLoseAmount					= 0;
	
	surgery_namelist(); 
	surgery_setup();
	
#define game_start
	surgery_setup();	
	
#define skill_name			return string(global.skillNameAdjective) + " " + string(global.skillNameNoun);
#define skill_text			return ("@sGAIN " + "@(color:2964142)" + global.skillGainText + "#@sLOSE " +  "@(color:2964142)" + global.skillLoseText);

#define skill_tip			return "...";
#define skill_button		sprite_index = global.sprSkillIcon;
#define skill_icon			return global.sprChosenIcon;
#define skill_avail			return 0;
#define skill_wepspec		return 0;
#define skill_sacrifice		return false;
#define skill_surgery		return true; 

#define skill_take
	surgery_applyStatChanges(global.statGainType[0], global.statGainAmount);
	surgery_applyStatChanges(global.statLoseType[0], -global.statLoseAmount);
	
#define skill_lose
	surgery_applyStatChanges(global.statGainType[0], -global.statGainAmount);
	surgery_applyStatChanges(global.statLoseType[0], global.statLoseAmount);
	surgery_setup();

#define surgery_setup
	 // Icon and Name:
	global.sprChosenIcon		= choose(global.sprSkillHud, global.sprSkillHud2);
	global.skillNameAdjective	= global.nameAdjectives[irandom(array_length(global.nameAdjectives) - 1)];
	global.skillNameNoun		= global.nameNouns[irandom(array_length(global.nameNouns)			- 1)];

	surgery_rollStatTypes();
	
	surgery_applyText(1, global.statGainType[0], global.statGainAmount);
	surgery_applyText(0, global.statLoseType[0], global.statLoseAmount);	

#define surgery_rollStatTypes
	global.statGainType = choose(	// [type, stat increase range, value multiplier (based off stat number)]
		["maxhealth",			irandom_range(1, 3),								9],		// 1-3, 6 value per
		["maxspeed",			(round(random_range(1, 2) / 0.20) * 0.20),			6],		// 1-3, rounded to nearest 0.20, 5 value per
		["accuracy",			(round(random_range(0.05, 0.40) / 0.05) * 0.05),	5],
		["reloadspeed",			(round(random_range(0.05, 0.25) / 0.05) * 0.05),	30],
		["maxammo",				irandom_range(5, 20),								0.5],
		["ammogain",			irandom_range(1, 3),								6],
		["projectilespeed",		(round(random_range(0.05, 0.4) / 0.05) * 0.05),		12],
		["radmax",				(round(irandom_range(50, 300) / 10) * 10),			0.03]
	)
	
	global.statLoseType = choose(	// [type, round to, stat cost per value, min, max]
		["maxhealth",			1,			4,			1,		1/0],				
		["maxspeed",			0.2,		20,			0.2,	1/0],
		["accuracy",			0.05,		9,			0.05,	2.5],
		["reloadspeed",			0.05,		18,			0.05,	(0.05 * 20)],
		["maxammo",				1,			0.5,		1,		1/0],
		["ammogain",			1,			5,			1,		1/0],
		["projectilespeed",		0.05,		12,			0.05,	(0.05 * 90)]
//		["radmax",				10,			0.01,		30,		550]  // its kinda just always worth it because u dont *need* to use rads. would prevent ushov + spc meta ig.
	)
																
	if((global.statGainType[0] = global.statLoseType[0])){
		surgery_rollStatTypes();
		exit;
	}
	global.statGainAmount = global.statGainType[1];
	surgery_rollStatChanges();

#define surgery_rollStatChanges
	
	var _value = global.statGainAmount * global.statGainType[2];
/*	
	trace("+ STAT : " + string(global.statGainType[0] + " (" + string(global.statGainType[2]) + ")"))
	trace("+ COUNT : " + string(global.statGainType[1]))
	trace("= VALUE : " + string(_value))
*/	
	 // :3
/*	if(random(3) < 1){
		trace("OLD VALUE : " + string(_value))
		_value += random_range(-2, 2);
		trace("NEW VALUE : " + string(_value))		
	}
*/

	var _loseType			= global.statLoseType[0],
		_loseRound			= global.statLoseType[1],
		_loseCost			= global.statLoseType[2],
		_loseMin			= global.statLoseType[3],
		_loseMax			= global.statLoseType[4],
		_loseMode			= "divide" //global.statLoseType[5];
		
	var _loss				= (_value / _loseCost),
		_loseAmount			= clamp((round(_loss / _loseRound) * _loseRound), _loseMin, _loseMax);

/*		
	trace("- STAT : " + string(_loseType) + " (" + string(_loseCost) + ")")
	trace("- COUNT : " + string(_loseAmount))
*/		
	global.statLoseAmount = _loseAmount;
	
#define surgery_applyStatChanges(_stat, _amount)
	switch(_stat){
		case "maxhealth":
			with(Player){
				maxhealth += _amount;
				if(my_health > maxhealth){
					my_health = maxhealth;
				}
			}
		break;
		
		case "maxspeed":
			mod_script_call("mod", "wibbly", "speedBonus_add", -1, _amount);
		break;
		
		case "accuracy":
			mod_script_call("mod", "wibbly", "accuracyBonus_add", -1, _amount);
		break;
		
		case "reloadspeed":
			mod_script_call("mod", "wibbly", "reloadBonus_add", -1, _amount);
		break;
		
		case "maxammo":
				mod_script_call("mod", "wibbly", "ammoMaxBonus_add", -1, 1, round(_amount * 4.6));
				var _ammoType = 2;
				repeat(4){
					mod_script_call("mod", "wibbly", "ammoMaxBonus_add", -1, _ammoType, _amount);
					_ammoType += 1
				}		
		break;
		
		case "ammogain":
			mod_script_call("mod", "wibbly", "ammoGainBonus_add", -1, 1, round(_amount * 3.2)); // each ammo gain point is worth 10%
			mod_script_call("mod", "wibbly", "ammoGainBonus_add", -1, 2, round(_amount * 0.8));
			mod_script_call("mod", "wibbly", "ammoGainBonus_add", -1, 3, round(_amount * 0.7));
			mod_script_call("mod", "wibbly", "ammoGainBonus_add", -1, 4, round(_amount * 0.6));
			mod_script_call("mod", "wibbly", "ammoGainBonus_add", -1, 5, round(_amount * 1));
		break;
		
		case "projectilespeed":
			mod_script_call("mod", "wibbly", "projectileSpeedBonus_add", -1, _amount);
		break;
		
		case "radmax":
			mod_script_call("mod", "wibbly", "radMaxBonus_add", _amount); // test in multiplayer :3
		break;
	}
	
#define surgery_applyText(_gain, _stat, _amount)
	
	var _text = ""
	
	 // Text:
	switch(_stat){
		case "maxhealth":
			_text = string(_amount) + " @wMAX HEALTH" 
		break;
		
		case "maxspeed":
			_text = string(round((_amount / 4) * 100)) + "% @wMOVEMENT SPEED" 
		break;
		
		case "accuracy":
			_text = string(round((_amount) * 100)) + "% @wACCURACY" 
		break;
		
		case "reloadspeed":
			_text = string(round((_amount) * 100)) + "% @wRELOAD SPEED" 
		break;
		
		case "maxammo":
			_text = string(_amount) + " @wMAX AMMO" 
		break;
		
		case "ammogain":
			_text = string(_amount) + "0% @wAMMO GAIN" 
		break;
		
		case "projectilespeed":
			_text = string(round((_amount) * 100)) + "% @wPROJECTILE SPEED" 
		break;
		
		case "radmax":
			_text = string(_amount) + " @wRAD CAPACITY"
		break;		
	}
	
	if(_gain){
		global.skillGainText	= _text;
	} else {
		global.skillLoseText	= _text;
	}
	
	
#define surgery_namelist
	
     // Choose Adjective:
    global.nameAdjectives = [
        "UNENDING",
        "ABYSMAL",
        "HELLSUNG",
        "BOILING",
        "SERRATED",
        "BROKEN",
        "SEETHING",
        "UNRELENTING",
        "BOUNDLESS",
        "ZANY",
        "INNOCENT",
        "UNMATCHED",
        "DARK",
        "ROYAL",
        "INVASIVE",
        "RABID",
        "WARBORN",
        "BATTLE-READY",
        "CURVED",
        "SUCCULENT",
        "LOVELY",
        "WONDERFUL",
        "EUPHORIC",
        "HUGE",
        "POWERFUL",
        "WARPED",
        "DANGEROUS",
        "HYPER-BALLISTIC",
        "CRUNCHY",
        "LUDICRIOUS",
        "ATROCIOUS",
        "GLORIOUS",
        "UNLEASHED",
        "BIG",
        "TINY",
        "SMALL",
        "SUS",
        "SUPER-DUPER",
        "SUPERCALIFRAGILISTICEXPIALIDOCIOUS",
        "SIGMA",
        "ALPHA",
        "BETA",
        "EVIL",
        "SILLY",
        "SWEATY",
        "REGRETTABLE",
        "THIN",
        "JUICY",
        "TERRIFYING",
        "HEAVY",
        "HEFTY",
        "WEIGHTLESS",
        "LIGHT",
        "SPOOKY",
        "SCARY",
        "CRISPY",
        "PAINFUL",
        "SLIMY",
        "EXTRA",
        "CRIMINAL",
        "CHUBBY",
        "BLOODY",
        "LEAFY",
        "USEFUL",
        "VIOLENT",
        "GAPING",
        "INCOMPETENT",
        "YUMMY",
        "MINDLESS",
        "BITTER",
        "SWEET",
        "PEACEFUL",
        "FEARFUL",
        "DAMAGED",
        "DEFECTIVE",
        "ASPIRING",
        "UNADVISED",
        "SOGGY",
        "MACHO",
        "ENCHANTING",
		"CRAZY",
		"WACKY",
		"CHAOTIC",
		"CROOKED",
		"TABOO",
		"HOT",
		"COLD",
		"ICY",
		"CHILLING",
		"ECONOMICS",
		"EXTREME",
		"INFAMOUS",
		"DISPOSABLE",
		"UNFORGETTABLE",
		"LIFE-CHANGING",
		"TRAUMATIZING",
		"MODERN",
		"RESTLESS",
		"EASY",
		"IMPORTANT",
		"DRAMATIC",
		"EMOTIONAL",
		"HELLISH",
		"BLISSFUL",
		"LARGE",
		"CHEESED",
		"SWOLLEN",
		"CREAMY",
		"WICKED",
		"EROTIC",
		"SENSUAL",
		"TROPICAL",
		"STICKY",
		"SQUEAKY",
		"STINKY",
		"CHARISMATIC",
		"FLAMING-HOT",
		"DINOSAUR",
		"BUG",
		"COMPENSATING",
		"MESSY",
		"GNARLED",
		"EXCESSIVE",
		"SHARK",
		"REDEEMED",
		"BUDGET",
		"SCRAMBLED",
		"LEGENDARY",
		"AGGRESSIVE",
		"MOM'S",
		"THE",
		"QUIVERING",
		"WIZARDLY",
		"POINTLESS",
		"KERATIN",
		"SLOPPY",
		"HARMFUL",
		"FOREIGN",
		"ENTICING",
		"LESS",
		"COMPOUND",
		"VARIA",
		"UNCANNY",
		"LOST",
		"ENDLESS",
		"MYSTERIOUS",
		"ELECTRIC",
		"FROG",
		"SOFT",
		"@(color:12884)BROWN",
		"HOLLOW",
		"YOUR",
		"TYPICAL",
		"MUSKY",
		"TIGHT",
		"REPLICA",
		"LUMPY",
		"VULGAR",
		"WIGGLY",
		"FAMILIAR",
		"FERTILE",
		"MEDICAL",
		"PURE",
		"MERE",
		"ANGRY",
		"SOME",
		"@(color:255)R@(color:37887)A@(color:55039)I@(color:65452)N@(color:4325120)B@(color:16773376)O@(color:16711845)W@w",
		"ALL",
		"POOR",
		"TASTEFUL",
		"FURRY",
		"POLITICAL",
		"ROTTEN",
		"INVINCIBLE",
		"MEAT",
		"BERSERK",
		"BIZARRE",
		"HEALTHY",
		"WET",
		"MOIST",
		"FUZZY",
		"WEIRD",
		"BRITTLE",
		"SUBMISSIVE",
		"SMOOTH",
		"DEVIOUS",
		"LOUD",
		"WILD",
		"WHITE",
		"WEAK",
		"STRONG",
		"SCROLL OF",
		"TWISTED",
		"WARTY",
		"MOTHER OF ALL",
		"TOXIC",
		"TOTAL",
		"EXPERT",
		"SCUMMY",
		"PROCEDURALLY GENERATED",
		"SPEEDY",
		"HALF",
		"DAY OF",
		"THE ONLY",
		"IMMATURE",
		"BAD",
		"IT'S KIND OF LIKE...",
		"THE WORST",
		"HELPFUL",
		"SUDDEN",
		"ECCLECTIC",
		"TRAINED",
		"REFINED",
		"INTOLERABLE",
		"STEAMY",
		"TOUCH OF",
		"FRIENDLY",
		"WHIRLING",
		"NON-STOP",
		"WASTELAND",
		"MUTANT",
		"FAIR",
		"VISCERAL",
		"SENTIENT",
		"@q@p",
		"BALD",
		"MUSICAL",
		"BRASH",
		"ILLEGAL",
		"BANNED",
		"FRUITY",
		"GIGA",
		"MEGA",
		"ACID-FILLED",
		"OLD-SCHOOL",
		"MILLION-DOLLAR",
		"E -",
		"DAILY",
		"COWBOY",
		"STANDARD-ISSUE",
		"CUTE",
		"DEVIL'S",
		"BOOTLEG",
		"PRO",
		"COOKING",
		"HATED",
		"PRETENTIOUS",
		"MR.",
		"GASEOUS",
		"POWDERED",
		"CLOWN",
		"SONIC",
		"NIHILIST",
		"DOOM",
		"STOLEN",
		"HOLIDAY",
		"STEAMPUNK",
		"REFRESHING",
		"EXPERIMENTAL",
		"CONTAGIOUS",
		"LA",
		"TEENY",
		"ALIEN",
		"SAVAGE",
		"DRAGON",
		"DRACONIC",
		"WACKY INFLATABLE",
		"INFLATED",
		"BIG AND ROUND",
		"UNIQUE",
		"EXOTIC",
		"THICK",
		"GUILTY",
		"CRUEL",
		"PROBLEMATIC",
		"NERDY",
		"CALMING",
		"JOYOUS",
		"TRAITOROUS",
		"ENTROPIC",
		"OOPS! ALL",
		"DUBIOUS",
		"A SPOONFUL OF",
		"GHOSTLY",
		"GHASTLY",
		"FRESH",
		"DEVILISH",
		"STRONG, WILD",
		"KINDA AWESOME",
		"LETHAL",
		"NOTHIN' BUT",
		"STRETCHED",
		"FUNNY",
		"NUCLEAR",
		"AMAZING",
		"OH! THE",
		"QUESTIONABLE",
		"YIKES! ITS",
		"HI! IM"
    ];

    // Choose Noun:
   global.nameNouns = [
        "EXPERIENCE",
        "TERROR",
        "TORTURE",
        "TEETH",
        "RIBS",
        "JAWBONE",
        "LUNGS",
        "LEGS",
        "BRAIN",
        "MIND",
        "THIGHS",
        "FISTS",
        "TONGUE",
        "EYES",
        "BLOOD",
        "GARBAGE",
        "DRAMA",
        "MOOD",
        "PHILOSOPHY",
        "PERSPECTIVE",
        "LENGTH",
        "CHUNGUS",
        "BALLS",
        "JUICES",
        "TIME",
        "LIGAMENTS",
        "NEURONS",
        "MOTIVES",
        "HEART",
        "ARMS",
        "FINGERS",
        "PALMS",
        "SHOULDERS",
        "FEET",
        "STOMACH",
        "HUNGER",
        "SKIN",
        "LUST",
        "HEAD",
        "APPENDIX",
        "VEINS",
        "BONES",
        "SKULL",
        "NIGHTMARE",
        "INVOLVEMENT",
        "REALITY",
        "WISDOM",
        "PROOF",
        "TRIAL",
        "DEVICES",
        "CHEMICALS",
        "PROCEDURE",
        "EXPERIMENT",
        "TEST-DRIVE",
        "RUN",
        "BOOSTERS",
        "THOUGHTS",
        "SONG",
        "TREAT",
        "EMPLOYMENT",
        "UNDERTAKING",
        "BAN",
        "LOVE",
        "SURPRISE",
        "TOES",
        "REWARD",
        "BONUS",
        "AWAKENING",
        "INJECTION",
        "MARROW",
        "SLUSHIE",
		"FARTS",
		"SHOES",
		"MANDATE",
		"IMAGINATION",
		"TECHNOLOGY",
		"MODE",
		"ANCESTRY",
		"VIBE",
		"LOBOTOMY",
		"IMPLANTS",
		"DRUGS",
		"JOKE",
		"ARSENAL",
		"SMILE",
		"EFFIGY",
		"WINGS",
		"LISP",
		"HAIR",
		"COMPOUND",
		"FREAK",
		"ADDON",
		"ADDONS",
		"SYNDROME",
		"POWERS",
		"EGGS",
		"TASTE",
		"BREATH",
		"ZONE",
		"MISTAKE",
		"SPOT",
		"KNOWLEDGE",
		"LUMPS",
		"TRUTH",
		"GROWTH",
		"PRESENCE",
		"CHILD",
		"GOALS",
		"UNION",
		"PERSONALITY",
		"INCLINATION",
		"MEAT",
		"SPIRIT",
		"VISIONS",
		"APPETITE",
		"DREAMS",
		"AWARD",
		"ACT",
		"UNIFORM",
		"SCIENCE",
		"BUTT",
		"ART",
		"WORDS",
		"MUTATION",
		"TRAITS",
		"STENCH",
		"REQUEST",
		"FRIEND",
		"QUIRKS",
		"WARFARE",
		"KING",
		"BANDITRY",
		"AGE",
		"SCALP",
		"ANDY",
		"WORLD",
		"THREAT",
		"ROLEPLAY",
		"CHIN",
		"CHALLENGE",
		"MAGGOTS",
		"MILK",
		"EXOSKELETON",
		"ACID",
		"BOMBS",
		"MEDICINE",
		"DRIP",
		"LICENSE",
		"LEGEND",
		"LAUGHTER",
		"HAT",
		"ACCOUNT",
		"PROCLAMATION",
		"DESIRE",
		"BEARD",
		"HONOR",
		"SEED",
		"MEDIA",
		"SACRIFICE",
		"KILLER",
		"BREATH",
		"TWITCH",
		"REFLEXES",
		"INSIGHT",
		"CONTRACT",
		"SPECIALIST",
		"ISOTOPES",
		"IDEA",
		"NERVE",
		"PHOBIA",
		"AND STUFF",
		"SCARS",
		"LOVE",
		"ENABLED",
		"CLAWS",
		"SAUCE",
		"IS YOU",
		"MIRACLE",
		"VOICES",
		"DREAMS",
		"PHOTOGRAPH",
		"DRAGON",
		"WEAPONS",
		"LEMONADE",
		"BETRAYAL",
		"CREAM",
		"CUSTARD",
		"SYRUP",
		"CREATURE",
		"BEAST",
		"CRIMINAL",
		"BABY",
		"COMPANY",
		"WAR",
		"JOB",
		"FRAGRANCE",
		"PAWS",
		"PAW",
		"STRING",
		"ENHANCEMENTS",
		"BEAK",
		"BONE",
		"THRONE",
		"GAMEPLAY",
		"SKILLS",
		"STYLE",
		"BUG",
		"CHASM",
		"PLANS",
		"TUNES"
    ];
    