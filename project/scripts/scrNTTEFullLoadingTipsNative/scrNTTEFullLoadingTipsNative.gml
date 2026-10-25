// Original petlib names and loading tips. Preserve case, punctuation, trailing
// spaces and scalar-vs-array choice (the latter consumes a random selection).
function scrNTTEFullPetGetName(_pet,_skin=0,_inst=noone) {
    var _name=_pet
    switch(_pet) {
        case "CoolGuy":_name="CoolGuy"+(_skin=="peas"?"?":"");break
        case "Twins":_name=instance_exists(_inst) && variable_instance_exists(_inst,"partner")
            && _inst.partner!=noone && !instance_exists(_inst.partner)?"TWIN":"TWINS";break
        case "Cuz":
            var _playing=false
            with(Player) if(spr_idle==sprMutant16Idle) {_playing=true;break}
            _name="Cuz"+(_playing?"?":"");break
    }
    return loc("NTTE:Pet:Info:"+_pet+".petlib.mod:"+string(_skin)+":Name",_name)
}
function scrNTTEFullPetPromptText(_inst) {
    return "@2("+sprite_get_name(_inst.spr_icon)+")"+scrNTTEFullPetGetName(_inst.pet,_inst.bskin,_inst)
}
function scrNTTEFullPetTipPool(_pet,_skin=0) {
    switch(_pet) {
        case "Scorpion":return ["SPIT VENOM","ROCKSLIDE","HIGH ON THE FOOD CHAIN"]
        case "Parrot":return [_skin==1?"BACKPACK BUDDY":"PARROTS RETRIEVE @wPICKUPS","HANDY","THEY LIKE YOU","HAND OVER HAND"]
        case "Slaughter":return ["BUBBLE BLOWIN'","BABY","JAWS","VICIOUS"]
        case "Octo":return ["BRAIN WAVES","TEAMWORK","JUMP ROPE","BRING FORTH THE MOLLUSK"]
        case "CoolGuy":return _skin=="peas"?"STINK BEAN":["JUST A COOL GUY","BRO","HIGH SCORE!","BACKWARD CAPS ARE COOL"]
        case "Salamander":return ["VEHICULAR COMBAT","NITROUS","PUNT"]
        case "Mimic":return ["EXTERNAL STORAGE","GUN DEALER","WHAT YOU NEED","BUY SOMETHING"]
        case "Spider":return _skin==1?["STUCK A BIT","SITUATION STICKY","GROSS","COCOONED"]:["A BIT STUCK","STICKY SITUATION","GROSS","COCOONED"]
        case "Prism":return ["STRANGE GEOMETRY","CURSED REFRACTION","YEAH OH ","LIGHT BEAMS"]
        case "Twins":return ["SUBSPACE HIGHWAY THROUGH YOUR HEAD","WROUGHT FROM THE SOURCE","AN ELEGANT DANCE"]
        case "Orchid":return ["ELEGANT","FLORID","GENETIC MAGIC","YOU WERE THE KING OF KARAT FLOWERS"]
        case "Weapon":return _skin==1?["RESPECT MUTUAL","WEAPON WALKING"]:["MUTUAL RESPECT","WALKING WEAPON"]
        case "Cuz":return ["YUNG CUZ","YUNG CUZ IS LAZY","CUZ IS STILL LEARNING","BE A ROLE MODEL","NO TIME FOR GAMES","1-UP"]
        case "Guardian":return ["MEMENTO","BLACK BOX","DEFECTIVE"]
    }
    throw "Unknown original NTTE pet tip provider: "+string(_pet)
}
function scrNTTEFullPetGetTip(_pet,_skin=0) {
    var _pool=scrNTTEFullPetTipPool(_pet,_skin),_key="NTTE:Pet:Info:"+_pet+".petlib.mod:"+string(_skin)+":Tip"
    if(is_array(_pool)) {
        var _n=irandom(array_length(_pool)-1)
        return loc(_key+":"+string(_n),_pool[_n])
    }
    return loc(_key,_pool)
}
function scrNTTEFullScytheTipPool() {
    return ["press @1(sprKeySmall:pick) to change modes","the @rscythe @scan do so much more",
        "press @1(sprKeySmall:pick) to rearrange a few @rbones","just press @1(sprKeySmall:pick) already",
        "please press @1(sprKeySmall:pick)","@q@1(sprKeySmall:pick)"]
}
function scrNTTEFullLoadingPickTag() {
    var _sprite=sprKeySmall,_image=keymap_get("pick")
    if(UberCont.opt_gamepad) {_sprite=gamepad_icon_small;_image-=32769}
    else if(!UberCont.opt_keyboard) {_sprite=is_touch(global.index)?sprMobilePickup:sprEPickup;_image=0}
    return "@1("+sprite_get_name(_sprite)+":"+string(_image)+")"
}
function scrNTTEFullLoadingShuffle(_array) {
    var _copy=array_create(array_length(_array));array_copy(_copy,0,_array,0,array_length(_array))
    for(var _i=0;_i<array_length(_copy);++_i) {
        var _j=irandom_range(_i,array_length(_copy)-1),_old=_copy[_i]
        _copy[@_i]=_copy[_j];_copy[@_j]=_old
    }
    return _copy
}
// Source ntte2649..2703 restores the RNG after all presentation choices.
// This preserves native generation state; it does not claim cross-engine seed
// equivalence with the PC MOD's separate legacy RNG implementation.
function scrNTTEFullLoadingTipsSetup(_gen) {
    if(!instance_exists(_gen) || scrNTTEFullValue(_gen,"ntte_loading_tips_setup",false)) return false
    _gen.ntte_loading_tips_setup=true;_gen.tip_ntte=""
    var _seed=random_get_seed()
    try {
        if(GameCont.hard>1) {
            if(!variable_instance_exists(GameCont,"ntte_scythe_tip_index")) GameCont.ntte_scythe_tip_index=0
            if(GameCont.ntte_scythe_tip_index>=0) {
                var _scythe=false
                with(Player) if(scrNTTEIsScythe(scrNTTEFullWeaponRaw(wep)) || scrNTTEIsScythe(scrNTTEFullWeaponRaw(bwep))) {_scythe=true;break}
                if(_scythe) {
                    var _pool=scrNTTEFullScytheTipPool(),_index=GameCont.ntte_scythe_tip_index
                    _gen.tip_ntte=_pool[_index]
                    GameCont.ntte_scythe_tip_index=min(_index+1,array_length(_pool)-1)
                }
            }
        }
        if(_gen.tip_ntte=="" && random(14)<1) {
            var _players=[]
            with(Player) if(is_array(scrNTTEFullValue(id,"ntte_pet",undefined))) array_push(_players,id)
            _players=scrNTTEFullLoadingShuffle(_players)
            for(var _i=0;_i<array_length(_players) && _gen.tip_ntte=="";++_i) {
                var _pets=scrNTTEFullLoadingShuffle(_players[_i].ntte_pet)
                for(var _j=0;_j<array_length(_pets);++_j) if(instance_exists(_pets[_j])) {
                    var _pet=_pets[_j]
                    _gen.tip_ntte=scrNTTEFullPetGetTip(_pet.pet,_pet.bskin)
                    if(_gen.tip_ntte!="") break
                }
            }
        }
        if(_gen.tip_ntte!="") _gen.tip=string_replace_all(scrNTTEFullDisplay(_gen.tip_ntte),"@1(sprKeySmall:pick)",scrNTTEFullLoadingPickTag())
    }
    finally {random_set_seed(_seed)}
    return _gen.tip_ntte!=""
}
