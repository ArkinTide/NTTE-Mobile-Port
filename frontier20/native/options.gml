// The desktop custom_options menu modifies NTT's UberCont.menu. Its data API
// is retained here and rendered through the host touch/gamepad options menu.
function scrFRCustomOptionsInit() {
    global.fr_option_pages={}; global.fr_option_fields={}; global.fr_option_points={};
    var _module=global.fr_module_vars[$ "mod:custom_options"];
    _module.mod_current_type="mod"; _module.scr={}; _module.export_to={};
    var _scripts=global.fr_module_scripts[$ "mod:custom_options"];
    _scripts.scr_import=scrFRCustomOptionsImport;
    _scripts.option_add_page=scrFROptionAddPage; _scripts.option_add=scrFROptionAdd;
    _scripts.option_get=scrFROptionGet; _scripts.option_set=scrFROptionSet;
    _scripts.option_defget=scrFROptionDefault;
    _scripts.option_get_field=scrFROptionGetField; _scripts.option_set_field=scrFROptionSetField;
    _scripts.option_defget_field=scrFROptionDefaultField;
    _scripts.option_set_mod_display_name=scrFROptionModName;
    _scripts.option_set_page_display_name=scrFROptionPageName;
    _scripts.option_set_display_name=scrFROptionName;
    _scripts.options_refresh=scrFROptionsRefresh;
    // The source's old UI is replaced by MenuOptions, including its Back
    // stack. Data utilities remain addressable for authored custom pages.
    variable_struct_remove(_scripts,"step");
    variable_struct_remove(_scripts,"draw_pause");
    var _names=variable_struct_get_names(_scripts);
    for(var _i=0;_i<array_length(_names);++_i) _module.scr[$ _names[_i]]=["mod","mod:custom_options",_names[_i]];
}

function scrFRCustomOptionsImport(_reference,_field="scr") {
    var _target=scrFRModGet(_reference[0],_reference[1],_field);
    if(!is_struct(_target)) _target={};
    var _source=global.fr_module_vars[$ "mod:custom_options"].scr,_names=variable_struct_get_names(_source);
    for(var _i=0;_i<array_length(_names);++_i) _target[$ _names[_i]]=_source[$ _names[_i]];
    return scrFRModSet(_reference[0],_reference[1],_field,_target);
}

function scrFROptionPageKey(_type,_mod,_page) { return scrFRModuleKey(_type,_mod)+":"+string(_page); }
function scrFROptionFieldKey(_type,_mod,_page,_option) { return scrFROptionPageKey(_type,_mod,_page)+":"+string(_option); }

function scrFROptionAddPage(_type,_mod,_variable,_name,_page) {
    var _key=scrFROptionPageKey(_type,_mod,_name);
    if(is_string(_page)) _page=json_parse(_page);
    global.fr_option_pages[$ _key]={type:_type,module:_mod,variable:_variable,name:_name,page:_page};
    var _options=is_struct(_page)?(_page[$ "options"]??[]):[];
    for(var _i=0;_i<array_length(_options);++_i) {
        var _option=_options[_i];
        scrFROptionAdd(_type,_mod,_variable,_name,_option[$ "option"],_option);
    }
    return _page;
}

function scrFROptionAdd(_type,_mod,_variable,_page,_name,_option) {
    if(is_string(_option)) _option=json_parse(_option);
    var _key=scrFROptionFieldKey(_type,_mod,_page,_name);
    global.fr_option_fields[$ _key]=_option;
    global.fr_option_points[$ _key]=[_type,_mod,_variable];
    return _option;
}

function scrFROptionGet(_type,_mod,_page,_name) {
    var _point=global.fr_option_points[$ scrFROptionFieldKey(_type,_mod,_page,_name)];
    if(is_undefined(_point)) return undefined;
    var _values=scrFRModGet(_point[0],_point[1],_point[2]);
    return is_struct(_values)?(_values[$ _name]):_values;
}

