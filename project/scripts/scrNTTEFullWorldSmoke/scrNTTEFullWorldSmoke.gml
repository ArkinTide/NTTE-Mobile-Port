// Called from the common runner after a clear 320x180 test floor is available.
// This checks state transitions and original conditions, not only constructors.
function scrNTTEFullWorldSmoke() {
    var _ctx={ area:area_desert,subarea:1,hard:1,loops:0,safespawn:1,buried_vaults:0,
        scorpion_city_pet_count:0,crime_bounty:0,crime_unlocked:false,coast_unlocked:false,
        general_loaded:true,pet_history_count:0,palace_shrine_skill_count:0,wepmuts:0,
        popolevel:0,player_alias:"fish",trench_unlocked:false }
    var _order=scrNTTEFullWorldEventOrder()
    assert(array_length(_order)==16 && _order[0]=="BlockedRoom" && _order[15]=="BuriedVault","Original event registration/order mismatch")
    assert(!scrNTTEFullWorldEventEligible("YetiHideout",_ctx) && !scrNTTEFullWorldEventEligible("ButtonGame",_ctx),"Original disabled events were enabled")
    assert(scrNTTEFullWorldEventEligible("BlockedRoom",_ctx) && !scrNTTEFullWorldEventEligible("BanditCamp",_ctx),"Event minimum difficulty changed")
    _ctx.hard=3
    assert(scrNTTEFullWorldEventEligible("BanditCamp",_ctx) && scrNTTEFullWorldEventChance("BanditCamp",_ctx)==1/20,"BanditCamp normal probability mismatch")
    _ctx.subarea=3
    assert(scrNTTEFullWorldEventChance("BanditCamp",_ctx)==1/10 && scrNTTEFullWorldEventChance("FirePit",_ctx)==0,"Subarea probability mismatch")
    assert(scrNTTEFullWorldEventChance("GatorDen",_ctx)==0,"Crime unlock bypassed")
    _ctx.crime_unlocked=true
    assert(scrNTTEFullWorldEventChance("GatorDen",_ctx)==1/10,"Crime unlock probability mismatch")
    _ctx.crime_bounty=2.999
    assert(!scrNTTEFullWorldEventChance("GatorAmbush",_ctx),"Ambush bounty threshold changed")
    _ctx.crime_bounty=3
    assert(scrNTTEFullWorldEventChance("GatorAmbush",_ctx),"Ambush bounty threshold changed")
    _ctx.safespawn=0
    assert(!scrNTTEFullWorldEventChance("GatorAmbush",_ctx),"Ambush unsafe spawn allowed")
    _ctx.area=area_vault
    assert(scrNTTEFullWorldEventChance("BuriedVault",_ctx)==1/2,"Vault revisit probability mismatch")
    _ctx.area=scrNTTEFullAreaId("coast")
    assert(scrNTTEFullWorldEventChance("BuriedVault",_ctx)==0,"Buried vault spawned at coast")
    _ctx.safespawn=1; _ctx.area=area_scrapyards; _ctx.buried_vaults=2
    assert(scrNTTEFullWorldEventChance("BuriedVault",_ctx)==1/16,"Vault diminishing probability mismatch")
    _ctx.pet_history_count=1
    assert(scrNTTEFullWorldEventChance("MutantVats",_ctx)==1/3,"MutantVats history probability mismatch")
    _ctx.pet_history_count=12
    assert(scrNTTEFullWorldEventChance("MutantVats",_ctx)==1/3,"MutantVats history count incorrectly multiplies chance")
    _ctx.player_alias="blaac"; _ctx.subarea=2
    assert(scrNTTEFullWorldEventChance("SeaCreature",_ctx)==1,"Original developer alias encounter changed")
    _ctx.subarea=1
    assert(scrNTTEFullWorldEventChance("SeaCreature",_ctx)==0,"Alias encounter spawned on wrong subarea")
    _ctx.player_alias="fish"
    assert(scrNTTEFullWorldEventChance("SeaCreature",_ctx)==1/25,"Normal sea encounter probability mismatch")
    _ctx.popolevel=15; _ctx.loops=2
    assert(scrNTTEFullWorldEventChance("PopoAmbush",_ctx)==1/3,"Loop-adjusted police probability mismatch")
    var _oldarea=GameCont.area,_oldloops=GameCont.loops
    GameCont.loops=0; GameCont.area=area_caves
    var _bat=instance_create(10080,10048,NTTEFullCrystalBat)
    assert(_bat.hp==18 && _bat.raddrop==8 && _bat.meleedamage==5 && _bat.size==1,"CrystalBat original parameters mismatch")
    assert(_bat.spr_shadow==shd24 && _bat.spr_shadow_y==4 && _bat.ntte_wander_left==90 && _bat.ntte_target_left==90,"CrystalBat initial state mismatch")
    with (_bat) {
        scrNTTEFullCrystalBatLook(90)
        scrNTTEFullCrystalBatDash()
        assert(dash && walk==60 && sprite_index==spr_fire,"CrystalBat failed dash start")
        scr_hit(id,2)
        assert(hp==16 && sprite_index==spr_fire,"CrystalBat generic damage cancelled dash animation")
        walk=0; scrNTTEFullCrystalBatFinishDash()
        assert(!dash && !canmelee && image_angle==0 && ntte_wander_left==45 && ntte_target_left==45,"CrystalBat dash did not restore cooldown/contact state")
    }
    instance_destroy(_bat,false)
    _bat=instance_create(10080,10048,NTTEFullInvCrystalBat)
    assert(_bat.curse && _bat.hp==18 && _bat.spr_idle==scrNTTERefSprite("InvCrystalBatIdle"),"Cursed CrystalBat changed health/sprites")
    instance_destroy(_bat,false)
    var _before=instance_number(NTTEFullCrystalBat),_prop=instance_create(10080,10048,NTTEFullBigCrystalProp)
    var _spawned=instance_number(NTTEFullCrystalBat)-_before
    assert(_prop.hp==48 && _prop.size==2 && _prop.spr_shadow==-1 && _spawned>=2 && _spawned<=3,"BigCrystalProp health/group spawn mismatch")
    instance_destroy(_prop,false); instance_destroy(NTTEFullCrystalBat,false)
    GameCont.area=area_cursed_caves
    _before=instance_number(NTTEFullInvCrystalBat); _prop=instance_create(10080,10048,NTTEFullBigCrystalProp)
    _spawned=instance_number(NTTEFullInvCrystalBat)-_before
    assert(_prop.curse && _spawned>=2 && _spawned<=3 && _prop.spr_idle==scrNTTERefSprite("InvBigCrystalPropIdle"),"Cursed big crystal spawned wrong bat group")
    instance_destroy(_prop,false); instance_destroy(NTTEFullInvCrystalBat,false)
    GameCont.area=_oldarea; GameCont.loops=_oldloops
    scrNTTESmokeLog("FULL WORLD EVENT ORDER/CONDITIONS + CRYSTAL BAT DAMAGE/DASH/COOLDOWNS + CRYSTAL GROUPS OK")
}

