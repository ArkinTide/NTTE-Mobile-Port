// ntte.mod3100..3240/5708: source camp Parrot wall perch and first-run marker.
function scrNTTEFullRaceCampDecorationStep() {
    if(!instance_exists(Menu) || !instance_exists(Wall)) return;
    // MenuGen rebuilds wall tops after the random floor makers finish.
    if(instance_exists(FloorMaker)) return;
    with(MenuGen) if(alarm[1]>=0) return;
    with(CampChar) if(race==NTTEFullRace.Parrot && !scrNTTEFullValue(id,"ntte_parrot_camp_setup",false)) {
        var _char=id
        with(Wall) if(place_free(x,y+16) && place_meeting(x,y+16,Floor) && distance_to_object(CampChar)>32) {
            var _left=place_free(x-16,y+8),_right=place_free(x+16,y+8)
            if(_left || _right) {
                _char.image_xscale=(_left && _right)?choose(-1,1):(_left?-1:1)
                _char.spr_shadow_x=0;_char.spr_shadow_y=0
                var _px=_char.image_xscale>0 ? bbox_right-4:bbox_left+4,
                    _py=bbox_bottom-1-19
                var _top=scrNTTEFullTopCreate(_px,_py,_char,0,0)
                if(instance_exists(_top)) _char.ntte_parrot_camp_setup=true
                break
            }
        }
    }
}
// ntte.mod4093: wall-perched Parrot must be redrawn after wall tops.
// Menu.Draw runs before the character portraits and after world geometry.
function scrNTTEFullRaceCampDecorationDraw() {
    if(!instance_exists(Menu)) return 0
    var _drawn=0
    with(CampChar) if(visible && race==NTTEFullRace.Parrot
        && (position_meeting(x,y+8,Wall) || !position_meeting(x,y+8,Floor))) {
        draw_self();_drawn++
    }
    return _drawn
}
function scrNTTEFullRaceNewMarker(_icon,_hover=false) {
    if(!instance_exists(_icon) || !_icon.visible || !_icon.can) return undefined
    var _key=scrNTTEFullRaceKey(_icon.race)
    if(_key=="" || scrNTTEFullValue(global.ntte_full_progress.stats,"race:"+_key+":runs",0)>0) return undefined
    // Native character slots already use GUI coordinates and have no source
    // alarm1 bump. Use their actual stable start position and pointer state.
    return {sprite:sprNew,image:_icon.image_index,x:_icon.xstart,y:_icon.ystart-_hover}
}
function scrNTTEFullRaceNewMarkerDraw(_icon,_hover=false) {
    var _marker=scrNTTEFullRaceNewMarker(_icon,_hover)
    if(is_undefined(_marker)) return false
    draw_sprite(_marker.sprite,_marker.image,_marker.x,_marker.y)
    return true
}
