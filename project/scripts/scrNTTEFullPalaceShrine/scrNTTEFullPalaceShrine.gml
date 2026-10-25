// tepickups4321..4500 and teevents2307..2530. Uses real shared Prompt,
// OrchidDecide and OrchidBall; this prop never substitutes a direct skill grant.
function scrNTTEFullGroundFlameGreenCreate() {
    var _big=random(3)<1
    sprite_index=scrNTTERefSprite(_big ? "GroundFlameGreenBig":"GroundFlameGreen")
    spr_dead=scrNTTERefSprite(_big ? "GroundFlameGreenBigDisappear":"GroundFlameGreenDisappear")
}
function scrNTTEFullGroundFlameGreenEndStep() {
    if (lockstep_stop) return;
    if (sprite_index==sprGroundFlameDisappear || sprite_index==sprGroundFlameBigDisappear) sprite_index=spr_dead
    if (sprite_index==spr_dead && image_index+image_speed>=image_number) instance_destroy()
}
function scrNTTEFullPalaceAltarCreate() {
    spr_idle=scrNTTERefSprite("PalaceAltarIdle"); spr_hurt=scrNTTERefSprite("PalaceAltarHurt"); spr_dead=scrNTTERefSprite("PalaceAltarDead")
    sprite_index=spr_idle; max_hp=80; size=3
    skill=scrNTTEFullOrchidDecide(); effect_color=make_color_rgb(72,253,8); direction=90+orandom(45)
    ntte_altar_break_left=-1
}
function scrNTTEFullPalaceAltarAfterCreate() {
    snd_hurt=sndHitRock; snd_dead=sndGeneratorBreak; raddrop=6; team=team_enemy
    prompt=scrNTTEFullPromptCreate(id,"  CHOOSE",mskReviveArea,-8,-16)
    prompt.on_meet=method(prompt,scrNTTEFullVaultFlowerPromptMeet)
}
function scrNTTEFullPalaceAltarStep() {
    if (lockstep_stop) return;
    if (hp<=0) { instance_destroy(); return }
    if (ntte_altar_break_left>0) {
        ntte_altar_break_left-=timescale
        if (ntte_altar_break_left<=0) { ntte_altar_break_left=-1; hp=0; return }
    }
    if (random(3)<2*timescale) {
        var _rad=instance_create(x+orandom(2),y-random(16),RadEat)
        _rad.direction=90; _rad.speed=random(2)*timescale; _rad.sprite_index=choose(sprEatRadPlut,sprEatBigRadPlut)
        _rad.image_speed=0.4*timescale; _rad.depth=-7
    }
    if (sprite_index==spr_hurt && random(3)<timescale) instance_create(x+orandom(16),y+8+orandom(16),PortalL)
    if (instance_exists(prompt) && prompt.pick>=0) {
        var _p=noone,_pick=prompt.pick
        with (Player) if (index==_pick) _p=id
        if (scrNTTEFullPlayerActive(_p)) {
            sprite_index=spr_hurt; image_index=0; snd_play_hit(snd_dead,0.2)
            var _fx=instance_create(x,y,ImpactWrists); _fx.image_blend=effect_color; _fx.depth=-4
            with (NTTEFullPalaceAltar) {
                ntte_altar_break_left=irandom_range(10,20)
                if (id!=other.id) skill=0
                if (instance_exists(prompt)) prompt.visible=false
            }
        }
    }
}
function scrNTTEFullPalaceAltarDeath() {
    if (hp>0) return;
    repeat(10) {
        var _shell=instance_create(x,y,Shell)
        _shell.sprite_index=scrNTTERefSprite("PalaceAltarDebris"); _shell.image_index=irandom(_shell.image_number-1)
        _shell.image_speed=0; _shell.image_angle=random(360); _shell.direction=random(360); _shell.speed=random_range(4,8)*timescale
    }
    if (skill!=0) {
        var _orb=instance_create(x,y,NTTEFullOrchidBall)
        _orb.skill=skill; _orb.type="portal"; _orb.creator=id; _orb.direction=direction; _orb.speed=10*timescale
    }
    with (NTTEFullPalaceAltar) if (id!=other.id && ntte_altar_break_left<0) {
        ntte_altar_break_left=irandom_range(10,20); skill=0
        if (instance_exists(prompt)) prompt.visible=false
    }
    instance_create(x,y,PortalClear)
    repeat(4) instance_create(x+orandom(24),y+8+orandom(24),NTTEFullGroundFlameGreen)
    repeat(15) {
        var _rad=instance_create(x+orandom(16),y+orandom(16),RadEat)
        _rad.direction=90; _rad.speed=random(1)*timescale; _rad.sprite_index=choose(sprEatRadPlut,sprEatBigRadPlut)
        _rad.image_index=random(2); _rad.image_speed=0.4*timescale; _rad.depth=-4
    }
    var _fx=instance_create(x,y-8,RadEat)
    _fx.sprite_index=sprMutant6Dead; _fx.image_speed=0.4*timescale; _fx.image_index=9; _fx.image_blend=effect_color; _fx.depth=-4
    scr_screenshake(50); sleep(50)
    snd_play(sndGunGun,0.6+random(0.2)); snd_play(sndSnowTankDead,0.6+random(0.2)); snd_play(sndEnergyHammerUpg,0.5)
}
function scrNTTEFullPalaceAltarCleanup() { if (instance_exists(prompt)) instance_destroy(prompt,false) }