function scrNTTEFullWorldLifecycleSmoke() {
    var _player=instance_find(Player,0),_oldloops=GameCont.loops
    assert(instance_exists(_player),"World lifecycle requires a live Player")
    var _oldx=_player.x,_oldy=_player.y,_oldwep=_player.wep,_oldbwep=_player.bwep
    var _oldangle=_player.angle,_oldroll=_player.roll
    _player.x=10016; _player.y=10016; _player.angle=0; _player.roll=false
    GameCont.loops=0
    var _guardian=instance_create(10120,10048,NTTEFullPortalGuardian)
    assert(_guardian.hp==55 && _guardian.raddrop==16 && _guardian.meleedamage==2 && _guardian.size==2,"PortalGuardian original stats changed")
    var _flak=scr_projectile_create(10080,10048,NTTEFullVenomFlak,0,6)
    _flak.creator=_guardian; _flak.team=_guardian.team
    assert(_flak.damage==6 && _flak.typ==2 && _flak.charge_time==15 && _flak.explo_time==40,"VenomFlak original parameters changed")
    var _silver=instance_create(10080,10048,NTTEFullVenomFlak)
    _silver.friction=0.2*timescale*timescale; _silver.speed=0
    with (_silver) scrNTTEFullVenomFlakStep()
    assert(abs(_silver.friction-0.2*timescale*timescale)<=0.00001 && abs(_silver.speed-0.5*timescale*timescale)<=0.00001,"VenomFlak overwrote SilverScorpion's original custom friction/charging acceleration")
    _silver.ntte_venom_left=timescale
    var _silver_speed=_silver.speed
    with (_silver) scrNTTEFullVenomFlakStep()
    assert(!_silver.charging && _silver.typ==1 && _silver.speed==_silver_speed && _silver.ntte_venom_left==40,"VenomFlak alarm0 release incorrectly continued same-frame Step")
    instance_destroy(_silver,false)
    var _ticks=ceil(15/timescale)
    repeat(_ticks) with (_flak) scrNTTEFullVenomFlakStep()
    assert(!_flak.charging && _flak.typ==1 && abs(_flak.ntte_venom_left-40)<0.01,"VenomFlak charge/release duration changed")
    instance_destroy(NTTEVenomPellet,false)
    var _before=instance_number(NTTEVenomPellet)
    instance_destroy(_flak)
    assert(instance_number(NTTEVenomPellet)-_before==28,"VenomFlak destruction did not emit4x5+8 original pellets")
    with (NTTEVenomPellet) assert(team==_guardian.team && creator==_guardian,"VenomFlak child faction/creator chain lost")
    instance_destroy(projectile,false)
    GameCont.loops=4
    _flak=instance_create(10080,10048,NTTEFullVenomFlak)
    assert(_flak.charge_time==5,"VenomFlak loop acceleration changed")
    instance_destroy(_flak,false); GameCont.loops=0
    // A guardian's own bullet must implode it despite sharing its faction.
    var _bullet=scr_projectile_create(_guardian.x,_guardian.y,NTTEFullPortalBullet,0,10)
    _bullet.creator=_guardian; _bullet.team=_guardian.team; _bullet.hold=false
    with (_bullet) {
        scrNTTEFullPortalBulletAnimate()
        scrNTTEFullPortalBulletHit(_guardian)
    }
    assert(_guardian.hp==0 && _guardian.implode && !instance_exists(_bullet),"Guardian self-bullet collision was filtered by faction")
    _player.wep=wep_ntte_teleport_gun; _player.bwep=wep_none
    instance_destroy(_guardian)
    var _death=instance_find(NTTEFullPortalGuardianDeath,0)
    assert(instance_exists(_death) && _death.raddrop==16 && _death.team==-1,"Guardian implosion was lost in normal death")
    instance_destroy(HorrorBullet,false)
    _before=instance_number(HorrorBullet)
    var _pickup_before=instance_number(WepPickup)
    with (_death) { image_index=image_number-0.1; scrNTTEFullPortalDeathStep() }
    assert(!instance_exists(_death) && instance_number(HorrorBullet)-_before==45,"Guardian implosion did not emit3x15 original bullets")
    assert(instance_number(WepPickup)==_pickup_before+1,"Guardian implosion did not grant golden teleport gun")
    var _gold=false
    with (WepPickup) if (wep==wep_ntte_golden_teleport_gun) _gold=true
    assert(_gold,"Guardian golden reward used the wrong weapon id")
    instance_destroy(projectile,false)
    // Normal removal branch is forced by visibility=false, not RNG mocking.
    var _portal=instance_create(10080,10048,Portal)
    _portal.visible=false; _portal.type=3; _portal.ntte_full_portal_timer=45
    _player.x=10120; _player.y=10048; _player.angle=15; _player.roll=false
    assert(!collision_line(_player.x,_player.y,_portal.x,_portal.y,Wall,false,false),"PortalPoof rescue fixture crossed a wall")
    var _corpse=instance_create(10080,10048,Corpse)
    _corpse.alarm[0]=10
    scrNTTEFullPortalPoof()
    assert(!instance_exists(_portal) && _corpse.alarm[0]==-1,"PortalPoof failed normal removal/corpse suppression")
    assert(_player.angle==0 || _player.roll,"PortalPoof left nearby player spinning")
    var _protofx=false
    with (BulletHit) if (sprite_index==sprProtoPortalDisappear) _protofx=true
    assert(_protofx,"Native type3 Proto portal used wrong disappearance sprite")
    // Portals occupied by players are protected regardless of age/RNG.
    _player.angle=0; _player.roll=false
    _portal=instance_create(_player.x,_player.y,Portal)
    _portal.ntte_full_portal_timer=45
    scrNTTEFullPortalPoof()
    assert(instance_exists(_portal),"PortalPoof deleted a player-occupied portal")
    instance_destroy(_portal,false); instance_destroy(PortalShock,false)
    instance_destroy(_corpse,false)
    _player.x=_oldx; _player.y=_oldy; _player.wep=_oldwep; _player.bwep=_oldbwep
    _player.angle=_oldangle; _player.roll=_oldroll; GameCont.loops=_oldloops
    scrNTTESmokeLog("FULL WORLD VENOM LOGICAL TIMERS/28PELLETS/FACTIONS + GUARDIAN SELF-IMPLOSION45BULLETS/GOLD + PORTAL TYPE/RESCUE/CONTACT/CORPSE OK")
}

