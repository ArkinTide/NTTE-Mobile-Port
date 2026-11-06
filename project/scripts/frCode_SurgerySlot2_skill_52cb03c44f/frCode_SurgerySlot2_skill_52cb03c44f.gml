// Original Mutations/SurgerySlot2.skill.gml:1
function fr_Mutations_SurgerySlot2_skill_gml___load() {

}

// Original Mutations/SurgerySlot2.skill.gml:1
function fr_Mutations_SurgerySlot2_skill_gml_init() {
global.fr_module_vars[$ "skill:SurgerySlot2"].sprSkillIcon = sprFR_sprSurgery_50ce02ced0d3;
;
global.fr_module_vars[$ "skill:SurgerySlot2"].sprSkillHud = sprFR_sprSurgeryIcon3_0db7ff52c1b4;
;
global.fr_module_vars[$ "skill:SurgerySlot2"].sprSkillHud2 = sprFR_sprSurgeryIcon4_fdbe9d5e36be;
;
global.fr_module_vars[$ "skill:SurgerySlot2"].sprChosenIcon = global.fr_module_vars[$ "skill:SurgerySlot2"].sprSkillHud;
;
global.fr_module_vars[$ "skill:SurgerySlot2"].skillNameAdjective = "";
;
global.fr_module_vars[$ "skill:SurgerySlot2"].skillNameNoun = "";
;
global.fr_module_vars[$ "skill:SurgerySlot2"].skillGainText = "";
;
global.fr_module_vars[$ "skill:SurgerySlot2"].skillLoseText = "";
;
global.fr_module_vars[$ "skill:SurgerySlot2"].statGainType = ["maxhealth"];
;
global.fr_module_vars[$ "skill:SurgerySlot2"].statGainAmount = 0;
;
global.fr_module_vars[$ "skill:SurgerySlot2"].statLoseType = ["maxhealth"];
;
global.fr_module_vars[$ "skill:SurgerySlot2"].statLoseAmount = 0;
;
fr_Mutations_SurgerySlot2_skill_gml_surgery_namelist();
;
fr_Mutations_SurgerySlot2_skill_gml_surgery_setup();
;
}

// Original Mutations/SurgerySlot2.skill.gml:22
function fr_Mutations_SurgerySlot2_skill_gml_game_start() {
fr_Mutations_SurgerySlot2_skill_gml_surgery_setup();
;
}

// Original Mutations/SurgerySlot2.skill.gml:25
function fr_Mutations_SurgerySlot2_skill_gml_skill_name() {
return scrFRLocalize(((string(global.fr_module_vars[$ "skill:SurgerySlot2"].skillNameAdjective) + " ") + string(global.fr_module_vars[$ "skill:SurgerySlot2"].skillNameNoun)));
;
}

// Original Mutations/SurgerySlot2.skill.gml:26
function fr_Mutations_SurgerySlot2_skill_gml_skill_text() {
return scrFRLocalize(((((("@sGAIN " + "@(color:2964142)") + global.fr_module_vars[$ "skill:SurgerySlot2"].skillGainText) + "#@sLOSE ") + "@(color:2964142)") + global.fr_module_vars[$ "skill:SurgerySlot2"].skillLoseText));
;
}

// Original Mutations/SurgerySlot2.skill.gml:28
function fr_Mutations_SurgerySlot2_skill_gml_skill_tip() {
return scrFRLocalize("...");
;
}

// Original Mutations/SurgerySlot2.skill.gml:29
function fr_Mutations_SurgerySlot2_skill_gml_skill_button() {
sprite_index = scrFRAreaSourceSprite(global.fr_module_vars[$ "skill:SurgerySlot2"].sprSkillIcon);
;
}

// Original Mutations/SurgerySlot2.skill.gml:30
function fr_Mutations_SurgerySlot2_skill_gml_skill_icon() {
return global.fr_module_vars[$ "skill:SurgerySlot2"].sprChosenIcon;
;
}

// Original Mutations/SurgerySlot2.skill.gml:31
function fr_Mutations_SurgerySlot2_skill_gml_skill_avail() {
return 0;
;
}

