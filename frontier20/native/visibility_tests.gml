// The real source libCharm uses instances_seen for its second actor draw.
// An actor can overlap that screen even when its origin is outside the margin.
function scrFRVisibilityTests() {
    var _actor=instance_create(view_xview-64,view_yview+view_height/2,FRMarker);
    try {
        _actor.sprite_index=mskPlasma;_actor.mask_index=mskPlasma;
        _actor.image_xscale=64;_actor.image_yscale=1;
        assert(_actor.x<view_xview-24 && _actor.bbox_right>=view_xview,
            "Frontier visibility fixture must overlap the view with an offscreen origin");
        var _visible=scrFRInstancesSeen([_actor],24,24,-1);
        assert(array_length(_visible)==1 && _visible[0]==real(_actor),
            "Frontier Charm visibility omitted an actor whose bounds overlap the view");
        _actor.x=view_xview-2048;
        assert(_actor.bbox_right<view_xview-24 && array_length(scrFRInstancesSeen([_actor],24,24,-1))==0,
            "Frontier Charm visibility retained an actor entirely outside the view");
        scrNTTESmokeLog("PASS FRONTIER real-bounds Charm visibility includes overlapping origins and rejects offscreen bounds");
    } finally {if(instance_exists(_actor)) instance_destroy(_actor);}
}
