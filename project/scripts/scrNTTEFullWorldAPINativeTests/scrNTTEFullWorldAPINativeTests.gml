// Exercise the actual hurt-only Draw and Blunderbuss charge Step paths that
// direct constructor/Attack fixtures do not enter.
function scrNTTEFullWorldHurtDrawNativeTests() {
    var _before=scrNTTEFullInstances(all),_game=scrNTTEFullAreaGeneratorSnapshot(GameCont),
        _seed=random_get_seed(),_active=scrNTTEFullValue(GameCont,"ntte_full_active_coast",false),
        _fog=gpu_get_fog(),_surface=-1,_target=false
    GameCont.ntte_full_active_coast=false;GameCont.area=area_desert;GameCont.loops=0;GameCont.crown=crwn_none
    try {
        _surface=surface_create(320,240)
        assert(surface_exists(_surface),"Actual native hurt-draw fixture could not create render target")
        surface_set_target(_surface);_target=true;draw_clear_alpha(c_black,0);gpu_set_fog(false,c_black,0,0)
        var _fish=instance_create(128,160,NTTEFullCoastBoss)
        _fish.nexthurt=current_frame+6;_fish.sprite_index=_fish.spr_fire;_fish.swim=0
        with(_fish) scrNTTEFullCoastBossDraw()
        assert(!gpu_get_fog()[0],"Actual hurt BigFish ground Draw leaked GPU fog")
        _fish.swim=30
        with(_fish) scrNTTEFullCoastBossDraw()
        assert(!gpu_get_fog()[0],"Actual hurt BigFish swim Draw leaked GPU fog")
        _fish.swim=0;_fish.sprite_index=_fish.spr_hurt
        with(_fish) scrNTTEFullCoastBossDraw()
        assert(!gpu_get_fog()[0],"Actual BigFish authored hurt-sprite Draw leaked GPU fog")
        var _pal=instance_create(160,160,NTTEFullPalanking)
        _pal.active=true;_pal.nexthurt=current_frame+6;_pal.z=12;_pal.sprite_index=_pal.spr_call
        with(_pal) scrNTTEFullPalankingDraw()
        assert(!gpu_get_fog()[0],"Actual active Palanking hurt call/bottom Draw leaked GPU fog")
        _pal.sprite_index=_pal.spr_hurt;_pal.image_index=0;_pal.active=false
        with(_pal) scrNTTEFullPalankingDraw()
        assert(!gpu_get_fog()[0],"Actual first-frame Palanking hurt/bottom Draw leaked GPU fog")
        var _die=instance_create(160,160,NTTEFullPalankingDie)
        _die.image_index=0
        with(_die) scrNTTEFullPalankingDieDraw()
        assert(!gpu_get_fog()[0],"Actual first-frame Palanking airborne-death Draw leaked GPU fog")
        _die.image_index=1
        with(_die) scrNTTEFullPalankingDieDraw()
        assert(!gpu_get_fog()[0],"Actual ordinary Palanking airborne-death Draw changed GPU fog")
    }
    finally {
        if(_target) surface_reset_target()
        if(surface_exists(_surface)) surface_free(_surface)
        gpu_set_fog(_fog[0],_fog[1],_fog[2],_fog[3])
        var _after=scrNTTEFullInstances(all)
        for(var _i=0;_i<array_length(_after);++_i) if(array_get_index(_before,_after[_i])<0) instance_destroy(_after[_i],false)
        scrNTTEFullAreaGeneratorRestore(_game);GameCont.ntte_full_active_coast=_active;random_set_seed(_seed)
    }
    scrNTTESmokeLog("ACTUAL WORLD HURT DRAW: BigFish ground/swim/authored hurt, Palanking active call/bottom/first hurt and airborne-death first/ordinary frames render through native GPU fog and reset state OK")
}
function scrNTTEFullSealPowderNativeTests() {
    var _before=scrNTTEFullInstances(all),_game=scrNTTEFullAreaGeneratorSnapshot(GameCont),
        _seed=random_get_seed(),_frame=current_frame,_active=scrNTTEFullValue(GameCont,"ntte_full_active_coast",false)
    GameCont.ntte_full_active_coast=false;GameCont.area=area_city;GameCont.loops=0;GameCont.crown=crwn_none
    current_frame=floor(current_frame)
    var _audio=true
    for(var _i=1;_i<=parameter_count();++_i) if(parameter_string(_i)=="-noaudio") _audio=false
    try {
        // The desktop harness runs -noaudio, which removes dynamic sound
        // lookup as well as audio_exists. The static six assets are checked
        // against project files by maintenance; audible playback is untested.
        if(_audio) {
            var _sounds=[sndFootPlaSand1,sndFootPlaSand2,sndFootPlaSand3,sndFootPlaSand4,sndFootPlaSand5,sndFootPlaSand6]
            for(var _i=0;_i<array_length(_sounds);++_i)
                assert(audio_exists(_sounds[_i]),"Audio-enabled runner did not load original Blunderbuss footstep asset")
        }
        var _seal=instance_create(98000,98000,NTTEFullSeal)
        _seal.type=NTTEFullSealType.Blunderbuss
        with(_seal) scrNTTEFullSealSetup()
        _seal.sprite_index=_seal.spr_idle;_seal.gunangle=0;_seal.right=1;_seal.ntte_seal_timer1=1000;_seal.ntte_seal_timer2=10
        _seal.slide=0;_seal.walk=0;_seal.speed=0;_seal.wkick=0
        var _local=scrNTTEFullInstances(Smoke)
        with(_seal) scrNTTEFullSealStep()
        var _smoke=noone
        with(Smoke) if(array_get_index(_local,id)<0) _smoke=id
        assert(instance_exists(_smoke) && _smoke.x==_seal.x && _smoke.y==_seal.y
            && _smoke.image_yscale==_smoke.image_xscale && _smoke.depth==_seal.depth
            && _smoke.speed>=timescale && _smoke.speed<=2*timescale
            && abs(angle_difference(_smoke.direction,120))<=20.00001,
            "Actual Blunderbuss charge Step failed original audio_exists/powder smoke position/scale/depth/angular spread/speed")
        var _bullets=scrNTTEFullInstances(EnemyBullet1)
        _seal.ntte_seal_timer2=timescale
        with(_seal) scrNTTEFullSealStep()
        var _pellets=[]
        with(EnemyBullet1) if(array_get_index(_bullets,id)<0) array_push(_pellets,id)
        assert(array_length(_pellets)==6 && _seal.ntte_seal_timer2==-1 && _seal.wkick>=10-timescale,
            "Actual Blunderbuss charge countdown did not fire six real native pellets/recoil")
        for(var _i=0;_i<array_length(_pellets);++_i) {
            var _shot=_pellets[_i]
            assert(_shot.creator==_seal && _shot.team==_seal.team && _shot.speed>=6*timescale && _shot.speed<=8*timescale
                && abs(angle_difference(_shot.direction,_seal.gunangle))<=6.00001,
                "Actual Blunderbuss timed pellet lost enemy creator/team/source6..8speed/6degree spread")
        }
    }
    finally {
        var _after=scrNTTEFullInstances(all)
        for(var _i=0;_i<array_length(_after);++_i) if(array_get_index(_before,_after[_i])<0) instance_destroy(_after[_i],false)
        scrNTTEFullAreaGeneratorRestore(_game);GameCont.ntte_full_active_coast=_active;current_frame=_frame;random_set_seed(_seed)
    }
    scrNTTESmokeLog("ACTUAL BLUNDERBUSS STEP: real powder-charge smoke/native tolerant audio, logical countdown-to-six native pellets/creator/team/spread/speed/recoil OK; "+(_audio?"six real sound assets loaded (audible quality untested)":"audible playback/assets not tested (-noaudio)"))
}
