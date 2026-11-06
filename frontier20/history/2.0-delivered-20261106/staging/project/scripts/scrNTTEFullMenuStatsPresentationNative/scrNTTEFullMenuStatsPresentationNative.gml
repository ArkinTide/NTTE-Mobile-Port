// Source temenu2382..2440,2739..2775 and petlib species *_stat callbacks.
// These pure queries never construct a pet or mutate saved collection arrays.
function scrNTTEFullMenuCollectionRaw(_weapon) {
    if(is_string(_weapon)) return _weapon;
    var _raw=scrNTTEFullWeaponRaw(_weapon)
    // Numeric0 is source wep_none, not the wrapper module whose table ID is0.
    if(is_numeric(_raw) && _raw>=0 && _raw<=127) return _raw;
    var _record=scrNTTEFullWeaponDropNativeRecord(_raw)
    return is_undefined(_record)?_raw:_record.raw;
}
function scrNTTEFullMenuMimicCollection(_weapons) {
    var _num=0,_max=0,_collected=[]
    if(is_array(_weapons)) {
        for(var _i=0;_i<array_length(_weapons);++_i) {
            var _raw=scrNTTEFullMenuCollectionRaw(_weapons[_i])
            if(array_get_index(_collected,_raw)<0) array_push(_collected,_raw)
        }
        var _wild=[wep_revolver,wep_golden_revolver,wep_chicken_sword,wep_rusty_revolver,
            wep_rogue_rifle,wep_guitar,wep_frog_pistol,wep_black_sword,wep_golden_frog_pistol,
            "crabbone","super teleport gun"],_table=scrNTTEFullWeaponDropTable()
        // Epsilon's extra native128 and physical LWO modes are not additional
        // source weapon modules. Count source0..127 and each registered module.
        for(var _i=127+array_length(_table);_i>=0;--_i) {
            var _raw=_i<128?_i:_table[_i-128].raw
            if(array_get_index(_collected,_raw)>=0) {_num++;_max++;}
            else {
                var _area=is_string(_raw)?scrNTTEFullWeaponDropArea(_raw,id):scr_weapon_get_area(_raw)
                if(_area>=0 || array_get_index(_wild,_raw)>=0) {_max++;}
            }
        }
    }
    return {stored:_num,total:_max,text:(_num<_max?"":"@q")+string(_num)+"/"+string(_max)+(_num<_max?"":"!")};
}
function scrNTTEFullMenuAreaNumber(_value) {
    return is_numeric(_value) && frac(_value)!=0?string_format(_value,0,2):string(_value);
}
function scrNTTEFullMenuAreaText(_value) {
    var _area=_value,_subarea=1,_loops=0
    if(is_array(_value) && array_length(_value)>0) {
        _area=_value[0]
        if(array_length(_value)>1) _subarea=_value[1]
        if(array_length(_value)>2) _loops=_value[2]
    }
    var _key=is_string(_area)?_area:scrNTTEFullAreaKey(_area),_text=scrNTTEFullAreaMapLabel(_area,_subarea)
    if(is_string(_area) && is_undefined(scrNTTEFullAreaInfo(_key))) return string(_value);
    if(is_undefined(_text)) {
            switch(_area) {
                case area_vault:_text="???";break
                case area_hq:_text="HQ"+scrNTTEFullMenuAreaNumber(_subarea);break
                case area_crib:_text="$$$";break
                default:
                    if(is_numeric(_area) && _area>100) _text=scrNTTEFullMenuAreaNumber(_area-100)+"-?"
                    else _text=scrNTTEFullMenuAreaNumber(_area)+"-"+scrNTTEFullMenuAreaNumber(_subarea)
            }
    }
    // Source telib checks the displayed area, not the current room's area.
    if(instance_exists(GameCont) && GameCont.win && (_area==area_palace || _area==area_hq))
        _text=_area==area_hq?"END2":"END1"
    if(real(_loops)>0) _text+=" "+(UberCont.hardmode?"H":"L")+scrNTTEFullMenuAreaNumber(_loops)
    return _text;
}
function scrNTTEFullMenuPresentationStatText(_key,_kind="number") {
    var _value=scrNTTEFullValue(global.ntte_full_progress.stats,_key,0)
    if(_kind=="time") return scrNTTEFullMenuTime(_value);
    if(_kind=="area") return scrNTTEFullMenuAreaText(_value);
    return string(_value);
}
function scrNTTEFullMenuPresentationPetValue(_pet,_key) {
    var _stat=scrNTTEFullValue(global.ntte_full_progress.stats,"pet:"+_pet+".petlib.mod",{}),
        _value=scrNTTEFullValue(_stat,_key,0)
    if(_pet=="Mimic" && _key=="weapons") return scrNTTEFullMenuMimicCollection(_value).text;
    if(_key=="owned" || (_pet=="Octo" && _key=="arcing") || (_pet=="Cuz" && _key=="playtime"))
        return scrNTTEFullMenuTime(_value);
    if(_pet=="Weapon" && _key=="battle" && is_array(_value)) {
        var _text=""
        for(var _i=0;_i<array_length(_value);++_i) _text+=(_i>0?"-":"")+string(_value[_i])
        return _text;
    }
    return string(_value);
}
function scrNTTEFullMenuPetStatLabel(_pet,_key) {
    if(_pet=="Weapon" && _key=="battle") return "@5("+string(scrNTTERefSprite("PetWeaponStat"))+")";
    if(_pet=="Spider" && _key=="cursed") return ((current_frame mod 60<15 || random(30)<1)?"@y@q":"@p")+_key;
    return _key;
}
function scrNTTEFullMenuPetPreviewSprite(_pet) {
    if(_pet=="Twins") return scrNTTERefSprite("PetTwinsStat");
    if(_pet=="Cuz") return sprCuzIdle;
    return scrNTTEFullPetGetSprite(_pet,"mod","petlib",0,"idle");
}
function scrNTTEFullMenuPetPreviewDraw(_opt) {
    var _sprite=scrNTTEFullMenuPetPreviewSprite(_opt.ntte_pet)
    draw_sprite(_sprite,0.4*current_frame,round(drawx-sprite_get_width(_sprite)/2+sprite_get_xoffset(_sprite)),
        round(drawy-sprite_get_height(_sprite)/2+sprite_get_yoffset(_sprite)))
    return true;
}
function scrNTTEFullMenuPetIconDraw(_opt) {
    var _sprite=scrNTTEFullPetIconSprite(_opt.ntte_pet),_known=scrNTTEFullMenuPetKnown(_opt.ntte_pet)
    draw_sprite_ext(_sprite,0.4*current_frame,round(drawx-_opt.width/2-10),drawy,1,1,0,_known?c_white:c_dkgray,1)
    return false;
}
function scrNTTEFullMenuPetPresentationBind() {
    var _pets=options[OptionCategory.NTTE_Pets]
    for(var _i=0;_i<array_length(_pets);++_i) {
        _pets[_i].draw=method(id,scrNTTEFullMenuPetIconDraw)
    }
}
function scrNTTEFullMenuPresentationPetPage(_pet) {
    ntte_menu_pet=_pet
    scrOptionsMenuCategoryBegin(OptionCategory.NTTE_PetDetails)
    var _sprite=scrNTTEFullMenuPetPreviewSprite(_pet)
    scrOptionsMenuCreateElement({name:"",value:"",ntte_pet:_pet,available:false,
        height:max(16,sprite_get_height(_sprite)),draw:method(id,scrNTTEFullMenuPetPreviewDraw)})
    var _stats=scrNTTEFullValue(global.ntte_full_progress.stats,"pet:"+_pet+".petlib.mod",{}),
        _keys=variable_struct_get_names(_stats)
    for(var _i=0;_i<array_length(_keys);++_i) {
        var _key=_keys[_i]
        scrOptionsMenuCreateElement({name:_key,ntte_pet:_pet,ntte_key:_key,available:false,
            get_name:function(_opt){return scrNTTEFullMenuPetStatLabel(_opt.ntte_pet,_opt.ntte_key);},
            get_value:function(_opt){return scrNTTEFullMenuPresentationPetValue(_opt.ntte_pet,_opt.ntte_key);}})
    }
    scrOptionsMenuCategoryEnd()
    scrOptionsMenuChangeCategory(OptionCategory.NTTE_PetDetails)
}
