function scrNTTEFullWallPropsFixtureClear(_state) {
    scrNTTEFullCavesFixtureCleanup(_state.baseline)
}
function scrNTTEFullWallPropsLevelNativeTests() {
    var _state=scrNTTEFullVanillaFixtureBegin(),_extra=scrNTTEFullInstances([TopSmall,TopPot,Bones,NTTEFullWallEnemy,NTTEFullTopObject])
    for(var _i=0;_i<array_length(_extra);++_i) instance_deactivate_object(_extra[_i])
    try {
        // Unlike mutually exclusive biome providers, source generic wall pass
        // deliberately consumes one stray roll even when no walls exist.
        GameCont.loops=2;random_set_seed(621);var _strays=8+irandom(4)+4;array_shuffle([])
        var _expected=random(100000);random_set_seed(621)
        var _result=scrNTTEFullWallPropsLevelStart()
        assert(!_result.main_created && _result.strays_left==_strays && _result.radius==80
            && array_length(_result.enemies)==0 && random(100000)==_expected,
            "Natural generic wall pass changed source unconditional stray RNG/loop radius")

        GameCont.area=area_caves;GameCont.loops=0
        var _wall=instance_create(98000,98000,Wall),_small=instance_create(98128,98000,TopSmall)
        _small.x=98032;_small.y=98000
        // Search real RNG path for source TopSmall1/3 child. No fake creator.
        var _child=false,_main=noone
        for(var _try=1;_try<=64 && !_child;++_try) {
            random_set_seed(_try);_result=scrNTTEFullWallPropsLevelStart()
            assert(_result.main_created && _result.radius==48 && array_length(_result.enemies)>=1,
                "Natural caves wall pass omitted guaranteed main Spider residence")
            for(var _i=0;_i<array_length(_result.enemies);++_i) {
                var _enemy=_result.enemies[_i]
                if(_enemy.special) _main=_enemy
                else if(instance_exists(_enemy) && point_distance(_enemy.x,_enemy.y,_small.x,_small.y)<32) _child=true
            }
            if(!_child) {
                var _new=scrNTTEFullInstances([NTTEFullWallEnemy,TopPot])
                for(var _i=0;_i<array_length(_new);++_i) if(array_get_index(_state.baseline,_new[_i])<0) instance_destroy(_new[_i],false)
            }
        }
        assert(_child && instance_exists(_main) && _main.special && instance_exists(_main.target)
            && _main.target.sprite_index==scrNTTERefSprite("WallSpider") && _wall.sprite_index==scrNTTERefSprite("WallSpiderBot"),
            "Natural caves wall pass lost source special Spider/target+wall art/nearby TopSmall1/3 group")
        var _pets=scrNTTEFullInstances(NTTEFullPet)
        instance_create(98000,98000,Floor);instance_destroy(_main)
        var _reward=noone
        with(NTTEFullPet) if(pet=="Spider" && array_get_index(_pets,id)<0) _reward=id
        assert(instance_exists(_reward),"Natural main Spider residence did not release genuine Spider pet when wall opens")
        scrNTTEFullWallPropsFixtureClear(_state)

        // Source central/stray budget: every far wall consumes its stray slot,
        // not a second chance, after the unique central residence.
        for(var _i=0;_i<16;++_i) instance_create(98000+256*_i,98000,Wall)
        random_set_seed(916);_result=scrNTTEFullWallPropsLevelStart()
        var _special=0
        for(var _i=0;_i<array_length(_result.enemies);++_i) if(_result.enemies[_i].special) { _special++ }
        assert(_special==1 && _result.strays_left==0 && array_length(_result.enemies)>=9 && array_length(_result.enemies)<=13,
            "Natural caves walls lost unique central Spider and original8..12 finite far-stray budget")
        scrNTTEFullWallPropsFixtureClear(_state)

        var _near=instance_create(10000,10000,Wall)
        _result=scrNTTEFullWallPropsLevelStart()
        assert(!_result.main_created && array_length(_result.enemies)==0,
            "Natural cave Spider residence violated source64px spawn distance")
        scrNTTEFullWallPropsFixtureClear(_state)

        GameCont.area=area_desert;var _wall=instance_create(98000,98000,Wall),_made=false
        for(var _try=1;_try<=10000 && !_made;++_try) {
            random_set_seed(_try);_result=scrNTTEFullWallPropsLevelStart()
            _made=array_length(_result.enemies)>0
        }
        assert(_made && _result.enemies[0].object_index==NTTEFullWallEnemy
            && _result.enemies[0].area==area_desert && _result.enemies[0].target.sprite_index==scrNTTERefSprite("WallBandit"),
            "Natural desert1/400 failed actual native Bandit wall residence")
        var _banditSeed=_try-1
        scrNTTEFullWallPropsFixtureClear(_state)
        var _wall=instance_create(98000,98000,Wall),_bones=instance_create(98000,98016,Bones)
        _bones.x=98000;_bones.y=98016;_bones.mask_index=mskFloor
        random_set_seed(_banditSeed);_result=scrNTTEFullWallPropsLevelStart()
        assert(array_length(_result.enemies)==0,"Natural desert wall Bandit ignored bones at y+16 exclusion")
        scrNTTEFullWallPropsFixtureClear(_state)

        // PortalClear/TopPot are tested before biome RNG and all emitters.
        for(var _kind=0;_kind<2;++_kind) {
            GameCont.area=area_caves;var _wall=instance_create(98000,98000,Wall)
            var _block=instance_create(98000,98000,_kind?TopPot:PortalClear)
            _block.mask_index=mskFloor;_block.x=98000;_block.y=98000
            _result=scrNTTEFullWallPropsLevelStart()
            assert(!_result.main_created && array_length(_result.enemies)==0 && array_length(_result.props)==0,
                "Natural wall pass ignored PortalClear/TopPot whole-pass exclusion")
            scrNTTEFullWallPropsFixtureClear(_state)
        }

        // Genuine vault Torch and normal/cursed crystal/cocoon on native top
        // wrappers. Success seed is searched through actual natural algorithm.
        var _areas=[area_vault,area_caves,area_cursed_caves]
        for(var _area=0;_area<array_length(_areas);++_area) {
            GameCont.area=_areas[_area]
            // Cave within64spawn suppresses only Spider, leaving prop chance.
            var _wall=instance_create(10000,10000,Wall),_made=false
            for(var _try=1;_try<=1024 && !_made;++_try) {
                random_set_seed(_try);_result=scrNTTEFullWallPropsLevelStart();_made=array_length(_result.props)>0
            }
            assert(_made && _result.props[0].object_index==NTTEFullTopObject && instance_exists(_result.props[0].target),
                "Natural wall prop chance failed actual native top wrapper")
            var _top=_result.props[0],_target=_top.target
            assert(_area==0 ? _target.object_index==Torch : (_target.object_index==Crystal || _target.object_index==Cocoon),
                "Natural vault/cave/cursed wall prop used substitute Torch/Crystal/Cocoon")
            assert(_top.spawn_dis>=8 && _top.spawn_dis<=16,"Natural wall prop lost native default prop spawn separation")
            scrNTTEFullWallPropsFixtureClear(_state)
        }
        for(var _kind=0;_kind<2;++_kind) {
            GameCont.area=area_caves;instance_create(10000,10000,Wall)
            var _block=instance_create(10064,10000,_kind?Bones:TopPot)
            _block.x=10064;_block.y=10000;_block.mask_index=mskFloor
            for(var _try=1;_try<=128;++_try) {
                random_set_seed(_try);_result=scrNTTEFullWallPropsLevelStart()
                assert(array_length(_result.props)==0,
                    "Natural cave prop ignored non-overlapping TopPot64/Bones96 distance exclusion")
            }
            scrNTTEFullWallPropsFixtureClear(_state)
        }
    }
    finally {
        scrNTTEFullVanillaFixtureEnd(_state)
        for(var _i=0;_i<array_length(_extra);++_i) instance_activate_object(_extra[_i])
    }
    scrNTTESmokeLog("NATURAL WALLS: unconditional original RNG/radius, genuine special Spider/nearby top grouping/art/pet release/finite8..12strays,64spawn distance, real Desert1/400Bandit/bones exclusion, portal/top whole-pass gates and actual Torch/normal+cursed Crystal/Cocoon top wrappers OK")
}
