// Keep the source's data and stable IDs; native menus own scrolling, fonts
// and touch coordinates. The original fixed 8px statistics page cannot fit
// translated 13px CJK rows and must not be drawn inside a single option row.
function scrFRMenuInfoRow(_label,_value="",_heading=false) {
    scrOptionsMenuCreateElement({name:scrFRLocalize(_label),available:false,skip:true,
        height:_heading?26:22,fr_info:true,fr_info_value:string(_value),fr_info_heading:_heading,
        draw:function(_option) {
            var _ha=draw_get_halign(),_va=draw_get_valign(),_font=draw_get_font(),
                _color=draw_get_color(),_alpha=draw_get_alpha();
            draw_set_valign(fa_middle);
            draw_set_halign(_option.fr_info_heading?fa_center:fa_left);
            var _text=_option.name,_x=_option.fr_info_heading?drawx:drawx-130;
            var _scale=min(1,(_option.fr_info_heading?260:180)/max(1,scrFRStringWidth(_text)));
            scrFRDrawText(_x,drawy,_text,_scale,_scale,0,c_white,1);
            if(_option.fr_info_value!="") {
                draw_set_halign(fa_right);
                var _scale=min(1,68/max(1,scrFRStringWidth(_option.fr_info_value)));
                scrFRDrawText(drawx+130,drawy,_option.fr_info_value,_scale,_scale,0,c_silver,1);
            }
            draw_set_halign(_ha);draw_set_valign(_va);draw_set_font(_font);
            draw_set_color(_color);draw_set_alpha(_alpha);return true;
        }});
}
function scrFRMenuStat(_key) {
    return scrFRModCallArray("mod","libSaves","save_get",["Frontier",_key]);
}
function scrFRMenuStatistics() {
    scrFRMenuInfoRow("GENERAL","",true);
    var _names=string_split(scrFROptionText("MEALS EATEN#AUGMENTS TAKEN#PROTO CACHES OPENED#CORE DETONATIONS#HOARDER K/E RATIO#CYBERSPACE VISITS"),"\n"),
        _keys=["meals_eaten","augments_taken","caches_opened","deeplabs_finales","hoarder_kills","cyberspace_visits"];
    for(var _i=0;_i<6;++_i) {
        var _value=string(scrFRMenuStat(_keys[_i]));
        if(_i==4) _value+=":"+string(scrFRMenuStat("hoarder_escapes"));
        scrFRMenuInfoRow(_names[_i],_value);
    }
    scrFRMenuInfoRow("WEAPONS TRADED","",true);
    scrFRMenuInfoRow(scrNTTEFullIsSimplifiedChinese()?"总数":"TOTAL",scrFRMenuStat("pirate_trades"));
    scrFRMenuInfoRow(scrNTTEFullIsSimplifiedChinese()?"不同种类":"UNIQUE",string(array_length(scrFRMenuStat("pirate_conversions")))+" / 45");
    scrFRMenuInfoRow("BUBBLES","",true);
    var _names=string_split(scrFROptionText("KILLS#LOOPS#RUNS#DEATHS#WINS#TIME#BUBBLES"),"\n"),
        _keys=["bubbles_kills","bubbles_loops","bubbles_runs","bubbles_deaths","bubbles_wins","bubbles_time","bubbles_bubbles"];
    for(var _i=0;_i<7;++_i) {
        var _value=scrFRMenuStat(_keys[_i]);
        if(_i==5) _value=string(floor(_value/3600))+":"+scrFRStringLPad(string(floor((_value/60)%60)),"0",2)+":"+scrFRStringLPad(string(floor(_value%60)),"0",2);
        scrFRMenuInfoRow(_names[_i],_value);
    }
    scrFRMenuInfoRow("BEST RUN","",true);
    var _best=scrFRMenuStat("bubbles_best_area"),_area=_best[0],_name="N/A";
    if(is_string(_area)) {
        var _resolved=scrFRAreaTryResolve(_area);
        _name=is_undefined(_resolved)?scrFRLocalize("AREA NOT LOADED"):scrFRDebugAreaLabel(_resolved,_best[1]);
    } else _name=string(_area)+"-"+string(_best[1]);
    scrFRMenuInfoRow("AREA",_name+" L"+string(_best[2]));
    scrFRMenuInfoRow("KILLS",scrFRMenuStat("bubbles_best_kills"));
}
function scrFRMenuCredits() {
    scrFRMenuInfoRow("WIGGLERCOLA MAKE MOD","",true);
    scrFRMenuInfoRow("WIGGLERCOLA");
    scrFRMenuInfoRow("MUSIC AND SFX","",true);
    scrFRMenuInfoRow("SPLATTIE");
    scrFRMenuInfoRow("-SPECIAL THANKS-","",true);
    var _names=["AEVUSONIAN","CRINGERHOMBUS","DRAGONSTRIVE","GECKOBONE","GOLDEN EPSILON","JSBURG","MCCHOMK","SANIBLUES","SQUIDDY","YOKIN"];
    for(var _i=0;_i<array_length(_names);++_i) scrFRMenuInfoRow(_names[_i]);
}
function scrFRMenuNativeInformation(_entry) {
    if(_entry.module!="Frontier_Options" && _entry.module!="mod:Frontier_Options") return false;
    if(_entry.name=="stats") {scrFRMenuStatistics();return true;}
    if(_entry.name=="credits") {scrFRMenuCredits();return true;}
    return false;
}

