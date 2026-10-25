// tedesert.mod.gml:223..389. Native Bandit AI is inherited as in original.
function scrNTTEFullBanditCamperAfterCreate() {
    spr_idle=scrNTTERefSprite("BanditCamperIdle"); spr_walk=scrNTTERefSprite("BanditCamperWalk")
    spr_hurt=scrNTTERefSprite("BanditCamperHurt"); spr_dead=scrNTTERefSprite("BanditCamperDead")
    sprite_index=spr_idle; hitid=[spr_idle,"CAMPER BANDIT"]; rider_target=noone
}

function scrNTTEFullBanditCamperEndStep() {
    if (lockstep_stop || !instance_exists(rider_target)) return;
    if (sprite_index!=spr_hurt) sprite_index=rider_target.speed<=0 ? spr_idle:spr_walk
    depth=rider_target.depth-1; right=rider_target.right
    x=rider_target.x; y=rider_target.y; xprevious=x; yprevious=y
    x-=(sprite_index==spr_idle ? 2:1)*right; y-=sprite_index==spr_idle ? 10:8
}

function scrNTTEFullBanditHikerAfterCreate() {
    spr_idle=scrNTTERefSprite("BanditHikerIdle"); spr_walk=scrNTTERefSprite("BanditHikerWalk")
    spr_hurt=scrNTTERefSprite("BanditHikerHurt"); spr_dead=scrNTTERefSprite("BanditHikerDead")
    gunspr=sprAllyGunTB; sprite_index=spr_idle; hitid=[spr_idle,"HIKER BANDIT"]
    max_hp=16; hp=max_hp; ntte_hiker_path=[]; path_delay=0; can_path=true; ntte_hiker_backpack_dropped=false
}

// tedesert.ntte_begin_step releases the Hiker's bag before native death.
function scrNTTEFullBanditHikerDeath() {
    if(hp>0 || ntte_hiker_backpack_dropped) return;
    ntte_hiker_backpack_dropped=true;speed/=2;
    var _wrapper=instance_create(x,y,NTTEFullBackpackPickup);
    _wrapper.target=scrNTTEFullLairChestCreate(x,y,"Backpack");
    _wrapper.direction=direction+orandom(10);
    with(_wrapper) scrNTTEFullBackpackPickupEndStep();
    repeat(5) with(instance_create(x,y,Dust)) {
        var _face=image_angle==direction;
        scrNTTEFullNativeMotionAddFT(id,random(360),4);
        if(_face) image_angle=direction;
    }
    snd_play(sndMenuASkin,1.2,0.6);
}

function scrNTTEFullBanditHikerStep() {
    if (lockstep_stop) return;
    if (alarm[1]>1 && (current_frame mod 1)<timescale) alarm[1]-=1
    if (path_delay>0) path_delay-=timescale
    if (walk>0 && instance_exists(target)) {
        if (!scrNTTEFullWorldTargetVisible()) {
            var _tx=target.x,_ty=target.y,_pd=scrNTTEFullPathDirection(ntte_hiker_path,x,y,Wall)
            if (!is_undefined(_pd) && scrNTTEFullPathReaches(ntte_hiker_path,_tx,_ty,Wall)) {
                can_path=true; direction+=angle_difference(_pd,direction)*0.25*timescale
            }
            else if (can_path && path_delay<=0) {
                can_path=false; path_delay=60
                ntte_hiker_path=scrNTTEFullPathShrink(scrNTTEFullPathCreate(x,y,_tx,_ty,Wall),Wall,4)
            }
        }
        else can_path=true
    }
}

function scrNTTEFullBanditHikerDraw() {
    if (gunangle<=180) draw_sprite_ext(gunspr,0,x-lengthdir_x(wkick,gunangle),y-lengthdir_y(wkick,gunangle),1,right,gunangle,c_white,1)
    draw_sprite_ext(sprite_index,image_index,x,y,right,1,0,c_white,1)
    if (gunangle>180) draw_sprite_ext(gunspr,0,x-lengthdir_x(wkick,gunangle),y-lengthdir_y(wkick,gunangle),1,right,gunangle,c_white,1)
    if (GameCont.underwater) draw_sprite(sprPlayerBubble,image_index,x,y)
}

