function scrNTTEFullMenuStatsPresentationNativeTests() {
    var _before=scrNTTEFullInstances(all),_parked=scrNTTEFullInstances([MenuOptions,BackButton]),
        _progress=global.ntte_full_progress,_seed=random_get_seed(),_menu=noone,
        _game=scrNTTEFullAreaGeneratorSnapshot(GameCont),_uber=scrNTTEFullAreaGeneratorSnapshot(UberCont),
        _reminders=variable_global_exists("ntte_full_reminders")?global.ntte_full_reminders:undefined
    for(var _i=0;_i<array_length(_parked);++_i) instance_deactivate_object(_parked[_i])
    global.ntte_full_progress={schema:1,unlocks:{},loadouts:{},stats:{}}
    try {
        GameCont.win=false;UberCont.hardmode=false
        assert(scrNTTEFullMenuAreaText(area_desert)=="1-1"
            && scrNTTEFullMenuAreaText([area_desert,2])=="1-2"
            && scrNTTEFullMenuAreaText([area_vault,1,0])=="???"
            && scrNTTEFullMenuAreaText([area_hq,3,0])=="HQ3"
            && scrNTTEFullMenuAreaText([area_crib,1,0])=="$$$",
            "Source best-area scalar/short-array defaults or secret names changed")
        var _route=string(scrNTTERefSprite("RouteIcon"))
        assert(scrNTTEFullMenuAreaText([201,0,1])=="@1("+_route+":0)1-? L1"
            && scrNTTEFullMenuAreaText(["oasis",1,0])=="@1("+_route+":0)2-1"
            && scrNTTEFullMenuAreaText([205,3,2])=="@1("+_route+":0)3-3 L2"
            && scrNTTEFullMenuAreaText([203,1,0])=="2-@2(sprSlice:0)"
            && scrNTTEFullMenuAreaText([204,1,0])=="2-?"
            && string_pos("@3("+string(scrNTTERefSprite("RedText"))+":-0.8)",scrNTTEFullMenuAreaText([206,1,0]))>0,
            "Source custom-area route/slice/red sprite markup missing")
        for(var _i=1;_i<=3;++_i) assert(scrNTTEFullMenuAreaText([201,_i,0])=="@1("+_route+":0)1-"+string(_i),
            "Original Coast route icon and statistics subarea label changed")
        scrNTTEFullBranchAreaLabelTests()
        UberCont.hardmode=true
        assert(scrNTTEFullMenuAreaText([area_desert,3,4])=="1-3 H4",
            "Best-area formatting lost source hardmode loop prefix")
        GameCont.win=true;GameCont.area=area_desert
        assert(scrNTTEFullMenuAreaText([area_palace,3,1])=="END1 H1"
            && scrNTTEFullMenuAreaText([area_hq,3,0])=="END2"
            && scrNTTEFullMenuAreaText([area_desert,2,0])=="1-2",
            "Source victory formatting used current room instead of displayed area")
        GameCont.win=false;UberCont.hardmode=false
        var _base=scrNTTEFullMenuMimicCollection([]),
            _variants=scrNTTEFullMenuMimicCollection([wep_revolver,wep_ntte_teleport_gun,
                wep_ntte_golden_teleport_gun,wep_ntte_ancient_artifact,wep_ntte_bone]),
            _single=scrNTTEFullMenuMimicCollection([wep_revolver,wep_ntte_teleport_gun,wep_ntte_bone])
        assert(_variants.stored==3 && _variants.total==_single.total && _variants.text==_single.text,
            "Mimic collection double-counted native modes of one source module")
        var _new=scrNTTEFullMenuMimicCollection([wep_ntte_harpoon_launcher]),
            _invalid=scrNTTEFullMenuMimicCollection([128,"unknown-module"]),
            _none=scrNTTEFullMenuMimicCollection([wep_none])
        assert(_new.stored==1 && _new.total==_base.total+1
            && _invalid.stored==0 && _invalid.total==_base.total
            && _none.stored==1 && _none.total==_base.total+1,
            "Mimic source collected/locked-module/extra-Epsilon-ID/none rules changed")
        var _full=[],_table=scrNTTEFullWeaponDropTable()
        for(var _w=0;_w<128;++_w) array_push(_full,_w)
        for(var _i=0;_i<array_length(_table);++_i) array_push(_full,_table[_i].raw)
        var _complete=scrNTTEFullMenuMimicCollection(_full),_count=128+array_length(_table)
        assert(_complete.stored==_count && _complete.total==_count
            && _complete.text=="@q"+string(_count)+"/"+string(_count)+"!",
            "Mimic complete source collection lost sparkling ratio/exclamation")
        global.ntte_full_progress.stats[$ "pet:Mimic.petlib.mod"]={found:1,owned:61,weapons:[wep_revolver,wep_ntte_bone]}
        global.ntte_full_progress.stats[$ "pet:Cuz.petlib.mod"]={found:1,owned:3661,playtime:61}
        global.ntte_full_progress.stats[$ "pet:Weapon.petlib.mod"]={found:1,owned:0,battle:[7,2]}
        global.ntte_full_progress.stats[$ "pet:Twins.petlib.mod"]={found:1,owned:0}
        global.ntte_full_progress.stats[$ "pet:Octo.petlib.mod"]={found:1,owned:0,arcing:61}
        global.ntte_full_progress.stats[$ "race:beetle:best:area"]=[205,3,2]
        _menu=instance_create(0,0,MenuOptions)
        assert(scrNTTEFullMenuStatText("race:beetle:best:area","area")=="@1("+_route+":0)3-3 L2",
            "Actual native menu stat entry did not delegate rich source area formatter")
        var _rows=_menu.options[OptionCategory.NTTE_Pets],_mimic=undefined,_cuz=undefined
        for(var _i=0;_i<array_length(_rows);++_i) {
            assert(is_method(_rows[_i].draw),"Actual pet collection row omitted native source icon renderer")
            if(_rows[_i].ntte_pet=="Mimic") _mimic=_rows[_i]
            if(_rows[_i].ntte_pet=="Cuz") _cuz=_rows[_i]
        }
        var _pets_before=instance_number(NTTEFullPet),_prompts=instance_number(NTTEFullPrompt),
            _stats_before=json_stringify(global.ntte_full_progress.stats),_saved_drawx=_menu.drawx,_saved_drawy=_menu.drawy
        with(_menu) {drawx=160;drawy=80;}
        // Epsilon's method_execute deliberately rebinds its method to the
        // caller id. Dispatch in the actual UI owner, exactly as Other_10.
        with(_menu) method_execute(_mimic.draw,_mimic)
        with(_menu) method_execute(_mimic.click,_mimic)
        var _detail=_menu.options[OptionCategory.NTTE_PetDetails],_weapons=undefined
        assert(_menu.category==OptionCategory.NTTE_PetDetails && array_length(_detail)==4
            && is_method(_detail[0].draw) && _detail[0].height>=sprite_get_height(scrNTTERefSprite("PetMimicIdle")),
            "Actual Mimic row click omitted source animated idle preview or saved stats")
        with(_menu) method_execute(_detail[0].draw,_detail[0])
        for(var _i=1;_i<array_length(_detail);++_i) if(_detail[_i].ntte_key=="weapons") _weapons=_detail[_i]
        assert(!is_undefined(_weapons),"Actual native Mimic detail page omitted weapons field")
        var _weapons_text=""
        with(_menu) _weapons_text=method_execute(_weapons.get_value,_weapons)
        assert(_weapons_text==scrNTTEFullMenuMimicCollection([wep_revolver,wep_ntte_bone]).text,
            "Actual native Mimic detail callback still displayed only array length")
        with(_menu) method_execute(_cuz.click,_cuz)
        assert(array_length(_menu.options[OptionCategory.NTTE_PetDetails])==4
            && scrNTTEFullMenuPetPreviewSprite("Cuz")==sprCuzIdle
            && scrNTTEFullMenuPetPreviewSprite("Twins")==scrNTTERefSprite("PetTwinsStat")
            && scrNTTEFullMenuPetValue("Cuz","owned")=="1:01:01"
            && scrNTTEFullMenuPetValue("Cuz","playtime")=="0:01:01"
            && scrNTTEFullMenuPetValue("Octo","arcing")=="0:01:01",
            "Source species stat preview/time formatting changed")
        with(_menu) scrNTTEFullMenuPetPage("Weapon")
        _detail=_menu.options[OptionCategory.NTTE_PetDetails]
        var _battle=undefined
        for(var _i=1;_i<array_length(_detail);++_i) if(_detail[_i].ntte_key=="battle") _battle=_detail[_i]
        var _battle_name="",_battle_text=""
        with(_menu) {
            _battle_name=method_execute(_battle.get_name,_battle)
            _battle_text=method_execute(_battle.get_value,_battle)
        }
        assert(_battle_name=="@5("+string(scrNTTERefSprite("PetWeaponStat"))+")"
            && _battle_text=="7-2",
            "Weapon pet battle statistic lost its source sprite label or paired result")
        assert(string_pos("cursed",scrNTTEFullMenuPetStatLabel("Spider","cursed"))>0,
            "Spider source special stat label omitted its saved field")
        assert(instance_number(NTTEFullPet)==_pets_before && instance_number(NTTEFullPrompt)==_prompts
            && json_stringify(global.ntte_full_progress.stats)==_stats_before,
            "Viewing pet statistics constructed gameplay pets/prompts or changed saved stats")
        with(_menu) {drawx=_saved_drawx;drawy=_saved_drawy;}
    }
    finally {
        scrNTTEFullMergedRuntimeTestCleanup(_before)
        for(var _i=0;_i<array_length(_parked);++_i) instance_activate_object(_parked[_i])
        global.ntte_full_progress=_progress
        global.ntte_full_reminders=_reminders
        scrNTTEFullAreaGeneratorRestore(_game);scrNTTEFullAreaGeneratorRestore(_uber);random_set_seed(_seed)
    }
    scrNTTESmokeLog("SOURCE MENU STATS PRESENTATION: real native collection-row click/callbacks/animated pure preview, Mimic canonical source ratio/complete display, pet special stats and rich best-area names OK @"+string(30/timescale))
}

