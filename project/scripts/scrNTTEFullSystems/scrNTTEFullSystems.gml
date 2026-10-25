// NTTE 2.062 native state and system interfaces. Existing native IDs stay intact.
// Original references: skills/*, crowns/*, and ntte.mod.gml.
enum NTTEFullSkill {
    Annihilation=30, BatEars=31, Compassion=32, LeadRibs=33,
    MagneticPulse=34, Reroll=35, SilverTongue=36, ToadBreath=37
}
enum NTTEFullCrown { Bonus=14, Crime=15, Red=16 }

// Runtime entry points are opened after their dependent content has been integrated.
function scrNTTEFullFeatureReady(_key) {
    return variable_global_exists("ntte_full_feature_ready") && is_struct(global.ntte_full_feature_ready) && scrNTTEFullValue(global.ntte_full_feature_ready,_key,false)
}

function scrNTTEFullValue(_target,_key,_default=undefined) {
    if (is_struct(_target)) return variable_struct_exists(_target,_key) ? variable_struct_get(_target,_key):_default
    return instance_exists(_target) && variable_instance_exists(_target,_key) ? variable_instance_get(_target,_key):_default
}

function scrNTTEFullSystemsInit() {
    scrNTTEFullPortalPickupsInit();
    scrNTTEFullPickupDropInit();
    scrNTTEFullLabsHooksInit();
    if (!variable_global_exists("ntte_full_progress")) scrNTTEFullProgressLoad()
    if (!instance_exists(GameCont)) return;
    if (!variable_instance_exists(GameCont,"ntte_full_skills")) GameCont.ntte_full_skills={}
    if (!variable_instance_exists(GameCont,"ntte_full_native_skill_counts")) GameCont.ntte_full_native_skill_counts={}
    if (!variable_instance_exists(GameCont,"ntte_full_skill_order")) GameCont.ntte_full_skill_order=[]
    if (!variable_instance_exists(GameCont,"ntte_pet_max")) GameCont.ntte_pet_max=1
    if (!variable_instance_exists(GameCont,"annihilation_list")) GameCont.annihilation_list=[]
}

// Progress is independent of the original cgot/cskingot arrays and never renumbers them.
function scrNTTEFullProgressPath(_path) {
    // Match the native main-save path, including the desktop harness redirect.
    // filename_path resolves bare names against the runner's default save
    // directory. Inspect the supplied spelling before that resolution instead.
    var _bare=_path!="" && string_pos("/",_path)==0
        && string_pos(chr(92),_path)==0 && string_pos(":",_path)==0
    return _bare ? game_directory+_path:_path
}
function scrNTTEFullProgressStateValid(_state) {
    return is_struct(_state) && scrNTTEFullValue(_state,"schema",0)==1
        && is_struct(scrNTTEFullValue(_state,"unlocks"))
        && is_struct(scrNTTEFullValue(_state,"loadouts"))
        && is_struct(scrNTTEFullValue(_state,"stats"))
}
function scrNTTEFullProgressLoad(_path="ntte-full-progress.json") {
    _path=scrNTTEFullProgressPath(_path)
    global.ntte_full_progress={schema:1,unlocks:{},loadouts:{},stats:{}}
    var _json=scrPersistentJsonLoad(_path,scrNTTEFullProgressStateValid)
    if(is_undefined(_json)) return false
    global.ntte_full_progress=json_parse(_json)
    return true
}

function scrNTTEFullProgressSave(_path="ntte-full-progress.json") {
    _path=scrNTTEFullProgressPath(_path)
    return scrPersistentJsonSave(_path,json_stringify(global.ntte_full_progress),scrNTTEFullProgressStateValid)
}