function scrNTTEFullBanditTentCreate() {
    spr_idle=scrNTTERefSprite("BanditTentIdle"); spr_hurt=scrNTTERefSprite("BanditTentHurt"); spr_dead=scrNTTERefSprite("BanditTentDead")
    sprite_index=spr_idle; mask_index=-1; max_hp=6; size=1; depth=-1; target=noone; target_mask=mskNone
}

function scrNTTEFullBanditTentAfterCreate() {
    spr_shadow=scrNTTERefSprite("shd.BanditTent"); snd_hurt=sndHitPlant; snd_dead=sndMoneyPileBreak; team=team_enemy
    scrNTTEFullWorldBudge(instance_create(x,y,NTTEFullBanditCamper),Wall)
}

function scrNTTEFullBanditTentStep() {
    if (lockstep_stop) return;
    if (instance_exists(target)) with (target) { x=other.x; y=other.y+4; xprevious=x; yprevious=y }
    else if (target!=noone) hp=0
    if (spr_idle==scrNTTERefSprite("BanditTentWallIdle") && !collision_circle(x-8*image_xscale,y,1,Wall,false,false)) hp=0
    if (hp<=0) instance_destroy()
}

function scrNTTEFullBanditTentDeath() {
    if (hp>0) return;
    var _angle=random(360)
    for(var _dir=_angle;_dir<_angle+360;_dir+=120) {
        var _dust=instance_create(x,y,Dust)
        with (_dust) motion_set(_dir,3*timescale)
    }
}

function scrNTTEFullBanditCampSmoke() {
    var _loops=GameCont.loops; GameCont.loops=0
    var _camper=instance_create(10080,10048,NTTEFullBanditCamper)
    assert(_camper.hp==4 && _camper.rider_target==noone && _camper.spr_idle==scrNTTERefSprite("BanditCamperIdle"),"Camper lost native Bandit stats/original art")
    var _ride=instance_create(10112,10080,Scorpion); _ride.speed=0; _ride.right=-1
    _camper.rider_target=_ride; _camper.sprite_index=_camper.spr_idle
    with (_camper) scrNTTEFullBanditCamperEndStep()
    assert(_camper.x==_ride.x+2 && _camper.y==_ride.y-10 && _camper.depth==_ride.depth-1,"Camper riding offset/depth changed")
    instance_destroy(_camper,false); instance_destroy(_ride,false)
    var _hiker=instance_create(10080,10048,NTTEFullBanditHiker)
    assert(_hiker.hp==16 && _hiker.gunspr==sprAllyGunTB,"Hiker original health/throne-butt gun changed")
    var _path=[[10080,10048],[10096,10048],[10112,10048],[10128,10048],[10144,10048],[10160,10048]]
    var _short=scrNTTEFullPathShrink(_path,Wall,4)
    assert(array_length(_short)==3 && _short[1][0]==10144,"Original path skipMax/shrink semantics changed")
    with (_hiker) assert(scrNTTEFullPathDirection(_short,x,y,Wall)==0,"Hiker path next-point direction changed")
    instance_destroy(_hiker,false)
    var _before=instance_number(NTTEFullBanditCamper),_tent=instance_create(10080,10048,NTTEFullBanditTent)
    assert(_tent.hp==6 && instance_number(NTTEFullBanditCamper)==_before+1,"Tent did not spawn original camper")
    var _chest=instance_create(10112,10080,WeaponChest); _tent.target=_chest
    with (_tent) scrNTTEFullBanditTentStep()
    assert(_chest.x==_tent.x && _chest.y==_tent.y+4,"Tent did not hold its chosen chest")
    instance_destroy(_chest,false)
    with (_tent) scrNTTEFullBanditTentStep()
    assert(!instance_exists(_tent),"Tent survived removed held chest")
    instance_destroy(NTTEFullBanditCamper,false); GameCont.loops=_loops
    scrNTTESmokeLog("FULL WORLD CAMPER NATIVE AI/RIDING + HIKER16HP/GUN/PATH + TENT SPAWN/CHEST/REMOVAL OK")
    scrNTTEFullBanditHikerDeathNativeTests();
}

