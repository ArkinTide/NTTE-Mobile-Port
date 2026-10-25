function scrNTTEFullBigDecalNativeTests() {
    // A previous synchronous case may still own ordinary live pickups.
    // Seven real Pizza controls exercise scene isolation while the original
    // strict4..6 assertion checks the native biome reward unchanged.
    var _entry=scrNTTEFullInstances(all),_seed=random_get_seed(),_controls=[]
    try {
        repeat(7) {
            var _pizza=instance_create(294000+array_length(_controls)*32,294000,NTTEFullPizza)
            array_push(_controls,[_pizza,_pizza.x,_pizza.y,_pizza.num,_pizza.alarm[0]])
        }
        var _kept_count=instance_number(NTTEFullPizza)
        scrNTTESmokeLog("BIG DECAL ISOLATION CONTROLS @"+string(30/timescale)+" existing="+string(_kept_count)+" injected=7")
        scrNTTEFullBigDecalNativeTestBody()
        assert(instance_number(NTTEFullPizza)==_kept_count,"BigDecal fixture did not preserve existing Pizza count")
        for(var _i=0;_i<array_length(_controls);++_i) {
            var _row=_controls[_i],_pizza=_row[0]
            assert(instance_exists(_pizza) && _pizza.x==_row[1] && _pizza.y==_row[2]
                && _pizza.num==_row[3] && _pizza.alarm[0]==_row[4],
                "BigDecal fixture altered an existing live Pizza control")
        }
    }
    finally {scrNTTEFullMergedRuntimeTestCleanup(_entry);random_set_seed(_seed)}
    scrNTTESmokeLog("BIG DECAL ISOLATION: seven existing real Pizza retained with unchanged position/value/lifetime; strict native biome assertions preserved OK @"+string(30/timescale))
}
function scrNTTEFullBigDecalNativeTestBody() {
    var _before=scrNTTEFullInstances(all),_game=scrNTTEFullAreaGeneratorSnapshot(GameCont),
        _players=scrNTTEFullAreaGeneratorSnapshot(Player),_back=scrNTTEFullAreaGeneratorSnapshot(BackCont),
        _seed=random_get_seed(),_tick=current_frame,
        _parked=scrNTTEFullInstances([Floor,Wall,TopSmall,Bones,enemy,prop,chestprop,RadChest,GenCont,NTTEDesertDecor,NTTEFullTopObject,NTTEFullWorldEvent,
            HPPickup,WepPickup,Feather,NTTEFullBackpackPickup,GreenExplosion,Bubble,NTTEFullBubbleExplosion,NTTEFullBubbleExplosionSmall,
            EnemyBullet2,NTTEFullVenomFlak,SmallExplosion]),
        _areas=[area_desert,area_sewers,area_scrapyards,area_caves,area_cursed_caves,area_palace,area_pizza_sewers,area_oasis,scrNTTEFullAreaId("trench")]
    for(var _i=0;_i<array_length(_parked);++_i) instance_deactivate_object(_parked[_i])
    try {
        GameCont.hard=4;GameCont.loops=0;GameCont.subarea=1;GameCont.crown=Crown.None;GameCont.underwater=false
        scrNTTEFullFloorResetStyle();scrNTTEFullFloorResetAlign()
        GameCont.area=area_city
        assert(scrNTTEFullBigDecalSpawn(280016,280016)==noone,"Source unsupported BigDecal area must create nothing")
        var _scorches=instance_number(Scorch)
        assert(scrNTTEFullBigDecalScorchGreen(286016,280016)==noone && instance_number(Scorch)==_scorches,
            "Source ScorchGreen must reject its actual collision mask over void")
        instance_create(286000,280000,Floor)
        var _green=scrNTTEFullBigDecalScorchGreen(286016,280016)
        assert(instance_exists(_green) && instance_is(_green,Scorch) && _green.sprite_index==sprScorch
            && _green.depth==object_get_depth(Scorch) && instance_number(Scorch)==_scorches+1,
            "Source ScorchGreen lost original same-Scorch sprite/depth or Epsilon BackCont upper-layer owner")
        scrNTTEFullMergedRuntimeTestCleanup(_before)
        for(var _i=0;_i<array_length(_areas);++_i) {
            GameCont.area=_areas[_i];random_set_seed(5000+_i)
            var _pizzas_before=scrNTTEFullInstances(NTTEFullPizza)
            instance_create(280000,280000,Floor)
            var _big=scrNTTEFullBigDecalSpawn(280016,280016)
            assert(instance_exists(_big) && instance_exists(_big.target) && !_big.visible
                && _big.target.name=="NTTEBigDecal" && instance_is(_big.target,Bones)
                && _big.target.sprite_index==_big.sprite_index && _big.target.mask_index==_big.mask_index,
                "Source BigDecal lost actual Bones ownership, mask/art or hidden controller: "+string(_i))
            with(_big) assert(!place_meeting(x,y,Floor),"Source BigDecal relocation failed to leave actual floors")
            if(_i==2) assert(instance_number(NTTEFullTopRaven)==3,"Source Scrapyard BigDecal nest omitted three real wall-top Ravens")
            var _old_target=_big.target
            instance_destroy(_old_target,false)
            with(_big) event_perform(ev_step,ev_step_normal)
            assert(instance_exists(_big) && instance_exists(_big.target) && _big.target!=_old_target,
                "Source BigDecal did not rebuild a missing Bones target while still over solid terrain")
            // A genuinely opened floor consumes the source controller and
            // dispatches this biome's real native death/reward content.
            var _x=_big.x,_y=_big.y
            instance_destroy(_big.target,false)
            instance_create(_x-16,_y-16,Floor)
            with(_big) event_perform(ev_step,ev_step_normal)
            assert(!instance_exists(_big),"Source BigDecal did not break after actual floor opening: "+string(_i))
            switch(_i) {
                case 0:assert(instance_number(WepPickup)>=2 && instance_number(WepPickup)<=3,"Source Desert BigDecal lost2..3actual Crabbone pickups");break
                case 1:
                    assert(instance_number(FrogEgg)>=3 && instance_number(FrogEgg)<=5 && instance_exists(NTTEFullBigDecalEggDepth),
                        "Source Sewer BigDecal lost3..5eggs or actual wait0 depth restoration")
                    var _guard=instance_find(NTTEFullBigDecalEggDepth,0),_saved=_guard.ntte_decal_egg_depth
                    with(_guard) event_perform(ev_step,ev_step_normal)
                    for(var _t=0;_t<array_length(_saved);++_t) assert(_saved[_t][0].depth==_saved[_t][1],"Source Sewer egg native depth did not restore")
                    break
                case 2:assert(instance_number(Feather)>=12 && instance_number(Feather)<=14,"Source Scrapyard nest omitted12..14real NestDebris feathers");break
                case 3:case 4:assert(instance_number(NTTEFullMinerBandit)+instance_number(NTTEFullSpiderling)>=2,
                    "Source Cave BigDecal omitted actual2..3Miner/Spider occupants");break
                case 5:assert(instance_number(NTTEFullBackpackPickup)==16 && instance_number(GreenExplosion)==3,
                    "Source Palace BigDecal omitted16real radial pickups or three native green explosions");break
                case 6:
                    var _pizzas_after=scrNTTEFullInstances(NTTEFullPizza),_new_pizzas=0,_pizza_rows=[]
                    for(var _j=0;_j<array_length(_pizzas_after);++_j) {
                        var _pizza=_pizzas_after[_j],_old=array_get_index(_pizzas_before,_pizza)>=0
                        if(!_old) _new_pizzas++
                        array_push(_pizza_rows,{id:real(_pizza),x:_pizza.x,y:_pizza.y,xstart:_pizza.xstart,ystart:_pizza.ystart,
                            preexisting:_old,in_body_snapshot:array_get_index(_before,_pizza)>=0})
                    }
                    scrNTTESmokeLog("BIG DECAL PIZZA COUNTS "+json_stringify({rate:30/timescale,
                        before:array_length(_pizzas_before),total:instance_number(NTTEFullPizza),created:_new_pizzas,
                        area:GameCont.area,x:_x,y:_y,seed:random_get_seed(),pickups:_pizza_rows}))
                    assert(instance_number(NTTEFullPizza)>=4 && instance_number(NTTEFullPizza)<=6,
                        "Source Pizza BigDecal omitted4..6actual Pizza pickups");break
                case 7:assert(instance_number(Bubble)>=20 && instance_number(Freak)+instance_number(Crab)+instance_number(BoneFish)+instance_number(NTTEFullPuffer)==4,
                    "Source Oasis BigDecal omitted four actual occupants/20bubbles");break
                case 8:assert(instance_number(NTTEFullBubbleExplosion)==1 && instance_number(NTTEFullBubbleExplosionSmall)==3,
                    "Source Trench BigDecal omitted actual large+three small bubble explosions");break
            }
            scrNTTEFullMergedRuntimeTestCleanup(_before)
        }
        // Actual ScorpionCity variant changes the mask-owned art and contains
        // the complete150bullet / flak / small-green /50rad grand-scorpion burst.
        GameCont.area=area_desert
        var _event=instance_create(0,0,NTTEFullWorldEvent);_event.event_name="ScorpionCity"
        var _big=scrNTTEFullBigDecalSpawn(282016,280016)
        assert(_big.sprite_index==scrNTTERefSprite("BigTopDecalScorpion"),"Source active ScorpionCity omitted actual GrandScorpion BigDecal art")
        var _x=_big.x,_y=_big.y
        instance_destroy(_big.target,false);instance_create(_x-16,_y-16,Floor)
        with(_big) event_perform(ev_step,ev_step_normal)
        assert(instance_number(EnemyBullet2)==150 && instance_number(NTTEFullVenomFlak)==1 && instance_number(SmallExplosion)==3,
            "Source GrandScorpion burst omitted150real EnemyBullet2 / VenomFlak / three original SmallGreenExplosion variants")
        with(EnemyBullet2) {
            assert(real(creator)==real(_big),"Source GrandScorpion controller ownership differs: creator="+string(creator)+" controller="+string(_big))
            assert(is_array(hitid) && hitid[1]=="GRAND SCORPION","Source GrandScorpion death cause differs: hitid="+string(hitid)+" is_array="+string(is_array(hitid)))
            assert(abs(friction+0.2*timescale*timescale)<=0.0000001,"Source GrandScorpion logical acceleration differs: friction="+string_format(friction,1,12)
                +" error="+string_format(abs(friction+0.2*timescale*timescale),1,12)+" timescale="+string(timescale)+" math_epsilon="+string_format(math_get_epsilon(),1,12))
        }
        with(SmallExplosion) assert(sprite_index==scrNTTERefSprite("SmallGreenExplosion") && damage==12 && knockback_speed==8*timescale,
            "Source GrandScorpion small-green explosion differs from actual original wrapper")
    }
    finally {
        scrNTTEFullMergedRuntimeTestCleanup(_before)
        for(var _i=0;_i<array_length(_parked);++_i) instance_activate_object(_parked[_i])
        scrNTTEFullAreaGeneratorRestore(_game);scrNTTEFullAreaGeneratorRestore(_players);scrNTTEFullAreaGeneratorRestore(_back)
        random_set_seed(_seed);current_frame=_tick;scrNTTEFullFloorResetStyle();scrNTTEFullFloorResetAlign()
    }
    scrNTTESmokeLog("FULL BIG DECAL all9source areas/exact imported art+mask/real Bones target+rebuild/floor-opening real death/all biome rewards/deferred egg depth/actual GrandScorpion150bullet+flak+smallgreens/unsupported area exclusion OK @"+string(30/timescale))
}