// Original Mutations/SurgerySlot2.skill.gml:32
function fr_Mutations_SurgerySlot2_skill_gml_skill_wepspec() {
return 0;
;
}

// Original Mutations/SurgerySlot2.skill.gml:33
function fr_Mutations_SurgerySlot2_skill_gml_skill_sacrifice() {
return false;
;
}

// Original Mutations/SurgerySlot2.skill.gml:34
function fr_Mutations_SurgerySlot2_skill_gml_skill_surgery() {
return true;
;
}

// Original Mutations/SurgerySlot2.skill.gml:36
function fr_Mutations_SurgerySlot2_skill_gml_skill_take() {
fr_Mutations_SurgerySlot2_skill_gml_surgery_applyStatChanges(scrFRIndexGet(global.fr_module_vars[$ "skill:SurgerySlot2"].statGainType, 0), global.fr_module_vars[$ "skill:SurgerySlot2"].statGainAmount);
;
fr_Mutations_SurgerySlot2_skill_gml_surgery_applyStatChanges(scrFRIndexGet(global.fr_module_vars[$ "skill:SurgerySlot2"].statLoseType, 0), (- global.fr_module_vars[$ "skill:SurgerySlot2"].statLoseAmount));
;
}

// Original Mutations/SurgerySlot2.skill.gml:40
function fr_Mutations_SurgerySlot2_skill_gml_skill_lose() {
fr_Mutations_SurgerySlot2_skill_gml_surgery_applyStatChanges(scrFRIndexGet(global.fr_module_vars[$ "skill:SurgerySlot2"].statGainType, 0), (- global.fr_module_vars[$ "skill:SurgerySlot2"].statGainAmount));
;
fr_Mutations_SurgerySlot2_skill_gml_surgery_applyStatChanges(scrFRIndexGet(global.fr_module_vars[$ "skill:SurgerySlot2"].statLoseType, 0), global.fr_module_vars[$ "skill:SurgerySlot2"].statLoseAmount);
;
fr_Mutations_SurgerySlot2_skill_gml_surgery_setup();
;
}

// Original Mutations/SurgerySlot2.skill.gml:45
function fr_Mutations_SurgerySlot2_skill_gml_surgery_setup() {
global.fr_module_vars[$ "skill:SurgerySlot2"].sprChosenIcon = scrFRSourceChoose(global.fr_module_vars[$ "skill:SurgerySlot2"].sprSkillHud, global.fr_module_vars[$ "skill:SurgerySlot2"].sprSkillHud2);
;
global.fr_module_vars[$ "skill:SurgerySlot2"].skillNameAdjective = scrFRIndexGet(global.fr_module_vars[$ "skill:SurgerySlot2"].nameAdjectives, scrFRSourceIRandom((array_length(global.fr_module_vars[$ "skill:SurgerySlot2"].nameAdjectives) - 1)));
;
global.fr_module_vars[$ "skill:SurgerySlot2"].skillNameNoun = scrFRIndexGet(global.fr_module_vars[$ "skill:SurgerySlot2"].nameNouns, scrFRSourceIRandom((array_length(global.fr_module_vars[$ "skill:SurgerySlot2"].nameNouns) - 1)));
;
fr_Mutations_SurgerySlot2_skill_gml_surgery_rollStatTypes();
;
fr_Mutations_SurgerySlot2_skill_gml_surgery_applyText(1, scrFRIndexGet(global.fr_module_vars[$ "skill:SurgerySlot2"].statGainType, 0), global.fr_module_vars[$ "skill:SurgerySlot2"].statGainAmount);
;
fr_Mutations_SurgerySlot2_skill_gml_surgery_applyText(0, scrFRIndexGet(global.fr_module_vars[$ "skill:SurgerySlot2"].statLoseType, 0), global.fr_module_vars[$ "skill:SurgerySlot2"].statLoseAmount);
;
}