function scrNTTEFullUnlockGet(_key,_default=false) {
    if (!variable_global_exists("ntte_full_progress")) scrNTTEFullProgressLoad()
    return scrNTTEFullValue(global.ntte_full_progress.unlocks,_key,_default)
}
function scrNTTEFullUnlockSet(_key,_value=true) {
    if (!variable_global_exists("ntte_full_progress")) scrNTTEFullProgressLoad()
    var _achievement_dirty=scrNTTEFullAchievementAward(_key,_value)
    if (scrNTTEFullUnlockGet(_key,undefined)==_value) {
        if(_achievement_dirty) scrNTTEFullProgressSave()
        return false
    }
    variable_struct_set(global.ntte_full_progress.unlocks,_key,_value)
    scrNTTEFullProgressSave()
    // BEGIN NTTE OWNED UNLOCK NOTIFY
    scrNTTEFullUnlockNotify(_key,_value);
    // END NTTE OWNED UNLOCK NOTIFY
    return true
}
function scrNTTEFullLoadoutGet(_key,_default=undefined) {
    if (!variable_global_exists("ntte_full_progress")) scrNTTEFullProgressLoad()
    return scrNTTEFullValue(global.ntte_full_progress.loadouts,_key,_default)
}
function scrNTTEFullLoadoutSet(_key,_value) {
    if (!variable_global_exists("ntte_full_progress")) scrNTTEFullProgressLoad()
    variable_struct_set(global.ntte_full_progress.loadouts,_key,_value)
    scrNTTEFullProgressSave()
}

// Include this struct in the native continue-game save, only for this same run.
function scrNTTEFullSystemsExport() {
    scrNTTEFullSystemsInit()
    return {schema:1,skills:GameCont.ntte_full_skills,native_counts:GameCont.ntte_full_native_skill_counts,
        order:GameCont.ntte_full_skill_order,pet_max:GameCont.ntte_pet_max,
        annihilation:GameCont.annihilation_list,
        reroll:scrNTTEFullValue(GameCont,"ntte_reroll",undefined),
        reroll_hud:scrNTTEFullValue(GameCont,"ntte_reroll_hud",undefined),
        crime_bounty:scrNTTEFullValue(GameCont,"ntte_crime_bounty",0),
        crime_active:scrNTTEFullValue(GameCont,"ntte_crime_active",false),
        crime_count:scrNTTEFullValue(GameCont,"ntte_crime_enemy_count",0),
        crime_delay:scrNTTEFullValue(GameCont,"ntte_crime_enemy_delay",0)}
}
function scrNTTEFullSystemsImport(_state) {
    scrNTTEFullSystemsInit()
    if (!is_struct(_state) || scrNTTEFullValue(_state,"schema",0)!=1) return false
    if (!is_struct(scrNTTEFullValue(_state,"skills")) || !is_array(scrNTTEFullValue(_state,"order"))) return false
    GameCont.ntte_full_skills=_state.skills
    GameCont.ntte_full_native_skill_counts=scrNTTEFullValue(_state,"native_counts",{})
    GameCont.ntte_full_skill_order=_state.order
    GameCont.ntte_pet_max=scrNTTEFullValue(_state,"pet_max",1)
    GameCont.annihilation_list=scrNTTEFullValue(_state,"annihilation",[])
    GameCont.ntte_reroll=scrNTTEFullValue(_state,"reroll",undefined)
    GameCont.ntte_reroll_hud=scrNTTEFullValue(_state,"reroll_hud",undefined)
    GameCont.ntte_crime_bounty=scrNTTEFullValue(_state,"crime_bounty",0)
    GameCont.ntte_crime_active=scrNTTEFullValue(_state,"crime_active",false)
    GameCont.ntte_crime_enemy_count=scrNTTEFullValue(_state,"crime_count",0)
    GameCont.ntte_crime_enemy_delay=scrNTTEFullValue(_state,"crime_delay",0)
    // Native DS list remains acquisition-ordered IDs; stack values live separately.
    for(var _i=ds_list_size(GameCont.skills)-1;_i>=0;--_i)
        if(GameCont.skills[|_i]>=30) ds_list_delete(GameCont.skills,_i)
    for(var _i=0;_i<array_length(GameCont.ntte_full_skill_order);++_i) {
        var _key=GameCont.ntte_full_skill_order[_i],_id=scrNTTEFullSkillId(_key)
        if(_id>=30 && scrNTTEFullSkillGet(_key)!=0) ds_list_add(GameCont.skills,_id)
    }
    // Side effects are restored by the native player save, never replay skill_take here.
    return true
}