function scrNTTEFullWorldMortarSmoke() {
    var _mortar=instance_create(10176,10048,NTTEFullMortar)
    assert(_mortar.hp==75 && _mortar.raddrop==30 && _mortar.size==3
        && _mortar.spr_shadow==shd48 && _mortar.spr_shadow_y==4,"Mortar original stats/shadow changed")
    _mortar.ntte_mortar_decide_left=1000
    _mortar.ntte_mortar_shot_left=26; _mortar.ntte_mortar_target_x=10016; _mortar.ntte_mortar_target_y=10016
    _mortar.sprite_index=_mortar.spr_fire
    repeat(ceil(26/timescale)) with (_mortar) scrNTTEFullMortarStep()
    assert(_mortar.ntte_mortar_shots==1 && _mortar.ntte_mortar_ammo==3,"Mortar26tick tell or first shot changed")
    repeat(ceil(12/timescale)) with (_mortar) scrNTTEFullMortarStep()
    assert(_mortar.ntte_mortar_shots==4 && _mortar.ntte_mortar_ammo==0 && instance_number(NTTEFullMortarPlasma)==4,"Mortar four-shot4tick burst changed")
    _mortar.sprite_index=_mortar.spr_fire
    scr_hit(_mortar,10)
    assert(_mortar.hp==65 && _mortar.sprite_index==_mortar.spr_fire,"Mortar damage cancelled fire animation")
    var _plasma=instance_find(NTTEFullMortarPlasma,0)
    assert(_plasma.z==19 && _plasma.zfriction==0.4 && _plasma.damage==0,"Mortar airborne projectile parameters changed")
    var _before=instance_number(PlasmaImpact)
    // Land while descending. z=0 with the launch's positive zspeed rises again.
    with (_plasma) { z=0; zspeed=-1; scrNTTEFullMortarPlasmaStep() }
    assert(!instance_exists(_plasma) && instance_number(PlasmaImpact)==_before+1,"Mortar landing did not create impact")
    var _impact=instance_find(PlasmaImpact,instance_number(PlasmaImpact)-1)
    assert(_impact.damage==2 && _impact.team==_mortar.team && _impact.creator==_mortar,"Mortar impact lost original damage/faction/creator")
    instance_destroy(projectile,false)
    var _cursed=instance_create(10080,10048,NTTEFullInvMortar)
    assert(_cursed.curse && _cursed.hp==75 && _cursed.spr_idle==scrNTTERefSprite("InvMortarIdle"),"CursedMortar changed base stats or sprites")
    var _x1=_mortar.x,_y1=_mortar.y,_x2=_cursed.x,_y2=_cursed.y
    with (_cursed) scrNTTEFullMortarSwap(_mortar)
    assert(_mortar.x==_x2 && _mortar.y==_y2 && _cursed.x==_x1 && _cursed.y==_y1,"CursedMortar did not swap both positions")
    assert(_mortar.xprevious==_mortar.x && _cursed.xprevious==_cursed.x,"CursedMortar swap left stale physics positions")
    instance_destroy(_mortar,false); instance_destroy(_cursed,false)
    scrNTTESmokeLog("FULL WORLD MORTAR26TELL/4x4BURST/DAMAGE FIRE STATE + AIRBORNE0/IMPACT2 + CURSED EXACT SWAP OK")
}

