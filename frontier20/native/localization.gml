// Frontier presentation is localized separately from NTTE. Never rewrite
// actor names, module/property keys, hitid identities, pools or save values.
function scrFRLocalizationTokenEnd(_text,_at) {
    if(string_char_at(_text,_at)!="@") return 0;
    var _next=string_char_at(_text,_at+1),_open=_at+1;
    if(_next=="") return 0;
    if(string_pos(_next,"123456789")>0) _open+=1;
    if(string_char_at(_text,_open)=="(") {
        var _end=string_pos_ext(")",_text,_open+1);
        return _end>0?_end:0;
    }
    if(string_pos(_next,"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ")>0) return _at+1;
    return 0;
}

function scrFRLocalizationPlain(_text) {
    var _out="",_space=false,_break=false;
    for(var _at=1;_at<=string_length(_text);++_at) {
        var _end=scrFRLocalizationTokenEnd(_text,_at);
        if(_end>0) {_at=_end;continue;}
        var _char=string_char_at(_text,_at);
        if(_char=="\r") continue;
        if(_char=="#" || _char=="\n") {_break=true;_space=false;continue;}
        if(_char==" " || _char=="\t") {_space=true;continue;}
        if(_break && _out!="") _out+=" / ";
        else if(_space && _out!="") _out+=" ";
        _out+=_char;_space=false;_break=false;
    }
    if(_break && _out!="") _out+=" /";
    return _out;
}

function scrFRLocalizationCompose(_original,_translated) {
    // Full translations may reorder grammar. Keep the initial text style and
    // every authored sprite slot intact; IDs inside @1(sprite:frame) stay raw.
    var _prefix="",_icons="",_inPrefix=true;
    for(var _at=1;_at<=string_length(_original);++_at) {
        var _end=scrFRLocalizationTokenEnd(_original,_at);
        if(_end>0) {
            var _token=string_copy(_original,_at,_end-_at+1);
            if(string_pos(string_char_at(_token,2),"123456789")>0) _icons+=_token;
            else if(_inPrefix) _prefix+=_token;
            _at=_end;continue;
        }
        if(string_char_at(_original,_at)!=" " && string_char_at(_original,_at)!="\t") _inPrefix=false;
    }
    return _prefix+_icons+string_replace_all(_translated," / ","#");
}

function scrFRLocalizationWords(_text,_dictionary) {
    // Composed surgery/stat/fishing text is translated at display time.
    // Longest whole phrases take priority, so MAX HEALTH is never split into
    // unrelated surgery words. This path runs once per distinct cached text.
    var _words=string_split(_text," "),_out="";
    for(var _at=0;_at<array_length(_words);) {
        var _found=undefined,_count=0;
        for(var _size=min(8,array_length(_words)-_at);_size>0;--_size) {
            var _phrase="";
            for(var _i=0;_i<_size;++_i) {
                if(_i>0) _phrase+=" ";
                _phrase+=_words[_at+_i];
            }
            _found=_dictionary[$ string_upper(_phrase)];
            if(!is_undefined(_found)) {_count=_size;break;}
        }
        if(_at>0) _out+=" ";
        if(_count>0) {_out+=_found;_at+=_count;}
        else {_out+=_words[_at];_at+=1;}
    }
    return _out;
}