function scrNTTEFullSkillKey(_skill) {
    if (is_string(_skill)) return _skill
    switch (_skill) {
        case NTTEFullSkill.Annihilation: return "annihilation"
        case NTTEFullSkill.BatEars: return "bat ears"
        case NTTEFullSkill.Compassion: return "compassion"
        case NTTEFullSkill.LeadRibs: return "lead ribs"
        case NTTEFullSkill.MagneticPulse: return "magnetic pulse"
        case NTTEFullSkill.Reroll: return "reroll"
        case NTTEFullSkill.SilverTongue: return "silver tongue"
        case NTTEFullSkill.ToadBreath: return "toad breath"
    }
    return ""
}
function scrNTTEFullSkillId(_key) {
    for (var _i=30;_i<=37;++_i) if (scrNTTEFullSkillKey(_i)==_key) return _i
    return -1
}
function scrNTTEFullSkillGet(_skill) {
    if (!instance_exists(GameCont)) return 0
    scrNTTEFullSystemsInit()
    var _key=scrNTTEFullSkillKey(_skill)
    if (_key!="") return scrNTTEFullValue(GameCont.ntte_full_skills,_key,0)
    var _count=scrNTTEFullValue(GameCont.ntte_full_native_skill_counts,string(_skill),undefined)
    return is_undefined(_count) ? scr_skill_get(_skill):_count
}
function scrNTTEFullSkillSet(_skill,_num) {
    scrNTTEFullSystemsInit()
    var _key=scrNTTEFullSkillKey(_skill),_last=scrNTTEFullSkillGet(_skill)
    if (_last==_num) return false
    if (_key=="") {
        scr_skill_set(_skill,_num)
        return true
    }
    variable_struct_set(GameCont.ntte_full_skills,_key,_num)
    var _id=scrNTTEFullSkillId(_key),_listpos=ds_list_find_index(GameCont.skills,_id)
    if(_num!=0 && _listpos<0) ds_list_add(GameCont.skills,_id)
    else if(_num==0 && _listpos>=0) ds_list_delete(GameCont.skills,_listpos)
    var _order=GameCont.ntte_full_skill_order,_pos=-1
    for(var _i=0;_i<array_length(_order);++_i) if (_order[_i]==_key) _pos=_i
    if (_num!=0 && _pos<0) array_push(_order,_key)
    else if (_num==0 && _pos>=0) array_delete(_order,_pos,1)
    GameCont.ntte_full_skill_order=_order
    switch (_key) {
        case "compassion":
            GameCont.ntte_pet_max+=_num-_last
            with(Player) if(variable_instance_exists(id,"ntte_pet_max")) ntte_pet_max+=_num-_last
            break
        case "annihilation":
            if (_num==0) GameCont.annihilation_list=[]
            break
        case "reroll": scrNTTEFullRerollTake(_num,_last); break
        case "toad breath":
            if (_num!=0) with(Player) if(scrNTTEFullPlayerActive(id)) {
                var _gas=scrNTTEFullSystemsCreate("ToxicDelay",x,y)
                _gas.team=team; _gas.creator=id; _gas.alarm[0]=1
                snd_play(sndFrogGasRelease,random_range(0.9,1.1))
            }
            break
    }
    if (_num>0 && instance_exists(LevCont)) scrNTTEFullSkillSound(_key)
    return true
}