function scrFRCustomWeaponGroups() {
    // Metadata callbacks run after registry bootstrap even when the player
    // opens Custom before starting their first run. Area -1/cache-only source
    // weapons remain selectable and never disappear through drop filtering.
    if(scrFREnabled()) scrFRWeaponsRefresh();
    group_count=Ammo.NUM_AMMO_TYPES+3;
    groups=array_create(group_count);group_names=array_create(group_count);
    for(var _i=0;_i<group_count;++_i) {
        groups[_i]=[];
        group_names[_i]=_i==0?loc("CustomMode.Weapon:Special","SPECIAL"):
            (_i==group_count-2?"NTTE":(_i==group_count-1?"NTUF":loc("Ammo:Type",_i-1,typ_name[_i-1])));
    }
    for(var _weapon=1;_weapon<=maxwep;++_weapon) {
        if(variable_struct_exists(global.fr_weapon_keys,string(_weapon))) {
            array_push(groups[group_count-1],_weapon);continue;
        }
        if(_weapon>=wep_ntte_rogue_carbine && _weapon<=wep_ntte_last) {
            array_push(groups[group_count-2],_weapon);continue;
        }
        if(scr_weapon_get_area(_weapon)>0 || array_contains([wep_revolver,wep_rusty_revolver,
            wep_chicken_sword,wep_black_sword,wep_golden_revolver,wep_ion_cannon,
            wep_sentry_gun,wep_party_gun,wep_guitar],_weapon)) {
            var _group=scr_weapon_is_melee(_weapon)||_weapon==wep_jackhammer?1:scr_weapon_get_type(_weapon)+1;
            array_push(groups[_group],_weapon);
        }
    }
    for(var _i=1;_i<group_count;++_i) array_sort(groups[_i],function(_a,_b) {
        var _u=scr_weapon_get_area(_a),_v=scr_weapon_get_area(_b);
        if(_u<0) _u=1000+_a;if(_v<0) _v=1000+_b;
        if(scr_weapon_is_golden(_a)) _u+=500;if(scr_weapon_is_golden(_b)) _v+=500;
        return sign(_u-_v);
    });
    var _current=scrCustomParam(get_weapon_key());
    if(scr_weapon_is_valid(_current)) {
        var _group=variable_struct_exists(global.fr_weapon_keys,string(_current))?group_count-1:
            (_current>=wep_ntte_rogue_carbine?group_count-2:scr_weapon_get_type(_current)+1);
        if(!array_contains(groups[_group],_current)) array_push(groups[_group],_current);
    }
    groups[0]=[-1,wep_none];
}
function scrFRCustomWeaponGroupOrder(_index,_count) {
    // SPECIAL, NTTE, NTUF, then the six native ammo categories.
    if(_index==0) return 0;
    if(_index==1) return _count-2;
    if(_index==2) return _count-1;
    return _index-2;
}
function scrFRDebugFonts() {
    // dbg_* uses its own atlas, separate from draw_set_font/fntCJK. The
    // shipped Silver font contains these CJK glyphs. Use Chinese Full (3):
    // the common simplified subset (4) excludes 萨, 巢 and 窟 in route names.
    if(!variable_global_exists("fr_debug_glyphs")) {
        dbg_add_font_glyphs("lang/Silver.ttf",13,3);
        global.fr_debug_glyphs=true;
    }
}
function scrFRDebugAreaLabel(_area,_subarea=undefined) {
    // Rich route labels contain @1(sprite:frame) and colour tags; ImGui prints
    // those bytes as text. Supply real Unicode names rather than sprite tags.
    var _name=scrFRAreaDebugName(_area);
    if(is_undefined(_name)) return is_undefined(_subarea)?scrAreaGetName(_area):scrAreaGetMapName(_area,_subarea,0,false,false);
    if(scrNTTEFullIsSimplifiedChinese()) {
        switch(_area) {
            case 201:_name="海滩";break;case 202:_name="绿洲";break;
            case 203:_name="披萨下水道";break;case 204:_name="巢穴";break;
            case 205:_name="海沟";break;case 206:_name="红水晶洞窟";break;
            case 207:_name="灌木丛";break;case 301:_name="海湾";break;
            case 302:_name="网络空间";break;case 303:_name="深层实验室";break;
            case 304:_name="开发区";break;case 305:_name="墓地";break;
            case 306:_name="机器人中心";break;
        }
    }
    return is_undefined(_subarea)?_name:_name+" "+string(_subarea);
}