function scrFRLocalize(_value) {
    // Native option prefixes/descriptions legitimately contain empty text.
    // GML permits no empty struct member name, including the cache's key.
    if(!is_string(_value) || _value=="" || !scrNTTEFullIsSimplifiedChinese()) return _value;
    static _cache={},_count=0;
    var _cached=_cache[$ _value];
    if(!is_undefined(_cached)) return _cached;
    var _plain=scrFRLocalizationPlain(_value);
    if(_plain=="") return _value;
    var _dictionary=scrFRLocalizationData();
    var _translated=_dictionary[$ _plain];
    if(is_undefined(_translated)) _translated=_dictionary[$ string_upper(_plain)];
    var _result=_value;
    if(!is_undefined(_translated)) _result=scrFRLocalizationCompose(_value,_translated);
    else {
        // Keep rich-text tags in their original positions when a sentence
        // contains changing numbers, generated names or existing NTTE text.
        var _out="",_run="";
        for(var _at=1;_at<=string_length(_value);++_at) {
            var _end=scrFRLocalizationTokenEnd(_value,_at),_char=string_char_at(_value,_at);
            if(_end>0 || _char=="#" || _char=="\n") {
                _out+=scrFRLocalizationWords(_run,_dictionary);_run="";
                if(_end>0) {_out+=string_copy(_value,_at,_end-_at+1);_at=_end;}
                else _out+=_char;
            } else _run+=_char;
        }
        _result=_out+scrFRLocalizationWords(_run,_dictionary);
    }
    if(_count>=512) {_cache={};_count=0;}
    _cache[$ _value]=_result;_count+=1;
    return _result;
}

function scrFRLoc() {
    var _args=[];
    for(var _i=0;_i<argument_count;++_i) array_push(_args,argument[_i]);
    return scrFRLocalize(scrFRInvokeHere(loc,_args));
}

function scrFRLocalizationNeedsCJK(_text) {
    // Fast path for the ordinary ASCII text/tag case. Resource IDs and other
    // rich-text payloads are not visible glyphs, even if they contain Unicode.
    if(!is_string(_text) || string_byte_length(_text)==string_length(_text)) return false;
    for(var _at=1;_at<=string_length(_text);++_at) {
        var _end=scrFRLocalizationTokenEnd(_text,_at);
        if(_end>0) {_at=_end;continue;}
        if(ord(string_char_at(_text,_at))>127) return true;
    }
    return false;
}

function scrFRLocalizationFont(_text=undefined) {
    var _font=draw_get_font();
    // Pure sprite tags and untranslated ASCII keep the caller's authored
    // metrics. Selecting CJK for those changes inline slot width/baseline.
    // The no-argument UI compatibility is retained. Preserve an already-CJK
    // caller too: keeping caller metrics never means forcing the Latin font.
    if(scrNTTEFullIsSimplifiedChinese()
        && (is_undefined(_text) || scrFRLocalizationNeedsCJK(_text))) draw_set_font(fntCJK);
    return _font;
}

function scrFRStringWidth(_text) {
    _text=scrFRLocalize(_text);
    var _font=scrFRLocalizationFont(_text);
    var _width=string_width(_text);
    draw_set_font(_font);return _width;
}

function scrFRLocalizationWeatherCaption(_sprite,_subimage) {
    if(!scrNTTEFullIsSimplifiedChinese() || !variable_global_exists("fr_module_vars")) return "";
    var _events=global.fr_module_vars[$ "mod:Frontier_Events"];
    if(!is_struct(_events) || _sprite!=(_events[$ "sprEventDropdowns"]??-1)) return "";
    var _labels=["","METEOR SHOWER","SCRAPYARDS NIGHT","AURORA","THUNDERSTORM",
        "BLIZZARD","BLACKOUT","PORTAL STORM","SERPENT LAIR","COAST NIGHT"],_index=floor(_subimage);
    return _index>0 && _index<array_length(_labels)?scrFRLocalize(_labels[_index]):"";
}

function scrFRLocalizationDrawWeatherCaption(_sprite,_subimage,_x,_y,_xs,_ys,_angle,_color,_alpha) {
    var _caption=scrFRLocalizationWeatherCaption(_sprite,_subimage);
    if(_caption=="") return;
    // Preserve the supplied graphic card and every animation coordinate. The
    // short translated caption follows its existing bottom edge as it moves.
    var _ha=draw_get_halign(),_va=draw_get_valign();
    draw_set_halign(fa_center);draw_set_valign(fa_top);
    scrFRDrawText(_x,_y+42*_ys,_caption,_xs,_ys,_angle,_color,_alpha);
    draw_set_halign(_ha);draw_set_valign(_va);
}