// Original Mutations/SurgerySlot2.skill.gml:56
function fr_Mutations_SurgerySlot2_skill_gml_surgery_rollStatTypes() {
global.fr_module_vars[$ "skill:SurgerySlot2"].statGainType = scrFRSourceChoose(["maxhealth", scrFRSourceIRandomRange(1, 3), 9], ["maxspeed", (round((scrFRSourceRandomRange(1, 2) / 0.20)) * 0.20), 6], ["accuracy", (round((scrFRSourceRandomRange(0.05, 0.40) / 0.05)) * 0.05), 5], ["reloadspeed", (round((scrFRSourceRandomRange(0.05, 0.25) / 0.05)) * 0.05), 30], ["maxammo", scrFRSourceIRandomRange(5, 20), 0.5], ["ammogain", scrFRSourceIRandomRange(1, 3), 6], ["projectilespeed", (round((scrFRSourceRandomRange(0.05, 0.4) / 0.05)) * 0.05), 12], ["radmax", (round((scrFRSourceIRandomRange(50, 300) / 10)) * 10), 0.03]);
global.fr_module_vars[$ "skill:SurgerySlot2"].statLoseType = scrFRSourceChoose(["maxhealth", 1, 4, 1, (1 / 0)], ["maxspeed", 0.2, 20, 0.2, (1 / 0)], ["accuracy", 0.05, 9, 0.05, 2.5], ["reloadspeed", 0.05, 18, 0.05, (0.05 * 20)], ["maxammo", 1, 0.5, 1, (1 / 0)], ["ammogain", 1, 5, 1, (1 / 0)], ["projectilespeed", 0.05, 12, 0.05, (0.05 * 90)]);
if ((scrFRIndexGet(global.fr_module_vars[$ "skill:SurgerySlot2"].statGainType, 0) == scrFRIndexGet(global.fr_module_vars[$ "skill:SurgerySlot2"].statLoseType, 0))) {
{
fr_Mutations_SurgerySlot2_skill_gml_surgery_rollStatTypes();
;
exit;
;
}
}
global.fr_module_vars[$ "skill:SurgerySlot2"].statGainAmount = scrFRIndexGet(global.fr_module_vars[$ "skill:SurgerySlot2"].statGainType, 1);
;
fr_Mutations_SurgerySlot2_skill_gml_surgery_rollStatChanges();
;
}

// Original Mutations/SurgerySlot2.skill.gml:86
function fr_Mutations_SurgerySlot2_skill_gml_surgery_rollStatChanges() {
var _frl__value = (global.fr_module_vars[$ "skill:SurgerySlot2"].statGainAmount * scrFRIndexGet(global.fr_module_vars[$ "skill:SurgerySlot2"].statGainType, 2));
;
var _frl__loseType = scrFRIndexGet(global.fr_module_vars[$ "skill:SurgerySlot2"].statLoseType, 0);
var _frl__loseRound = scrFRIndexGet(global.fr_module_vars[$ "skill:SurgerySlot2"].statLoseType, 1);
var _frl__loseCost = scrFRIndexGet(global.fr_module_vars[$ "skill:SurgerySlot2"].statLoseType, 2);
var _frl__loseMin = scrFRIndexGet(global.fr_module_vars[$ "skill:SurgerySlot2"].statLoseType, 3);
var _frl__loseMax = scrFRIndexGet(global.fr_module_vars[$ "skill:SurgerySlot2"].statLoseType, 4);
var _frl__loseMode = "divide";
var _frl__loss = (_frl__value / _frl__loseCost);
var _frl__loseAmount = clamp((round((_frl__loss / _frl__loseRound)) * _frl__loseRound), _frl__loseMin, _frl__loseMax);
;
global.fr_module_vars[$ "skill:SurgerySlot2"].statLoseAmount = _frl__loseAmount;
;
}