// An unresolved content object is an integration error, not a silent no-op.
// The factory may be overridden to handle custom initializers/constructors.
function scrNTTEFullSystemsCreate(_name,_x,_y) {
    if(_name=="TopDecal") return scrNTTEFullAreaTopDecalCreate(_x,_y)
    if (variable_global_exists("ntte_full_systems_factory") && is_callable(global.ntte_full_systems_factory))
        return global.ntte_full_systems_factory(_name,_x,_y)
    if(_name=="RedChest") {
        var _chest=instance_create(_x,_y,NTTEFullCustomChest)
        with(_chest) scrNTTEFullRedChestCreate()
        return _chest
    }
    var _obj=asset_get_index("NTTEFull"+_name)
    if (_obj<0) _obj=asset_get_index("NTTE"+_name)
    if (_obj<0) _obj=asset_get_index(_name)
    if (_obj<0) throw "NTTE content not integrated: "+_name
    return instance_create(_x,_y,_obj)
}

function scrNTTEFullPlayerActive(_player) {
    return instance_exists(_player) && _player.visible && !instance_exists(GenCont)
        && !instance_exists(LevCont) && !instance_exists(SitDown)
}

function scrNTTEFullSkillAvailable(_skill,_rat_shop=false) {
    var _key=scrNTTEFullSkillKey(_skill)
    if (_key=="") return is_numeric(_skill) && _skill>=1 && _skill<=29
        && (_skill!=mut_heavy_heart || scr_skill_get(_skill)!=0 || (GameCont.heavyheart>=3 && !GameCont.wantheavy))
    var _num=scrNTTEFullSkillGet(_key)
    if (_rat_shop && (_key=="bat ears" || _key=="lead ribs" || _key=="magnetic pulse" || _key=="toad breath")) return true
    if (_key=="silver tongue") return _num!=0
    if (_key!="compassion") return false
    if (_num!=0) return true
    var _full=false
    with(Player) {
        var _pets=scrNTTEFullValue(id,"ntte_pet",[]),_max=scrNTTEFullValue(id,"ntte_pet_max",array_length(_pets)),_count=0
        for (var _i=0;_i<array_length(_pets);++_i) _count+=instance_exists(_pets[_i])
        if (_max>0 && _count>=_max) _full=true
    }
    return _full
}

function scrNTTEFullSkillSound(_key) {
    var _sound=sndMut,_extra=-1,_pitch=1
    switch (_key) {
        case "bat ears": _sound=sndMutLastWish; _extra=sndMutant3Valt; _pitch=1.5; break
        case "compassion": _extra=sndMutLuckyShot; _pitch=1.2; break
        case "lead ribs": snd_play(sndSewerPipeBreak); snd_play(sndBigMaggotDie); _sound=sndMutPlutoniumHunger; break
        case "magnetic pulse": _sound=sndMutGammaGuts; _extra=sndShielderDeadF; _pitch=0.75; break
        case "silver tongue": _extra=sndFishUltraA; _pitch=1.2; break
        case "toad breath": _sound=sndMutEuphoria; _extra=sndFrogGasRelease; break
        case "reroll": return;
        case "annihilation": return;
    }
    if (_extra>=0) snd_play(_extra,_pitch)
    snd_play(_sound)
}

// Run after all enemy Create initialization, including child team/size overrides.
function scrNTTEFullMagneticPulseSetup(_enemy) {
    var _num=scrNTTEFullSkillGet("magnetic pulse")
    if (_num==0 || !instance_exists(_enemy)) return;
    with(_enemy) {
        if (size<4 && (team==3 || instance_is(id,PopoFreak)) && random(power(2,abs(_num)))>=1) {
            if (_num>0) hp=min(hp,0)
            else { hp*=2; max_hp*=2 }
        }
    }
}

// Call once from enemy death, BEFORE the original raddrop is processed.
function scrNTTEFullLeadRibsDeath(_enemy) {
    var _num=scrNTTEFullSkillGet("lead ribs")
    if (_num==0 || !instance_exists(_enemy)) return;
    with(_enemy) {
        if (scrNTTEFullValue(id,"leadribs_check",false)) return;
        leadribs_check=true
        var _drop=ceil(raddrop*0.2*_num)
        if (_drop<=0) raddrop+=_drop
        else {
            var _rads=scrNTTEFullRadDrop(x,y,_drop,direction,speed/4)
            for(var _i=0;_i<array_length(_rads);++_i) with(_rads[_i])
                sprite_index=scrNTTERefSprite(instance_is(id,BigRad) ? "BigRadUpg":"RadUpg")
        }
    }
}

