function scrNTTEFullRedSpiralNativeTests() {
    var _before=scrNTTEFullInstances(all),_game=scrNTTEFullAreaGeneratorSnapshot(GameCont),
        _players=scrNTTEFullAreaGeneratorSnapshot(Player),_uber=scrNTTEFullAreaGeneratorSnapshot(UberCont),
        _spirals=scrNTTEFullAreaGeneratorSnapshot(Spiral),_controllers=scrNTTEFullAreaGeneratorSnapshot(SpiralCont),
        _seed=random_get_seed(),_p=instance_find(Player,0),
        _source_state=scrNTTEFullValue(GameCont,"ntte_full_source_seed",undefined)
    if(is_struct(_source_state)) GameCont.ntte_full_source_seed=scrNTTEFullSourceSeedCopy(_source_state)
    try {
        GameCont.area=206;scrNTTEFullSourceRandomSeed(1)
        var _source_random=scrNTTEFullSourceSeedState().random,_timescale=timescale
        var _controller=instance_create(view_width/2,view_height/2,SpiralCont),
            _stars=[],_debris=0,_number=sprite_get_number(scrNTTERefSprite("Starfield"))
        with(NTTEFullSpiralStarfield) if(array_get_index(_before,id)<0) array_push(_stars,id)
        with(SpiralDebris) if(array_get_index(_before,id)<0 && object_index==SpiralDebris && sprite_index==_p.spr_hurt && image_index==1) {_debris+=1}
        assert(_controller.time==0 && array_length(_stars)==_number && _debris==1,
            "Red actual native SpiralCont setup omitted time reset/all starfield frames/seeded player debris")
        assert(timescale==_timescale && scrNTTEFullSourceSeedState().random==_source_random,
            "Red source setup wrapper leaked forced1tick time scale/preview RNG into gameplay")
        for(var _i=0;_i<_number;++_i) {
            var _star=_stars[_i]
            assert(instance_is(_star,SpiralDebris) && _star.image_index==_number-1-_i
                && _star.sprite_index==scrNTTERefSprite("Starfield") && _star.turnspeed==0,
                "Red actual starfield lost inherited debris/source descending image order/zero turn")
        }
        var _ring=instance_create(_controller.x,_controller.y,Spiral)
        assert(_ring.sprite_index==scrNTTERefSprite("SpiralStarfield") && _ring.lanim==-100
            && _ring.colors[0]==make_color_rgb(30,14,29) && _ring.colors[1]==make_color_rgb(16,10,25),
            "Red native Spiral constructor failed source artwork/two exact colors/no lightning binding")
        _controller.time=100
        var _star=_stars[0],_index=_star.image_index,_expected=0.8+0.4*_index+arctan(1)
        with(_star) event_perform(ev_step,ev_step_normal)
        assert(abs(_star.image_xscale-_expected)<=0.00001 && _star.image_yscale==_star.image_xscale
            && _star.rotspeed==_star.image_xscale && _star.dist==0 && _star.grow==0,
            "Red real inherited debris/custom step lost arctan time/source spin/scale/orbit override")
        // The controller's source time is30ticks/second at30,60and120Hz.
        _controller.time=0;_controller.ntte_full_spiral_phase=0
        repeat(round(30/timescale)) with(_controller) event_perform(ev_step,ev_step_normal)
        assert(_controller.time==30 && _controller.ntte_full_spiral_phase==0,
            "Native SpiralCont loading-screen source time/ring cadence is not30Hz")
        with(NTTEFullSpiralStarfield) if(array_get_index(_before,id)<0) instance_destroy(id,false)
        var _normal=instance_create(_controller.x,_controller.y,Spiral)
        assert(_normal.sprite_index==sprSpiral,"Starfield setup stayed bound after all source starfield instances disappeared")
    }
    finally {
        scrNTTEFullMergedRuntimeTestCleanup(_before)
        scrNTTEFullAreaGeneratorRestore(_game);scrNTTEFullAreaGeneratorRestore(_players)
        scrNTTEFullAreaGeneratorRestore(_uber);scrNTTEFullAreaGeneratorRestore(_spirals);scrNTTEFullAreaGeneratorRestore(_controllers)
        GameCont.ntte_full_source_seed=_source_state
        random_set_seed(_seed)
    }
    scrNTTESmokeLog("FULL RED SPIRAL: real native controller post-warmup/time reset/player-debris/all original frames/actual inherited starfield step/arctan scale+spin/dynamic original art+two-color binding/30Hz cadence/unbind OK @"+string(30/timescale))
}
