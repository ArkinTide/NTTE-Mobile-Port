// Real acquired mutation callbacks run in the ordinary world between checks.
function scrFRSkillTestsStart(_driver) {
    var _main_pool=scrFRModGet("mod","Frontier_IDPD","settingMainPoolAugments"),
        _hyperion=scrFRSkillResolve("AugmentCompassion"),_active=scrFRSkillActive(_hyperion);
    try {
        assert(scrFRModLoaded("skill","compassion") && !scrFRModLoaded("skill","__ntuf_missing_skill"),
            "Native NTTE mutation presence was not exposed to authored augment availability");
        scrFRSkillSetActive(_hyperion,true);
        scrFRModSet("mod","Frontier_IDPD","settingMainPoolAugments",true);
        assert(scrFRSkillAvailable(_hyperion),"Authored Hyperion availability did not see native Compassion");
        scrFRModSet("mod","Frontier_IDPD","settingMainPoolAugments",false);
        assert(!scrFRSkillAvailable(_hyperion),"Authored main-pool augment switch was ignored");
    } finally {
        scrFRModSet("mod","Frontier_IDPD","settingMainPoolAugments",_main_pool);
        scrFRSkillSetActive(_hyperion,_active);
    }
    _driver.fr_skill_test_ids=variable_struct_get_names(global.fr_skill_keys);
    _driver.fr_skill_test_index=0;_driver.fr_skill_test_age=0;
    _driver.fr_skill_test_current=undefined;
    with(Player) {hp=10000;max_hp=10000;infammo=true;}
}

function scrFRSkillTestsStep(_driver) {
    var _at=_driver.fr_skill_test_index,_ids=_driver.fr_skill_test_ids;
    if(_at>=array_length(_ids)) return true;
    if(_driver.fr_skill_test_age==0) {
        var _skill=real(_ids[_at]);
        _driver.fr_skill_test_current=_skill;
        scrNTTESmokeLog("FRONTIER ACQUIRE "+scrFRSkillKey(_skill));
        scrFRSetSkill(_skill,1);
        assert(scrFRGetSkill(_skill)==1 && ds_list_find_index(GameCont.skills,_skill)>=0,
            "Frontier acquired skill missing from native mutation order");
        var _enabled=scrFRSkillActive(_skill);
        scrFRSkillSetActive(_skill,false);
        assert(!scrFRSkillAvailable(_skill),"Disabled Frontier mutation remained in native pool");
        scrFRSkillSetActive(_skill,_enabled);
    }
    _driver.fr_skill_test_age++;
    if(_driver.fr_skill_test_age==15) {
        scrFRSetSkill(_driver.fr_skill_test_current,0);
        assert(scrFRGetSkill(_driver.fr_skill_test_current)==0,
            "Frontier skill_lose did not update native ownership");
        _driver.fr_skill_test_index++;_driver.fr_skill_test_age=0;
    }
    return false;
}

function scrFROptionTestValuesEqual(_expected,_actual) {
    if(is_struct(_expected) || is_struct(_actual)) {
        if(!is_struct(_expected) || !is_struct(_actual)) return false;
        var _keys=variable_struct_get_names(_expected);
        if(array_length(_keys)!=array_length(variable_struct_get_names(_actual))) return false;
        for(var _i=0;_i<array_length(_keys);++_i)
            if(!variable_struct_exists(_actual,_keys[_i])
                || !scrFROptionTestValuesEqual(_expected[$ _keys[_i]],_actual[$ _keys[_i]])) return false;
        return true;
    }
    if(is_array(_expected) || is_array(_actual)) {
        if(!is_array(_expected) || !is_array(_actual) || array_length(_expected)!=array_length(_actual)) return false;
        for(var _i=0;_i<array_length(_expected);++_i)
            if(!scrFROptionTestValuesEqual(_expected[_i],_actual[_i])) return false;
        return true;
    }
    // Preserve each serialized primitive's exact type/value. Struct member
    // enumeration order is not part of the authored JSON settings contract.
    return json_stringify(_expected)==json_stringify(_actual);
}