function scrNTTEFullBatEarsDark(_phase) {
    var _num=scrNTTEFullSkillGet("bat ears")
    if (_num<=0) return;
    if (_phase=="normal") draw_clear(draw_get_color())
    else if (_phase=="end") with(Player)
        draw_circle(x,y,((130*(1+(race==Race.Eyes)))+random(4))*_num,false)
}

function scrNTTEFullToadBreathStep() {
    var _num=scrNTTEFullSkillGet("toad breath")
    if (_num<=0 || !instance_exists(Player)) return;
    with(ToxicGas) if (team==0 || team==-1) {
        var _player=instance_nearest(x,y,Player)
        if(instance_exists(_player)) team=_player.team
    }
    with(Player) if(speed==0 && race!=Race.Robot && scrNTTEFullPlayerActive(id)
        && (wave%30)<timescale && random(2)<1) {
        var _fx=instance_create(x,y-4*(race==Race.Plant),Breath)
        _fx.image_xscale=right; _fx.image_blend=make_color_rgb(108,195,4); _fx.image_alpha=1
    }
}
function scrNTTEFullToadBreathEndStep() {
    var _num=scrNTTEFullSkillGet("toad breath")
    if (_num==0 || !instance_exists(Player) || !instance_exists(ToxicGas)) return;
    with(Player) if(speed!=0 && place_meeting(x,y,ToxicGas)) {
        var _player=id
        with(ToxicGas) if(place_meeting(x,y,_player)) {
            var _factor=1-power(1-min(1,abs(_num)/50),timescale)
            x=lerp(x,_player.x,_factor); y=lerp(y,_player.y,_factor)
            var _cap=max(_player.speed*_num,speed),_angle=_player.direction
            _angle+=angle_difference(point_direction(_player.x,_player.y,x,y),_angle)
                *clamp((point_distance(x,y,_player.x,_player.y)-8)/16,0,1)
            motion_add(_angle,(_player.speed/4)*abs(_num)*timescale)
            if(speed>_cap) speed=_cap
        }
    }
}

function scrNTTEFullRerollTake(_num,_last) {
    if (_num!=0 && _last==0) {
        GameCont.ntte_reroll_hud=undefined
        var _target=scrNTTEFullValue(GameCont,"ntte_reroll",undefined)
        if (is_undefined(_target)) {
            for(var _i=0;_i<ds_list_size(GameCont.skills);++_i) {
                var _candidate=GameCont.skills[|_i]
                if(scrNTTEFullSkillAvailable(_candidate)) _target=_candidate
            }
            GameCont.ntte_reroll=_target
        }
        if (!is_undefined(_target)) {
            variable_struct_set(GameCont.ntte_full_skills,"reroll",_num*scrNTTEFullSkillGet(_target))
            var _health=[]
            with(Player) array_push(_health,[id,hp])
            scrNTTEFullSkillSet(_target,0)
            for(var _i=0;_i<array_length(_health);++_i) {
                var _p=_health[_i][0]
                if(instance_exists(_p) && _p.hp<_health[_i][1]) _p.lasthit=[scrNTTERefSprite("Skill.Reroll.HUD"),"FLOWER'S BLESSING"]
            }
            GameCont.skillpoints++
        }
    }
    else if (_num==0 && !is_undefined(scrNTTEFullValue(GameCont,"ntte_reroll",undefined))) {
        if (_last!=0) { scrNTTEFullSkillSet(GameCont.ntte_reroll,_last); GameCont.skillpoints-- }
        GameCont.ntte_reroll=undefined
    }
}

