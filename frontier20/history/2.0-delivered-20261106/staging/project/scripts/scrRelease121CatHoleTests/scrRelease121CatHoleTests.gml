function scrRelease121CatHoleTests() {
    var _before=scrNTTEFullInstances(all),_game=scrNTTEFullAreaGeneratorSnapshot(GameCont),
        _seed=random_get_seed(),_active_floors=true;
    try {
        GameCont.area=scrNTTEFullAreaId("lair");
        for(var _ix=0;_ix<4;++_ix) for(var _iy=0;_iy<4;++_iy)
            instance_create(62000+32*_ix,62000+32*_iy,Floor);
        with(Floor) if(x>=62000 && y>=62000) mcr_floor_make_walls;
        var _floor_count=instance_number(Floor),_wall_count=instance_number(Wall),
            _cat=instance_create(62048,62048,NTTECat),_hp=_cat.hp;
        // Independent old-path witness: the former 64px push cannot recover
        // a cover that was generated well outside the floor footprint.
        _cat.x=62528;_cat.y=62048;
        assert(!scrNTTEDesertBudge(_cat),"Outside-cover fixture no longer witnesses the old64px failure");
        with(_cat) assert(!position_meeting(x,y,Floor),"Old path unexpectedly found Floor");
        _cat.x=62048;_cat.y=62048;
        for(var _case=0;_case<4;++_case) {
            var _x=_case==0?62528:(_case==1?62000:62048),
                _cover=instance_create(_x,62048,NTTECatHole),_obstacle=noone;
            if(_case>=2) {
                with(_cover) assert(scrNTTECatHoleEnsure(),"Initial native cover placement failed");
                _obstacle=instance_create(_cover.x,_cover.y,_case==2?Wall:InvisiWall);
            }
            with(_cover) assert(!scrNTTECatGroundClear(x,y),"Missing actual outside/late-wall cover witness");
            _cat.x=62048;_cat.y=62048;
            with(_cat) {scrNTTECatHide();target=noone;}
            _cover.target=_cat;_cover.image_index=2;
            // Real registered CatHole.Step must validate before releasing Cat.
            with(_cover) event_perform(ev_step,ev_step_normal);
            with(_cover) assert(scrNTTECatGroundClear(x,y),"Cover remained blocked/outside after native Step");
            with(_cat) assert(visible && ntte_cat_active && mask_index==mskRat
                && scrNTTECatGroundClear(x,y) && hp==_hp,"Cat emerged outside or lost health");
            assert(_cover.target==noone,"Cover retained an already emerged target");
            instance_destroy(_cover,false);
            if(instance_exists(_obstacle)) instance_destroy(_obstacle,false);
        }
        // Safe original placement and native capture/arrival anchors stay exact.
        var _cover=instance_create(62048,62048,NTTECatHole);
        with(_cover) assert(scrNTTECatHoleEnsure() && x==62048 && y==62048,"Valid cover moved");
        _cat.x=62048;_cat.y=62048;with(_cat) {scrNTTECatHide();target=noone;}
        var _reserved=false;
        with(_cat) _reserved=scrNTTECatReserveHole(true);
        assert(_reserved && _cover.target==_cat,"Hidden cat did not reserve a valid native cover");
        _cover.image_index=2;
        with(_cover) event_perform(ev_step,ev_step_normal);
        assert(_cat.x==62048 && _cat.y==62048 && _cat.ntte_cat_active,
            "Valid native cover changed the emergence anchor");
        instance_destroy(_cover,false);
        // Deleted/changed home ground uses real floors. With no floor at all,
        // remain hidden until geometry exists, without creating terrain/deaths.
        _cat.x=62528;_cat.y=62048;with(_cat) scrNTTECatHide();
        instance_deactivate_object(Floor);_active_floors=false;
        var _emerged=true;
        with(_cat) _emerged=scrNTTECatEmerge(ntte_cat_last_x,ntte_cat_last_y);
        assert(!_emerged && !_cat.ntte_cat_active && !_cat.visible && _cat.hp==_hp,
            "No-ground fallback exposed, killed, or damaged the hidden cat");
        instance_activate_object(Floor);_active_floors=true;
        with(_cat) {ntte_cat_hidden_age=240;event_perform(ev_step,ev_step_normal);}
        with(_cat) assert(ntte_cat_active && visible && scrNTTECatGroundClear(x,y) && hp==_hp,
            "Native no-cover timeout stranded the cat at its vanished home floor");
        assert(instance_number(Floor)==_floor_count && instance_number(Wall)==_wall_count,
            "Cat placement changed authored floor/wall geometry");
        scrNTTESmokeLog("PASS Release121 CatHole native Step/reservation/emergence outside64px/late Wall/InvisiWall, exact valid anchor and missing-ground recovery without terrain or HP changes @"+string(30/timescale));
    } finally {
        if(!_active_floors) instance_activate_object(Floor);
        scrNTTEFullMergedRuntimeTestCleanup(_before);
        scrNTTEFullAreaGeneratorRestore(_game);random_set_seed(_seed);
    }
}
