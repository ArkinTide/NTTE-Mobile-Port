// Original Mutations/BurdenPlagueOfFlesh.skill.gml:1
function fr_Mutations_BurdenPlagueOfFlesh_skill_gml___load() {

}

// Original Mutations/BurdenPlagueOfFlesh.skill.gml:1
function fr_Mutations_BurdenPlagueOfFlesh_skill_gml_init() {
global.fr_module_vars[$ "skill:BurdenPlagueOfFlesh"].sprSkillIcon = sprFR_sprBurden_780c79a91ee6;
global.fr_module_vars[$ "skill:BurdenPlagueOfFlesh"].sprSkillHud = sprFR_sprBurdenPelagicPredicam_fc6a5d58fa9f;
}

// Original Mutations/BurdenPlagueOfFlesh.skill.gml:7
function fr_Mutations_BurdenPlagueOfFlesh_skill_gml_skill_name() {
return scrFRLocalize("VISCERA VICISSITUDE");
;
}

// Original Mutations/BurdenPlagueOfFlesh.skill.gml:8
function fr_Mutations_BurdenPlagueOfFlesh_skill_gml_skill_text() {
return scrFRLocalize("@q@(color:2964142)IT HUNGERS");
;
}

// Original Mutations/BurdenPlagueOfFlesh.skill.gml:9
function fr_Mutations_BurdenPlagueOfFlesh_skill_gml_skill_tip() {
return scrFRLocalize("SMELLS OF CARRION");
;
}

// Original Mutations/BurdenPlagueOfFlesh.skill.gml:10
function fr_Mutations_BurdenPlagueOfFlesh_skill_gml_skill_button() {
sprite_index = scrFRAreaSourceSprite(global.fr_module_vars[$ "skill:BurdenPlagueOfFlesh"].sprSkillIcon);
;
}

// Original Mutations/BurdenPlagueOfFlesh.skill.gml:11
function fr_Mutations_BurdenPlagueOfFlesh_skill_gml_skill_icon() {
return global.fr_module_vars[$ "skill:BurdenPlagueOfFlesh"].sprSkillHud;
;
}

// Original Mutations/BurdenPlagueOfFlesh.skill.gml:12
function fr_Mutations_BurdenPlagueOfFlesh_skill_gml_skill_avail() {
return 0;
;
}

// Original Mutations/BurdenPlagueOfFlesh.skill.gml:13
function fr_Mutations_BurdenPlagueOfFlesh_skill_gml_skill_wepspec() {
return 0;
;
}

// Original Mutations/BurdenPlagueOfFlesh.skill.gml:14
function fr_Mutations_BurdenPlagueOfFlesh_skill_gml_skill_sacrifice() {
return false;
;
}

// Original Mutations/BurdenPlagueOfFlesh.skill.gml:15
function fr_Mutations_BurdenPlagueOfFlesh_skill_gml_skill_burden() {
return true;
;
}
