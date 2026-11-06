function scrNTTEFullLoadingTipsNativeTests() {
    assert(scrNTTESmokeEnabled(),"Loading tips fixture requires explicit desktop smoke harness")
    var _before=scrNTTEFullInstances(all),_game=scrNTTEFullAreaGeneratorSnapshot(GameCont),
        _players=scrNTTEFullAreaGeneratorSnapshot(Player),_seed=random_get_seed(),
        _progress=global.ntte_full_progress,_petSlots=[],
        _gamepad=UberCont.opt_gamepad,_keyboard=UberCont.opt_keyboard,
        _originalSkills=GameCont.skills,_tipSkills=ds_list_create()
    with(Player) array_push(_petSlots,[id,scrNTTEFullValue(id,"ntte_pet",[]),scrNTTEFullValue(id,"ntte_pet_max",undefined)])
    global.ntte_full_progress={schema:1,unlocks:{},loadouts:{},stats:{}}
    with(Player) {ntte_pet=[];ntte_pet_max=2}
    try {
        var _p=instance_find(Player,0),_gen=instance_create(99000,99000,Floor)
        with(_gen) instance_change(GenCont,false)
        // Exercise the real native loading selector with its mutation branch.
        // A skill ID is not a second list index; an empty list cannot be sampled.
        var _mutationSeed=-1
        for(var _n=1;_n<500 && _mutationSeed<0;++_n) {
            random_set_seed(_n)
            if(choose(0,0,0,0,0,0,0,1,1,1,1,2,2,3,4,5,6,7)==4) _mutationSeed=_n
        }
        assert(_mutationSeed>=0,"Native mutation tip fixture seed missing")
        GameCont.skills=_tipSkills;GameCont.level=2
        random_set_seed(_mutationSeed)
        with(_gen) scrTips()
        assert(is_string(_gen.tip) && string_length(_gen.tip)>0,
            "Native empty mutation list did not safely fall back to an ordinary loading tip")
        var _tipSkill=mut_last_wish
        ds_list_add(_tipSkills,_tipSkill)
        var _skillTip=loc("Skills",_tipSkill,"Tip",scr_skill_get_tips(_tipSkill))
        random_set_seed(_mutationSeed)
        with(_gen) scrTips()
        assert(is_array(_skillTip) ? array_get_index(array_map(_skillTip,function(_s){return string_hash_to_newline(_s)}),_gen.tip)>=0
                                  : _gen.tip==string_hash_to_newline(_skillTip),
            "Native mutation loading tip used the skill ID as a second list index")
        GameCont.skills=_originalSkills
        _gen.tip="native tip";_gen.ntte_loading_tips_setup=false
        GameCont.hard=2;GameCont.ntte_scythe_tip_index=0
        _p.wep=wep_ntte_bone_scythe;_p.bwep=wep_revolver
        var _pool=scrNTTEFullScytheTipPool()
        for(var _i=0;_i<8;++_i) {
            _gen.ntte_loading_tips_setup=false;_gen.tip="native tip"
            random_set_seed(9173);var _expected=random(100000);random_set_seed(9173)
            assert(scrNTTEFullLoadingTipsSetup(_gen) && _gen.tip_ntte==_pool[min(_i,5)]
                && GameCont.ntte_scythe_tip_index==min(_i+1,5)
                && string_pos("sprKeySmall:pick",_gen.tip)==0,
                "Source six-step Scythe teaching priority/terminal index/native control binding diverged")
            assert(abs(random(100000)-_expected)<=0.001,
                "Scythe presentation changed the native generation RNG stream")
            var _tip=_gen.tip,_index=GameCont.ntte_scythe_tip_index
            assert(!scrNTTEFullLoadingTipsSetup(_gen) && _gen.tip==_tip && GameCont.ntte_scythe_tip_index==_index,
                "Repeated native GenCont setup replayed source teaching progression")
        }
        GameCont.ntte_scythe_tip_index=-1;_gen.ntte_loading_tips_setup=false;_gen.tip="native tip"
        scrNTTEFullLoadingTipsSetup(_gen)
        assert(_gen.tip_ntte=="" && _gen.tip=="native tip" && GameCont.ntte_scythe_tip_index==-1,
            "Source Scythe mode-change sentinel did not permanently suppress teaching")
        GameCont.hard=1;GameCont.ntte_scythe_tip_index=0
        _gen.ntte_loading_tips_setup=false;_gen.tip="native tip";scrNTTEFullLoadingTipsSetup(_gen)
        assert(_gen.tip_ntte=="" && GameCont.ntte_scythe_tip_index==0,
            "Source Scythe teaching escaped hard>1 gate")
        // Exact authored pools include scalar Peas and cursed word order.
        assert(scrNTTEFullPetTipPool("CoolGuy","peas")=="STINK BEAN"
            && scrNTTEFullPetTipPool("Parrot",1)[0]=="BACKPACK BUDDY"
            && scrNTTEFullPetTipPool("Spider",1)[0]=="STUCK A BIT"
            && scrNTTEFullPetTipPool("Weapon",1)[0]=="RESPECT MUTUAL"
            && scrNTTEFullPetTipPool("Prism")[2]=="YEAH OH ",
            "Source pet tip skin variants/scalar semantics/trailing authored whitespace changed")
        var _names=["Scorpion","Parrot","CoolGuy","Orchid","Octo","Mimic","Salamander","Slaughter","Spider","Prism","Twins","Cuz","Weapon","Guardian"]
        for(var _i=0;_i<array_length(_names);++_i) {
            var _tips=scrNTTEFullPetTipPool(_names[_i])
            assert(is_array(_tips) && array_length(_tips)>0 && array_get_index(_tips,scrNTTEFullPetGetTip(_names[_i]))>=0,
                "Source pet authored loading pool missing/localized selector mismatch: "+_names[_i])
        }
        var _hit=-1,_miss=-1
        for(var _n=1;_n<500 && (_hit<0 || _miss<0);++_n) {
            random_set_seed(_n)
            if(random(14)<1) {if(_hit<0) _hit=_n}
            else if(_miss<0) _miss=_n
        }
        assert(_hit>=0 && _miss>=0,"Native RNG fixture could not find both 1/14 presentation branches")
        var _pet=scrNTTEFullPetCreate(_p.x,_p.y,"CoolGuy")
        scrNTTEFullPetSetSkin(_pet,"peas");assert(scrNTTEFullPetTake(_pet,_p),"Actual Peas adoption failed")
        _p.wep=wep_revolver;_p.bwep=wep_none;GameCont.hard=0
        _gen.ntte_loading_tips_setup=false;_gen.tip="native tip"
        random_set_seed(_hit);var _expected=random(100000);random_set_seed(_hit)
        assert(scrNTTEFullLoadingTipsSetup(_gen) && _gen.tip=="STINK BEAN"
            && _gen.tip_ntte=="STINK BEAN" && abs(random(100000)-_expected)<=0.001,
            "Source 1/14 owned-pet loading path lost actual fixed slots/scalar tip/RNG restoration")
        _gen.ntte_loading_tips_setup=false;_gen.tip="native tip";random_set_seed(_miss)
        assert(!scrNTTEFullLoadingTipsSetup(_gen) && _gen.tip=="native tip",
            "Source pet loading tips ignored the 13/14 ordinary native-tip branch")
        assert(scrNTTEFullPetGetName("CoolGuy","peas")=="CoolGuy?"
            && string_pos("@2(",_pet.prompt.text)==1 && string_pos("CoolGuy?",_pet.prompt.text)>0,
            "Actual source skin prompt lost icon markup or Peas question-mark name")
        var _twins=scrNTTEFullPetCreate(_p.x+128,_p.y,"Twins"),_gone=instance_create(99200,99200,Floor)
        assert(scrNTTEFullPetGetName("Twins",0,_twins)=="TWINS","Source default Twins name lost uppercase plurality")
        instance_destroy(_gone,false);_twins.partner=_gone
        assert(scrNTTEFullPetGetName("Twins",0,_twins)=="TWIN","Source surviving Twin name remained plural")
        with(Player) spr_idle=sprMutant1Idle
        assert(scrNTTEFullPetGetName("Cuz")=="Cuz","Source Cuz name added question mark without native Cuz body")
        _p.spr_idle=sprMutant16Idle
        assert(scrNTTEFullPetGetName("Cuz")=="Cuz?","Source Cuz name missed actual active Cuz body")
        UberCont.opt_gamepad=false;UberCont.opt_keyboard=true
        assert(scrNTTEFullLoadingPickTag()=="@1(sprKeySmall:"+string(keymap_get("pick"))+")",
            "Source loading key tag did not resolve actual keyboard pickup mapping")
        UberCont.opt_gamepad=true;UberCont.opt_keyboard=false
        assert(scrNTTEFullLoadingPickTag()=="@1("+sprite_get_name(gamepad_icon_small)+":"+string(keymap_get("pick")-32769)+")",
            "Source loading key tag did not resolve actual native gamepad pickup mapping")
    }
    finally {
        GameCont.skills=_originalSkills
        ds_list_destroy(_tipSkills)
        var _all=scrNTTEFullInstances(all)
        for(var _i=array_length(_all)-1;_i>=0;--_i)
            if(array_get_index(_before,_all[_i])<0 && instance_exists(_all[_i])) instance_destroy(_all[_i],false)
        scrNTTEFullAreaGeneratorRestore(_game);scrNTTEFullAreaGeneratorRestore(_players)
        for(var _i=0;_i<array_length(_petSlots);++_i) if(instance_exists(_petSlots[_i][0])) {
            _petSlots[_i][0].ntte_pet=_petSlots[_i][1];_petSlots[_i][0].ntte_pet_max=_petSlots[_i][2]
        }
        UberCont.opt_gamepad=_gamepad;UberCont.opt_keyboard=_keyboard
        global.ntte_full_progress=_progress;random_set_seed(_seed)
    }
    scrNTTESmokeLog("FULL LOADING TIPS NATIVE: six source Scythe teaching steps+hard gate+stop sentinel/actual native key binding/owned-pet1-in14+all14 authored pools+skin variants/RNG restored/actual pet skin prompt icon+special names OK @"+string(30/timescale))
}
