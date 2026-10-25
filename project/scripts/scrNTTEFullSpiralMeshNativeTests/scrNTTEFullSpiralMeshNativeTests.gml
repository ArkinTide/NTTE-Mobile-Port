function scrNTTEFullSpiralMeshNativeTests() {
    var _c0=make_color_rgb(30,14,29),_c1=make_color_rgb(16,10,25),
        _rings=[{x:64,y:64,angle:0,scale:0.1,colors:[_c0,_c1],type:0},
            {x:64,y:64,angle:90,scale:0.3,colors:[_c0,_c1],type:0},
            {x:999,y:999,angle:270,scale:20,colors:[_c0,_c1],type:0}],
        _v=scrNTTEFullSpiralMeshData(_rings)
    assert(array_length(_v)==60,"Source portal mesh lost24vertices/real ring or12vertex final cap")
    assert(_v[0][0]==64 && _v[0][1]==64 && _v[0][2]==c_black
        && abs(_v[2][0]-75)<=0.00001 && _v[2][1]==64 && _v[2][2]==_c0,
        "Source portal first polygon lost center/110scale radius/black-to-authored palette")
    assert(abs(_v[26][0]-(64+lengthdir_x(33,15)))<=0.0001
        && abs(_v[26][1]-(64+lengthdir_y(33,15)))<=0.0001
        && _v[24][2]==_c0 && _v[32][2]==_c1,
        "Source portal lost15degree angular clamp/alternating edge palette/previous ring vertices")
    assert(abs(_v[50][0]-(64+lengthdir_x(33*sqrt(2),60)))<=0.0001
        && abs(_v[50][1]-(64+lengthdir_y(33*sqrt(2),60)))<=0.0001,
        "Source portal final instance was sampled as real ring instead of sqrt2/+45 outer cap")
    _rings[1].angle=-179;_rings[0].angle=179
    _v=scrNTTEFullSpiralMeshData(_rings)
    assert(abs(_v[26][0]-(64+lengthdir_x(33,181)))<=0.0001,
        "Source portal angular wrap crossed the long side of180degree boundary")
    assert(array_length(scrNTTEFullSpiralMeshData([]))==0
        && array_length(scrNTTEFullSpiralMeshData([_rings[0]]))==0,
        "Source portal drew a mesh without the original count>1 guard")
    var _before=scrNTTEFullInstances(all),_surface=-1,_baseline=-1,
        _seed=random_get_seed(),_color=draw_get_color(),_alpha=draw_get_alpha()
    try {
        assert(instance_number(Spiral)==0,"Portal fixture requires no live loading screen")
        _rings[0].angle=0;_rings[1].angle=90
        // Native with(Spiral) enumerates the newly constructed instances
        // first. Construct in reverse so authored ring0 is enumerated first.
        for(var _i=2;_i>=0;--_i) {
            var _ring=instance_create(_rings[_i].x-view_xview,_rings[_i].y-view_yview,Spiral)
            _ring.sprite_index=scrNTTERefSprite("SpiralStarfield");_ring.colors=[_c0,_c1]
            _ring.image_angle=_rings[_i].angle;_ring.image_xscale=_rings[_i].scale;_ring.type=0
        }
        _surface=surface_create(128,128);_baseline=surface_create(128,128)
        assert(surface_exists(_surface) && surface_exists(_baseline),"Portal native render surfaces unavailable")
        surface_set_target(_baseline);draw_clear_alpha(c_black,0)
        scrNTTEFullSpiralMeshDraw(scrNTTEFullSpiralMeshData(_rings));surface_reset_target()
        surface_set_target(_surface);draw_clear_alpha(c_black,0)
        draw_set_color(c_yellow);draw_set_alpha(0.75)
        var _input_alpha=draw_get_alpha()
        assert(!scrNTTEFullRedSpiralDraw(640,480) && !scrNTTEFullRedSpiralDraw(1600,100),
            "Source portal high-resolution branch used aspect ratio or wrong threshold")
        assert(scrNTTEFullRedSpiralDraw(800,600),"Real native Spiral instances failed source high-resolution mesh draw")
        assert(draw_get_color()==c_yellow && draw_get_alpha()==_input_alpha,
            "Portal mesh changed global draw state")
        surface_reset_target()
        var _visible=0,_different=0
        for(var _x=0;_x<128;_x+=2) for(var _y=0;_y<128;_y+=2) {
            var _pixel=surface_getpixel_ext(_surface,_x,_y)
            if(((_pixel>>24)&255)>0) _visible++
            if(_pixel!=surface_getpixel_ext(_baseline,_x,_y)) _different++
        }
        if(_visible<=100 || _different!=0) {
            var _actual=[]
            with(Spiral) array_push(_actual,[view_xview+x,view_yview+y,image_angle,image_xscale,type,colors]);
            scrNTTESmokeLog("SPIRAL PIXEL MISMATCH "+string(_visible)+" visible "+string(_different)+" different; rings="+json_stringify(_actual))
        }
        assert(_visible>100 && _different==0,
            "Actual native portal mesh omitted source geometry/palette or drew no visible rings")
    } finally {
        if(surface_get_target()==_surface || surface_get_target()==_baseline) surface_reset_target()
        if(surface_exists(_surface)) surface_free(_surface)
        if(surface_exists(_baseline)) surface_free(_baseline)
        scrNTTEFullMergedRuntimeTestCleanup(_before)
        random_set_seed(_seed);draw_set_color(_color);draw_set_alpha(_alpha)
    }
    scrNTTESmokeLog("FULL SPIRAL MESH: source110radius/four sides/15degree wrap clamp/two-color interpolation/sqrt2+45 final cap/area threshold/actual native instance-to-pixel equality+draw state OK @"+string(30/timescale))
}