// Checks real consumer entry points and the native rich-text parser/renderer;
// expected strings and sprite identities are independently copied from MOD.
function scrNTTEFullBranchAreaLabelTests() {
    var _game=scrNTTEFullAreaGeneratorSnapshot(GameCont),_uber=scrNTTEFullAreaGeneratorSnapshot(UberCont),
        _language=global.language_current,_small=global.language_font_default,
        _big=global.language_font_bigname_default,_draw=scrNTTEFullCoastDrawState(),
        _font=draw_get_font(),_ha=draw_get_halign(),_va=draw_get_valign(),
        _shader=shader_current(),_surface=-1,_camera=-1,_target=false,
        _route=scrNTTERefSprite("RouteIcon"),_red=scrNTTERefSprite("RedText"),
        _seed=random_get_seed(),_progress=json_stringify(global.ntte_full_progress),
        _fixtures=[]
    for(var _i=1;_i<=3;++_i)
        array_push(_fixtures,{area:201,key:"coast",sub:_i,text:"@1("+string(_route)+":0)1-"+string(_i),
            plain:"1-"+string(_i),sprite:_route,slots:1,frame:0})
    array_push(_fixtures,{area:201,key:"coast",sub:0,text:"@1("+string(_route)+":0)1-?",
        plain:"1-?",sprite:_route,slots:1,frame:0})
    array_push(_fixtures,{area:202,key:"oasis",sub:1,text:"@1("+string(_route)+":0)2-1",
        plain:"2-1",sprite:_route,slots:1,frame:0})
    array_push(_fixtures,{area:203,key:"pizza",sub:1,text:"2-@2(sprSlice:0)",
        plain:"2-",sprite:sprSlice,slots:2,frame:0})
    array_push(_fixtures,{area:204,key:"lair",sub:1,text:"2-?",
        plain:"2-?",sprite:-1,slots:0,frame:0})
    for(var _i=1;_i<=3;++_i)
        array_push(_fixtures,{area:205,key:"trench",sub:_i,text:"@1("+string(_route)+":0)3-"+string(_i),
            plain:"3-"+string(_i),sprite:_route,slots:1,frame:0})
    array_push(_fixtures,{area:206,key:"red",sub:1,
        text:"@(color:"+string(scrAreaGetBackroundColor(206))+")@3("+string(_red)+":-0.8)",
        plain:"",sprite:_red,slots:3,frame:-0.8})
    gpu_push_state()
    try {
        GameCont.win=false;UberCont.hardmode=false
        _surface=surface_create(320,240)
        assert(surface_exists(_surface),"Branch label evidence surface unavailable")
        _camera=camera_create_view(0,0,320,240,0,noone,-1,-1,-1,-1)
        surface_set_target(_surface);_target=true;camera_apply(_camera)
        matrix_set(matrix_world,matrix_build_identity());shader_reset()
        gpu_set_blendmode(bm_normal);gpu_set_texfilter(false);gpu_set_fog(false,c_white,0,0)
        draw_clear_alpha(c_black,1);draw_set_color(c_white);draw_set_alpha(1)
        draw_set_halign(fa_left);draw_set_valign(fa_top)
        var _languages=["English","Simplified Chinese"]
        for(var _lang=0;_lang<array_length(_languages);++_lang) {
            scrLanguageSet(_languages[_lang]);draw_set_font(global.language_font_default)
            for(var _i=0;_i<array_length(_fixtures);++_i) {
                var _f=_fixtures[_i],_label=scrAreaGetMapName(_f.area,_f.sub,0,false,true)
                assert(_label==_f.text
                    && scrAreaGetMapName(_f.area,_f.sub,0,false,false)==_f.text
                    && scrNTTEFullMenuAreaText([_f.area,_f.sub,0])==_f.text
                    && scrNTTEFullMenuAreaText([_f.key,_f.sub,0])==_f.text
                    && scrNTTEFullWarpAreaName(_f.area,_f.sub,0)==_f.text,
                    "Original branch label differs between language/HUD/roadmap/statistics/Warp: "+_f.key)
                assert(scrAreaGetMapName(_f.area,_f.sub,2,false,false)==_f.text+" L2"
                    && scrAreaGetMapName(_f.area,_f.sub,2,true,false)==_f.text+" H2",
                    "Branch icon label lost explicit loop/hardmode suffix")
                var _parsed=render_parse_text(_label),_icons=0,_plain=""
                for(var _line=0;_line<array_length(_parsed.lines);++_line) {
                    var _parts=_parsed.lines[_line].strings
                    for(var _p=0;_p<array_length(_parts);++_p) {
                        var _part=_parts[_p]
                        if(_part.type==TextRenderFragment.String) _plain+=_part.string
                        if(_part.type==TextRenderFragment.Sprite) {
                            _icons++
                            assert(_part.sprite_index==_f.sprite && _part.image_index==_f.frame
                                && _part.ntt_slots==_f.slots
                                && _part.ntt_width==_f.slots*font_get_string_width("A"),
                                "Branch icon failed native sprite resolution/frame/slot layout: "+_f.key)
                        }
                    }
                }
                assert(_plain==_f.plain && _icons==(_f.slots>0?1:0)
                    && _parsed.width==font_get_string_width(_f.plain)+_f.slots*font_get_string_width("A"),
                    "Branch HUD printed literal sprite markup or wrong number/width: "+_f.key)
                draw_text_nt(8+_lang*160,8+_i*20,_label)
            }
        }
        surface_reset_target();_target=false
        var _pixels=0
        for(var _y=0;_y<240;++_y) for(var _x=0;_x<320;++_x)
            if(surface_getpixel(_surface,_x,_y)!=c_black) _pixels++
        assert(_pixels>100,"Actual branch label renderer produced no visible evidence")
        var _path=working_directory+"ntte-branch-area-labels-"+string(30/timescale)+".png"
        surface_save(_surface,_path)
        assert(random_get_seed()==_seed && json_stringify(global.ntte_full_progress)==_progress,
            "Formatting branch labels mutated gameplay RNG or progress")
        scrNTTESmokeLog("BRANCH AREA LABEL IMAGE "+_path)
    } finally {
        if(_target) surface_reset_target()
        if(surface_exists(_surface)) surface_free(_surface)
        if(_camera>=0) camera_destroy(_camera)
        global.language_current=_language;global.language_font_default=_small;global.language_font_bigname_default=_big
        scrNTTEFullAreaGeneratorRestore(_game);scrNTTEFullAreaGeneratorRestore(_uber)
        gpu_pop_state();matrix_set(matrix_world,_draw.world);matrix_set(matrix_view,_draw.view);matrix_set(matrix_projection,_draw.projection)
        if(_draw.target>=0) surface_set_target(_draw.target)
        if(_shader>=0) shader_set(_shader);else shader_reset()
        draw_set_font(_font);draw_set_halign(_ha);draw_set_valign(_va)
        draw_set_color(_draw.color);draw_set_alpha(_draw.alpha)
        random_set_seed(_seed)
    }
    scrNTTESmokeLog("BRANCH AREA LABELS: original Coast/Oasis/Trench route icon+numbers, Pizza slice, Lair and animated Red label; real HUD/roadmap/stat/Warp queries, English/Chinese native parser+Draw and loop suffixes OK @"+string(30/timescale))
}

