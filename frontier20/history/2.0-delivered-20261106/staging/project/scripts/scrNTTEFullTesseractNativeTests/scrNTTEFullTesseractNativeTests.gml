function scrNTTEFullTesseractNativeTests() {
    scrNTTEFullTesseractParticlesOffTests();
    var _before=scrNTTEFullInstances(all),_game=scrNTTEFullAreaGeneratorSnapshot(GameCont),
        _players=scrNTTEFullAreaGeneratorSnapshot(Player),_back=scrNTTEFullAreaGeneratorSnapshot(BackCont),
        _uber=scrNTTEFullAreaGeneratorSnapshot(UberCont),_music=scrNTTEFullAreaGeneratorSnapshot(MusCont),
        _seed=random_get_seed(),_tick=current_frame,_p=instance_find(Player,0),
        _surface=-1,_camera=-1,_world=matrix_get(matrix_world),_view=matrix_get(matrix_view),_projection=matrix_get(matrix_projection),
        _source_state=scrNTTEFullValue(GameCont,"ntte_full_source_seed",undefined)
    if(is_struct(_source_state)) GameCont.ntte_full_source_seed=scrNTTEFullSourceSeedCopy(_source_state)
    try {
        GameCont.loops=0;GameCont.area=206;current_frame=8;_p.x=100160;_p.y=100000;_p.team=team_player
        UberCont.opt_bossintro=false
        var _boss=instance_create(100000,100000,NTTEFullTesseract),_hp=scrNTTEFullSewerBossHP(600)
        assert(_boss.hp==_hp && _boss.max_hp==_hp && _boss.raddrop==65 && _boss.size==6
            && _boss.meleedamage==_hp && !_boss.canmelee && !_boss.corpse && _boss.boss
            && _boss.ntte_tesseract_alarm1==200 && _boss.ntte_tesseract_alarm2==240
            && _boss.mask_index==scrNTTERefSprite("msk.CaveHole") && _boss.spr_shadow==mskNone
            && _boss.spr_shadow_y==12 && abs(_boss.friction-0.2*timescale*timescale)<=0.0001
            && array_length(_boss.layers)==3 && array_length(_boss.weapons)==4,
            "Tesseract actual constructor lost source600bossHP/arms/layers/timers/body")
        for(var _i=0;_i<4;++_i) {
            var _arm=_boss.weapons[_i]
            assert(_arm.kick==16 && _arm.offset==64*2/3 && _arm.strike==noone
                && abs(angle_difference(_arm.rotation,_i*90+round(_boss.direction/90)*90))<0.001,
                "Tesseract constructor lost four orthogonal source arms")
        }
        _boss.speed=0;_boss.walk=0
        with(_boss) event_perform(ev_step,ev_step_normal)
        assert(abs(_boss.speed-0.2*timescale)<=0.0001,"Tesseract source minimum hover cap lost")
        _boss.speed=9*timescale
        with(_boss) event_perform(ev_step,ev_step_normal)
        assert(abs(_boss.speed-2*timescale)<=0.0001,"Tesseract source maximum hover cap lost")
        var _clears=instance_number(PortalClear)
        with(_boss) event_perform(ev_alarm,1)
        assert(_boss.intro && _boss.canmelee && instance_number(PortalClear)==_clears+5
            && GameCont.ntte_full_boss_music_key=="Tesseract",
            "Tesseract first actual alarm omitted intro/melee/music/body+four outward wall clears")
        // Three orderly volleys exhaust source ammo then preserve24tick/arm cooldown.
        repeat(3) {
            var _old=_boss.ammo,_count=instance_number(NTTEFullTesseractStrike)
            with(_boss) event_perform(ev_alarm,2)
            assert(_boss.ammo==_old-1 && instance_number(NTTEFullTesseractStrike)==_count+4,
                "Tesseract orderly actual volley lost four genuine strikes/source ammo")
            var _speed=_boss.weapons[0].rotspeed
            for(var _i=0;_i<4;++_i) {
                var _arm=_boss.weapons[_i],_strike=_arm.strike
                assert(instance_exists(_strike) && _strike.creator==_boss && _strike.team==_boss.team
                    && _arm.kick_goal==10 && _arm.rotspeed==_speed && _strike.active
                    && abs(angle_difference(_arm.rotation,_boss.weapons[0].rotation+_i*90))<0.001,
                    "Tesseract orderly strike lost creator/team/even rotation/kick")
            }
        }
        assert(_boss.ammo==0 && _boss.ntte_tesseract_alarm2==96,"Tesseract final orderly volley lost24tick per-arm cooldown")
        // Advance the boss before strike callbacks: authored muzzle anchoring,
        // fire pose, kick and layer spins happen while their warning is active.
        var _strike=_boss.weapons[0].strike
        _strike.ntte_strike_alarm=ceil(timescale)
        with(_boss) event_perform(ev_step,ev_step_normal)
        var _arm=_boss.weapons[0]
        assert(_boss.sprite_index==_boss.spr_fire && _boss.image_index==0 && _arm.kick==10
            && abs(_strike.xstart-(_boss.x+lengthdir_x(_arm.offset*_boss.image_xscale,_arm.rotation)))<=0.008
            && abs(_strike.ystart-(_boss.y+lengthdir_y(_arm.offset*_boss.image_yscale,_arm.rotation)))<=0.008,
            "Tesseract warning launch lost native muzzle anchor/fire pose/recoil")
        // A single remaining arm always uses the chaotic branch because source
        // orderly probability is(len-1)/(max*2). Actual old strikes are removed.
        with(NTTEFullTesseractStrike) if(creator==_boss) instance_destroy(id,false)
        var _saved=_boss.weapons
        _boss.weapons=[_saved[0]];_boss.ammo=0
        var _count=instance_number(NTTEFullTesseractStrike)
        with(_boss) event_perform(ev_alarm,2)
        _arm=_boss.weapons[0];_strike=_arm.strike
        assert(instance_number(NTTEFullTesseractStrike)==_count+1 && _arm.kick_goal==15 && _arm.kick==-5
            && _strike.ntte_strike_alarm<=20 && _strike.creator==_boss
            && abs(angle_difference(_arm.rotation,point_direction(_boss.x,_boss.y,_p.x,_p.y)))<0.001,
            "Tesseract single-arm chaotic volley lost aim/delay/kick/actual strike")
        // Genuine staged arm ejection at the first source health threshold.
        _boss.weapons=_saved;_boss.hp=0.75*_boss.max_hp;_boss.speed=0;_boss.walk=0
        var _arms=instance_number(NTTEFullTesseractArmDeath)
        with(_boss) event_perform(ev_step,ev_step_normal)
        assert(array_length(_boss.weapons)==3 && instance_number(NTTEFullTesseractArmDeath)==_arms+1 && _boss.ammo<=0,
            "Tesseract actual health threshold failed genuine detached projectile arm")
        var _detached=noone
        with(NTTEFullTesseractArmDeath) if(creator==_boss) _detached=id
        assert(instance_exists(_detached) && _detached.team==_boss.team && abs(_detached.speed-5.5*timescale)<=0.0001,
            "Tesseract actual detached arm lost source owner/team/5.5speed")
        _surface=surface_create(96,96);_camera=camera_create_view(_boss.x-48,_boss.y-48,96,96,0,noone,-1,-1,-1,-1)
        surface_set_target(_surface);camera_apply(_camera);draw_clear_alpha(c_black,0)
        with(_boss) event_perform(ev_draw,0)
        surface_reset_target()
        // Kill through real enemy destruction. Arms eject immediately, while
        // the65rads and goldenTunneller wait for the four-stage death chain.
        _p.wep=wep_ntte_tunneller;_p.bwep=wep_revolver
        var _kills=GameCont.kills,_rads=instance_number(Rad)+9*instance_number(BigRad)
        _boss.hp=0;_boss.speed=5*timescale;instance_destroy(_boss)
        var _death=noone
        with(NTTEFullTesseractDeath) if(array_get_index(_before,id)<0) _death=id
        assert(GameCont.kills==_kills+1 && instance_exists(_death) && _death.raddrop==65
            && _death.throes==3 && _death.ntte_tesseract_death_alarm==1 && abs(_death.speed-2*timescale)<=0.0001
            && instance_number(Rad)+9*instance_number(BigRad)==_rads,
            "Tesseract native enemy death lost single kill/deferred65rads/3throes/initial1tick")
        repeat(max(1,ceil(1/timescale))) if(instance_exists(_death)) with(_death) event_perform(ev_step,ev_step_normal)
        assert(instance_exists(_death) && _death.throes==2 && abs(_death.speed-4*timescale)<=0.0001,
            "Tesseract actual first logical1tick throe failed jerk/layer release")
        surface_set_target(_surface);camera_apply(_camera)
        with(_death) event_perform(ev_draw,0)
        surface_reset_target()
        repeat(3) if(instance_exists(_death)) repeat(round(30/timescale)) if(instance_exists(_death))
            with(_death) event_perform(ev_step,ev_step_normal)
        scrNTTESmokeLog("TESSERACT DEATH DIAG exists="+string(instance_exists(_death))
            +" rads="+string(instance_number(Rad)+9*instance_number(BigRad))+" before="+string(_rads)
            +" throes="+string(scrNTTEFullValue(_death,"throes",-99))
            +" alarm="+string(scrNTTEFullValue(_death,"ntte_tesseract_death_alarm",-99)))
        assert(!instance_exists(_death) && instance_number(Rad)+9*instance_number(BigRad)==_rads+65,
            "Tesseract actual three30tick stages did not release final deferred65rads")
        var _reward=false,_chunks=0
        with(WepPickup) if(array_get_index(_before,id)<0 && wep==wep_ntte_golden_tunneller) _reward=true
        with(ScrapBossCorpse) if(array_get_index(_before,id)<0) {
            ++_chunks
            assert(size==3 && mask_index==-1 && speed<=16*timescale,"Tesseract genuine corpse fragment lost source size/mask/speed cap")
        }
        assert(_reward && _chunks>0,"Tesseract final actual death omitted goldenTunneller qualification/corpse fragments")
        // Loop boss keeps4+loops arms and gets a real native intro as well.
        GameCont.loops=2;UberCont.opt_bossintro=true
        var _loop=instance_create(100000,100000,NTTEFullTesseract)
        assert(_loop.hp==scrNTTEFullSewerBossHP(600) && array_length(_loop.weapons)==6,
            "Tesseract loop construction lost source bossHP multiplier/4+loops arms")
        with(_loop) event_perform(ev_alarm,1)
        assert(UberCont.bossintro && UberCont.ntte_full_intro_key=="Tesseract"
            && scrNTTEFullBossIntroSprite(sprBossIntro)==scrNTTERefSprite("Intro.Tesseract.Main"),
            "Tesseract loop boss omitted actual native intro/source artwork")
    }
    finally {
        if(surface_get_target()==_surface && _surface>=0) surface_reset_target()
        if(surface_exists(_surface)) surface_free(_surface)
        if(_camera>=0) camera_destroy(_camera)
        matrix_set(matrix_world,_world);matrix_set(matrix_view,_view);matrix_set(matrix_projection,_projection)
        scrNTTEFullMergedRuntimeTestCleanup(_before)
        scrNTTEFullAreaGeneratorRestore(_game);scrNTTEFullAreaGeneratorRestore(_players);scrNTTEFullAreaGeneratorRestore(_back)
        scrNTTEFullAreaGeneratorRestore(_uber);scrNTTEFullAreaGeneratorRestore(_music)
        GameCont.ntte_full_source_seed=_source_state
        random_set_seed(_seed);current_frame=_tick
    }
    scrNTTESmokeLog("FULL TESSERACT: source600bossHP/4+loops actual arms/hover/intro wall clears/orderly+chaotic genuine strikes/muzzle+recoil/health arm ejection/actual layered Draw/real staged death+corpse+65rads/goldenTunneller/loop native intro OK @"+string(30/timescale))
}

function scrNTTEFullTesseractParticlesOffTests() {
    var _fixture=scrNTTEFullVanillaFixtureBegin(),_old=UberCont.opt_prtcls,_stop=lockstep_stop;
    lockstep_stop=false;
    try {
        UberCont.opt_prtcls=false;
        var _d=instance_create(104000,104000,NTTEFullTesseractDeath),_rads=instance_number(Rad)+9*instance_number(BigRad);
        assert(instance_exists(_d),"Tesseract particle fixture lost actual death actor");
        instance_destroy(_d);
        assert(!instance_exists(_d) && instance_number(Rad)+9*instance_number(BigRad)==_rads+65,
            "Real Tesseract Destroy with disabled particles crashed or skipped deferred65rads");
        scrNTTESmokeLog("TESSERACT PARTICLES OFF: actual Destroy, Smoke constructor self-destruction and all65rad rewards retained @"+string(30/timescale));
    } finally {UberCont.opt_prtcls=_old;scrNTTEFullVanillaFixtureEnd(_fixture);lockstep_stop=_stop;}
}