function scrFROptionSet(_type,_mod,_page,_name,_value) {
    var _point=global.fr_option_points[$ scrFROptionFieldKey(_type,_mod,_page,_name)];
    if(is_undefined(_point)) return undefined;
    var _values=scrFRModGet(_point[0],_point[1],_point[2]);
    if(is_struct(_values)) _values[$ _name]=_value;
    else scrFRModSet(_point[0],_point[1],_point[2],_value);
    return _value;
}

function scrFROptionDefault(_type,_mod,_page,_name,_default) {
    var _value=scrFROptionGet(_type,_mod,_page,_name);
    return is_undefined(_value)?_default:_value;
}
function scrFROptionGetField(_type,_mod,_page,_name,_field) {
    var _option=global.fr_option_fields[$ scrFROptionFieldKey(_type,_mod,_page,_name)];
    return is_struct(_option)?_option[$ _field]:undefined;
}
function scrFROptionSetField(_type,_mod,_page,_name,_field,_value) {
    var _option=global.fr_option_fields[$ scrFROptionFieldKey(_type,_mod,_page,_name)];
    if(is_struct(_option)) _option[$ _field]=_value;
    return _value;
}
function scrFROptionDefaultField(_type,_mod,_page,_name,_field,_default) {
    var _value=scrFROptionGetField(_type,_mod,_page,_name,_field);
    return is_undefined(_value)?_default:_value;
}
function scrFROptionModName(_type,_mod,_name) { global.fr_option_mod_name=_name; }
function scrFROptionPageName(_type,_mod,_page,_name) {
    var _entry=global.fr_option_pages[$ scrFROptionPageKey(_type,_mod,_page)];
    if(is_struct(_entry)) _entry.display_name=_name;
}
function scrFROptionName(_type,_mod,_page,_name,_display) { return scrFROptionSetField(_type,_mod,_page,_name,"name",{text:_display}); }
function scrFROptionsRefresh() { if(instance_exists(MenuOptions)) with(MenuOptions) scrFRMenuOptionsBuild(); }

function scrFROptionSprite(_token) {
    var _sprite=handle_parse(_token);
    if(!sprite_exists(_sprite)) _sprite=asset_get_index(_token);
    if(sprite_exists(_sprite)) return _sprite;
    // Source interpolation uses real(sprite), whereas the native runner
    // uses typed asset references. Reconstruct the original sprite from
    // packaged assets before passing its name to the native text renderer.
    static _source_ids=undefined;
    if(is_undefined(_source_ids)) {
        _source_ids={};
        var _paths=variable_struct_get_names(global.fr_asset_sources);
        for(var _i=0;_i<array_length(_paths);++_i) {
            var _asset=global.fr_asset_sources[$ _paths[_i]];
            if(sprite_exists(_asset)) _source_ids[$ string(real(_asset))]=_asset;
        }
    }
    return _source_ids[$ _token]??-1;
}

function scrFROptionText(_value,_fallback="",_trim=true) {
    if(is_struct(_value)) _value=_value[$ "text"]??_fallback;
    if(is_undefined(_value)) _value=_fallback;
    var _text=string(_value),_out="",_at=1;
    // Preserve NTT's authored slot width/frame while replacing raw source
    // sprite IDs with the corresponding named native asset.
    while(_at<=string_length(_text)) {
        if(string_char_at(_text,_at)=="@"
            && string_pos(string_char_at(_text,_at+1),"123456789")>0
            && string_char_at(_text,_at+2)=="(") {
            var _end=string_pos_ext(")",_text,_at+3);
            if(_end>0) {
                var _parts=string_split(string_copy(_text,_at+3,_end-_at-3),":"),
                    _sprite=scrFROptionSprite(_parts[0]);
                if(sprite_exists(_sprite)) {
                    var _image=array_length(_parts)>1?_parts[1]:"0";
                    _out+="@"+string_char_at(_text,_at+1)+"("+sprite_get_name(_sprite)+":"+_image+")";
                } else {
                    throw "Unresolved Frontier text sprite "+_parts[0];
                }
                _at=_end+1;continue;
            }
        }
        _out+=string_char_at(_text,_at++);
    }
    var _lines=string_split(string_replace_all(string_replace_all(_out,"\r",""),"#","\n"),"\n"),_clean="";
    for(var _i=0;_i<array_length(_lines);++_i) {
        if(_i>0) _clean+="\n";
        _clean+=_trim?string_trim(_lines[_i]):_lines[_i];
    }
    return string_replace_all(scrFRLocalize(_clean),"#","\n");
}