// Source weapon_shrine overrides. Native numeric IDs encode the source
// wrapper's weapon/mode; finite-ammo bone state still decides its empty form.
function scrNTTEFullPalaceWeaponShrine(_weapon,_state=undefined) {
    if (scrNTTEIsBone(_weapon)) {
        if (is_struct(_state) && _state.ammo<=0) return []
        return _weapon==wep_ntte_bone ? [mut_long_arms]:[mut_long_arms,mut_laser_brain]
    }
    if (scrNTTEIsScythe(_weapon)) return [mut_long_arms,mut_shotgun_shoulders,mut_bolt_marrow]
    if (scrNTTEIsTrident(_weapon) || _weapon==wep_ntte_pizza_cutter) return [mut_long_arms,mut_bolt_marrow]
    if (scrNTTEIsTunnel(_weapon)) return [mut_long_arms,mut_laser_brain]
    switch (_weapon) {
        case wep_ntte_annihilator: return [mut_long_arms,mut_shotgun_shoulders]
        case wep_ntte_sawblade_gun: case wep_ntte_sawblade_cannon: return [mut_bolt_marrow]
    }
    return []
}
function scrNTTEFullPalaceWeaponSkills(_weapon,_state=undefined) {
    switch (_weapon) {
        case wep_none: return [mut_last_wish]
        case wep_incinerator: return [mut_shotgun_shoulders]
        case wep_jackhammer: return [mut_long_arms]
        case wep_lightning_hammer: return [mut_long_arms,mut_laser_brain]
    }
    var _custom=scrNTTEFullPalaceWeaponShrine(_weapon,_state)
    if (array_length(_custom)>0) return _custom
    var _list=[],_type=scr_weapon_get_type(_weapon)
    switch (_type) {
        case Ammo.None: array_push(_list,mut_long_arms); break
        case Ammo.Bullets: array_push(_list,mut_recycle_gland); break
        case Ammo.Shells: array_push(_list,mut_shotgun_shoulders); break
        case Ammo.Bolts: array_push(_list,mut_bolt_marrow); break
        case Ammo.Explosives: array_push(_list,mut_boiling_veins); break
        case Ammo.Energy: array_push(_list,mut_laser_brain); break
    }
    if (scr_weapon_is_melee(_weapon)) array_push(_list,mut_long_arms)
    if (scr_weapon_get_rads(_weapon)>0) array_push(_list,"lead ribs")
    var _name=render_parse_text(scr_weapon_get_name(_weapon)),_plain=""
    for(var _i=0;_i<array_length(_name.lines);++_i) {
        var _parts=_name.lines[_i].strings
        for(var _j=0;_j<array_length(_parts);++_j) if (_parts[_j].type==TextRenderFragment.String) _plain+=_parts[_j].string
    }
    var _split=string_split(string_upper(_plain)," ")
    if (array_get_index(_split,"TOXIC")>=0) array_push(_list,"toad breath")
    if (array_get_index(_split,"BLOOD")>=0) array_push(_list,mut_bloodlust)
    if (array_get_index(_split,"POP")>=0 && _type==Ammo.Bullets) array_push(_list,mut_shotgun_shoulders)
    return _list
}
function scrNTTEFullPalaceShrineSkills() {
    var _list=[],_pool=[],_players=scrNTTEFullInstances([Player,Revive])
    for(var _i=0;_i<array_length(_players);++_i) with (_players[_i]) {
        _list=array_concat(_list,scrNTTEFullPalaceWeaponSkills(wep,scrNTTEFullValue(id,"ntte_state")),
            scrNTTEFullPalaceWeaponSkills(bwep,scrNTTEFullValue(id,"bntte_state")))
    }
    // The source shuffles every registered mod skill before searching for the
    // first weapon-specific available one. Only Toad Breath has wepspec=true;
    // its normal availability is false, which must not force-add a blessing.
    var _modded=array_shuffle(["annihilation","bat ears","compassion","lead ribs","magnetic pulse","reroll","silver tongue","toad breath"])
    for(var _i=0;_i<array_length(_modded);++_i) if (_modded[_i]=="toad breath" && scrNTTEFullSkillAvailable(_modded[_i])) {
        array_push(_list,_modded[_i]); break
    }
    for(var _i=0;_i<array_length(_list);++_i) {
        var _skill=_list[_i],_active=is_string(_skill) ? scrNTTEFullSkillId(_skill)>=30:scr_skill_is_valid(_skill)
        if (_active && scrNTTEFullSkillGet(_skill)==0 && array_get_index(_pool,_skill)<0) array_push(_pool,_skill)
    }
    return _pool
}
function scrNTTEFullPalaceShrineSkillsInit() { global.ntte_full_palace_shrine_skills=scrNTTEFullPalaceShrineSkills }