function scrNTTEFullWorldCoastBasicSmoke() {
    var _p=instance_find(Player,0),_ox=_p.x,_oy=_p.y,_oa=GameCont.area,_ol=GameCont.loops
    GameCont.area=area_desert; GameCont.loops=0
    _p.x=10016; _p.y=10016
    var _b=instance_create(10080,10048,NTTEFullBabyScorpion)
    assert(_b.hp==7 && _b.raddrop==4 && _b.meleedamage==6,"BabyScorpion original stats changed")
    _b.ammo=2
    var _before=instance_number(NTTEVenomPellet)
    with (_b) scrNTTEFullBabyScorpionDecision()
    assert(_b.ammo==1 && _b.ntte_baby_decide_left>=1 && _b.ntte_baby_decide_left<=3 && instance_number(NTTEVenomPellet)==_before+1,"BabyScorpion normal venom volley changed")
    with (NTTEVenomPellet) assert(team==_b.team && creator==_b,"BabyScorpion venom lost its faction")
    instance_destroy(_b,false); instance_destroy(NTTEVenomPellet,false)
    _b=instance_create(10080,10048,NTTEFullBabyScorpionGold)
    assert(_b.gold && _b.hp==16 && _b.raddrop==14,"Golden baby changed source stats")
    _b.ammo=2
    with (_b) scrNTTEFullBabyScorpionDecision()
    assert(instance_number(NTTEVenomPellet)==3 && _b.ntte_baby_decide_left==2,"Golden baby lost three-shot venom spread")
    with (_b) { ammo=1; scrNTTEFullBabyScorpionDecision() }
    assert(_b.ammo==0 && _b.ntte_baby_decide_left>=20 && _b.ntte_baby_decide_left<=40,"Baby volley did not enter source cooldown")
    instance_destroy(_b,false); instance_destroy(NTTEVenomPellet,false)
    var _g=instance_create(10080,10048,NTTEFullGull)
    assert(_g.hp==8 && _g.raddrop==3 && _g.meleedamage==0,"Gull original stats changed")
    _g.target=_p; _g.ntte_gull_decide_left=1000; _g.ntte_gull_slash_left=8
    _before=instance_number(EnemySlash)
    repeat(ceil(8/timescale)) with (_g) scrNTTEFullGullStep()
    assert(instance_number(EnemySlash)==_before+1 && _g.wkick<0,"Gull8tick tell failed to slash")
    var _slash=instance_find(EnemySlash,instance_number(EnemySlash)-1)
    assert(_slash.damage==2 && _slash.creator==_g && _slash.team==_g.team,"Gull slash damage/faction mismatch")
    instance_destroy(_g,false); instance_destroy(EnemySlash,false)
    // On-floor cactus near a player must not trap that player in a baby group.
    _p.x=10080; _p.y=10048
    _before=instance_number(NTTEFullBabyScorpion)
    var _cactus=instance_create(_p.x,_p.y,NTTEFullBigCactus)
    assert(_cactus.hp==24 && _cactus.spr_shadow_y==4 && instance_number(NTTEFullBabyScorpion)==_before,"BigCactus ignored source player safety radius")
    instance_destroy(_cactus,false)
    var _skull=instance_create(10080,10048,NTTEFullCowSkull)
    assert(_skull.hp==50 && _skull.spr_idle==scrNTTERefSprite("CowSkullIdle") && instance_number(NTTEFullFlySpin)>0,"CowSkull lost native parent or attached fly")
    var _fly=instance_find(NTTEFullFlySpin,0)
    _fly.target=_skull; _fly.target_x=4; _fly.target_y=-8
    with (_fly) scrNTTEFullWorldFlyEndStep()
    assert(_fly.x==_skull.x+4 && _fly.y==_skull.y-8,"FlySpin failed target attachment")
    instance_destroy(_skull,false)
    with (_fly) scrNTTEFullWorldFlyEndStep()
    assert(!instance_exists(_fly),"FlySpin survived deleted target")
    instance_destroy(NTTEFullFlySpin,false)
    var _puffer=instance_create(10080,10048,NTTEFullPuffer)
    assert(_puffer.hp==10 && _puffer.raddrop==4 && _puffer.spr_shadow_y==7,"Puffer original stats/shadow changed")
    _puffer.sprite_index=_puffer.spr_chrg
    scr_hit(_puffer,2)
    assert(_puffer.hp==8 && _puffer.sprite_index==_puffer.spr_chrg,"Puffer generic damage cancelled charging")
    _puffer.ntte_puffer_decide_left=1000; _puffer.image_index=_puffer.image_number-0.1
    with (_puffer) scrNTTEFullPufferStep()
    assert(_puffer.blow>0.95 && _puffer.sprite_index==_puffer.spr_fire,"Puffer charge did not begin original blow state")
    var _blow=_puffer.blow
    scr_hit(_puffer,2)
    assert(_puffer.sprite_index==_puffer.spr_fire && _puffer.blow==_blow,"Puffer hurt cancelled its blow")
    instance_destroy(_puffer,false)
    // Source follower condition deliberately compares player distance < king.
    var _king=instance_create(10160,10048,NTTEFullYetiCrab),_crab=instance_create(10080,10048,NTTEFullYetiCrab)
    _king.is_king=1; _p.x=10096; _p.y=10048
    with (_crab) scrNTTEFullYetiCrabDecision()
    assert(_crab.walk==5 && _crab.ntte_yeti_decide_left>=5 && _crab.ntte_yeti_decide_left<10,"YetiCrab leader-follow ordering diverged")
    instance_destroy(_king,false)
    with (_crab) scrNTTEFullYetiCrabDecision()
    assert(_crab.ntte_yeti_tears>=4 && _crab.ntte_yeti_tears<=10,"YetiCrab did not mourn lost leader")
    instance_destroy(_crab,false)
    _p.x=_ox; _p.y=_oy; GameCont.area=_oa; GameCont.loops=_ol
    scrNTTESmokeLog("FULL WORLD BABY/GOLD VENOM VOLLEY/FACTION + GULL8TELL/SLASH + CACTUS SAFETY + FLY ATTACH/DELETE + PUFFER DAMAGE/CHARGE/BLOW + YETI LEADER/MOURNING OK")
}
