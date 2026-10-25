// Behavioral fixtures execute real constructors, damage callbacks, collision,
// animation completion and destruction. Root runs them on the native runner.
function scrNTTEFullCoastBossBecomeSmoke() {
    var _before=scrNTTEFullInstances(all),_loops=GameCont.loops,_visits=scrNTTEFullValue(GameCont,"ntte_visits_coast",0)
    GameCont.loops=1; GameCont.ntte_visits_coast=1
    var _skull=instance_create(76016,76016,NTTEFullCoastBossBecome),_prompt=_skull.prompt,_parts=min(2,sprite_get_number(_skull.spr_idle)-2)
    assert(_skull.hp==200 && _skull.max_hp==200 && _skull.part==_parts && _skull.team==0 && _skull.size==2 && _skull.image_speed==0,"CoastBossBecome source HP/visits+loop/neutral/static constructor changed")
    assert(instance_exists(_prompt) && _prompt.creator==_skull && _prompt.text=="DONATE","Source skull lacks actual donation prompt")
    var _p=instance_find(Player,0),_race=_p.race
    _p.race=Race.Fish; assert(!scrNTTEFullCoastBossBecomePromptMeet(_p),"Non-Skeleton incorrectly eligible to donate")
    _p.race=Race.Skeleton; assert(scrNTTEFullCoastBossBecomePromptMeet(_p),"Skeleton donation eligibility missing"); _p.race=_race
    var _arrow=instance_create(_skull.x,_skull.y,NTTEFullBoneArrow); _arrow.big=true
    scrNTTEFullCoastBossBecomeHurt(_skull,42,90,16*timescale,_arrow)
    assert(!instance_exists(_arrow) && _skull.part==_parts+2 && _skull.hp==200 && _skull.speed==0,"Heavy real BoneArrow failed source two-part feeding/heal/consumption/knockback immunity")
    // Use an unfinished skull: a complete skull transforms before its death
    // check by design, even when its HP was depleted in the same frame.
    _skull.part=1
    var _before_bones=instance_number(WepPickup),_expected=_skull.part
    _skull.hp=0; with (_skull) scrNTTEFullCoastBossBecomeStep()
    assert(instance_number(WepPickup)==_before_bones+_expected,"Broken skull failed source one recoverable bone per donated part")
    assert(!instance_exists(_prompt),"Skull death/transformation left orphan donation prompt")
    GameCont.loops=0; GameCont.ntte_visits_coast=0
    var _complete=instance_create(76516,76516,NTTEFullCoastBossBecome),_complete_prompt=_complete.prompt,_bosses=instance_number(NTTEFullCoastBoss)
    _complete.image_xscale=-1; _complete.part=sprite_get_number(_complete.spr_idle)-1
    var _x=_complete.x+8,_y=_complete.y-6
    with (_complete) scrNTTEFullCoastBossBecomeStep()
    assert(!instance_exists(_complete) && !instance_exists(_complete_prompt) && instance_number(NTTEFullCoastBoss)==_bosses+1,"Complete source skeleton did not transform once into actual boss/clean prompt")
    var _boss=instance_nearest(_x,_y,NTTEFullCoastBoss)
    assert(_boss.x==_x && _boss.y==_y && _boss.right==-1,"Skull-to-boss source8px/6px location/facing changed")
    var _all=scrNTTEFullInstances(all)
    for(var _i=0;_i<array_length(_all);++_i) if (array_get_index(_before,_all[_i])<0) instance_destroy(_all[_i],false)
    GameCont.loops=_loops; GameCont.ntte_visits_coast=_visits
    scrNTTESmokeLog("FULL WORLD COAST SKULL SOURCE100*(1+LOOPS)HP/VISITS+LOOPS PARTS/SKELETON PROMPT/HEAVY ARROW FEED+CONSUMPTION/ACTUAL DEATH BONE REFUND/REAL BOSS TRANSFORMATION+OFFSET+CLEANUP OK")
}
function scrNTTEFullCoastBossSmoke() {
    var _before=scrNTTEFullInstances(all),_loops=GameCont.loops,_p=instance_find(Player,0),_px=_p.x,_py=_p.y
    GameCont.loops=0; _p.x=77016; _p.y=77216
    var _boss=instance_create(77016,77016,NTTEFullCoastBoss)
    assert(_boss.hp==scrNTTEFullSewerBossHP(150) && _boss.hp==_boss.max_hp && _boss.raddrop==50 && _boss.size==3 && _boss.meleedamage==3 && _boss.ntte_coast_timers[1]==90,"Big Fish source boss HP/drop/contact/90tick initial decision changed")
    assert(array_length(_boss.fish_train)==0 && !_boss.intro && _boss.sprite_index==_boss.spr_spwn,"First-loop Big Fish gained loop-only train or lost spawn animation")
    _boss.sprite_index=_boss.spr_idle; _boss.hspeed=0; _boss.vspeed=0
    var _hp=_boss.hp
    scrNTTEFullCoastBossHurt(_boss,7,90,3*timescale,noone)
    assert(_boss.hp==_hp-7 && abs(_boss.vspeed+3*timescale)*1000000<=1 && _boss.sprite_index==_boss.spr_hurt,"Surface Big Fish custom hurt lost exact damage/knockback/hurt animation")
    _boss.swim=50; _boss.hspeed=0; _boss.vspeed=0
    scrNTTEFullCoastBossHurt(_boss,5,0,12*timescale,noone)
    assert(_boss.hp==_hp-12 && _boss.speed==0,"Swimming Big Fish should still take damage while suppressing knockback")
    _boss.swim=0; _boss.ntte_coast_timers=[-1,-1,-1,-1]; _boss.ammo=8; _boss.gunangle=90
    var _bombs=instance_number(NTTEFullBubbleBomb)
    repeat(8) with (_boss) scrNTTEFullCoastBossAlarm2()
    assert(_boss.ammo==0 && instance_number(NTTEFullBubbleBomb)==_bombs+8 && _boss.ntte_coast_timers[1]==60 && _boss.shot_wave==16,"Actual source bubble volley omitted eight bombs/wave progression/final60tick recovery")
    with (NTTEFullBubbleBomb) if (id>_boss.id) assert(team==team_enemy && creator==_boss && damage==3,"Big Fish bombs lost actual native creator/team/damage inheritance")
    _boss.ntte_coast_timers=[-1,-1,-1,-1]; _boss.sprite_index=_boss.spr_dive; _boss.image_index=sprite_get_number(_boss.spr_dive)-0.01; _boss.swim_target=_p; _boss.right=1
    with (_boss) scrNTTEFullCoastBossStep()
    assert(_boss.swim>=179 && _boss.swim<=180 && _boss.mask_index==mskNone && _boss.swim_mask==mskBigMaggot && _boss.depth==-1 && _boss.spr_shadow==mskNone,"Actual dive animation did not start source180tick maskless swimming")
    _boss.swim=timescale/2; _boss.ntte_coast_timers=[-1,-1,-1,-1]
    with (_boss) scrNTTEFullCoastBossStep()
    assert(_boss.swim==0 && _boss.mask_index==mskBigMaggot && _boss.swim_mask==-1 && _boss.sprite_index==_boss.spr_rise && _boss.depth==-2 && _boss.speed==0,"Source swim expiry omitted full collision/shadow/depth/rise restoration")
    GameCont.loops=1
    var _train=instance_create(77516,77516,NTTEFullCoastBoss)
    assert(array_length(_train.fish_train)==3,"Loop Big Fish requires exactly three train slots per loop")
    _train.fish_swim=[true,true,true]; _train.fish_swim_delay=100; _train.fish_swim_regen=0
    with (_train) scrNTTEFullCoastBossTrain()
    var _first=_train.fish_train[0]
    assert(instance_exists(_first) && _first.creator==_train && !_first.visible && _first.kills==0 && _train.fish_train[1]==noone,"Swim train failed one-at-a-time physical fish regeneration/hidden attachment/no-kill defaults")
    _train.fish_swim_regen=0; with (_train) scrNTTEFullCoastBossTrain()
    var _second=_train.fish_train[1]
    assert(instance_exists(_second) && !_second.visible && _second.creator==_train,"Swim train did not regenerate second sequential physical member")
    instance_destroy(_first,false); _train.fish_swim[0]=false; _train.fish_swim_regen=100
    with (_train) scrNTTEFullCoastBossTrain()
    assert(_train.fish_train[0]==noone && _train.fish_train[1]==noone && _second.visible,"Broken source train must release surviving tail visibly rather than tether across a dead leader")
    var _all=scrNTTEFullInstances(all)
    for(var _i=0;_i<array_length(_all);++_i) if (array_get_index(_before,_all[_i])<0) instance_destroy(_all[_i],false)
    _p.x=_px; _p.y=_py; GameCont.loops=_loops
    scrNTTESmokeLog("FULL WORLD BIG FISH ORIGINAL HP/RADIATION+CONTACT/90TICK DECISION/SURFACE HURT+SWIM KNOCKBACK IMMUNITY/ACTUAL8BOMB VOLLEY/180TICK MASKLESS DIVE+RISE/3PERLOOP PHYSICAL TRAIN+REGEN+BROKEN TAIL RELEASE OK")
}
function scrNTTEFullBubbleBombSmoke() {
    var _before=scrNTTEFullInstances(all),_bubble=instance_create(78016,78016,NTTEFullBubbleBomb)
    assert(_bubble.damage==3 && _bubble.knockback_speed==2*timescale && _bubble.z==0 && _bubble.zspeed==-0.5 && _bubble.zfriction==-0.02,"Source bubble damage/force/vertical physics constructor changed")
    _bubble.team=team_enemy; with (_bubble) scrNTTEFullBubbleBombSetup()
    assert(_bubble.sprite_index==scrNTTERefSprite("BubbleBombEnemy"),"Actual hostile bubble failed enemy visual selection")
    repeat(round(30/timescale)) with (_bubble) scrNTTEFullBubbleBombStep()
    // Semi-implicit source integration at higher physical frame rates differs
    // by at most0.225px over30logicalticks; velocity must agree exactly.
    assert(abs(_bubble.zspeed-0.1)*1000000<=1 && _bubble.z<0,"Bubble original fall-then-float ascent acceleration/sign changed")
    var _shot=instance_create(_bubble.x,_bubble.y-_bubble.z,NTTEVenomPellet)
    // Raw constructors leave both creators=noone. Source detonation deletes
    // only a projectile with a different creator, so use an actual shooter.
    _shot.creator=instance_find(Player,0); _shot.team=team_player; _shot.typ=1; _shot.direction=0; _shot.speed=4*timescale
    with (_bubble) scrNTTEFullBubbleBombEndStep()
    assert(array_length(_bubble.held)==1 && _bubble.held[0]==_shot && _shot.bubble_bombed,"Actual small-bubble overlap failed to capture projectile")
    _bubble.speed=0; _bubble.big=0
    var _slash=instance_create(_bubble.x,_bubble.y,Slash); _slash.direction=180; _slash.shank=false
    with (_bubble) scrNTTEFullBubbleBombBaseball(_slash)
    assert(abs(_bubble.speed-10*timescale)*1000000<=1 && _bubble.deflected,
        "Occupied normal bubble source melee baseball lost10speed or real native Grenade deflection")
    var _blast_before=scrNTTEFullInstances(NTTEFullBubbleExplosion),_blast_count=array_length(_blast_before)
    _bubble.damage=9
    with (_bubble) scrNTTEFullBubbleBombAnimate()
    assert(!instance_exists(_bubble) && instance_number(NTTEFullBubbleExplosion)==_blast_count+1 && !instance_exists(_shot),"Actual bubble animation completion must explode once and delete foreign trapped projectile")
    // Native instance_find order is not an append-only creation order when
    // earlier world fixtures still own explosions. Identify actual new IDs.
    var _blast=noone,_blast_new=[]
    with(NTTEFullBubbleExplosion) if(array_get_index(_blast_before,id)<0) {_blast=id;array_push(_blast_new,id)}
    scrNTTESmokeLog("BUBBLE WORLD BLAST DIAG "+json_stringify({before:_blast_count,newCount:array_length(_blast_new),
        damage:scrNTTEFullValue(_blast,"damage",-999),team:scrNTTEFullValue(_blast,"team",-999)}))
    // Source Animate: deflected bubbles use creator.team for a Player creator,
    // otherwise -1. This raw-created bubble has creator=noone; its genuine
    // Slash/Grenade baseball now correctly marks it deflected before exploding.
    assert(_blast.damage==9 && _blast.team==-1,"Bubble detonation lost damage or source unowned deflection team-1")
    var _big=instance_create(78516,78516,NTTEFullBubbleBomb),_enemy=instance_create(78516,78516,Bandit)
    _big.big=1; _big.team=team_player
    with (_big) { scrNTTEFullBubbleBombSetup(); scrNTTEFullBubbleBombEndStep() }
    assert(_big.sprite_index==scrNTTERefSprite("BubbleBombBig") && _big.mask_index==mskExploder && _enemy.bubble_bombed && array_length(_big.held)==1,"Actual large bubble failed size/hostile enemy capture")
    instance_destroy(_big)
    assert(!_enemy.bubble_bombed,"Popped large bubble failed captured enemy release")
    var _pop=instance_create(79016,79016,NTTEFullBubbleBomb),_bolt=instance_create(79016,79016,Bolt)
    _pop.team=team_enemy; _bolt.team=team_player
    with (_pop) scrNTTEFullBubbleBombEndStep()
    assert(!instance_exists(_pop) && instance_exists(_bolt),"Enemy bubble must pop on hostile bolt without destroying the bolt")
    var _all=scrNTTEFullInstances(all)
    for(var _i=0;_i<array_length(_all);++_i) if (array_get_index(_before,_all[_i])<0) instance_destroy(_all[_i],false)
    scrNTTESmokeLog("FULL WORLD ACTUAL BUBBLE HOSTILE VISUAL/PHYSICAL FALL-THEN-FLOAT/PROJECTILE CAPTURE/OCCUPIED MELEE BASEBALL/ANIMATION EXPLOSION+DAMAGE+TEAM/LARGE ENEMY CAPTURE+RELEASE/HOSTILE BOLT POP OK")
}
function scrNTTEFullCoastBossDeathSmoke() {
    var _before=scrNTTEFullInstances(all),_pending=scrNTTEFullValue(GameCont,"ntte_full_pending_destination",undefined),
        _kill=scrNTTEFullValue(GameCont,"killenemies",0),_kills=GameCont.kills,_portals=instance_number(Portal)
    var _boss=instance_create(79516,79516,NTTEFullCoastBoss)
    _boss.hp=0; instance_destroy(_boss)
    var _destination=GameCont.ntte_full_pending_destination
    assert(GameCont.killenemies==true && is_struct(_destination) && _destination.area==scrNTTEFullAreaId("coast") && _destination.subarea==1 && _destination.loops==GameCont.loops,"Actual Big Fish death omitted kill-all/native Coast0-to1 portal destination")
    assert(instance_number(Portal)==_portals+1 && GameCont.kills==_kills+1,"Actual Big Fish death omitted real Portal/native one-kill accounting")
    var _all=scrNTTEFullInstances(all)
    for(var _i=0;_i<array_length(_all);++_i) if (array_get_index(_before,_all[_i])<0) instance_destroy(_all[_i],false)
    GameCont.ntte_full_pending_destination=_pending; GameCont.killenemies=_kill; GameCont.kills=_kills
    scrNTTESmokeLog("FULL WORLD ACTUAL BIG FISH DEATH/NATIVE KILL ACCOUNTING+PORTAL/30HZ KILLALL REQUEST/CORRECT COAST1 MOBILE TRANSITION DESTINATION OK; NATURAL TRANSITION STILL REQUIRES REGRESSION")
}