function scrNTTEFullBanditHikerDeathNativeTests() {
    var _before=scrNTTEFullInstances(all),_seed=random_get_seed(),_stop=lockstep_stop,
        _game=scrNTTEFullAreaGeneratorSnapshot(GameCont),_players=scrNTTEFullAreaGeneratorSnapshot(Player),
        _back=scrNTTEFullAreaGeneratorSnapshot(BackCont),_particles=UberCont.opt_prtcls;
    try {
        lockstep_stop=false;GameCont.crown=0;GameCont.underwater=false;UberCont.opt_prtcls=true;
        for(var _direct=0;_direct<2;++_direct) {
            var _sample=scrNTTEFullInstances(all),_bags=instance_number(NTTEFullBackpack),
                _wrappers=instance_number(NTTEFullBackpackPickup),_dust=instance_number(Dust),
                _hiker=instance_create(197000+64*_direct,197000,NTTEFullBanditHiker);
            _hiker.hp=0;_hiker.speed=4*timescale;_hiker.direction=35;
            if(_direct) instance_destroy(_hiker);
            else {
                with(_hiker) event_perform(ev_step,ev_step_begin);
                assert(_hiker.speed==2*timescale && _hiker.ntte_hiker_backpack_dropped,
                    "Hiker source BeginStep lost halved corpse motion or bag-release marker");
                assert(instance_number(Dust)==_dust+5,"Hiker source bag release lost exactly five native Dust effects");
                with(_hiker) event_perform(ev_step,ev_step_begin);
                with(_hiker) event_perform(ev_step,ev_step_normal);
            }
            assert(!instance_exists(_hiker) && instance_number(NTTEFullBackpack)==_bags+1
                && instance_number(NTTEFullBackpackPickup)==_wrappers+1,
                "Actual Hiker inherited death omitted or duplicated its one source Backpack chest/wrapper");
            var _wrapper=noone;
            with(NTTEFullBackpackPickup) if(array_get_index(_sample,id)<0) _wrapper=id;
            var _bag=_wrapper.target;
            assert(instance_exists(_bag) && _bag.object_index==NTTEFullBackpack && _bag.num==2
                && _bag.raddrop==8 && _bag.ally==0 && _bag.mask_index==mskNone && _wrapper.z>0
                && abs(angle_difference(_wrapper.direction,35))<=10,
                "Hiker dropped an inert icon or lost source chest rewards/airborne collision/direction");
            var _limit=ceil(30/timescale);
            while(instance_exists(_wrapper) && _limit>0) {
                _limit-=1;
                with(_wrapper) event_perform(ev_step,ev_step_end);
            }
            assert(!instance_exists(_wrapper) && instance_exists(_bag) && _bag.mask_index!=mskNone
                && _bag.y==197000,"Hiker bag did not become a reachable interactive chest after landing");
            scrNTTEFullMergedRuntimeTestCleanup(_sample);
        }
        var _bags=instance_number(NTTEFullBackpack),_wrappers=instance_number(NTTEFullBackpackPickup),
            _alive=instance_create(197128,197000,NTTEFullBanditHiker);
        instance_destroy(_alive);
        assert(instance_number(NTTEFullBackpack)==_bags && instance_number(NTTEFullBackpackPickup)==_wrappers,
            "Nonlethal Hiker cleanup generated a death backpack");
    }
    finally {
        scrNTTEFullMergedRuntimeTestCleanup(_before);scrNTTEFullAreaGeneratorRestore(_game);
        scrNTTEFullAreaGeneratorRestore(_players);scrNTTEFullAreaGeneratorRestore(_back);
        UberCont.opt_prtcls=_particles;lockstep_stop=_stop;random_set_seed(_seed);
    }
    scrNTTESmokeLog("HIKER BACKPACK actual BeginStep/inherited death and direct lethal Destroy, exactly one real bag/airborne wrapper/landing collision, nonlethal exclusion OK @"+string(30/timescale));
}
