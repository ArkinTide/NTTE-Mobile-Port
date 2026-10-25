// Source petlib4914..4967. Setup is deferred until the common native Step,
// matching source setup after the creator has assigned final object fields.
// In particular PetCuzStep creates YungCuz and immediately sets ntte_cuz;
// a Create-event hook would spawn a duplicate companion before that binding.
function scrNTTEFullPetNativeEntryStep() {
    if(!instance_exists(GameCont)) return;
    with(LastDie) if(!scrNTTEFullValue(id,"ntte_guardian_setup",false)) {
        ntte_guardian_setup=true;team=0
        var _pet=scrNTTEFullPetCreate(x,y,"Guardian"),_away=point_direction(0,0,-image_xscale,-image_yscale)
        with(_pet) {
            sprite_index=spr_appear;team=other.team;ntte_pet_alarm=30;can_escape=true
            scrNTTEFullPetWalk(_away,15)
            right=lengthdir_x(1,direction+180)>=0 ? 1:-1
        }
    }
    with(YungCuz) {
        if(is_undefined(scrNTTEFullValue(id,"ntte_cuz",undefined))) {
            ntte_cuz=spr_idle==sprCuzIdle ? scrNTTEFullPetCreate(x,y,"Cuz"):noone
            if(instance_exists(ntte_cuz)) ntte_cuz.cuz=id
        }
        if(spr_to==sprCuzInteractTo && spr_from==sprCuzInteractFrom) {
            var _lastSprite=sprite_index,_lastImage=image_index,_looking=distance_to_object(Player)<=64
            sprite_index=_looking ? spr_idle:spr_heya
            event_perform(ev_other,ev_animation_end)
            if(sprite_index==(_looking ? spr_from:spr_to)) {
                spr_from=sprCuzInteractTo;spr_to=sprCuzInteractFrom
            }
            sprite_index=_lastSprite;image_index=_lastImage
        }
    }
}