// Call after a new mutation choice was appended to the run's skill order.
function scrNTTEFullRerollChosen(_chosen) {
    var _num=scrNTTEFullSkillGet("reroll")
    if (_num==0 || _chosen==NTTEFullSkill.Reroll || _chosen=="reroll") return;
    GameCont.ntte_reroll_hud=_chosen; GameCont.ntte_reroll=undefined
    scrNTTEFullSkillSet("reroll",0)
    scrNTTEFullSkillSet(_chosen,scrNTTEFullSkillGet(_chosen)*_num)
}

function scrNTTEFullCrownKey(_crown) {
    if(is_string(_crown)) return _crown
    switch(_crown) {
        case NTTEFullCrown.Bonus:return "bonus"
        case NTTEFullCrown.Crime:return "crime"
        case NTTEFullCrown.Red:return "red"
    }
    return ""
}
function scrNTTEFullCrownAvailable(_crown,_loadout=false) {
    var _key=scrNTTEFullCrownKey(_crown)
    if(_key=="") return false
    if(_loadout) return scrNTTEFullUnlockGet("loadout:crown:"+_key)
    switch(_key) {
        case "bonus":return GameCont.loops>0
        case "crime":return GameCont.loops<=0 && scrNTTEFullUnlockGet("crown:crime")
        case "red":return GameCont.loops>0 && scrNTTEFullUnlockGet("crown:red")
    }
    return false
}
function scrNTTEFullRedCrownFloorMaker(_maker) {
    if(!instance_exists(_maker) || scrNTTEFullCrownKey(GameCont.crown)!="red") return;
    with(_maker) goal=round(goal*0.4)
    if(instance_number(Floor)>_maker.goal && instance_exists(GenCont)) with(GenCont) {
        if(alarm[0]<0) alarm[0]=3
        if(alarm[2]<0) alarm[2]=2
    }
}

// Call once when a newly created eligible pickup/chest/mimic is ready.
// Defer until generation ends; an already opened chest must never be replaced.
function scrNTTEFullBonusCrownSetup(_inst) {
    if(!instance_exists(_inst) || instance_exists(GenCont) || scrNTTEFullCrownKey(GameCont.crown)!="bonus") return false
    if(variable_instance_exists(_inst,"bonus_pickup_check")) return false
    _inst.bonus_pickup_check=true
    if(position_meeting(_inst.xstart,_inst.ystart,ChestOpen)) return false
    var _bonus=0
    with(Player) if(scrNTTEFullValue(id,"bonus_ammo",0)>0) _bonus+=bonus_ammo
    var _near_player=false,_near_portal=false
    with(_inst) { _near_player=place_meeting(x,y,Player); _near_portal=place_meeting(x,y,Portal) }
    if(random(_bonus)<60 || _near_player || _near_portal) {
        var _pickup=instance_is(_inst,AmmoPickup) || instance_is(_inst,HPPickup)
        var _name=_pickup ? "BonusAmmoPickup":(instance_is(_inst,enemy) ? "BonusAmmoMimic":"BonusAmmoChest")
        if(_pickup) scrNTTEFullSystemsCreate(_name,_inst.x,_inst.y)
        else scrNTTEFullLairChestCreate(_inst.x,_inst.y,_name,false)
    }
    instance_destroy(_inst,false)
    return true
}

// Additional Crime crown setup/step and alert methods live in scrNTTEFullCrime.

function scrNTTEFullRadDrop(_x,_y,_count,_direction,_speed) {
    // telib.rad_drop, deliberately separate from the different native death drop.
    var _out=[],_pellets=_count*0.6*scr_ultra_get(Race.Horror,UltraSkill.Stalker)
    if(_pellets>0) with(Player) if(race==Race.Horror) repeat(_pellets)
        scr_projectile_create(_x,_y,HorrorBullet,random(360),6)
    while(_count>0) {
        var _big=_count>15
        _count-= _big ? 10:1
        var _rad=instance_create(_x,_y,_big ? BigRad:Rad)
        with(_rad) {
            motion_add(_direction,_speed)
            motion_add(random(360),(3+random(_count/2))*timescale)
            speed*=power(0.9,speed/max(timescale,0.00001))
        }
        array_push(_out,_rad)
    }
    return _out
}