// Original Mutations/SurgerySlot2.skill.gml:118
function fr_Mutations_SurgerySlot2_skill_gml_surgery_applyStatChanges(_frl__stat=undefined, _frl__amount=undefined) {
{ var __fr_switch_value1=_frl__stat, __fr_switch_case2=-1;
if(__fr_switch_case2==-1 && __fr_switch_value1==("maxhealth")) __fr_switch_case2=0;
if(__fr_switch_case2==-1 && __fr_switch_value1==("maxspeed")) __fr_switch_case2=1;
if(__fr_switch_case2==-1 && __fr_switch_value1==("accuracy")) __fr_switch_case2=2;
if(__fr_switch_case2==-1 && __fr_switch_value1==("reloadspeed")) __fr_switch_case2=3;
if(__fr_switch_case2==-1 && __fr_switch_value1==("maxammo")) __fr_switch_case2=4;
if(__fr_switch_case2==-1 && __fr_switch_value1==("ammogain")) __fr_switch_case2=5;
if(__fr_switch_case2==-1 && __fr_switch_value1==("projectilespeed")) __fr_switch_case2=6;
if(__fr_switch_case2==-1 && __fr_switch_value1==("radmax")) __fr_switch_case2=7;
if(__fr_switch_case2==-1) __fr_switch_case2=-1;
switch(__fr_switch_case2) {
case 0:
{ var __fr_with3 = scrFRWithValues(Player), __fr_break5=false;
for (var __fr_index4=0; __fr_index4<array_length(__fr_with3); ++__fr_index4) {
if(scrFRScopeExists(__fr_with3[__fr_index4])) with (__fr_with3[__fr_index4]) {
{
scrFRMaxHealthWrite(id, _frl__amount, "+=");
;
if ((hp > max_hp)) {
{
hp = max_hp;
;
}
}
}
}
if(__fr_break5) break;
}}
break;
;
case 1:
scrFRModCall("mod", "wibbly", "speedBonus_add", (- 1), _frl__amount);
;
break;
;
case 2:
scrFRModCall("mod", "wibbly", "accuracyBonus_add", (- 1), _frl__amount);
;
break;
;
case 3:
scrFRModCall("mod", "wibbly", "reloadBonus_add", (- 1), _frl__amount);
;
break;
;
case 4:
scrFRModCall("mod", "wibbly", "ammoMaxBonus_add", (- 1), 1, round((_frl__amount * 4.6)));
;
var _frl__ammoType = 2;
;
repeat (4) {
scrFRModCall("mod", "wibbly", "ammoMaxBonus_add", (- 1), _frl__ammoType, _frl__amount);
;
_frl__ammoType += 1;
}
break;
;
case 5:
scrFRModCall("mod", "wibbly", "ammoGainBonus_add", (- 1), 1, round((_frl__amount * 3.2)));
;
scrFRModCall("mod", "wibbly", "ammoGainBonus_add", (- 1), 2, round((_frl__amount * 0.8)));
;
scrFRModCall("mod", "wibbly", "ammoGainBonus_add", (- 1), 3, round((_frl__amount * 0.7)));
;
scrFRModCall("mod", "wibbly", "ammoGainBonus_add", (- 1), 4, round((_frl__amount * 0.6)));
;
scrFRModCall("mod", "wibbly", "ammoGainBonus_add", (- 1), 5, round((_frl__amount * 1)));
;
break;
;
case 6:
scrFRModCall("mod", "wibbly", "projectileSpeedBonus_add", (- 1), _frl__amount);
;
break;
;
case 7:
scrFRModCall("mod", "wibbly", "radMaxBonus_add", _frl__amount);
;
break;
;
}
}
}

