function scrNTTEFullRedSpiderNativeTests() {
    var _before=scrNTTEFullInstances(all),_players=scrNTTEFullAreaGeneratorSnapshot(Player),
        _game=scrNTTEFullAreaGeneratorSnapshot(GameCont),_back=scrNTTEFullAreaGeneratorSnapshot(BackCont),
        _seed=random_get_seed(),_tick=current_frame,_p=instance_find(Player,0)
    try {
        GameCont.loops=0;current_frame=8;_p.x=96040;_p.y=96000
        var _spider=instance_create(96000,96000,NTTEFullRedSpider)
        assert(_spider.name=="RedSpider" && _spider.hp==14 && _spider.raddrop==4 && _spider.size==1
            && _spider.meleedamage==2 && _spider.canmelee && _spider.mask_index==mskSpider
            && _spider.walkspeed==0.6 && _spider.maxspeed==4 && !_spider.ntte_red_spider_seen
            && _spider.ntte_red_spider_decide>=30 && _spider.ntte_red_spider_decide<=60,
            "RedSpider actual constructor lost original health/rads/melee/motion/initial timer")
        var _count=instance_number(NTTEFullVlasmaBullet),_tries=32
        while(instance_number(NTTEFullVlasmaBullet)==_count && _tries-->0)
            with(_spider) scrNTTEFullRedSpiderDecision()
        assert(instance_number(NTTEFullVlasmaBullet)==_count+3 && _spider.ntte_red_spider_seen
            && _spider.ntte_red_spider_decide==45 && _spider.walk==0,
            "RedSpider close actual attack failed permanent aggro/exact three incoming Vlasma/45timer")
        var _shots=scrNTTEFullBubbleWeaponTestNew(_before,NTTEFullVlasmaBullet)
        for(var _i=0;_i<array_length(_shots);++_i) {
            var _shot=_shots[_i]
            assert(_shot.creator==_spider && _shot.team==team_enemy && _shot.target==_spider
                && _shot.target_x==_spider.x && _shot.target_y==_spider.y
                && _shot.sprite_index==scrNTTERefSprite("EnemyVlasmaBullet")
                && abs(_shot.speed-timescale)<0.0001,
                "RedSpider source field lost actual enemy Vlasma/owner/target/one logical launch speed")
            // BasicCreate applies source sub30Hz launch lead correction.
            assert(abs(point_distance(_spider.x,_spider.y,_shot.x-_shot.hspeed*(1/timescale-1),
                _shot.y-_shot.vspeed*(1/timescale-1))-128)<=0.02,
                "RedSpider source three field launch positions lost128radius or native launch correction")
        }
        _spider.ntte_red_spider_decide=1;_spider.walk=0
        var _timer=_spider.ntte_red_spider_decide
        with(_spider) event_perform(ev_step,ev_step_normal)
        if(timescale<1) assert(_spider.ntte_red_spider_decide==_timer-timescale,
            "RedSpider logical timer rounded to native integer frame")
        _spider.speed=10*timescale;_spider.walk=3;_spider.ntte_red_spider_decide=100
        with(_spider) event_perform(ev_step,ev_step_normal)
        assert(_spider.speed==4*timescale && _spider.walk==3-timescale,
            "RedSpider movement lost source logical acceleration/cap/timer")
        _spider.ntte_red_spider_seen=false;_spider.speed=0
        with(_p) scr_hit(_spider,2)
        assert(_spider.hp==12 && _spider.ntte_red_spider_seen && _spider.sprite_index==_spider.spr_hurt
            && _spider.nexthurt==current_frame+6,
            "Actual native hit missed RedSpider authored hurt/permanent aggro callback")
        _spider.ntte_red_spider_seen=false
        with(_p) scrNTTEFullRawHit(_spider,1,1)
        assert(_spider.hp==11 && _spider.ntte_red_spider_seen,
            "Actual raw hit missed RedSpider callback or applied damage twice")
        _spider.ntte_red_spider_seen=false
        var _bullet=instance_create(96300,96000,Bullet1);_bullet.team=team_player
        with(_bullet) scrNTTEFullNativeProjectileHitNP(_spider,1,0,0)
        assert(_spider.hp==10 && _spider.ntte_red_spider_seen,
            "Actual NP hit missed source RedSpider custom hurt route")
        var _epoch=scrNTTEFullInstances(all)
        _spider.hp=0;instance_destroy(_spider)
        var _impact=scrNTTEFullBubbleWeaponTestNew(_epoch,PlasmaImpact)
        assert(array_length(_impact)==1 && _impact[0].team==team_enemy
            && _impact[0].sprite_index==scrNTTERefSprite("EnemyPlasmaImpact")
            && _impact[0].mask_index==mskPopoPlasmaImpact,
            "RedSpider actual death lost genuine enemy PlasmaImpact/mask or spawned duplicates")
        assert(array_length(scrNTTEFullBubbleWeaponTestNew(_epoch,PortalClear))>=1,
            "RedSpider actual death lost source wall_clear footprint")
    }
    finally {
        scrNTTEFullMergedRuntimeTestCleanup(_before)
        scrNTTEFullAreaGeneratorRestore(_players);scrNTTEFullAreaGeneratorRestore(_game);scrNTTEFullAreaGeneratorRestore(_back)
        current_frame=_tick;random_set_seed(_seed)
    }
    scrNTTESmokeLog("FULL RED SPIDER: source14HP/4rad/melee2, actual incoming3Vlasma/owner/target, logical clocks/speed, ordinary/raw/NP authored hurt aggro and real plasma death/wall clear OK @"+string(30/timescale))
}