function scrFROptionTests() {
    var _keys=variable_struct_get_names(global.fr_option_pages);
    assert(array_length(_keys)==6,"Frontier options did not register all six authored pages");
    var _menu=instance_create(0,0,MenuOptions),_checked=0,_default_sliders=0,_descriptions=0,_icons=0;
    // Frontier_Options:96..636 has32 active controls. The two controls at
    // 238..265 (V100 compatibility/event loading text) are source comments.
    var _expected_counts={visuals:10,gameplay:7,gameplay2:5,events:10,stats:0,credits:0};
    var _fixture="mod:__frontier_options_fixture",_fixture_page=scrFROptionPageKey("mod",_fixture,"fixture"),
        _fixture_names=["defaults","explicit","partial","choice"];
    try {
        with(_menu) {
            for(var _p=0;_p<array_length(_keys);++_p) {
                var _source_page=global.fr_option_pages[$ _keys[_p]],_page_before=json_stringify(_source_page.page),
                    _before_checked=_checked,_before_sliders=_default_sliders,
                    _before_descriptions=_descriptions,_before_icons=_icons;
                scrFRMenuOptionsPage(_keys[_p]);
                var _native=options[OptionCategory.Frontier_Page];
                for(var _o=0;_o<array_length(_native);++_o) {
                    var _option=_native[_o];
                    if(variable_struct_exists(_option,"fr_description")) {
                        assert(_option.fr_description!="" && _option.skip && !_option.available
                            && is_method(_option.draw),"Authored option explanation has no native presentation");
                        _descriptions++;continue;
                    }
                    if(!variable_struct_exists(_option,"fr_option")) continue;
                    var _entry=_option.fr_entry,_source=_option.fr_source;
                    if(string_pos("@1(",scrFROptionField(_source.name,"text",""))>0) {
                        var _source_text=scrFROptionField(_source.name,"text",""),
                            _source_end=string_pos(")",_source_text),
                            _source_parts=string_split(string_copy(_source_text,4,_source_end-4),":"),
                            _expected_icon=global.fr_module_vars[$ "mod:Frontier_Options"].sprSettingsIcons,
                            _expected_frame=real(_source_parts[1]);
                        assert(string_pos("@1("+_source_parts[0]+":",_option.name)==0,
                            "Native options exposed a raw numeric source sprite ID");
                        var _layout=render_parse_text(_option.name),_found_icon=false;
                        for(var _line=0;_line<array_length(_layout.lines);++_line) {
                            var _fragments=_layout.lines[_line].strings;
                            for(var _part=0;_part<array_length(_fragments);++_part)
                                if(_fragments[_part].type==TextRenderFragment.Sprite) {
                                    assert(sprite_exists(_fragments[_part].sprite_index),"Native settings icon is invalid");
                                    assert(_fragments[_part].sprite_index==_expected_icon
                                        && _fragments[_part].image_index==_expected_frame
                                        && _fragments[_part].ntt_slots==1,
                                        "Native settings icon changed authored sprite, frame or slot width");
                                    _found_icon=true;
                                }
                        }
                        assert(_found_icon,"Authored settings icon was omitted from its native label");_icons++;
                    }
                    if(is_struct(_source[$ "desc"]) && scrFROptionText(_source.desc)!="")
                        assert(_o+1<array_length(_native) && (_native[_o+1][$ "fr_description"]??"")==scrFROptionText(_source.desc),
                            "Native menu omitted an authored description");
                    var _old=scrFROptionGet(_entry.type,_entry.module,_entry.name,_option.fr_option);
                    if(_option.type=="switch" || _option.type=="list") {
                        method_execute(_option.click,_option);
                        assert(scrFROptionGet(_entry.type,_entry.module,_entry.name,_option.fr_option)==_option.value,
                            "Frontier option click did not commit its changed value");
                    } else if(_option.type=="slider") {
                        if(!is_struct(_source[$ "range"])) {
                            assert(_option.fr_min==0 && _option.fr_max==1,"Source Slider_create default0..1 was not inherited");
                            _default_sliders++;
                        }
                        if(_option.fr_option=="settingCrushTrapSpawnrate") {
                            assert(_option.fr_min==0 && _option.fr_max==2 && _option.fr_step==0.01,
                                "Explicit authored slider range or precision changed");
                            _option.value=0.625;
                            assert(method_execute(_option.get_value,_option)=="125%","Authored slider percent suffix/format changed");
                        }
                        _option.value=1;
                        method_execute(_option.click,_option);
                        var _new=scrFROptionGet(_entry.type,_entry.module,_entry.name,_option.fr_option);
                        assert(abs(_new-_option.fr_max)<0.0001,"Frontier slider lost authored numeric range");
                    }
                    scrFROptionSet(_entry.type,_entry.module,_entry.name,_option.fr_option,_old);
                    _checked++;
                }
                var _page_counts=[_checked-_before_checked,_default_sliders-_before_sliders,
                    _descriptions-_before_descriptions,_icons-_before_icons];
                scrNTTESmokeLog("FRONTIER OPTIONS PAGE "+_source_page.name
                    +" controls="+string(_page_counts[0])+" default_sliders="+string(_page_counts[1])
                    +" descriptions="+string(_page_counts[2])+" icons="+string(_page_counts[3]));
                var _expected=_expected_counts[$ _source_page.name];
                assert(!is_undefined(_expected) && _page_counts[0]==_expected
                    && _page_counts[2]==_expected && _page_counts[3]==_expected,
                    "Frontier authored page count mismatch: "+_source_page.name+" "+json_stringify(_page_counts));
                assert(json_stringify(_source_page.page)==_page_before,"Native menu mutated authored option metadata");
            }
        }
        var _counts="controls="+string(_checked)+" default_sliders="+string(_default_sliders)
            +" descriptions="+string(_descriptions)+" icons="+string(_icons);
        scrNTTESmokeLog("FRONTIER OPTIONS TOTAL "+_counts);
        assert(_checked==32 && _default_sliders==9 && _descriptions==32 && _icons==32,
            "Frontier options skipped authored controls, default sliders, explanations or icons: "+_counts);
        var _icon=global.fr_module_vars[$ "mod:Frontier_Options"].sprSettingsIcons;
        assert(scrFROptionSprite(string(real(_icon)))==_icon
            && scrFROptionSprite(sprite_get_name(_icon))==_icon,
            "Numeric source and native named icon references disagree");
        // Exercise fields omitted by the authored probability sliders as well
        // as non-percent custom formats without changing stable option data.
        global.fr_module_vars[$ _fixture]={values:{defaults:0.5,explicit:2.5,partial:0.25,choice:2}};
        scrFROptionAddPage("mod",_fixture,"values","fixture",{options:[
            {option:"defaults",kind:"slider",name:{text:"DEFAULT SLIDER"}},
            {option:"explicit",kind:"slider",range:{minimum:-2,maximum:4},steps:0.25,
                prefix:"x",suffix:" units",format:{total:1,dec:2,display_multiplier:1}},
            {option:"partial",kind:"slider",range:{minimum:-1}},
            {option:"choice",kind:"choice",values:[1,2,3]}
        ]});
        with(_menu) {
            scrFRMenuOptionsPage(_fixture_page);
            var _controls=options[OptionCategory.Frontier_Page],_defaults=_controls[1],_explicit=_controls[2],
                _partial=_controls[3],_choice=_controls[4];
            assert(_defaults.fr_min==0 && _defaults.fr_max==1 && _defaults.fr_step==0.001
                && _defaults.fr_total==3 && _defaults.fr_dec==1 && _defaults.fr_multiplier==100,
                "Source slider omitted-field defaults changed");
            assert(method_execute(_defaults.get_value,_defaults)=="50.0","Default format added a non-authored suffix");
            assert(_partial.fr_min== -1 && _partial.fr_max==1,"Partially specified slider range lost its default bound");
            assert(method_execute(_explicit.get_value,_explicit)=="x2.50 units","Custom source format/prefix/suffix changed");
            _explicit.value=0.59;method_execute(_explicit.click,_explicit);
            assert(scrFROptionGet("mod",_fixture,"fixture","explicit")==1.5,"Explicit slider step rounding changed");
            assert(method_execute(_choice.get_value,_choice)=="2","Choice without display labels did not inherit values");
        }
        scrFRModCall("mod","Frontier_Options","CustomOptions_save");
        var _values=scrFRModGet("mod","Frontier_Options","options"),_before=json_stringify(_values),
            _old_chance=_values.settingNightEventSpawnChance,_expected_values=json_parse(_before),
            _config="Frontier_Options config.json";
        assert(file_exists(scrFRPrivateFile(_config)),"Frontier source option save did not write its actual private config file");
        var _disk=scrFRJsonDecode(scrFRStringLoad(_config));
        assert(is_struct(_disk) && scrFROptionTestValuesEqual(_expected_values,_disk),
            "Frontier private config file did not retain every source option key/type/value");
        _values.settingNightEventSpawnChance=(_old_chance==0.73)?0.71:0.73;
        assert(_values.settingNightEventSpawnChance!=_old_chance,
            "Frontier reload fixture did not actually perturb its live option value");
        scrFRModCall("mod","Frontier_Options","CustomOptions_load");
        var _loaded=scrFRModGet("mod","Frontier_Options","options"),
            _equal=scrFROptionTestValuesEqual(_expected_values,_loaded);
        if(!_equal) scrNTTESmokeLog("FRONTIER OPTIONS RELOAD expected="+_before+" actual="+json_stringify(_loaded));
        assert(_equal,
            "Frontier options did not survive their private config round trip");
    } finally {
        variable_struct_remove(global.fr_option_pages,_fixture_page);
        for(var _i=0;_i<array_length(_fixture_names);++_i) {
            var _key=scrFROptionFieldKey("mod",_fixture,"fixture",_fixture_names[_i]);
            variable_struct_remove(global.fr_option_fields,_key);variable_struct_remove(global.fr_option_points,_key);
        }
        variable_struct_remove(global.fr_module_vars,_fixture);
        if(instance_exists(_menu)) instance_destroy(_menu,false);
        UberCont.paused=false;
    }
    scrNTTESmokeLog("PASS FRONTIER six pages,32 controls/icons/descriptions,9 default sliders,custom formats and config reload");
    return true;
}