// Original Mutations/SurgerySlot2.skill.gml:167
function fr_Mutations_SurgerySlot2_skill_gml_surgery_applyText(_frl__gain=undefined, _frl__stat=undefined, _frl__amount=undefined) {
var _frl__text = "";
{ var __fr_switch_value1=_frl__stat, __fr_switch_case2=-1;
if(__fr_switch_case2==-1 && __fr_switch_value1==("maxhealth")) __fr_switch_case2=0;
if(__fr_switch_case2==-1 && __fr_switch_value1==("maxspeed")) __fr_switch_case2=1;
if(__fr_switch_case2==-1 && __fr_switch_value1==("accuracy")) __fr_switch_case2=2;
if(__fr_switch_case2==-1 && __fr_switch_value1==("reloadspeed")) __fr_switch_case2=3;
if(__fr_switch_case2==-1 && __fr_switch_value1==("maxammo")) __fr_switch_case2=4;
if(__fr_switch_case2==-1 && __fr_switch_value1==("ammogain")) __fr_switch_case2=5;
if(__fr_switch_case2==-1 && __fr_switch_value1==("projectilespeed")) __fr_switch_case2=6;
if(__fr_switch_case2==-1 && __fr_switch_value1==("radmax")) __fr_switch_case2=7;
if(__fr_switch_case2==-1) __fr_switch_case2=-1;
switch(__fr_switch_case2) {
case 0:
_frl__text = (string(_frl__amount) + " @wMAX HEALTH");
break;
;
case 1:
_frl__text = (string(round(((_frl__amount / 4) * 100))) + "% @wMOVEMENT SPEED");
break;
;
case 2:
_frl__text = (string(round((_frl__amount * 100))) + "% @wACCURACY");
break;
;
case 3:
_frl__text = (string(round((_frl__amount * 100))) + "% @wRELOAD SPEED");
break;
;
case 4:
_frl__text = (string(_frl__amount) + " @wMAX AMMO");
break;
;
case 5:
_frl__text = (string(_frl__amount) + "0% @wAMMO GAIN");
break;
;
case 6:
_frl__text = (string(round((_frl__amount * 100))) + "% @wPROJECTILE SPEED");
break;
;
case 7:
_frl__text = (string(_frl__amount) + " @wRAD CAPACITY");
break;
;
}
}
if (_frl__gain) {
{
global.fr_module_vars[$ "skill:SurgerySlot2"].skillGainText = _frl__text;
;
}
} else {
{
global.fr_module_vars[$ "skill:SurgerySlot2"].skillLoseText = _frl__text;
;
}
}
}

