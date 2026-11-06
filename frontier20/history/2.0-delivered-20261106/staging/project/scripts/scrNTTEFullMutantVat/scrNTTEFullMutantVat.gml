// telabs1154..1504; teevents2168..2250. No unsupported vat contents are replaced.
function scrNTTEFullVaultDebrisCreate() {
    sprite_index=scrNTTERefSprite("BuriedVaultChestDebris"); image_speed=0.4*choose(-1,1)*timescale; depth=-8; snd_land=-1
    friction=0.15*timescale*timescale; direction=random(360); speed=random_range(1,2)*timescale
    z=0; zspeed=10; zfriction=1; rotspeed=orandom(30); bounce=0; land=false
}
function scrNTTEFullVaultDebrisStep() {
    if (lockstep_stop) return;
    z+=zspeed*timescale; zspeed-=zfriction*timescale
    if (zspeed>0) { image_angle+=rotspeed*timescale; image_angle=(image_angle+360)%360 }
    else image_angle-=image_angle*0.2*timescale
    if (z<=8) {
        var _land=false
        if (position_meeting(x,y+8,Wall) || place_meeting(x,y+8,TopSmall)) { z=8; depth=-7; _land=true }
        else if (z<=0) {
            z=0; depth=0; _land=true
            if (position_meeting(x,y-8,Wall)) { y+=timescale; depth=-1 }
            if (position_meeting(x+hspeed,y+8+vspeed,Wall)) {
                if (position_meeting(x+hspeed,y+8,Wall)) hspeed=0
                if (position_meeting(x,y+8+vspeed,Wall)) vspeed=0
            }
        }
        if (_land) {
            if (abs(zspeed)>zfriction) {
                snd_play(snd_land,0.9+random(0.2),0.5)
                repeat(3) with (instance_create(x,y-z,Dust)) { speed=2*timescale; depth=other.depth }
            }
            if (bounce-->0) zspeed*=-2/3
            else { image_index=0; image_angle=0; zspeed=0 }
        }
    }
    else { depth=-9; speed+=friction }
}
function scrNTTEFullVaultDebrisDraw() {
    image_alpha=abs(image_alpha)
    draw_sprite_ext(sprite_index,image_index,x,y-z,image_xscale,image_yscale,image_angle,image_blend,image_alpha)
    image_alpha*=-1
}
function scrNTTEFullMutantVatCreate() {
    spr_idle=scrNTTERefSprite("MutantVatIdle"); spr_hurt=scrNTTERefSprite("MutantVatHurt"); spr_dead=scrNTTERefSprite("MutantVatDead")
    spr_back=scrNTTERefSprite("MutantVatBack"); spr_dude=mskNone; sprite_index=spr_idle; depth=-1
    color=make_color_rgb(40,87,9); face=choose(-1,1); mask_index=-1; max_hp=50; size=3
    wave=random(100); setup=true; wep=wep_none; pet_data=["","","",{}]; ntte_vat_timer1=-1; ntte_vat_timer2=-1
    var _pool=[[Freak,3],["FishFreak",2],["Angler",3],["PortalGuardian",3],[PopoFreak,2],["CrystalHeart",1],[Bandit,1],[WeaponChest,1],["Backpack",1]]
    if (scrNTTEFullUnlockGet("crown:crime")) array_push(_pool,[choose("CatChest","BatChest"),1])
    var _total=0
    for(var _i=0;_i<array_length(_pool);++_i) _total+=_pool[_i][1]
    var _roll=random(_total)
    for(var _i=0;_i<array_length(_pool);++_i) { _roll-=_pool[_i][1]; if (_roll<0) { type=_pool[_i][0]; break } }
}
function scrNTTEFullMutantVatAfterCreate() {
    spr_shadow=shd64B; spr_shadow_y=12; snd_hurt=sndLabsTubeBreak; snd_dead=sndLabsMutantTubeBreak; team=team_enemy; raddrop=4
    alarm[1]=-1; alarm[2]=-1
}
function scrNTTEFullMutantVatSetup() {
    setup=false; var _watch=false
    switch(type) {
        case "MergedWep":
            if (!variable_global_exists("ntte_full_merged_weapon_decide") || !is_callable(global.ntte_full_merged_weapon_decide)) throw "MutantVat requires original merged weapon decision provider"
            wep=global.ntte_full_merged_weapon_decide(0,max(1,GameCont.hard-1)); spr_dude=scr_weapon_get_sprite(wep); break
        case Freak:spr_dude=sprFreak1Idle; _watch=true; break
        case "FishFreak":spr_dude=scrNTTERefSprite("FishFreakIdle"); _watch=true; break
        case "Angler":spr_dude=sprRadChest; break
        case "PortalGuardian":spr_dude=scrNTTERefSprite("PortalGuardianIdle"); _watch=true; break
        case PopoFreak:spr_dude=sprPopoFreakIdle; _watch=true; break
        case "CrystalHeart":spr_dude=scrNTTERefSprite("CrystalHeartIdle"); break
        case Bandit:spr_dude=sprBanditHurt; break
        case WeaponChest:spr_dude=sprWeaponChest; break
        case "Backpack":case "CatChest":case "BatChest":spr_dude=scrNTTERefSprite(type); break
        case "Pet":_watch=true; break
        default:throw "Unknown original MutantVat content: "+string(type)
    }
    if (_watch) ntte_vat_timer2=90
}
function scrNTTEFullMutantVatSelfDestruct() {
    ntte_vat_timer1=10+random(10)
    scr_projectile_hit(id,10)
    scrNTTEFullTrenchShake(x,y,10)
    with (instance_create(x+orandom(15),y+orandom(20),NTTEFullSmokeOLD)) {
        sprite_index=sprExploderExplo; image_index=1; depth=other.depth-1
        repeat(2+irandom(2)) instance_create(x+orandom(6),y+orandom(6),Smoke)
    }
}
function scrNTTEFullMutantVatWatch() {
    ntte_vat_timer2=30+random(60)
    var _distance=infinity,_target=noone
    with (Player) {
        var _d=point_distance(x,y,other.x,other.y)
        if (_d<_distance && !collision_line(x,y,other.x,other.y,Wall,false,false)) { _distance=_d; _target=id }
    }
    if (instance_exists(_target)) { var _face=sign(_target.x-x); if (_face!=0) face=_face }
}
function scrNTTEFullMutantVatStep() {
    if (lockstep_stop) return;
    if (hp<=0) { instance_destroy(); return }
    if (setup) scrNTTEFullMutantVatSetup()
    if (ntte_vat_timer1>0) { ntte_vat_timer1-=timescale; if (ntte_vat_timer1<=0) { ntte_vat_timer1=-1; scrNTTEFullMutantVatSelfDestruct() } }
    if (ntte_vat_timer2>0) { ntte_vat_timer2-=timescale; if (ntte_vat_timer2<=0) { ntte_vat_timer2=-1; scrNTTEFullMutantVatWatch() } }
    wave+=timescale; x=xstart; y=ystart
    if (sprite_index==spr_hurt && image_index+image_speed>=image_number) sprite_index=spr_idle
}
function scrNTTEFullMutantVatDraw() {
    // Source image_speed is logical; native runner stores animation per frame.
    var _img=wave*image_speed/max(timescale,0.000001)
    draw_sprite_ext(spr_back,_img,x,y,image_xscale,image_yscale,image_angle,image_blend,image_alpha)
    var _chance=random(30)<1,_dir=random(360),_x=x+_chance*lengthdir_x(2,_dir)+sin(wave/10)*2,_y=y+_chance*lengthdir_y(2,_dir)+cos(wave/10)*3
    var _fog=gpu_get_fog()
    gpu_set_fog(true,color,0,0)
    draw_sprite_ext(spr_dude,_img,_x,_y,abs(image_xscale)*face,image_yscale,image_angle+sin(wave/30)*30,c_white,image_alpha)
    gpu_set_fog(_fog)
    draw_self()
}
function scrNTTEFullMutantVatDeath() {
    if (hp>0) return;
    repeat(24) with (instance_create(x,y,Shell)) {
        sprite_index=scrNTTERefSprite("MutantVatGlass"); image_index=irandom(image_number-1); image_speed=0
        motion_set(random(360),random_range(2,6)*timescale); x+=hspeed; y+=vspeed
    }
    with (instance_create(x,y,NTTEFullBuriedVaultChestDebris)) {
        sprite_index=scrNTTERefSprite("MutantVatLid"); mask_index=mskExploder; zfriction/=2; zspeed*=2/3; bounce=irandom_range(1,2); snd_land=sndTechnomancerHurt
    }
    repeat(12) with (instance_create(x+orandom(20),y-irandom(25),AcidStreak)) { image_angle=270; image_index=random(2) }
    repeat(24) {
        var _c=random(1),_l=48*_c,_d=random(360)
        with (instance_create(x+lengthdir_x(_l,_d),y+16+lengthdir_y(_l,_d),NTTEFullSmokeOLD)) { sprite_index=sprExploderExplo; image_index=2+3*(1-_c); motion_set(_d,2*timescale) }
    }
    switch(type) {
        case Bandit:case Freak:case PopoFreak:instance_create(x,y,type); break
        case "PortalGuardian":scrNTTEFullWorldCreateRequired(type,x,y); break
        case WeaponChest:case "OrchidChest":case "Backpack":case "CatChest":case "BatChest":scrNTTEFullLairChestCreate(x,y,type); break
        case "MergedWep":scrWeaponPickupCreate(x,y,wep); break
        case "FishFreak":
            // Fish Freak is a real native Freak hook, never a visual-only copy.
            if (!variable_global_exists("ntte_full_fish_freak_create") || !is_callable(global.ntte_full_fish_freak_create)) throw "MutantVat requires source FishFreak native hook"
            global.ntte_full_fish_freak_create(x,y); break
        case "Angler":with (scrNTTEFullWorldCreateRequired(type,x,y)) event_perform(ev_step,ev_step_normal); break
        case "CrystalHeart":with (scrNTTEFullWorldCreateRequired(type,x,y-16)) { hp=0; event_perform(ev_destroy,0) }; break
        case "Pet":
            if (pet_data[1]!="mod" || pet_data[2]!="petlib") throw "MutantVat pet mod provider not available: "+string(pet_data)
            var _pet=scrNTTEFullPetCreate(x,y,pet_data[0]),_fields=variable_struct_get_names(pet_data[3])
            for(var _i=0;_i<array_length(_fields);++_i) variable_instance_set(_pet,_fields[_i],variable_struct_get(pet_data[3],_fields[_i]))
            scrNTTEFullPetSetSkin(_pet,_pet.bskin); _pet.history=[]
            break
    }
}
function scrNTTEFullMutantVatsEvent(_spawn_floor=Floor) {
    scrNTTEFullFloorSetAlign(32,32)
    var _room=scrNTTEFullFloorRoom(spawn_x,spawn_y,128,_spawn_floor,6,5,"",0,0,true)
    if (is_struct(_room)) {
        var _cx=_room.x,_cy=_room.y
        var _sides=[instance_create(_cx-64,_cy-24,NTTEFullMutantVat),instance_create(_cx+64,_cy-24,NTTEFullMutantVat)]
        _sides=array_shuffle(_sides)
        var _vats=array_concat([instance_create(_cx,_cy-40,NTTEFullMutantVat)],_sides)
        for(var _i=0;_i<array_length(_vats);++_i) with (_vats[_i]) {
            var _dir=point_direction(x,y,_cx,_cy+random_range(64,128))
            with (instance_create(x+lengthdir_x(32,_dir),y+lengthdir_y(32,_dir),Terminal)) {
                depth=other.depth-1
                with (instance_create(x+lengthdir_x(16,_dir),y+lengthdir_y(24,_dir),Necromancer)) { alarm[1]=600+random(150); scrNTTEFullWorldLook(_dir+180) }
            }
        }
        if (variable_instance_exists(GameCont,"ntte_pet_history")) {
            for(var _i=min(3,array_length(GameCont.ntte_pet_history))-1;_i>=0;--_i) if (random(1)<1-_i/3) with (_vats[_i]) {
                type="Pet"; pet_data=GameCont.ntte_pet_history[_i]
                spr_dude=scrNTTEFullPetGetSprite(pet_data[0],pet_data[1],pet_data[2],scrNTTEFullValue(pet_data[3],"bskin",0),"idle")
                array_delete(GameCont.ntte_pet_history,_i,1)
            }
        }
        scrNTTEFullFloorSetStyle(1); scrNTTEFullFloorFill(_cx,_cy,6,5,"ring")
    }
    scrNTTEFullFloorResetAlign(); scrNTTEFullFloorResetStyle()
    return is_struct(_room)
}
function scrNTTEFullMutantVatSmoke() {
    var _before=scrNTTEFullInstances(all)
    var _vat=instance_create(55000,55000,NTTEFullMutantVat)
    _vat.type=Freak
    with (_vat) scrNTTEFullMutantVatSetup()
    assert(_vat.hp==50 && _vat.raddrop==4 && _vat.spr_shadow==shd64B && _vat.spr_shadow_y==12 && _vat.team==team_enemy && _vat.spr_dude==sprFreak1Idle && _vat.ntte_vat_timer2==90,"MutantVat original stats/preview/watching changed")
    var _freaks=instance_number(Freak),_glass=instance_number(Shell),_lids=instance_number(NTTEFullBuriedVaultChestDebris)
    _vat.hp=0
    instance_destroy(_vat)
    assert(instance_number(Freak)==_freaks+1 && instance_number(Shell)==_glass+24 && instance_number(NTTEFullBuriedVaultChestDebris)==_lids+1,"MutantVat death omitted real occupant/24glass/ballistic lid")
    var _lid=instance_find(NTTEFullBuriedVaultChestDebris,_lids)
    assert(_lid.sprite_index==scrNTTERefSprite("MutantVatLid") && _lid.zfriction==0.5 && _lid.zspeed==10*2/3 && _lid.bounce>=1 && _lid.bounce<=2,"MutantVat lid source z/bounce/art changed")
    var _all=scrNTTEFullInstances(all)
    for(var _i=0;_i<array_length(_all);++_i) if (array_get_index(_before,_all[_i])<0) instance_destroy(_all[_i],false)
    scrNTTESmokeLog("FULL WORLD MUTANT VAT 50HP/FOUR RADS/FREAK PREVIEW+WATCH/REAL RELEASE/24GLASS/BALLISTIC LID OK; CRYSTALHEART/FISHFREAK/MERGED PATHS STRICTLY REQUIRE ORIGINAL PROVIDERS")
}
function scrNTTEFullMutantVatsEventSmoke() {
    var _before=scrNTTEFullInstances(all),_area=GameCont.area,_oldhistory=scrNTTEFullValue(GameCont,"ntte_pet_history",[])
    GameCont.area=area_labs
    GameCont.ntte_pet_history=[["Parrot","mod","petlib",{bskin:1,team:team_none,stat_found:false}]]
    scrNTTEFullFloorResetAlign(); scrNTTEFullFloorResetStyle(); var _fixture=scrNTTEFullFloorFill(57016,57016,9,5)
    var _event=instance_create(57016,57016,NTTEFullWorldEvent),_done=false
    _event.spawn_x=57016; _event.spawn_y=57016
    var _vats=instance_number(NTTEFullMutantVat),_terminals=instance_number(Terminal),_necros=instance_number(Necromancer)
    with (_event) _done=scrNTTEFullMutantVatsEvent(_fixture)
    assert(_done && instance_number(NTTEFullMutantVat)==_vats+3 && instance_number(Terminal)==_terminals+3 && instance_number(Necromancer)==_necros+3,"MutantVats event omitted source6x5 room/three vats/three terminals/three necromancers")
    assert(array_length(GameCont.ntte_pet_history)==0,"MutantVats guaranteed first source history entry was not consumed")
    var _petvat=noone
    with (NTTEFullMutantVat) if (array_get_index(_before,id)<0 && type=="Pet") _petvat=id
    assert(instance_exists(_petvat) && _petvat.spr_dude==scrNTTERefSprite("PetParrotBIdle"),"MutantVats source pure pet preview/skin mapping changed")
    var _pets=instance_number(NTTEFullPet)
    _petvat.hp=0; instance_destroy(_petvat)
    assert(instance_number(NTTEFullPet)==_pets+1,"MutantVat failed original history pet reconstruction")
    var _pet=instance_find(NTTEFullPet,_pets)
    assert(_pet.pet=="Parrot" && _pet.bskin==1 && _pet.team==team_none && !_pet.stat_found && array_length(_pet.history)==0,"MutantVat omitted source pet values/skin/history clear")
    var _all=scrNTTEFullInstances(all)
    for(var _i=0;_i<array_length(_all);++_i) if (array_get_index(_before,_all[_i])<0) instance_destroy(_all[_i],false)
    GameCont.area=_area; GameCont.ntte_pet_history=_oldhistory
    scrNTTEFullFloorResetAlign(); scrNTTEFullFloorResetStyle()
    scrNTTESmokeLog("FULL WORLD MUTANT VATS SOURCE6x5 ROOM/THREE VATS+TERMINALS+NECROMANCERS/HISTORY CONSUMPTION/PURE PET SKIN PREVIEW/REAL PET RECONSTRUCTION+HISTORY CLEAR OK")
}