function scrNTTEFullPalaceShrineCreate() {
    if (!variable_global_exists("ntte_full_palace_shrine_skills") || !is_callable(global.ntte_full_palace_shrine_skills))
        throw "Original PalaceShrine_skills is not integrated"
    var _before=scrNTTEFullInstances(Floor,true),_skills=array_shuffle(global.ntte_full_palace_shrine_skills()),_skill_count=min(array_length(_skills),2+irandom(2))
    var _w=choose(3,4),_h=choose(3,4),_dir_start=random(360)
    scrNTTEFullFloorSetAlign(32,32)
    var _start=scrNTTEFullFloorRoomStart(spawn_x,spawn_y,128,Floor),_main=noone
    if (is_struct(_start)) {
        _main=scrNTTEFullFloorRoomCreate(_start.x,_start.y,_w,_h,"",_dir_start,0,0)
        if (is_struct(_main)) {
            for(var _i=0;_i<_skill_count;++_i) {
                var _size=choose(2,3),_room_dir=_dir_start+orandom(45)
                var _room=scrNTTEFullFloorRoomCreate(_main.x,_main.y,_size,_size,"",_room_dir,0,0)
                if (is_struct(_room)) {
                    var _altar=instance_create(_room.x,_room.y-10,NTTEFullPalaceAltar); _altar.skill=_skills[_i]
                    for(var _j=0;_j<array_length(_room.floors);++_j) with (_room.floors[_j]) {
                        sprite_index=scrNTTERefSprite(_size==3 ? "FloorPalaceShrineRoomLarge":"FloorPalaceShrineRoomSmall")
                        image_index=_j; depth=8
                    }
                }
            }
            repeat(2+irandom(2)) {
                var _size=choose(1,1,1,2),_room=scrNTTEFullFloorRoomCreate(_main.x,_main.y,_size,_size,"",0,360,0)
                if (is_struct(_room) && random(3)<2) instance_create(_room.x,_room.y,Pillar)
            }
            repeat(3) instance_create(_main.x,_main.y,TopDecalPalace)
        }
        with (Floor) if (object_index==Floor && array_get_index(_before,id)<0
            && sprite_index!=scrNTTERefSprite("FloorPalaceShrineRoomSmall") && sprite_index!=scrNTTERefSprite("FloorPalaceShrineRoomLarge")) {
            sprite_index=scrNTTERefSprite("FloorPalaceShrine"); image_index=irandom(image_number-1); depth=8
        }
    }
    scrNTTEFullFloorResetAlign()
    return _main
}
function scrNTTEFullPalaceAltarSmoke() {
    var _snapshot=scrNTTEFullInstances(all),_p=instance_find(Player,0)
    var _a=instance_create(33000,33000,NTTEFullPalaceAltar),_b=instance_create(33048,33000,NTTEFullPalaceAltar)
    assert(_a.hp==80 && _a.raddrop==6 && _a.team==team_enemy && is_callable(_a.prompt.on_meet),"PalaceAltar source80HP/6rads/team/mutation-icon prompt changed")
    _a.skill=mut_laser_brain; _b.skill=mut_long_arms; _a.prompt.pick=_p.index
    with (_a) scrNTTEFullPalaceAltarStep()
    assert(_a.ntte_altar_break_left>=10 && _a.ntte_altar_break_left<=20 && _b.ntte_altar_break_left>=10 && _b.skill==0
        && !_a.prompt.visible && !_b.prompt.visible,"PalaceAltar selection did not disable all altars while retaining only selected skill")
    var _count=instance_number(NTTEFullOrchidBall)
    _a.hp=0; instance_destroy(_a)
    assert(instance_number(NTTEFullOrchidBall)==_count+1,"PalaceAltar did not emit exactly one real temporary-blessing OrchidBall")
    var _orb=instance_find(NTTEFullOrchidBall,instance_number(NTTEFullOrchidBall)-1)
    assert(_orb.skill==mut_laser_brain && _orb.type=="portal" && _orb.speed==10*timescale,"PalaceAltar lost original portal blessing skill/type/speed")
    _b.hp=0; instance_destroy(_b)
    assert(instance_number(NTTEFullOrchidBall)==_count+1,"Disabled PalaceAltar incorrectly granted a second blessing")
    var _new=scrNTTEFullInstances(all)
    for(var _i=0;_i<array_length(_new);++_i) if (array_get_index(_snapshot,_new[_i])<0) instance_destroy(_new[_i],false)
    scrNTTESmokeLog("FULL WORLD PALACE ALTAR SOURCE80HP/6RADS/SHARED MUTATION ICON PROMPT/ONE SELECTION/DISABLE PEERS/REAL PORTAL ORCHID BALL OK; SHRINE SKILL POOL SEPARATE")
}
function scrNTTEFullPalaceShrineSkillsSmoke() {
    var _ann=scrNTTEFullPalaceWeaponSkills(wep_ntte_annihilator),_saw=scrNTTEFullPalaceWeaponSkills(wep_ntte_sawblade_gun)
    assert(array_length(_ann)==2 && _ann[0]==mut_long_arms && _ann[1]==mut_shotgun_shoulders
        && array_length(_saw)==1 && _saw[0]==mut_bolt_marrow,"Shrine source Annihilator/BatDisc overrides changed")
    var _scythe=scrNTTEFullPalaceWeaponSkills(wep_ntte_bone_slugbow),_artifact=scrNTTEFullPalaceWeaponSkills(wep_ntte_guarded_artifact,{ammo:1})
    assert(array_length(_scythe)==3 && _scythe[2]==mut_bolt_marrow && array_length(_artifact)==2
        && _artifact[1]==mut_laser_brain,"Shrine source shared Scythe modes/artifact type overrides changed")
    var _empty=scrNTTEFullPalaceWeaponSkills(wep_ntte_guarded_artifact,{ammo:0})
    assert(array_length(_empty)>=1 && _empty[0]==mut_long_arms && array_get_index(_empty,mut_laser_brain)<0,
        "Empty artifact retained nonempty Laser Brain shrine override")
    var _lightning=scrNTTEFullPalaceWeaponSkills(wep_lightning_hammer)
    assert(array_length(_lightning)==2 && _lightning[0]==mut_long_arms && _lightning[1]==mut_laser_brain,
        "Vanilla Lightning Hammer source special case changed")
    var _saved=[],_players=scrNTTEFullInstances([Player,Revive]),_skills=GameCont.skills,_counts=GameCont.ntte_full_native_skill_counts
    for(var _i=0;_i<array_length(_players);++_i) with (_players[_i]) {
        array_push(_saved,[id,wep,bwep]); wep=wep_ntte_annihilator; bwep=wep_ntte_pizza_cutter
    }
    GameCont.skills=ds_list_create(); GameCont.ntte_full_native_skill_counts={}
    var _pool=scrNTTEFullPalaceShrineSkills()
    assert(array_length(_pool)==3 && array_get_index(_pool,mut_long_arms)>=0
        && array_get_index(_pool,mut_shotgun_shoulders)>=0 && array_get_index(_pool,mut_bolt_marrow)>=0,
        "Shrine loadout pool lost source order/deduplication or force-added unavailable Toad Breath")
    ds_list_add(GameCont.skills,mut_long_arms)
    _pool=scrNTTEFullPalaceShrineSkills()
    assert(array_length(_pool)==2 && array_get_index(_pool,mut_long_arms)<0,"Shrine offered an already-owned mutation")
    ds_list_destroy(GameCont.skills); GameCont.skills=_skills; GameCont.ntte_full_native_skill_counts=_counts
    for(var _i=0;_i<array_length(_saved);++_i) { _saved[_i][0].wep=_saved[_i][1]; _saved[_i][0].bwep=_saved[_i][2] }
    scrNTTESmokeLog("FULL WORLD SHRINE SKILL POOL ORIGINAL LOADOUT/SPECIAL CASES/CUSTOM SHRINE/SCYTHE MODES/FINITE ARTIFACT/DEDUPLICATION/OWNED FILTER/NO UNAVAILABLE WEPSPEC OK")
}