function scrFROptionField(_record,_name,_default) {
    return is_struct(_record)?(_record[$ _name]??_default):_default;
}

function scrFROptionSliderValue(_option) {
    var _value=lerp(_option.fr_min,_option.fr_max,clamp(_option.value,0,1));
    return clamp(round(_value/_option.fr_step)*_option.fr_step,_option.fr_min,_option.fr_max);
}

function scrFROptionDisplayValue(_option) {
    if(!is_undefined(_option.fr_override)) return scrFROptionText(_option.fr_override);
    var _value=_option.value;
    if(_option.type=="slider") {
        _value=scrFROptionSliderValue(_option)*_option.fr_multiplier;
        return _option.fr_prefix+string_trim(string_format(_value,_option.fr_total,_option.fr_dec))+_option.fr_suffix;
    }
    var _at=array_get_index(_option.list,_value),_display=_option.fr_display;
    if(_at>=0 && _at<array_length(_display)) _value=_display[_at];
    return _option.fr_prefix+scrFROptionText(_value)+_option.fr_suffix;
}

function scrFRMenuOptionsDescription(_text) {
    if(_text=="") return;
    // A separate noninteractive row keeps every authored explanation readable
    // on touch screens without covering controls or depending on mouse hover.
    scrOptionsMenuCreateElement({name:"",skip:true,available:false,fr_description:_text,
        height:max(14,(string_count("\n",_text)+1)*8+6),
        draw:function(_option) {
            var _font=scrFRLocalizationFont(_option.fr_description);
            var _halign=draw_get_halign(),_valign=draw_get_valign();
            draw_set_halign(fa_left);draw_set_valign(fa_top);
            draw_text_nt(drawx-130,drawy-5,_option.fr_description,0.65,0.65,0,c_silver,1);
            draw_set_halign(_halign);draw_set_valign(_valign);
            draw_set_font(_font);
            return true;
        }});
}

function scrFRMenuOptionsBuild() {
    if(!scrFREnabled()) return;
    scrOptionsMenuCategoryBegin(OptionCategory.Frontier);
    scrOptionsMenuCreateElement({name:scrFRLocalize("UNCHARTED FRONTIER (NTUF)"),available:false,skip:true});
    var _keys=variable_struct_get_names(global.fr_option_pages);
    for(var _i=0;_i<array_length(_keys);++_i) {
        var _entry=global.fr_option_pages[$ _keys[_i]],_label=scrFROptionText(_entry[$ "display_name"]??string_upper(_entry.name));
        var _page_key=_keys[_i];
        scrOptionsMenuCreateElement({name:_label,fr_page:_page_key,click:function(_option) {
            scrFRMenuOptionsPage(_option.fr_page);
            scrOptionsMenuChangeCategory(OptionCategory.Frontier_Page);
        }});
    }
    scrOptionsMenuCategoryEnd();
    var _main=options[OptionCategory.Main],_existing=[];
    for(var _i=0;_i<array_length(_main);++_i) if(!(_main[_i][$ "fr_menu_entry"]??false)) array_push(_existing,_main[_i]);
    scrOptionsMenuCategoryBegin(OptionCategory.Main);
    option_list=_existing;
    scrOptionsMenuCreateElement({name:"NTUF",fr_menu_entry:true,type:"category",category:OptionCategory.Frontier});
    scrOptionsMenuCategoryEnd();
}