// Original Mutations/SurgerySlot2.skill.gml:213
function fr_Mutations_SurgerySlot2_skill_gml_surgery_namelist() {
global.fr_module_vars[$ "skill:SurgerySlot2"].nameAdjectives = ["UNENDING", "ABYSMAL", "HELLSUNG", "BOILING", "SERRATED", "BROKEN", "SEETHING", "UNRELENTING", "BOUNDLESS", "ZANY", "INNOCENT", "UNMATCHED", "DARK", "ROYAL", "INVASIVE", "RABID", "WARBORN", "BATTLE-READY", "CURVED", "SUCCULENT", "LOVELY", "WONDERFUL", "EUPHORIC", "HUGE", "POWERFUL", "WARPED", "DANGEROUS", "HYPER-BALLISTIC", "CRUNCHY", "LUDICRIOUS", "ATROCIOUS", "GLORIOUS", "UNLEASHED", "BIG", "TINY", "SMALL", "SUS", "SUPER-DUPER", "SUPERCALIFRAGILISTICEXPIALIDOCIOUS", "SIGMA", "ALPHA", "BETA", "EVIL", "SILLY", "SWEATY", "REGRETTABLE", "THIN", "JUICY", "TERRIFYING", "HEAVY", "HEFTY", "WEIGHTLESS", "LIGHT", "SPOOKY", "SCARY", "CRISPY", "PAINFUL", "SLIMY", "EXTRA", "CRIMINAL", "CHUBBY", "BLOODY", "LEAFY", "USEFUL", "VIOLENT", "GAPING", "INCOMPETENT", "YUMMY", "MINDLESS", "BITTER", "SWEET", "PEACEFUL", "FEARFUL", "DAMAGED", "DEFECTIVE", "ASPIRING", "UNADVISED", "SOGGY", "MACHO", "ENCHANTING", "CRAZY", "WACKY", "CHAOTIC", "CROOKED", "TABOO", "HOT", "COLD", "ICY", "CHILLING", "ECONOMICS", "EXTREME", "INFAMOUS", "DISPOSABLE", "UNFORGETTABLE", "LIFE-CHANGING", "TRAUMATIZING", "MODERN", "RESTLESS", "EASY", "IMPORTANT", "DRAMATIC", "EMOTIONAL", "HELLISH", "BLISSFUL", "LARGE", "CHEESED", "SWOLLEN", "CREAMY", "WICKED", "EROTIC", "SENSUAL", "TROPICAL", "STICKY", "SQUEAKY", "STINKY", "CHARISMATIC", "FLAMING-HOT", "DINOSAUR", "BUG", "COMPENSATING", "MESSY", "GNARLED", "EXCESSIVE", "SHARK", "REDEEMED", "BUDGET", "SCRAMBLED", "LEGENDARY", "AGGRESSIVE", "MOM'S", "THE", "QUIVERING", "WIZARDLY", "POINTLESS", "KERATIN", "SLOPPY", "HARMFUL", "FOREIGN", "ENTICING", "LESS", "COMPOUND", "VARIA", "UNCANNY", "LOST", "ENDLESS", "MYSTERIOUS", "ELECTRIC", "FROG", "SOFT", "@(color:12884)BROWN", "HOLLOW", "YOUR", "TYPICAL", "MUSKY", "TIGHT", "REPLICA", "LUMPY", "VULGAR", "WIGGLY", "FAMILIAR", "FERTILE", "MEDICAL", "PURE", "MERE", "ANGRY", "SOME", "@(color:255)R@(color:37887)A@(color:55039)I@(color:65452)N@(color:4325120)B@(color:16773376)O@(color:16711845)W@w", "ALL", "POOR", "TASTEFUL", "FURRY", "POLITICAL", "ROTTEN", "INVINCIBLE", "MEAT", "BERSERK", "BIZARRE", "HEALTHY", "WET", "MOIST", "FUZZY", "WEIRD", "BRITTLE", "SUBMISSIVE", "SMOOTH", "DEVIOUS", "LOUD", "WILD", "WHITE", "WEAK", "STRONG", "SCROLL OF", "TWISTED", "WARTY", "MOTHER OF ALL", "TOXIC", "TOTAL", "EXPERT", "SCUMMY", "PROCEDURALLY GENERATED", "SPEEDY", "HALF", "DAY OF", "THE ONLY", "IMMATURE", "BAD", "IT'S KIND OF LIKE...", "THE WORST", "HELPFUL", "SUDDEN", "ECCLECTIC", "TRAINED", "REFINED", "INTOLERABLE", "STEAMY", "TOUCH OF", "FRIENDLY", "WHIRLING", "NON-STOP", "WASTELAND", "MUTANT", "FAIR", "VISCERAL", "SENTIENT", "@q@p", "BALD", "MUSICAL", "BRASH", "ILLEGAL", "BANNED", "FRUITY", "GIGA", "MEGA", "ACID-FILLED", "OLD-SCHOOL", "MILLION-DOLLAR", "E -", "DAILY", "COWBOY", "STANDARD-ISSUE", "CUTE", "DEVIL'S", "BOOTLEG", "PRO", "COOKING", "HATED", "PRETENTIOUS", "MR.", "GASEOUS", "POWDERED", "CLOWN", "SONIC", "NIHILIST", "DOOM", "STOLEN", "HOLIDAY", "STEAMPUNK", "REFRESHING", "EXPERIMENTAL", "CONTAGIOUS", "LA", "TEENY", "ALIEN", "SAVAGE", "DRAGON", "DRACONIC", "WACKY INFLATABLE", "INFLATED", "BIG AND ROUND", "UNIQUE", "EXOTIC", "THICK", "GUILTY", "CRUEL", "PROBLEMATIC", "NERDY", "CALMING", "JOYOUS", "TRAITOROUS", "ENTROPIC", "OOPS! ALL", "DUBIOUS", "A SPOONFUL OF", "GHOSTLY", "GHASTLY", "FRESH", "DEVILISH", "STRONG, WILD", "KINDA AWESOME", "LETHAL", "NOTHIN' BUT", "STRETCHED", "FUNNY", "NUCLEAR", "AMAZING", "OH! THE", "QUESTIONABLE", "YIKES! ITS", "HI! IM"];
;
global.fr_module_vars[$ "skill:SurgerySlot2"].nameNouns = ["EXPERIENCE", "TERROR", "TORTURE", "TEETH", "RIBS", "JAWBONE", "LUNGS", "LEGS", "BRAIN", "MIND", "THIGHS", "FISTS", "TONGUE", "EYES", "BLOOD", "GARBAGE", "DRAMA", "MOOD", "PHILOSOPHY", "PERSPECTIVE", "LENGTH", "CHUNGUS", "BALLS", "JUICES", "TIME", "LIGAMENTS", "NEURONS", "MOTIVES", "HEART", "ARMS", "FINGERS", "PALMS", "SHOULDERS", "FEET", "STOMACH", "HUNGER", "SKIN", "LUST", "HEAD", "APPENDIX", "VEINS", "BONES", "SKULL", "NIGHTMARE", "INVOLVEMENT", "REALITY", "WISDOM", "PROOF", "TRIAL", "DEVICES", "CHEMICALS", "PROCEDURE", "EXPERIMENT", "TEST-DRIVE", "RUN", "BOOSTERS", "THOUGHTS", "SONG", "TREAT", "EMPLOYMENT", "UNDERTAKING", "BAN", "LOVE", "SURPRISE", "TOES", "REWARD", "BONUS", "AWAKENING", "INJECTION", "MARROW", "SLUSHIE", "FARTS", "SHOES", "MANDATE", "IMAGINATION", "TECHNOLOGY", "MODE", "ANCESTRY", "VIBE", "LOBOTOMY", "IMPLANTS", "DRUGS", "JOKE", "ARSENAL", "SMILE", "EFFIGY", "WINGS", "LISP", "HAIR", "COMPOUND", "FREAK", "ADDON", "ADDONS", "SYNDROME", "POWERS", "EGGS", "TASTE", "BREATH", "ZONE", "MISTAKE", "SPOT", "KNOWLEDGE", "LUMPS", "TRUTH", "GROWTH", "PRESENCE", "CHILD", "GOALS", "UNION", "PERSONALITY", "INCLINATION", "MEAT", "SPIRIT", "VISIONS", "APPETITE", "DREAMS", "AWARD", "ACT", "UNIFORM", "SCIENCE", "BUTT", "ART", "WORDS", "MUTATION", "TRAITS", "STENCH", "REQUEST", "FRIEND", "QUIRKS", "WARFARE", "KING", "BANDITRY", "AGE", "SCALP", "ANDY", "WORLD", "THREAT", "ROLEPLAY", "CHIN", "CHALLENGE", "MAGGOTS", "MILK", "EXOSKELETON", "ACID", "BOMBS", "MEDICINE", "DRIP", "LICENSE", "LEGEND", "LAUGHTER", "HAT", "ACCOUNT", "PROCLAMATION", "DESIRE", "BEARD", "HONOR", "SEED", "MEDIA", "SACRIFICE", "KILLER", "BREATH", "TWITCH", "REFLEXES", "INSIGHT", "CONTRACT", "SPECIALIST", "ISOTOPES", "IDEA", "NERVE", "PHOBIA", "AND STUFF", "SCARS", "LOVE", "ENABLED", "CLAWS", "SAUCE", "IS YOU", "MIRACLE", "VOICES", "DREAMS", "PHOTOGRAPH", "DRAGON", "WEAPONS", "LEMONADE", "BETRAYAL", "CREAM", "CUSTARD", "SYRUP", "CREATURE", "BEAST", "CRIMINAL", "BABY", "COMPANY", "WAR", "JOB", "FRAGRANCE", "PAWS", "PAW", "STRING", "ENHANCEMENTS", "BEAK", "BONE", "THRONE", "GAMEPLAY", "SKILLS", "STYLE", "BUG", "CHASM", "PLANS", "TUNES"];
;
}
