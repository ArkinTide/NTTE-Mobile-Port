// Robocenter laser geometry is stationary. Keep the source's exact mask and
// binary-search precision, without resolving its module reference on every
// probe. The actual damaging beam retains its native collision events.
function scrFRRobocenterLaserCheck(_length) {
    x=xstart+lengthdir_x(_length,image_angle);
    y=ystart+lengthdir_y(_length,image_angle);
    image_xscale=_length/2;
    return place_meeting(x,y,Wall);
}
function scrFRRobocenterBeamLength(_search_length=500) {
    var _length=_search_length,_difference=_search_length;
    if(scrFRRobocenterLaserCheck(_length)) {
        _difference/=2;_length-=_difference;
    } else return _search_length;
    while(_difference>1) {
        _difference/=2;
        if(scrFRRobocenterLaserCheck(_length)) _length-=_difference;
        else _length+=_difference;
    }
    return _length;
}

function scrFRRobocenterWarningVisual() {
    // Authored warning on_hit/on_wall are both `nothing`. A 500px warning
    // otherwise still enters every native Wall/hitme collision candidate at
    // every host frame, although none of those callbacks can change the game.
    // -1/-1 removes its mask entirely; the original geometry has already been
    // scanned and the original source lifetime/creator cleanup remains live.
    spr_idle=sprite_index;sprite_index=-1;mask_index=-1;
    on_draw=scrFRRobocenterWarningDraw;
}
function scrFRRobocenterWarningDraw() {
    draw_sprite_ext(spr_idle,image_index,xstart,ystart,image_xscale,image_yscale,image_angle,image_blend,1);
    draw_sprite_ext(spr_idle,image_index,xstart,ystart,image_xscale,image_yscale*1.7,image_angle,image_blend,.2);
}