function scrFRMenuOptionsPage(_key) {
    var _entry=global.fr_option_pages[$ _key],_page=_entry.page;
    scrOptionsMenuCategoryBegin(OptionCategory.Frontier_Page);
    scrOptionsMenuCreateElement({name:scrFROptionText(_entry[$ "display_name"]??string_upper(_entry.name)),available:false,skip:true});
    if(scrFRMenuNativeInformation(_entry)) {scrOptionsMenuCategoryEnd();return;}
    if(is_struct(_page)) {
        var _options=_page[$ "options"]??[];
        for(var _i=0;_i<array_length(_options);++_i) {
            var _original=_options[_i],_name=_original[$ "option"],_kind=_original[$ "kind"]??"button";
            var _text=scrFROptionText(_original[$ "name"],string_upper(_name));
            var _native={name:_text,fr_entry:_entry,fr_option:_name,
                fr_source:_original,fr_prefix:scrFROptionText(_original[$ "prefix"],"",false),
                fr_suffix:scrFROptionText(_original[$ "suffix"],"",false),fr_override:_original[$ "display_override"],
                value:scrFROptionGet(_entry.type,_entry.module,_entry.name,_name),
                click:function(_option) {
                    var _entry=_option.fr_entry;
                    if(_option.type=="switch" || _option.type=="list")
                        method_execute(element_functions[$ _option.type],_option);
                    var _value=_option.value;
                    if(_option.type=="slider") _value=scrFROptionSliderValue(_option);
                    scrFROptionSet(_entry.type,_entry.module,_entry.name,_option.fr_option,_value);
                    scrFRModCall("mod","Frontier_Options","CustomOptions_save");
                    return true;
                }};
            switch(_kind) {
                case "bool": _native.type="switch"; break;
                case "int":case "float":case "number":case "range":
                    var _range=_original[$ "range"];
                    _native.type="list";_native.list=[];
                    var _step=_original[$ "steps"]??1;
                    var _minimum=scrFROptionField(_range,"minimum",-5),_maximum=scrFROptionField(_range,"maximum",5);
                    assert(_step>0 && _maximum>=_minimum,"Invalid Frontier numeric option range: "+_name);
                    for(var _v=_minimum;_v<=_maximum+_step/10;_v+=_step) array_push(_native.list,_v);
                    _native.fr_display=[];_native.get_value=function(_option) {return scrFROptionDisplayValue(_option);};
                    break;
                case "slider":
                    var _range=_original[$ "range"];
                    _native.type="slider";_native.scalar_slider=false;
                    _native.fr_min=scrFROptionField(_range,"minimum",0);_native.fr_max=scrFROptionField(_range,"maximum",1);
                    _native.fr_step=_original[$ "steps"]??0.001;
                    assert(_native.fr_step>0 && _native.fr_max>_native.fr_min,"Invalid Frontier slider range: "+_name);
                    var _format=_original[$ "format"];
                    _native.fr_total=scrFROptionField(_format,"total",3);
                    _native.fr_dec=scrFROptionField(_format,"dec",1);
                    _native.fr_multiplier=scrFROptionField(_format,"display_multiplier",100);
                    _native.value=clamp((_native.value-_native.fr_min)/max(0.000001,_native.fr_max-_native.fr_min),0,1);
                    _native.get_value=function(_option) {return scrFROptionDisplayValue(_option);};
                    break;
                case "choices":case "choice":
                case "cycle":
                    _native.type="list";_native.list=_original[$ "values"]??["this","is","a","cycle"];
                    _native.fr_display=_original[$ "display"]??_native.list;
                    _native.get_value=function(_option) {return scrFROptionDisplayValue(_option);};
                    break;
                default: _native.type="button";break;
            }
            scrOptionsMenuCreateElement(_native);
            scrFRMenuOptionsDescription(scrFROptionText(_original[$ "desc"]));
        }
        var _reference=_page[$ "reference"];
        if(!is_undefined(_reference)) {
            scrOptionsMenuCreateElement({name:"",skip:true,available:false,height:160,fr_reference:_reference,
                draw:function(_option) {scrFRInvokeDraw(id,_option.fr_reference,[]);return true;}});
        }
    } else {
        // Authored statistics/credits pages are invoked in the menu's own
        // scope. The upstream libMenu uses the same shared input adapters.
        scrFRCallArray(_page,[]);
    }
    scrOptionsMenuCategoryEnd();
}
