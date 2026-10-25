// Source petlib.CoolGuy. Native PopupText field is mytext rather than text.
function scrNTTEFullPetCoolGuyCreate() {
    spr_idle=scrNTTERefSprite(bskin=="peas" ? "PetPeasIdle":"PetCoolGuyIdle")
    spr_walk=scrNTTERefSprite(bskin=="peas" ? "PetPeasWalk":"PetCoolGuyWalk")
    spr_hurt=scrNTTERefSprite(bskin=="peas" ? "PetPeasHurt":"PetCoolGuyHurt")
    spr_icon=scrNTTERefSprite(bskin=="peas" ? "PetPeasIcon":"PetCoolGuyIcon")
    spr_shadow=shd16; spr_shadow_y=4; maxspeed=3.5; poop=1; poop_delay=0
    combo=0; combo_text=noone; combo_texty=0; combo_delay=0; kills_last=GameCont.kills
    stat.combo=scrNTTEFullValue(stat,"combo",0)
    hooks={step:method(id,scrNTTEFullPetCoolGuyStep),draw:method(id,scrNTTEFullPetCoolGuyDraw),alarm:method(id,scrNTTEFullPetCoolGuyAlarm),skin:method(id,scrNTTEFullPetCoolGuySkin)}
    array_push(history,"poop","poop_delay","combo","combo_delay","kills_last")
}
function scrNTTEFullPetCoolGuySkin() {
    var _names=["idle","walk","hurt","icon"]
    for(var _i=0;_i<array_length(_names);++_i) {
        var _part=_names[_i]
        scrNTTEFullPetSkinField("spr_"+_part,scrNTTERefSprite((bskin=="peas" ? "PetPeas":"PetCoolGuy")+string_upper(string_char_at(_part,1))+string_delete(_part,1,1)))
    }
}
function scrNTTEFullWaterStreakCreate() {
    sprite_index=scrNTTERefSprite("WaterStreak"); image_speed=(0.4+random(0.2))*timescale; depth=0
    vspeed-=2*timescale; image_angle=direction
}
function scrNTTEFullPetCoolGuyStep() {
    if(instance_exists(leader) && GameCont.kills>kills_last) { combo+=GameCont.kills-kills_last; combo_delay=40 }
    kills_last=GameCont.kills
    if(combo>=2) {
        var _level=max(0,floor(combo/10)),_colors=[c_white,make_color_rgb(255,230,70),make_color_rgb(50,210,255),make_color_rgb(255,110,25),make_color_rgb(255,110,150)]
        var _color=_colors[_level<array_length(_colors) ? _level:floor((wave*(combo/150))%array_length(_colors))]
        var _off=round(min(3,floor(combo/5))),_px=x+hspeed+orandom(_off),_py=y+vspeed+orandom(_off)-8+combo_texty
        if(!instance_exists(combo_text)) combo_text=instance_create(0,0,PopupText)
        combo_text.mytext=(_level>=array_length(_colors) ? "COMBO#":"")+"x"+string(combo)+(combo>stat.combo ? "!":"")
        combo_text.alarm[1]=15; combo_text.alarm[2]=-1
        with(combo_text) event_perform(ev_alarm,2)
        if(_color!=c_white || _level>=array_length(_colors)) combo_text.mytext="@(color:"+string(_color)+")#"+combo_text.mytext
        combo_text.x=_px; combo_text.y=_py-(font_get_string_height(string_hash_to_newline(combo_text.mytext))-8); combo_text.speed=0
        combo_texty=lerp(combo_texty,-8,1-power(0.5,timescale))
    } else { combo_text=noone; combo_texty=0 }
    if(combo_delay>0) combo_delay-=timescale
    else {
        if(combo>0) {
            if(instance_exists(combo_text)) { combo_text.vspeed=-4.5*timescale; combo_text.friction=timescale*timescale/3; combo_text.time+=combo/5 }
            if(combo>=10) {
                snd_play(sndCrownNo,1.4,0.5+combo/50)
                snd_play(combo>=50 ? sndLevelUltra:sndLevelUp,0.8,combo/25)
            }
            if(combo>stat.combo) {
                stat.combo=combo
                if(combo>=10 && instance_exists(combo_text)) combo_text.mytext+="@w#NEW RECORD"
            }
            if(combo>=100) {
                var _frog=false
                with(Player) if(race==Race.Frog) _frog=true
                if(_frog) scrNTTEFullUnlockSet("skin:cool frog",true)
            }
            var _add=floor(combo/5)
            if(_add>0) {
                if(poop<=0) { poop_delay=30; ntte_pet_alarm=poop_delay+10 }
                poop+=_add
            }
        }
        combo=0
    }
    if(!instance_exists(leader) && poop_delay<30) poop_delay=30
    if(poop_delay>0) poop_delay-=timescale
    else if(poop>0) {
        repeat(4) {
            var _fx=instance_create(x+orandom(2),y+1,NTTEFullWaterStreak)
            with(_fx) motion_add(random(360),timescale)
            _fx.hspeed=-2*right*timescale; _fx.image_angle=_fx.direction; _fx.image_blend=make_color_rgb(255,120,25)
            _fx.image_xscale/=2; _fx.image_yscale/=2; _fx.depth=-1
        }
        if(poop>=2) repeat(floor(poop/2)) {
            var _fx=instance_create(x,y,Dust)
            if(instance_exists(_fx)) {
                with(_fx) motion_add(random(360),timescale)
                _fx.sprite_index=sprBreath; _fx.image_index=irandom(4); _fx.image_blend=make_color_rgb(255,105,10)
                _fx.hspeed-=random(2)*right*timescale; _fx.vspeed+=orandom(poop/12)*timescale; _fx.image_angle=_fx.direction+180
                _fx.image_xscale*=2; _fx.image_yscale*=2; _fx.growspeed/=2; _fx.rot/=2
            }
        }
        snd_play(sndHPPickup,0.8+random(0.2),0.8); snd_play(sndFrogExplode,1.2+random(0.8),0.8)
        var _drop=noone,_px=x+orandom(4),_py=y+orandom(4)
        if(random(2)<1 && random(poop)>=4) { _drop=scrNTTEFullSystemsCreate("PizzaChest",_px,_py); poop-=2 }
        else if(poop>=2 && random(3)<1) { _drop=scrNTTEFullSystemsCreate("PizzaStack",_px,_py); poop-=2 }
        else { _drop=scrNTTEFullSystemsCreate("Pizza",_px,_py); poop-- }
        _drop.hspeed=-3*right*timescale; _drop.vspeed=orandom(1)*timescale
        if(instance_is(_drop,prop)) { _drop.x+=_drop.hspeed; _drop.y+=_drop.vspeed }
        if(!instance_is(_drop,HPPickup)) snd_play(sndEnergyHammerUpg,1.4+random(0.2),0.4)
        hspeed+=min(poop+1,4)*right*timescale; poop_delay=8/max(1,poop)
    }
    if(poop<=0 || poop_delay>10) speed=maxspeed*timescale
    if(!array_length(path)) for(var _i=0;_i<array_length(path_wall);++_i) if(place_meeting(x+hspeed,y+vspeed,path_wall[_i])) {
        if(place_meeting(x+hspeed,y,path_wall[_i])) hspeed*=-1
        if(place_meeting(x,y+vspeed,path_wall[_i])) vspeed*=-1
    }
    right=lengthdir_x(1,direction)>=0 ? 1:-1
}
function scrNTTEFullPetCoolGuyDraw(_spr,_img,_x,_y,_xsc,_ysc,_ang,_col,_alp) {
    if(poop>0 && poop_delay<20) _x+=sin(wave*5)*1.5
    draw_sprite_ext(_spr,_img,_x,_y,_xsc,_ysc,_ang,_col,_alp)
}
function scrNTTEFullPetCoolGuyAlarm(_leader_dir,_leader_dis) {
    if(instance_exists(leader)) {
        if(_leader_dis>24) {
            if(!is_undefined(path_dir)) {
                if(random(3)<1) direction=path_dir+orandom(20)
                else direction+=angle_difference(path_dir,direction)/2
            } else direction+=angle_difference(_leader_dir,direction)/2
        } else direction+=orandom(16)
        right=lengthdir_x(1,direction)>=0 ? 1:-1; return 8
    }
    direction+=orandom(16); right=lengthdir_x(1,direction)>=0 ? 1:-1; return 10+random(10)
}
function scrNTTEFullPetCoolGuyTests() {
    var _p=instance_find(Player,0),_old_pets=scrNTTEFullValue(_p,"ntte_pet",[]),_old_kills=GameCont.kills,_old_race=_p.race
    _p.ntte_pet=[]
    var _pet=scrNTTEFullPetCreate(_p.x+48,_p.y,"CoolGuy")
    scrNTTEFullPetTake(_pet,_p); scrNTTEFullPetCoolGuyFxSourceTests(_pet); _pet.poop=0; _pet.poop_delay=60
    GameCont.kills+=10
    with(_pet) scrNTTEFullPetCoolGuyStep()
    assert(_pet.combo==10 && _pet.combo_delay==40-timescale && instance_exists(_pet.combo_text)
        && string_pos("x10",_pet.combo_text.mytext)>0,"CoolGuy actual kills did not start source combo/display")
    _pet.combo_delay=0
    with(_pet) scrNTTEFullPetCoolGuyStep()
    assert(_pet.combo==0 && _pet.poop==2 && _pet.stat.combo>=10,"CoolGuy combo ended without score or five-kill pizza budget")
    var _before=instance_number(NTTEFullPizza)
    _pet.poop=1; _pet.poop_delay=0
    with(_pet) scrNTTEFullPetCoolGuyStep()
    assert(_pet.poop==0 && instance_number(NTTEFullPizza)==_before+1,
        "CoolGuy one budget failed original guaranteed pizza output")
    _p.race=Race.Frog; _pet.combo=100; _pet.combo_delay=0; _pet.poop_delay=60
    with(_pet) scrNTTEFullPetCoolGuyStep()
    assert(scrNTTEFullUnlockGet("skin:cool frog"),"CoolGuy x100 with native Frog failed actual skin unlock")
    if(instance_exists(_pet.combo_text)) instance_destroy(_pet.combo_text,false)
    instance_destroy(_pet); _p.ntte_pet=_old_pets; _p.race=_old_race; GameCont.kills=_old_kills
    scrNTTESmokeLog("SYSTEMS PET COOLGUY: actual kill combo+native popup, score/pizza budget, real guaranteed pizza output and Frog x100 unlock OK")
}
// Literal source oracle for owned, zero-combo, immediate-poop path only.
// Budgets1/2/4 leave repeat(poop/2) integral; no odd-budget rounding claim.
function scrNTTEFullPetCoolGuyFxSourceReference() {
    kills_last=GameCont.kills
    combo_delay-=timescale
    repeat(4) {
        var _fx=instance_create(x+orandom(2),y+1,NTTEFullWaterStreak)
        with(_fx) motion_add(random(360),timescale)
        _fx.hspeed=-2*right*timescale
        _fx.image_angle=_fx.direction
        _fx.image_blend=make_color_rgb(255,120,25)
        _fx.image_xscale/=2;_fx.image_yscale/=2;_fx.depth=-1
    }
    if(poop>=2) repeat(poop/2) {
        var _fx=instance_create(x,y,Dust)
        assert(instance_exists(_fx),"CoolGuy source oracle needs live native Dust")
        with(_fx) motion_add(random(360),timescale)
        _fx.sprite_index=sprBreath
        _fx.image_index=irandom(4)
        _fx.image_blend=make_color_rgb(255,105,10)
        _fx.hspeed-=random(2)*right*timescale
        _fx.vspeed+=orandom(poop/12)*timescale
        _fx.image_angle=_fx.direction+180
        _fx.image_xscale*=2;_fx.image_yscale*=2
        _fx.growspeed/=2;_fx.rot/=2
    }
    snd_play(sndHPPickup,0.8+random(0.2),0.8)
    snd_play(sndFrogExplode,1.2+random(0.8),0.8)
    var _drop=noone,_px=x+orandom(4),_py=y+orandom(4)
    if(random(2)<1 && random(poop)>=4) {
        _drop=scrNTTEFullSystemsCreate("PizzaChest",_px,_py);poop-=2
    } else if(poop>=2 && random(3)<1) {
        _drop=scrNTTEFullSystemsCreate("PizzaStack",_px,_py);poop-=2
    } else {
        _drop=scrNTTEFullSystemsCreate("Pizza",_px,_py);poop--
    }
    _drop.hspeed=-3*right*timescale;_drop.vspeed=orandom(1)*timescale
    if(instance_is(_drop,prop)) {_drop.x+=_drop.hspeed;_drop.y+=_drop.vspeed}
    if(!instance_is(_drop,HPPickup)) snd_play(sndEnergyHammerUpg,1.4+random(0.2),0.4)
    hspeed+=min(poop+1,4)*right*timescale
    poop_delay=8/max(1,poop)
    if(poop<=0 || poop_delay>10) speed=maxspeed*timescale
    if(!array_length(path)) for(var _i=0;_i<array_length(path_wall);++_i) if(place_meeting(x+hspeed,y+vspeed,path_wall[_i])) {
        if(place_meeting(x+hspeed,y,path_wall[_i])) hspeed*=-1
        if(place_meeting(x,y+vspeed,path_wall[_i])) vspeed*=-1
    }
    right=lengthdir_x(1,direction)>=0 ? 1:-1
}
function scrNTTEFullPetCoolGuyFxSourceCleanup(_before) {
    var _now=scrNTTEFullInstances(all)
    for(var _i=array_length(_now)-1;_i>=0;--_i)
        if(array_get_index(_before,_now[_i])<0 && instance_exists(_now[_i])) instance_destroy(_now[_i],false)
}
function scrNTTEFullPetCoolGuyFxSourceCapture(_before,_pet) {
    var _now=scrNTTEFullInstances(all),_created=[],_rows=[],_tail=[]
    for(var _i=0;_i<array_length(_now);++_i)
        if(array_get_index(_before,_now[_i])<0) array_push(_created,_now[_i])
    array_sort(_created,true)
    var _fields=["object_index","x","y","xprevious","yprevious","xstart","ystart","hspeed","vspeed","speed","direction","sprite_index","mask_index","image_angle","image_index","image_speed","image_xscale","image_yscale","image_blend","image_alpha","visible","persistent","depth","friction","gravity","gravity_direction"]
    var _optional=["growspeed","rot","num","blink","time","size","max_hp","hp"]
    var _streaks=0,_breath=0,_drops=0
    for(var _i=0;_i<array_length(_created);++_i) {
        var _v=_created[_i],_row=[]
        for(var _j=0;_j<array_length(_fields);++_j) array_push(_row,variable_instance_get(_v,_fields[_j]))
        for(var _j=0;_j<array_length(_optional);++_j) {
            var _has=variable_instance_exists(_v,_optional[_j])
            array_push(_row,_has)
            if(_has) array_push(_row,variable_instance_get(_v,_optional[_j]))
        }
        with(_v) for(var _j=0;_j<12;++_j) array_push(_row,alarm[_j])
        array_push(_rows,_row)
        if(_v.object_index==NTTEFullWaterStreak) _streaks++
        if(_v.object_index==Dust && _v.sprite_index==sprBreath) _breath++
        if(_v.object_index==NTTEFullPizza || _v.object_index==NTTEFullPizzaStack || _v.object_index==NTTEFullPizzaChest) _drops++
    }
    repeat(6) array_push(_tail,random(1))
    return {rows:_rows,streaks:_streaks,breath:_breath,drops:_drops,tail:_tail,
        pet:[_pet.poop,_pet.poop_delay,_pet.combo,_pet.combo_delay,_pet.kills_last,_pet.hspeed,_pet.vspeed,_pet.speed,_pet.direction,_pet.right]}
}
function scrNTTEFullPetCoolGuyFxSourceExact(_a,_b,_where) {
    assert(is_array(_a) && is_array(_b) && array_length(_a)==array_length(_b),"CoolGuy source array shape differs at "+_where)
    for(var _i=0;_i<array_length(_a);++_i) {
        if(is_array(_a[_i]) || is_array(_b[_i])) scrNTTEFullPetCoolGuyFxSourceExact(_a[_i],_b[_i],_where+"/"+string(_i))
        else assert(_a[_i]==_b[_i],"CoolGuy source exact value differs at "+_where+"/"+string(_i)+": expected="+string(_a[_i])+", actual="+string(_b[_i]))
    }
}
function scrNTTEFullPetCoolGuyFxSourceReset(_pet,_budget) {
    GameCont.area=1;GameCont.underwater=false
    with(_pet) {
        x=140000;y=140000;xprevious=x;yprevious=y
        direction=0;speed=0;right=1;visible=true
        combo=0;combo_delay=60;combo_text=noone;combo_texty=0
        kills_last=GameCont.kills;poop=_budget;poop_delay=0;path=[]
        assert(instance_exists(leader),"CoolGuy source fixture requires its actual adopted owner")
        assert(!place_meeting(x,y,Player),"CoolGuy source fixture must be isolated from player contact")
        for(var _i=0;_i<array_length(path_wall);++_i)
            assert(!place_meeting(x+16*timescale,y,path_wall[_i]),"CoolGuy source fixture must retain a clear native wall path")
    }
}
function scrNTTEFullPetCoolGuyFxSourceTests(_pet) {
    var _before=scrNTTEFullInstances(all),_seed=random_get_seed()
    var _game=scrNTTEFullAreaGeneratorSnapshot(GameCont),_players=scrNTTEFullAreaGeneratorSnapshot(Player)
    var _back=scrNTTEFullAreaGeneratorSnapshot(BackCont),_pet_saved=scrNTTEFullAreaGeneratorSnapshot(_pet)
    var _particles=UberCont.opt_prtcls,_budgets=[1,2,4],_seeds=[41017,41018,41019,41020,73103,73104,73105,73106]
    assert(!instance_exists(GenCont),"CoolGuy source fixture needs real effects outside generation")
    try {
        UberCont.opt_prtcls=true
        for(var _bi=0;_bi<array_length(_budgets);++_bi) for(var _si=0;_si<array_length(_seeds);++_si) {
            var _budget=_budgets[_bi],_trial_seed=_seeds[_si]
            scrNTTEFullAreaGeneratorRestore(_game);scrNTTEFullAreaGeneratorRestore(_players)
            scrNTTEFullAreaGeneratorRestore(_back);scrNTTEFullAreaGeneratorRestore(_pet_saved)
            scrNTTEFullPetCoolGuyFxSourceReset(_pet,_budget)
            random_set_seed(_trial_seed)
            with(_pet) scrNTTEFullPetCoolGuyFxSourceReference()
            var _expected=scrNTTEFullPetCoolGuyFxSourceCapture(_before,_pet)
            assert(_expected.streaks==4 && _expected.breath==(_budget>=2 ? _budget/2:0) && _expected.drops==1,
                "CoolGuy source oracle lost actual effects or exactly one real pizza output")
            scrNTTEFullPetCoolGuyFxSourceCleanup(_before)
            scrNTTEFullAreaGeneratorRestore(_game);scrNTTEFullAreaGeneratorRestore(_players)
            scrNTTEFullAreaGeneratorRestore(_back);scrNTTEFullAreaGeneratorRestore(_pet_saved)
            scrNTTEFullPetCoolGuyFxSourceReset(_pet,_budget)
            random_set_seed(_trial_seed)
            with(_pet) scrNTTEFullPetCoolGuyStep()
            var _actual=scrNTTEFullPetCoolGuyFxSourceCapture(_before,_pet)
            var _where="rate="+string(30/timescale)+",budget="+string(_budget)+",seed="+string(_trial_seed)
            assert(_actual.streaks==4 && _actual.breath==(_budget>=2 ? _budget/2:0) && _actual.drops==1,
                "CoolGuy production lost native effects/output at "+_where)
            scrNTTEFullPetCoolGuyFxSourceExact(_expected.rows,_actual.rows,_where+"/instances")
            scrNTTEFullPetCoolGuyFxSourceExact(_expected.pet,_actual.pet,_where+"/pet")
            scrNTTEFullPetCoolGuyFxSourceExact(_expected.tail,_actual.tail,_where+"/RNG-tail")
            scrNTTESmokeLog("COOLGUY SOURCE FX EXACT "+_where+", instances="+string(array_length(_actual.rows))+", RNG6="+json_stringify(_actual.tail))
            scrNTTEFullPetCoolGuyFxSourceCleanup(_before)
        }
        scrNTTESmokeLog("SYSTEMS PET COOLGUY SOURCE FX: budgets1/2/4 x8seeds, real constructors, source additive WaterStreak/Dust motion, exact newborn fields/pizza outcome/pet budget+velocity and six RNG continuation values OK")
    } finally {
        scrNTTEFullPetCoolGuyFxSourceCleanup(_before)
        scrNTTEFullAreaGeneratorRestore(_game);scrNTTEFullAreaGeneratorRestore(_players)
        scrNTTEFullAreaGeneratorRestore(_back);scrNTTEFullAreaGeneratorRestore(_pet_saved)
        UberCont.opt_prtcls=_particles;random_set_seed(_seed)
    }
}
