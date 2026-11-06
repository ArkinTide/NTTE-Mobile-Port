function scrNTTEFullThroneIntroNativeTests() {
    assert(scrNTTESmokeEnabled(),"Throne intro requires the explicit desktop fixture")
    var _before=scrNTTEFullInstances(all),_players=scrNTTEFullAreaGeneratorSnapshot(Player),
        _game=scrNTTEFullAreaGeneratorSnapshot(GameCont),_mus=scrNTTEFullAreaGeneratorSnapshot(MusCont),
        _seed=random_get_seed(),_surface=-1,_blank=-1
    try {
        var _p=instance_find(Player,0)
        with(Player) {x=10500;y=10500;xprevious=x;yprevious=y;speed=0;}
        var _body=instance_create(10000,10000,NothingInactive),_mask=_body.ntte_throne_intro_mask,
            _masks=instance_number(NTTEFullThroneIntroMask)
        assert(instance_exists(_mask) && _mask.creator==_body && !is_undefined(_mask.mask_index),
            "Actual NothingInactive Create did not acquire separate source mask")
        scrNTTEFullThroneIntroStep()
        assert(_body.depth>=object_get_depth(BackCont) && _body.spr_shadow==-1
            && _mask.mask_index==scrNTTERefSprite("msk.NothingInactiveCool") && !_mask.solid,
            "Inactive Throne source cool mask/background depth/shadow/temporary solid state changed")
        scrNTTEFullThroneIntroStep()
        assert(instance_number(NTTEFullThroneIntroMask)==_masks,"Intro mask duplicated on repeated actual global Step")
        // Both native body's old outward-kick Collisions must be replaced;
        // the separate mask owns source predictive wall resolution instead.
        _p.speed=0
        with(_p) with(_body) event_perform(ev_collision,Player)
        assert(_p.speed==0,"Inactive native body still applies old extra outward impulse")
        // The actual mask's lower stairs region applies source eight logical
        // frames and restores its previous solid flag after player processing.
        _p.x=_body.x;_p.y=_body.y+62;_p.xprevious=_p.x;_p.yprevious=_p.y
        _p.friction=0;_p.gravity=0;_p.speed=0;_p.ntte_stairslow=0
        scrNTTEFullThroneIntroStep()
        assert(_p.ntte_stairslow==8 && !_mask.solid,"Real intro mask omitted original lower-stairs collision or leaked solid")
        // The source wall path uses real InvisiWall Collision, rather than an
        // extra generic enemy push. Begin with a one-pixel overlap and a safe
        // previous position on the right side, moving left toward the body.
        _p.mask_index=object_get_mask(Player);_p.roll=false;_p.race=Race.Fish
        _p.x=11000;_p.y=_mask.y+10
        var _half=_p.x-_p.bbox_left
        _p.x=_mask.bbox_right+_half-1
        _p.xprevious=_p.x+8;_p.yprevious=_p.y;_p.direction=180;_p.speed=4*timescale
        scrNTTESmokeLog("THRONE collision BEFORE p="+string([_p.x,_p.y,_p.xprevious,_p.yprevious,_p.hspeed,_p.vspeed,_p.speed,_p.maxspeed,_p.bbox_left,_p.bbox_right])+" mask="+string([_mask.bbox_left,_mask.bbox_top,_mask.bbox_right,_mask.bbox_bottom,_mask.solid,object_get_parent(NTTEFullThroneIntroMask)]))
        scrNTTEFullThroneIntroStep()
        var _overlap=false
        with(_p) _overlap=place_meeting(x,y,_mask)
        scrNTTESmokeLog("THRONE collision AFTER p="+string([_p.x,_p.y,_p.xprevious,_p.yprevious,_p.hspeed,_p.vspeed,_p.speed,_p.bbox_left,_p.bbox_right])+" overlap="+string(_overlap)+" solid="+string(_mask.solid))
        assert(!_overlap && _p.speed<=4*timescale+0.001 && !_mask.solid,
            "Actual Throne smooth collision retained overlap or introduced source-absent kick")
        // Exercise the source rolling branch against the same actual solid
        // mask. The source WallBounce adjusts angle once and never integrates
        // x/y inside the helper; the enclosing predictive block owns motion.
        _p.x=_mask.bbox_right+_half+1;_p.y=_mask.y+10
        _p.xprevious=_p.x;_p.yprevious=_p.y;_p.direction=180;_p.speed=4*timescale
        _p.roll=true;_p.angle=100;_p.right=1
        var _rollx=_p.x,_rolly=_p.y
        _mask.solid=true
        with(_p) scrNTTEFullThroneIntroWallCollision()
        _mask.solid=false
        assert(abs(_p.angle-(100+(720-100)*0.7))<=0.001 && _p.x==_rollx && _p.y==_rolly,
            "Original rolling WallBounce lost source angle or added duplicate position integration")
        _p.roll=false
        with(Player) {x=10500;y=10500;xprevious=x;yprevious=y;speed=0;}
        // Real inactive death creates the real BecomeNothing and native pipe;
        // Create transfers the SAME mask instead of losing its cool->normal
        // transition. Source pipeline replaces the nearest pipe exactly once.
        _body.active=true;_body.hp=0
        with(_body) event_perform(ev_step,ev_step_normal)
        assert(!instance_exists(_body),"Actual inactive death did not hand off native intro body")
        _body=_mask.creator
        assert(instance_is(_body,BecomeNothing) && _body.ntte_throne_intro_mask==_mask,
            "Actual BecomeNothing Create did not retain physical source intro mask")
        var _pipe=instance_nearest(_body.x,_body.y,NothingPipes),_flames=instance_number(Wind),
            _pictures=instance_number(NTTEFullThroneIntroDecoration)
        assert(instance_exists(_pipe),"Native BecomeNothing did not create its ordinary pipe")
        scrNTTEFullThroneIntroStep()
        assert(!instance_exists(_pipe) && _mask.mask_index==mskNothingInactive
            && instance_number(NTTEFullThroneIntroDecoration)==_pictures+1 && instance_number(Wind)==_flames+4,
            "Real body handoff omitted source pipe depth copy, mask reset or four Wind flame fixes")
        var _picture=instance_nearest(_body.x,_body.y,NTTEFullThroneIntroDecoration)
        assert(_picture.sprite_index==object_get_sprite(NothingPipes) && _picture.depth==_body.depth
            && _picture.x==_body.x && _picture.y==_body.y,"Pipe replacement lost source body depth/position/artwork")
        scrNTTEFullThroneIntroStep()
        assert(instance_number(NTTEFullThroneIntroDecoration)==_pictures+1 && instance_number(Wind)==_flames+4,
            "Source cool-mask transition effects replayed on every Step")
        _p.speed=0
        with(_p) with(_body) event_perform(ev_collision,Player)
        assert(_p.speed==0,"BecomeNothing native body retained duplicate enemy push")
        // Alarm0 starts activation; Alarm4 only plays the earlier rumble.
        // Native Draw transfers spr_idle into sprite_index before Step uses
        // it, so exercise that real event too rather than leaving stale art.
        with(_body) event_perform(ev_alarm,0)
        assert(_body.spr_idle==sprNothingActivate && _body.drawimg==0,"Native intro activation alarm changed")
        with(_body) event_perform(ev_draw,0)
        _body.drawimg=0.99
        with(_body) event_perform(ev_step,ev_step_normal)
        scrNTTEFullThroneIntroStep()
        assert(_body.depth==object_get_depth(Nothing),"Real activation frame1 did not restore original boss depth")
        var _last_mask=_body.mask_index,_left=0,_right=0,_top=0,_bottom=0
        with(_body) {
            mask_index=object_get_mask(Nothing)
            _left=bbox_left;_right=bbox_right-1;_top=bbox_top;_bottom=bbox_bottom-1
            mask_index=_last_mask
        }
        var _lower=instance_create(_body.x,_bottom-4,Wall),_upper=instance_create(_body.x,_top+4,Wall),
            _outside=instance_create(_right+40,_bottom-4,Wall),_explo=instance_number(FloorExplo)
        _body.drawimg=1.99
        with(_body) event_perform(ev_step,ev_step_normal)
        scrNTTEFullThroneIntroStep()
        assert(!instance_exists(_lower) && instance_exists(_upper) && instance_exists(_outside)
            && instance_number(FloorExplo)==_explo+1 && _body.mask_index==_last_mask,
            "Real activation frame2 leg strip did not break only the lower intersecting wall/restore damage mask")
        _body.drawimg=5.99
        with(_body) event_perform(ev_step,ev_step_normal)
        scrNTTEFullThroneIntroStep()
        assert(!instance_exists(_upper) && instance_exists(_outside) && instance_number(FloorExplo)==_explo+2,
            "Real activation frame6 did not widen source wall strip while preserving an outside wall")
        // Actual source shadow artwork is drawn into the same native shadow
        // surface pass. Compare visible pixels before and after activation.
        _surface=surface_create(400,240);_blank=surface_create(400,240)
        assert(surface_exists(_surface) && surface_exists(_blank),"Throne shadow fixture surface allocation failed")
        _body.visible=true;_body.drawimg=0
        surface_set_target(_blank);draw_clear_alpha(c_black,0)
        scrNTTEFullThroneIntroShadowDraw(_body.x-200,_body.y-100);surface_reset_target()
        _body.drawimg=2
        surface_set_target(_surface);draw_clear_alpha(c_black,0)
        scrNTTEFullThroneIntroShadowDraw(_body.x-200,_body.y-100);surface_reset_target()
        var _changed=0
        for(var _x=0;_x<400;_x+=2) for(var _y=0;_y<240;_y+=2)
            if(surface_getpixel_ext(_surface,_x,_y)!=surface_getpixel_ext(_blank,_x,_y)) { _changed++; }
        assert(_changed>0,"Actual activation omitted source full-Throne shadow artwork")
        instance_destroy(_body,false);scrNTTEFullThroneIntroStep()
        assert(!instance_exists(_mask),"Orphan intro physical mask survived both intro bodies")
        scrNTTESmokeLog("PASS Throne native Create/death/Become/Alarm0/Draw/Step activation, cool physical mask, actual smooth/stairs/body-collision replacement, lower/all-height leg walls, one-shot pipe depth/flames, real shadow pixels/orphan cleanup")
    }
    finally {
        if(surface_exists(_surface)) surface_free(_surface)
        if(surface_exists(_blank)) surface_free(_blank)
        scrNTTEFullMergedRuntimeTestCleanup(_before)
        scrNTTEFullAreaGeneratorRestore(_players);scrNTTEFullAreaGeneratorRestore(_game);scrNTTEFullAreaGeneratorRestore(_mus)
        random_set_seed(_seed)
    }
}
