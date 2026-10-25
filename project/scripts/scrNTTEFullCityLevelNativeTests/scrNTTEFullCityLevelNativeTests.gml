function scrNTTEFullCityFixtureSeed(_denominator) {
    for(var _seed=1;_seed<=10000;++_seed) { random_set_seed(_seed);if(chance(1,_denominator)) return _seed }
    assert(false,"City native fixture could not find original spawn chance seed")
}
function scrNTTEFullCityLevelNativeTests() {
    scrNTTEFullFloorInit()
    var _before=scrNTTEFullInstances(all),_game=scrNTTEFullAreaGeneratorSnapshot(GameCont),
        _seed=random_get_seed(),_hidden=scrNTTEFullInstances([enemy,prop,Floor,Wall,InvisiWall,PortalClear,GenCont,LevCont,NTTEFullSawTrap]),
        _active=scrNTTEFullValue(GameCont,"ntte_full_active_coast",false),
        _style=global.ntte_full_floor_style,_area=global.ntte_full_floor_area,
        _aw=global.ntte_full_floor_aw,_ah=global.ntte_full_floor_ah,_ax=global.ntte_full_floor_ax,_ay=global.ntte_full_floor_ay
    for(var _i=0;_i<array_length(_hidden);++_i) instance_deactivate_object(_hidden[_i])
    GameCont.ntte_full_active_coast=false;GameCont.crown=crwn_none;GameCont.loops=0;GameCont.subarea=1
    if(!instance_exists(TopCont)) { GameCont.area=area_desert;instance_create(0,0,TopCont) }
    GameCont.area=area_city;scrNTTEFullFloorResetStyle();scrNTTEFullFloorSetAlign(32,32,0,0)
    var _baseline=scrNTTEFullInstances(all)
    try {
        GameCont.area=area_caves;random_set_seed(4921);var _expected=random(100000);random_set_seed(4921)
        scrNTTEFullCityLevelStart()
        assert(random(100000)==_expected,"Natural city provider consumed RNG outside Frozen City")
        GameCont.area=area_city
        var _floor=instance_create(10336,10000,Floor),_choice=scrNTTEFullCityFixtureSeed(1)
        random_set_seed(_choice);var _igloos=scrNTTEFullCityIgloos()
        assert(array_length(_igloos)>=1 && array_length(_igloos)<=3 && instance_number(Floor)>=10,
            "Natural city did not generate original one-to-three detached3x3 Igloo rooms")
        for(var _i=0;_i<array_length(_igloos);++_i) {
            var _igloo=_igloos[_i],_locked=false
            with(NTTEFullPortalPrevent) if(creator==_igloo) _locked=true
            assert(_igloo.object_index==NTTEFullIgloo && _igloo.hp==30 && _igloo.type>=4 && _igloo.type<=6
                && _igloo.num>=5 && _igloo.num<=6 && position_meeting(_igloo.x,_igloo.y,Floor) && _locked,
                "Natural city Igloo lost real Arctic Seal constructor, native floor room or portal prevent")
        }
        assert(is_undefined(global.ntte_full_floor_aw) && is_undefined(global.ntte_full_floor_ah),
            "Natural city Igloo failed source floor_reset_align")
        scrNTTEFullCavesFixtureCleanup(_baseline)
        scrNTTEFullFloorSetAlign(32,32,0,0)

        var _tank=instance_create(98000,98000,SnowTank),_necro=instance_create(98100,98000,Necromancer)
        random_set_seed(782);_expected=random(100000);random_set_seed(782)
        assert(array_length(scrNTTEFullCitySawTraps())==0 && array_length(scrNTTEFullCityNecroCats())==0
            && random(100000)==_expected && instance_exists(_tank) && instance_exists(_necro),
            "Preloop city consumed loop-only species RNG or changed original natives")
        GameCont.loops=1;_choice=scrNTTEFullCityFixtureSeed(4);random_set_seed(_choice)
        var _saws=scrNTTEFullCitySawTraps()
        assert(array_length(_saws)==1 && _saws[0].object_index==NTTEFullSawTrap && instance_exists(_tank)
            && _saws[0].xstart==_tank.x && _saws[0].ystart==_tank.y && !instance_is(_saws[0],enemy),
            "Natural city SawTrap1/4 replaced its source SnowTank or incorrectly entered hostile-clear enemy hierarchy")
        _choice=scrNTTEFullCityFixtureSeed(2);random_set_seed(_choice)
        var _cats=scrNTTEFullCityNecroCats()
        assert(array_length(_cats)==1 && _cats[0].object_index==NTTECat && !instance_exists(_necro),
            "Natural city Necromancer1/2 did not become a real shared Cat")
        scrNTTEFullCavesFixtureCleanup(_baseline)

        for(var _loop=0;_loop<=1;++_loop) {
            GameCont.loops=_loop
            var _wolf=instance_create(98000,98000,Wolf),_choice=scrNTTEFullCityFixtureSeed(_loop>0 ? 5:200)
            _wolf.x=98000;_wolf.y=98000;_wolf.alarm[1]=1;_wolf.image_xscale=-1
            random_set_seed(_choice);var _cats=scrNTTEFullCityWolfCats()
            assert(array_length(_cats)==1 && instance_exists(_wolf) && _cats[0].ntte_cat_sit==_wolf
                && _cats[0].depth==_wolf.depth-1,
                "Natural Wolf Cat lost source preloop1/200/loop1/5 chance, actual seat or relative depth")
            var _cat=_cats[0];_cat.ntte_cat_timer=100;_cat.right=1
            with(_cat) scrNTTECatStep()
            assert(_cat.x==_wolf.x && _cat.y==_wolf.y && _cat.xprevious==_wolf.x && _cat.yprevious==_wolf.y
                && _wolf.alarm[1]>=30 && _cat.right==1,
                "Actual Cat on Wolf used furniture -5 offset/flip instead of native enemy seat/alarm suppression")
            _wolf.x+=13;_wolf.y+=9
            with(_cat) scrNTTECatStep()
            assert(_cat.x==_wolf.x && _cat.y==_wolf.y,"Actual sitting Cat did not track moving Wolf")
            instance_destroy(_wolf,false);with(_cat) scrNTTECatStep()
            assert(_cat.ntte_cat_sit==noone,"Actual Cat retained destroyed Wolf seat")
            scrNTTEFullCavesFixtureCleanup(_baseline)
        }
    }
    finally {
        scrNTTEFullCavesFixtureCleanup(_before)
        for(var _i=0;_i<array_length(_hidden);++_i) instance_activate_object(_hidden[_i])
        scrNTTEFullAreaGeneratorRestore(_game);GameCont.ntte_full_active_coast=_active;random_set_seed(_seed)
        scrNTTEFullFloorSetStyle(_style,_area);scrNTTEFullFloorSetAlign(_aw,_ah,_ax,_ay)
    }
    scrNTTESmokeLog("NATURAL CITY: area/RNG gates, actual1..3 Igloo3x3 rooms/Arctic Seal constructor/portal prevent/alignment, retained SnowTank saw, Necro Cat, preloop200/loop5 Wolf Cat/native seat tracking/alarm suppression OK")
}
function scrNTTEFullSawTrapNativeTests() {
    var _before=scrNTTEFullInstances(all),_game=scrNTTEFullAreaGeneratorSnapshot(GameCont),
        _players=scrNTTEFullAreaGeneratorSnapshot(Player),_back=scrNTTEFullAreaGeneratorSnapshot(BackCont),
        _seed=random_get_seed(),_hidden=scrNTTEFullInstances([enemy,prop,Floor,Wall,InvisiWall,Portal,PortalShock,GenCont,LevCont,NTTEFullSawTrap]),
        _active=scrNTTEFullValue(GameCont,"ntte_full_active_coast",false)
    for(var _i=0;_i<array_length(_hidden);++_i) instance_deactivate_object(_hidden[_i])
    GameCont.ntte_full_active_coast=false;GameCont.area=area_city;GameCont.loops=1;GameCont.crown=crwn_none
    try {
        var _wall=instance_create(98100,98000,Wall),_saw=instance_create(98000,98000,NTTEFullSawTrap)
        assert(_saw.hp==30 && _saw.team==team_enemy && _saw.size==3 && _saw.meleedamage==6 && _saw.raddrop==0
            && _saw.mask_index==mskShield && _saw.depth==1 && !_saw.active && _saw.ntte_saw_wait>=30 && _saw.ntte_saw_wait<=60
            && !instance_is(_saw,enemy),"Actual SawTrap lost CustomHitme classification, source30HP/stats/mask/tell")
        var _direction=point_direction(_saw.x,_saw.y,(_wall.bbox_left+_wall.bbox_right)/2,(_wall.bbox_top+_wall.bbox_bottom)/2)
        assert(abs(angle_difference(_saw.dir,_direction))<=0.00001,"Actual SawTrap did not seek nearest Wall bbox center")
        var _p=instance_find(Player,0)
        _p.x=98000;_p.y=98000;_p.hp=20;_p.nexthurt=current_frame-1;_p.friction=0
        _saw.ntte_saw_wait=10;_saw.spd=0
        with(_saw) scrNTTEFullSawTrapStep()
        assert(!_saw.active && _saw.x==98000 && _saw.spd==0 && _p.hp==20,"Inactive SawTrap moved or damaged before source initial wait elapsed")
        _saw.ntte_saw_wait=0;_saw.active=true;_saw.spd=3;_saw.dir=0;_saw.side=1
        instance_destroy(_wall,false)
        with(_saw) scrNTTEFullSawTrapMove()
        assert(_saw.x==round(98000+3*timescale) && _saw.y==98000 && _saw.dir==0
            && abs(_saw.image_angle-12*timescale)<=0.00001,"Actual SawTrap lost rounded logical movement/spin")
        _saw.walled=true;_saw.dir=0
        with(_saw) scrNTTEFullSawTrapMove()
        assert(_saw.dir==90,"Actual SawTrap did not turn toward side after losing wall")
        _saw.x=98000;_saw.y=98000;_saw.walled=false;_saw.dir=0;_saw.spd=3
        _wall=instance_create(98000,98000,Wall)
        with(_saw) scrNTTEFullSawTrapMove()
        assert(_saw.x==98000 && _saw.y==98000 && _saw.dir==270,"Actual SawTrap crossed solid wall instead of opposite90-degree corner turn")
        instance_destroy(_wall,false)
        _saw.active=false;_saw.hp=30
        var _bullet=instance_create(98000,98000,Bullet1);_bullet.team=team_player
        with(_bullet) scr_projectile_hit(_saw,3,8*timescale,123)
        assert(_saw.hp==27 && _saw.spd==2 && _saw.dir==123 && _saw.sprite_index==_saw.spr_hurt,
            "Actual SawTrap projectile callback lost inactive force/4 logical impulse or direction")
        _saw.active=true;_saw.spd=2
        with(_p) scrNTTEFullRawHit(_saw,-2,0)
        assert(_saw.hp==29 && _saw.spd==1 && _saw.nexthurt==current_frame+6,
            "Actual SawTrap signed raw CustomHitme hurt bypassed health restoration/active speed halving")
        _saw.x=98000;_saw.y=98000;_saw.dir=0;_saw.walled=false
        _p.x=98000;_p.y=98000;_p.hp=20;_p.nexthurt=current_frame-1
        var _xs=_saw.image_xscale,_ys=_saw.image_yscale
        with(_saw) scrNTTEFullSawTrapContact()
        assert(_p.hp==14 && _p.nexthurt==current_frame+6 && _saw.image_xscale==_xs && _saw.image_yscale==_ys,
            "Actual SawTrap0.55 contact mask lost6 damage/native NP hit or failed to restore scale")
        with(_saw) scrNTTEFullSawTrapContact()
        assert(_p.hp==14,"Actual SawTrap ignored original melee iframe guard")
        var _bandit=instance_create(98000,98000,Bandit);_bandit.nexthurt=current_frame-1;_bandit.hp=20
        var _same=false,_dead=false
        with(_saw) _same=scrNTTEFullSawTrapCanMelee(_bandit)
        _bandit.team=team_player;_bandit.hp=0
        with(_saw) _dead=scrNTTEFullSawTrapCanMelee(_bandit)
        assert(!_same && _dead,"Actual SawTrap melee diverged from9940 opposite-team/no-HP condition")
        var _oldX=_saw.x,_oldY=_saw.y,_sweatBefore=instance_number(NTTEFullSweat)
        _saw.x=view_xview+view_width/2;_saw.y=view_yview+view_height/2
        _saw.spd=3;_saw.walled=true;_saw.dir=0
        for(var _fxTry=0;_fxTry<256 && instance_number(NTTEFullSweat)==_sweatBefore;++_fxTry)
            with(_saw) scrNTTEFullSawTrapFX()
        var _gold=noone
        with(NTTEFullSweat) if(array_get_index(_before,id)<0 && image_blend==make_color_rgb(255,222,56)) _gold=id
        assert(instance_exists(_gold) && _gold.sprite_index==sprSweat && _gold.ntte_sweat_timer>=11 && _gold.ntte_sweat_timer<=15
            && _gold.speed<=2*timescale,
            "Actual SawTrap wall spark FX lost original native Sweat pixels/timer/gold recolor/logical speed")
        _saw.x=_oldX;_saw.y=_oldY;_saw.walled=false
        var _portal=instance_create(99000,99000,Portal)
        _saw.active=true;_saw.spd=3;_saw.dir=0
        with(_saw) scrNTTEFullSawTrapMove()
        assert(!_saw.active && abs(_saw.spd-3*(1-0.2*timescale))<=0.00001,
            "Actual SawTrap did not deactivate/decelerate when level portal appeared")
        instance_destroy(_portal,false)
        var _local=scrNTTEFullInstances(all)
        instance_destroy(_saw)
        var _explosions=0,_small=0,_flames=0,_pieces=0,_after=scrNTTEFullInstances(all)
        for(var _i=0;_i<array_length(_after);++_i) if(array_get_index(_local,_after[_i])<0) with(_after[_i]) {
            if(object_index==Explosion) { _explosions++;assert(team==-1,"SawTrap death explosion source team changed") }
            if(object_index==SmallExplosion) { _small++;assert(team==-1,"SawTrap death small explosion source team changed") }
            if(object_index==GroundFlame) _flames++
            if(object_index==Debris && sprite_index==scrNTTERefSprite("SawTrapDebris")) _pieces++
        }
        assert(_explosions==1 && _small==3 && _flames==3 && _pieces>=3 && _pieces<=6,
            "Actual SawTrap death lost original explosion/three minis/three flames/three-to-six source debris")
    }
    finally {
        scrNTTEFullCavesFixtureCleanup(_before)
        for(var _i=0;_i<array_length(_hidden);++_i) instance_activate_object(_hidden[_i])
        scrNTTEFullAreaGeneratorRestore(_game);GameCont.ntte_full_active_coast=_active
        scrNTTEFullAreaGeneratorRestore(_players);scrNTTEFullAreaGeneratorRestore(_back);random_set_seed(_seed)
    }
    scrNTTESmokeLog("ACTUAL SAWTRAP: CustomHitme/non-enemy, source wait/30HP, nearest wall/cardinal rounding/corners/spin, normal+raw logical hurt,0.55 native6damage/iframes/HP-independent melee, portal stop and exact death projectiles/flames/debris OK")
}