function scrNTTEFullSkillMetadataInit() {
    var _names=["ANNIHILATION","BAT EARS","COMPASSION","LEAD RIBS","MAGNETIC PULSE","FLOWER'S BLESSING","SILVER TONGUE","TOAD BREATH"]
    var _texts=["DESTROY", "SEE BETTER IN THE @dDARK", "EXTRA @wPET @sSLOT", "MORE @gRADS @sFROM @wENEMIES",
        "CHANCE @bI.D.P.D. @sDIE @wON ENTRY", "REROLL", "FIND @wSMUGGLED GOODS#@sTHE FAMILY CONCEDES", "@gTOXIC GAS @sIS @wBREATHABLE"]
    var _tips=["GOODBYE","ECHOLOCATION IS UNDERRATED","NEW BEST FRIEND","HIGHER THRESHOLD","SHORT CIRCUIT","~","DIPLOMACY","CORROSION"]
    var _sounds=[sndMut,sndMutLastWish,sndMut,sndMutPlutoniumHunger,sndMutGammaGuts,sndMut,sndMut,sndMutEuphoria]
    for(var _i=0;_i<8;++_i) {
        skill_name[30+_i]=_names[_i]; skill_text[30+_i]=_texts[_i]
        skill_tips[30+_i]=_tips[_i]; skill_msnd[30+_i]=_sounds[_i]
    }
    maxskill=37
}
function scrNTTEFullCrownMetadataInit() {
    crown_name[14]="CROWN OF BONUS"
    crown_text[14]="@bBONUS AMMO PICKUPS#@sREPLACE @wAMMO @sAND @wHP DROPS"
    crown_tips[14]="ALL EXTRA"; crown_sond[14]=sndCrownProtection
    crown_name[15]="CROWN OF CRIME"
    crown_text[15]="FIND @wSMUGGLED GOODS#@sA @rPRICE @sON YOUR HEAD"
    crown_tips[15]=choose("THE @wFAMILY@s DOESN'T FORGIVE","THE @rBAT'S@s EXPERIMENTS","THE @rCAT'S@s RESOURCES")
    crown_sond[15]=sndCrownLove
    crown_name[16]="RED CROWN"
    crown_text[16]="CHAOTIC @rCRYSTAL HEARTS#@sSMALLER @wAREAS"
    crown_tips[16]=choose("FULL OF LIFE","SO CRAMPED"); crown_sond[16]=sndCrownCurses
    crownmax=16
}
function scrNTTEFullSkillIcon(_skill,_button=false) {
    var _keys=["Annihilation","BatEars","Compassion","LeadRibs","MagneticPulse","Reroll","SilverTongue","ToadBreath"]
    var _id=is_string(_skill) ? scrNTTEFullSkillId(_skill):_skill
    if(_id<30 || _id>37) return [-1,-1]
    var _icon=(_button && (_id==32 || _id==36)) ? "Icon":"HUD"
    return [scrNTTERefSprite("Skill."+_keys[_id-30]+"."+_icon),0]
}
function scrNTTEFullDrawSkillHUD(_skill,_x,_y) {
    var _icon=_skill>=30 ? scrNTTEFullSkillIcon(_skill):[sprSkillIconHUD,_skill]
    scrNTTEFullOrchidHUD(_skill,_icon[0],_icon[1],_x,_y)
}
function scrNTTEFullCrownSprite(_crown,_kind="Icon") {
    var _key=scrNTTEFullCrownKey(_crown)
    switch(_key) {
        case "bonus":return scrNTTERefSprite("Crown.Bonus."+_kind)
        case "crime":return scrNTTERefSprite("Crown.Crime."+_kind)
        case "red":return scrNTTERefSprite("Crown.Red."+_kind)
    }
    return -1
}
