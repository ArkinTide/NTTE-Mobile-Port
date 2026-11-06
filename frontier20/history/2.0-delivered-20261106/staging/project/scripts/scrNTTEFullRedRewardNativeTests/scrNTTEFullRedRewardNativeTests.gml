function scrNTTEFullRedRewardNativeTests() {
    var _before=scrNTTEFullInstances(all),_players=scrNTTEFullAreaGeneratorSnapshot(Player),
        _game=scrNTTEFullAreaGeneratorSnapshot(GameCont),_back=scrNTTEFullAreaGeneratorSnapshot(BackCont),
        _frame=current_frame,_seed=random_get_seed(),_skills=ds_list_create()
    GameCont.skills=_skills;GameCont.ntte_full_native_skill_counts={};GameCont.crown=0;current_frame=2
    try {
        var _p=instance_find(Player,0),_shock=instance_create(58000,58000,PortalShock)
        _p.x=58000;_p.y=58000;_p.bonus_spirit=[];_p.wep=wep_revolver;_p.bwep=wep_none
        var _chest=instance_create(58032,58000,NTTEFullSpiritChest)
        assert(_chest.num==2 && _chest.snd_open==sndWeaponChest,"SpiritChest lost source quantity2 or WeaponChest sound")
        with(_chest) scrNTTEFullSpiritHaloStep()
        assert(abs(_chest.img_halo-0.4*timescale)<=0.00001,
            "SpiritChest halo inherited static native chest image_speed instead of source0.4 animation")
        with(_chest) scrNTTEFullCustomChestOpen(_p)
        assert(!instance_exists(_chest) && array_length(_p.bonus_spirit)==2,
            "Actual SpiritChest native opening failed two bonus-spirit tokens")
        // Tokens must participate in the actual existing Player rescue system.
        _p.hp=0;_p.spirit=false;_p.visible=true
        with(_p) scrNTTEFullBonusSpiritStep()
        assert(_p.hp==1 && !_p.bonus_spirit[1].active,
            "Collected SpiritChest token did not rescue actual Player through bonus-spirit lifecycle")
        _chest=instance_create(58064,58000,NTTEFullSpiritChest)
        var _count=instance_number(NTTEFullSpiritPickup)
        with(_chest) scrNTTEFullCustomChestOpen(_shock)
        assert(instance_number(NTTEFullSpiritPickup)==_count+2,
            "Portal-opened SpiritChest granted every player instead of releasing two actual pickups")
        var _items=scrNTTEFullInstances(NTTEFullSpiritPickup),_item=_items[array_length(_items)-1],_pull=true
        with(_item) _pull=scrNTTEFullSpiritPickupPull(_p)
        assert(!_pull && _item.num==1 && _item.pull_delay==30 && _item.pull_spd==4,
            "SpiritPickup source thirty-tick attraction delay or default quantity/strength lost")
        repeat(ceil(30/timescale)) with(_item) scrNTTEFullSpiritPickupStep()
        with(_item) _pull=scrNTTEFullSpiritPickupPull(_p)
        assert(_pull,"SpiritPickup never became attractable after source thirty logical ticks")
        var _hpItems=instance_number(HPPickup),_spirits=instance_number(StrongSpiritRefill)
        _item.num=2
        with(_item) scrNTTEFullSpiritPickupFade()
        assert(instance_number(HPPickup)==_hpItems+1 && instance_number(StrongSpiritRefill)==_spirits+2,
            "SpiritPickup fading omitted two dead spirit FX and actual pity HP pickup")
        var _hammer=_p.hammerhead
        _chest=instance_create(58100,58000,NTTEFullHammerHeadChest)
        with(_chest) scrNTTEFullCustomChestOpen(_p)
        assert(_p.hammerhead==_hammer+20,"Actual HammerHeadChest opening did not grant twenty native tiles")
        _chest=instance_create(58132,58000,NTTEFullHammerHeadChest);_chest.num=25
        _count=instance_number(NTTEFullHammerHeadPickup)
        with(_chest) scrNTTEFullCustomChestOpen(_shock)
        assert(instance_number(NTTEFullHammerHeadPickup)==_count+3,
            "Portal-opened HammerHeadChest lost original ceil(num/10) actual pickups")
        _items=scrNTTEFullInstances(NTTEFullHammerHeadPickup);_item=_items[array_length(_items)-1]
        _hammer=_p.hammerhead
        with(_item) scrNTTEFullCustomPickupOpen(_p)
        assert(_p.hammerhead==_hammer+10,"Actual HammerHeadPickup native collection lost ten-tile grant")
        _p.ntte_red_ammo=3;_p.ntte_red_amax=4;_p.ntte_red_amax_muscle=0
        _chest=instance_create(58164,58000,NTTEFullRedAmmoChest);_chest.num=9
        with(_chest) scrNTTEFullCustomChestOpen(_p)
        assert(_p.ntte_red_ammo==4,"RedAmmoChest failed original capacity clamp4")
        GameCont.ntte_full_native_skill_counts[$ string(mut_back_muscle)]=2;ds_list_add(_skills,mut_back_muscle)
        with(_p) scrNTTEFullRedAmmoState()
        assert(_p.ntte_red_amax==12 && _p.ntte_red_ammo==4,
            "Red ammo source cap4+4*BackMuscle changed current ammo or ignored stacked levels")
        _p.ntte_red_amax+=2
        with(_p) scrNTTEFullRedAmmoState()
        assert(_p.ntte_red_amax==14,"Red ammo unchanged Back Muscle erased independently modified capacity")
        GameCont.ntte_full_native_skill_counts[$ string(mut_back_muscle)]=1
        with(_p) scrNTTEFullRedAmmoState()
        assert(_p.ntte_red_amax==10,"Red ammo muscle change failed original differential adjustment")
        _chest=instance_create(58196,58000,NTTEFullRedAmmoChest);_chest.num=3
        _count=instance_number(NTTEFullRedAmmoPickup)
        with(_chest) scrNTTEFullCustomChestOpen(_shock)
        assert(instance_number(NTTEFullRedAmmoPickup)==_count+1,"Portal-opened RedAmmoChest failed actual retained-quantity pickup")
        _items=scrNTTEFullInstances(NTTEFullRedAmmoPickup);_item=_items[array_length(_items)-1]
        with(_item) _pull=scrNTTEFullRedAmmoPickupPull(_p)
        assert(!_pull,"Red ammo attracted to a Player with no red-using weapon")
        _p.bwep=wep_ntte_entangler
        with(_item) _pull=scrNTTEFullRedAmmoPickupPull(_p)
        assert(_pull && _item.num==3,"Red ammo attraction ignored secondary red weapon or source quantity")
        with(_item) scrNTTEFullCustomPickupOpen(_p)
        assert(_p.ntte_red_ammo==7,"Actual RedAmmoPickup contact failed separate red resource grant")
        // Live Orchid chest produces the existing timed mutation ball, not a
        // generic mutation counter or substitute ammo reward.
        _chest=instance_create(58228,58000,NTTEFullOrchidChest);_chest.num=3
        _count=instance_number(NTTEFullOrchidBall)
        with(_chest) scrNTTEFullCustomChestOpen(_p)
        assert(instance_number(NTTEFullOrchidBall)==_count+1,"OrchidChest failed actual OrchidBall creation")
        _items=scrNTTEFullInstances(NTTEFullOrchidBall);_item=_items[array_length(_items)-1]
        assert(_item.target==_p && _item.num==3 && _item.direction>=45 && _item.direction<=135,
            "OrchidChest timed mutation ball lost opener target/quantity/source heading")
        _chest=instance_create(58260,58000,NTTEFullOrchidChest);_chest.alive=false
        _count=instance_number(NTTEFullBonePickup)
        with(_chest) scrNTTEFullCustomChestOpen(_p)
        assert(instance_number(NTTEFullBonePickup)==_count+5,
            "Dead OrchidChest did not release five real collectible scythe bones")
        var _red=scrNTTEFullSystemsCreate("RedChest",58292,58000),_redX=_red.x,_redY=_red.y,
            _oldOrbs=scrNTTEFullInstances(NTTEFullOrchidBall),_opens=instance_number(ChestOpen)
        assert(_red.sprite_index==scrNTTERefSprite("RedChest") && _red.spr_dead==scrNTTERefSprite("RedChestOpen")
            && _red.spr_shadow==shd16 && _red.spr_shadow_y==4 && _red.num==2,
            "CrystalHeart RedChest dispatcher omitted the authored chest constructor")
        with(_red) scrNTTEFullCustomChestOpen(_p)
        var _redOrbs=0
        with(NTTEFullOrchidBall) if(array_get_index(_oldOrbs,id)<0) {
            _redOrbs++
            assert(type=="red" && time==2 && target==_p && x==_redX && y==_redY,
                "RedChest opening lost source red buff/two-area duration/player target")
        }
        assert(!instance_exists(_red) && _redOrbs==1 && instance_number(ChestOpen)==_opens+1,
            "RedChest actual opening did not transfer exactly one red ball and opened shell")
    }
    finally {
        var _all=scrNTTEFullInstances(all)
        for(var _i=array_length(_all)-1;_i>=0;--_i) if(array_get_index(_before,_all[_i])<0 && instance_exists(_all[_i])) instance_destroy(_all[_i],false)
        scrNTTEFullAreaGeneratorRestore(_players);scrNTTEFullAreaGeneratorRestore(_game);scrNTTEFullAreaGeneratorRestore(_back)
        current_frame=_frame;random_set_seed(_seed);ds_list_destroy(_skills)
    }
    scrNTTESmokeLog("FULL RED REWARDS NATIVE: actual Spirit chest2/tokens/Player rescue/portal pickups/delay/pity HP, HammerHead20+pickup10/ceil portal quantity, RedAmmo cap4+stacked Back Muscle differential/clamp/secondary attraction/contact, Orchid actual mutation ball and dead five bones OK @"+string(30/timescale))
}
