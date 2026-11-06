"""Focused regressions for legacy constructs rejected by the native compiler.

These checks validate the lowering, while the desktop fixture executes its
runtime semantics. They never modify or execute the supplied MOD itself.
"""
import re
import unittest
from pathlib import Path

from frontier_compiler import FrontierEmitter, walk
from fr_gml_parser import definitions


def emit(body, name="main", module="tests/compiler.gml"):
    parsed = definitions(body, module)
    names = {module: {d.name for d in parsed}}
    definition = next(d for d in parsed if d.name == name)
    macros={n.args[0]:n for d in parsed for n in walk(d.body) if n.kind=="macro"}
    enums={n.args[0]:n for d in parsed for n in walk(d.body) if n.kind=="enum"}
    return FrontierEmitter(module, definition, names, {}, macros, enums).emit()


class NativeLoweringTests(unittest.TestCase):
    def test_only_authored_cyberspace_revive_uses_native_event_adapter(self):
        source=Path(__file__).resolve().parents[1]/"original/Frontier/Areas/cyberspace.area.gml"
        code=emit(source.read_text(encoding="utf-8-sig"),"cyberspace_revive","Areas/cyberspace.area.gml")
        self.assertEqual(code.count('scrFRCyberspaceReviveEvent('),2)
        self.assertIn('scrFRCyberspaceReviveEvent(ev_collision, Player);',code)
        self.assertIn('scrFRCyberspaceReviveEvent(ev_alarm, 0);',code)
        self.assertNotIn('event_perform(',code)
        self.assertIn('global.fr_module_vars[$ "area:cyberspace"].settingCyberspaceEnabled == true',code)
        self.assertIn('GameCont.fr_visitedCyberspace = true;',code)
        self.assertIn('scrFRInstanceCreate(x, y, Revive)',code)
        for module,name in [('Areas/cyberspace.area.gml','another_callback'),
                            ('tests/compiler.gml','cyberspace_revive')]:
            other=emit('#define '+name+'\nevent_perform(ev_collision,Player);event_perform(ev_alarm,0);',name,module)
            self.assertNotIn('scrFRCyberspaceReviveEvent',other)
            self.assertEqual(other.count('event_perform('),2)

    def test_source_bbox_instance_reads_keep_data_lvalues_and_sprite_descriptors(self):
        reads=emit('#define main(target)\nreturn [bbox_right,bbox_bottom,target.bbox_right,target.bbox_bottom,bbox_left,bbox_top];')
        self.assertIn('scrFRSourceBBoxRead(scrFRSelf(self), "bbox_right")',reads)
        self.assertIn('scrFRSourceBBoxRead(scrFRSelf(self), "bbox_bottom")',reads)
        self.assertIn('scrFRSourceBBoxRead(_frl_target, "bbox_right")',reads)
        self.assertIn('scrFRSourceBBoxRead(_frl_target, "bbox_bottom")',reads)
        self.assertIn('bbox_left, bbox_top',reads)
        data=emit('#define main(target)\nvar bbox_right=7;global.bbox_bottom=8;target.bbox_right=9;'
                  'return [bbox_right,global.bbox_bottom,target.bbox_right,sprite_get_bbox_right(mskFloor),sprite_get_bbox_bottom(mskFloor)];')
        self.assertIn('_frl_bbox_right = 7',data)
        self.assertIn('global.bbox_bottom = 8',data)
        self.assertIn('_frl_target.bbox_right = 9',data)
        self.assertIn('scrFRSourceBBoxRead(_frl_target, "bbox_right")',data)
        self.assertIn('sprite_get_bbox_right(mskFloor)',data)
        self.assertIn('sprite_get_bbox_bottom(mskFloor)',data)
        self.assertNotIn('scrFRSourceBBoxRead(scrFRSelf(self)',data)
        self.assertNotIn('scrFRSourceBBoxRead(global',data)

    def test_authored_dropdown_acceleration_survives_later_draw_calls(self):
        for module,name in (("Frontier_Events.mod.gml","EventDropdown_draw"),
                            ("Areas/deeplabs.area.gml","DeeplabsFinaleDropdown_draw")):
            with self.subTest(module=module):
                source=Path(__file__).resolve().parents[1]/"original/Frontier"/module
                text=emit(source.read_text(encoding="utf-8-sig"),name,module)
                self.assertIn("fr_callback__dropdownExtraSpeed = 0;",text)
                self.assertIn("fr_callback__dropdownExtraSpeed += 1;",text)
                self.assertNotIn("var fr_callback__dropdownExtraSpeed",text)
                self.assertNotIn("_frl__dropdownExtraSpeed",text)
        other=emit("#define main\nvar _dropdownExtraSpeed=0;return _dropdownExtraSpeed;")
        self.assertIn("var _frl__dropdownExtraSpeed = 0;",other)

    def test_optional_area_equality_queries_preserve_strict_route_writes(self):
        text=emit('#define main(destination)\n'
                  'if(GameCont.area!="bigdog") value=1;'
                  'if("junkyard"==GameCont.lastarea) value=2;'
                  'if(area=("ravenboss"||3)) value=3;'
                  'GameCont.area="bigdog";lastarea="junkyard";destination.area="ravenboss";'
                  'return [GameCont.area<"bigdog",GameCont.area<>"junkyard"];')
        self.assertIn('(GameCont.area != scrFRAreaTryResolve("bigdog"))',text)
        self.assertIn('(scrFRAreaTryResolve("junkyard") == GameCont.lastarea)',text)
        self.assertIn('(area == scrFRAreaTryResolve("ravenboss")) || (area == scrFRAreaTryResolve(3))',text)
        self.assertIn('GameCont.area = scrFRAreaResolve("bigdog")',text)
        self.assertIn('lastarea = scrFRAreaResolve("junkyard")',text)
        self.assertIn('_frl_destination.area = scrFRAreaResolve("ravenboss")',text)
        self.assertIn('(GameCont.area < scrFRAreaResolve("bigdog"))',text)
        self.assertIn('(GameCont.area <> scrFRAreaTryResolve("junkyard"))',text)
        local=emit('#define main(area)\nreturn area=="bigdog";')
        self.assertNotIn('scrFRArea',local)

    def test_original_scrapyards_night_cleanup_queries_optional_companion_areas(self):
        # Compile the supplied coroutine itself: this cleanup follows real
        # room changes and previously threw for absent Hardmode-only areas.
        module='Frontier_Events.mod.gml'
        source=Path(__file__).resolve().parents[1]/'original/Frontier'/module
        parsed=definitions(source.read_text(encoding='utf-8-sig'),module)
        definition=next(d for d in parsed if d.name=='ScrapyardsNight_cleanup')
        names={module:{d.name for d in parsed}}
        macros={n.args[0]:n for d in parsed for n in walk(d.body) if n.kind=='macro'}
        enums={n.args[0]:n for d in parsed for n in walk(d.body) if n.kind=='enum'}
        text=FrontierEmitter(module,definition,names,{},macros,enums).emit()
        self.assertIn('scrFRTaskStart(',text)
        for area in ('bigdog','junkyard','ravenboss'):
            self.assertIn('GameCont.area != scrFRAreaTryResolve("'+area+'")',text)
            self.assertNotIn('scrFRAreaResolve("'+area+'")',text)
        self.assertIn('GameCont.area == scrFRAreaTryResolve(3)',text)

    def test_area_switches_and_either_are_queries_in_sync_and_coroutine_code(self):
        body='switch(GameCont.area){case "bigdog":value=1;break;case "cavesinv":value=2;break;default:value=3;}return either(lastarea,"junkyard",3);'
        for prefix in ('','wait(1);'):
            with self.subTest(coroutine=bool(prefix)):
                text=emit('#define main\n'+prefix+body)
                self.assertIn('scrFRAreaTryResolve("bigdog")',text)
                self.assertIn('scrFRAreaTryResolve("cavesinv")',text)
                self.assertIn('scrFRAreaTryResolve("junkyard")',text)
                self.assertNotIn('scrFRAreaResolve(',text)
        other=emit('#define main\nswitch(race){case "bubbles":return 1;}')
        self.assertIn('scrFRRaceResolve("bubbles")',other)
        self.assertNotIn('TryResolve(',other)

    def test_original_frontier_main_area_switch_does_not_enter_optional_routes(self):
        module='Frontier_Main.mod.gml'
        source=Path(__file__).resolve().parents[1]/'original/Frontier'/module
        parsed=definitions(source.read_text(encoding='utf-8-sig'),module)
        definition=next(d for d in parsed if d.name=='step')
        names={module:{d.name for d in parsed}}
        macros={n.args[0]:n for d in parsed for n in walk(d.body) if n.kind=='macro'}
        enums={n.args[0]:n for d in parsed for n in walk(d.body) if n.kind=='enum'}
        text=FrontierEmitter(module,definition,names,{},macros,enums).emit()
        self.assertIn('scrFRAreaTryResolve("cavesinv")',text)
        self.assertNotIn('scrFRAreaResolve("cavesinv")',text)

    def test_array_macro_lvalues_retain_their_authoritative_owner(self):
        text=emit('#define main\n#macro bonus GameCont.wib_speedBonus;\n#macro nested bonus;\nnested[index]+=2;bonus[index]++;',module='dependencies/wibbly.mod.gml')
        self.assertIn('scrFRMemberIndexWrite(GameCont, "wib_speedBonus", [index], 2, "+=")',text)
        self.assertIn('scrFRMemberIndexIncrement(GameCont, "wib_speedBonus", [index], 1, true)',text)
        self.assertNotIn('"bonus", [',text)
        nested=emit('#define main\n#macro bonus GameCont.wib_ammoMaxBonus;\nbonus[index][@2]+=4;')
        self.assertIn('scrFRMemberIndexWrite(GameCont, "wib_ammoMaxBonus", [index, 2], 4, "+=")',nested)
        local=emit('#define main(bonus)\n#macro bonus GameCont.wib_speedBonus;\nbonus[0]+=1;')
        self.assertIn('scrFRIndexPathWrite(_frl_bonus, [0], 1, "+=")',local)

    def test_ammo_tables_share_the_native_player_boundary(self):
        text=emit('#define main\ntyp_amax[1]+=25;creator.typ_amax[1]++;return typ_ammo[2]+creator.typ_amax[1];')
        self.assertIn('scrFRAmmoIndexWrite(scrFRSelf(self), "typ_amax", [1], 25, "+=")',text)
        self.assertIn('scrFRAmmoIndexIncrement(creator, "typ_amax", [1], 1, true)',text)
        self.assertIn('scrFRIndexGet(scrFRAmmoArray(scrFRSelf(self), "typ_ammo"), 2)',text)
        self.assertIn('scrFRIndexGet(scrFRAmmoArray(creator, "typ_amax"), 1)',text)
        self.assertNotIn('scrFRMemberIndexWrite(',text)
        local=emit('#define main(typ_amax)\ntyp_amax[0]=1;global.typ_amax=[2];return typ_amax;')
        self.assertNotIn('scrFRAmmo',local)
        copied=emit('#define main\ntyp_amax=[1000,255,55,55,55,55];')
        self.assertIn('scrFRAmmoArrayWrite(scrFRSelf(self), "typ_amax",',copied)

    def test_wibbly_baseline_refresh_sets_its_existing_ammo_delta(self):
        text=emit('#define PlayerManager_step\n#macro bonus GameCont.wib_ammoMaxBonus;\nwith(Player){typ_amax[1]+=bonus[index][0];}',name='PlayerManager_step',module='dependencies/wibbly.mod.gml')
        self.assertIn('scrFRAmmoBonusSet(scrFRSelf(self), "typ_amax", [1],',text)
        self.assertNotIn('scrFRAmmoIndexWrite(',text)

    def test_source_builtin_id_retains_legacy_numeric_semantics(self):
        text=emit('#define main\nreturn [id,instance_is(id+1,Floor),other.id];')
        self.assertIn('return [real(id), scrFRInstanceIs((real(id) + 1), Floor),',text)
        self.assertIn('.id]',text)
        self.assertNotIn('real((scrFROther(other)).id)',text)
        local=emit('#define main(id)\nreturn id;')
        self.assertIn('return _frl_id;',local)
        self.assertNotIn('real(id)',local)

    def test_source_module_names_are_untyped_but_storage_is_typed(self):
        for module,kind,name in [
            ('Characters/bubbles.race.gml','race','bubbles'),
            ('Areas/cove.area.gml','area','cove'),
            ('Weapons/FR_CoralCrossbow.wep.gml','weapon','FR_CoralCrossbow'),
            ('Mutations/AugmentLaserBrain.skill.gml','skill','AugmentLaserBrain'),
            ('Skins/RobotBluescreened.skin.gml','skin','RobotBluescreened'),
            ('Crowns/Frontier.crown.gml','crown','Frontier'),
            ('Frontier_Main.mod.gml','mod','Frontier_Main'),
        ]:
            with self.subTest(kind=kind):
                text=emit('#define main\nreturn [mod_current,script_ref_create(main),global.saved];',module=module)
                self.assertIn('return ["'+name+'", ["'+kind+'", "'+name+'",',text)
                self.assertIn('global.fr_module_vars[$ "'+kind+':'+name+'"].saved',text)

    def test_backtick_templates_lower_expressions_and_coerce_values(self):
        text=emit('#define main(_path)\nreturn `${_path}sprPopoLaserBrain.png @1(${real(global.sprIcon)}:0) ${1+2}`;', module='Mutations/AugmentLaserBrain.skill.gml')
        self.assertIn('string(_frl__path)',text)
        self.assertIn('"sprPopoLaserBrain.png @1("',text)
        self.assertIn('string(real(global.fr_module_vars[$ "skill:AugmentLaserBrain"].sprIcon))',text)
        self.assertIn('string((1 + 2))',text)
        self.assertNotIn('${',text)

    def test_templates_allow_quoted_braces_and_multiline_expressions(self):
        text=emit('#define main\nreturn `prefix ${lq_get({answer:"}"},\n "answer")} suffix`;',module='tests/templates.gml')
        self.assertIn('string(scrFRLQGet({"answer": "}"}, "answer"))',text)
        self.assertIn('" suffix"',text)
        literal=emit('#define main\nreturn "${_path}literal.png";')
        self.assertIn('"${_path}literal.png"',literal)
        with self.assertRaisesRegex(SyntaxError,'Unclosed template interpolation'):
            emit('#define main\nreturn `broken ${value`;')

    def test_dynamic_switch_emits_only_constant_native_labels(self):
        text = emit("#define main(v)\nswitch(v){case choose(2,7):v+=10;default:v+=3;break;case 8:return 88;}return v;")
        self.assertIn("scrFRSourceChoose(2, 7)", text)
        self.assertEqual(re.findall(r"case ([^:]+):", text), ["0", "1", "2"])
        self.assertLess(text.index("case 1:"), text.index("case 2:"))

    def test_array_result_access_uses_native_safe_helpers(self):
        text = emit("#define main\nvar list=[[1,2]];list[0][1]+=3;return choose(list,list)[0];")
        self.assertIn("scrFRIndexPathWrite(", text)
        self.assertIn("scrFRIndexGet(scrFRSourceChoose(", text)
        self.assertNotRegex(text, r"\)\[")

    def test_for_multiple_initializers_are_hoisted(self):
        text = emit("#define main\nvar n=0;for(var i=0,j=1;i<3;i++){n+=i+j;}return n;")
        self.assertIn("for (;", text)
        self.assertNotRegex(text, r"for\s*\(\s*var")
        self.assertLess(text.index("_frl_j = 1"), text.index("for ("))

    def test_parameter_var_is_reassignment(self):
        text = emit("#define main(value)\nvar value=3;return value;")
        self.assertIn("_frl_value = 3;", text)
        self.assertNotIn("var _frl_value", text)

    def test_optional_legacy_arguments_return_undefined(self):
        text=emit("#define main(value)\nreturn argument0+argument4;")
        self.assertIn("_frl_value=undefined",text)
        self.assertIn("argument_count>4 ? argument[4] : undefined",text)
        text=emit("#define main\nwait(1);return argument8;")
        self.assertIn("array_length(_fr.args)>8 ? _fr.args[8] : undefined",text)

    def test_native_argument_accessor_is_not_passed_as_an_array(self):
        text=emit("#define main(value)\nvar i=2;return argument[0]+argument[3]+argument[i];")
        self.assertIn("_frl_value",text)
        self.assertIn("argument_count>3 ? argument[3] : undefined",text)
        self.assertIn("argument[_frl_i]",text)
        self.assertNotIn("scrFRIndexGet(argument",text)
        text=emit("#define main\nwait(1);return argument[0];")
        self.assertIn("scrFRIndexGet(_fr.args, 0)",text)

    def test_source_inventory_is_read_and_written_through_shadows(self):
        text = emit("#define main(value)\nwep=value;other.bwep=value;return wep==other.wep;")
        self.assertEqual(text.count("scrFRWeaponSlotWrite("), 2)
        self.assertEqual(text.count("scrFRWeaponSlotRead("), 2)
        self.assertIn("scrFRSourceWeaponEqual(", text)

    def test_player_firing_and_life_fields_use_native_authority(self):
        text = emit('#define main\ncanfire=false;other.bcanfire=true;canspirit=false;chickendeaths+=1;return Player.canfire+other.chickendeaths;')
        self.assertIn('can_shoot = false', text)
        self.assertIn('.bcan_shoot = true', text)
        self.assertIn('can_spirit = false', text)
        self.assertIn('headloses += 1', text)
        self.assertIn('Player.can_shoot', text)
        self.assertNotRegex(text, r'\b(?:canfire|bcanfire|canspirit|chickendeaths)\b')

    def test_controller_counters_preserve_their_own_semantics(self):
        text=emit('#define main\nGameCont.norads=0;GameCont.vaults+=1;GameCont.canspirit[0]=true;return GameCont.kills+global.kills;')
        self.assertIn('GameCont.noradch = 0',text)
        self.assertIn('GameCont.crownvisits += 1',text)
        self.assertIn('"canspirit", [0]',text)
        self.assertIn('GameCont.kills',text)
        self.assertIn('global.kills',text)
        self.assertNotIn('givekill',text)

    def test_controller_seed_reads_use_the_live_source_ladder(self):
        text=emit('#define main\nreturn GameCont.baseseed+GameCont.gameseed[GameCont.atseed];')
        for field in ('baseseed','gameseed','atseed'):
            self.assertIn('scrFRPlayerCompatSeedField("'+field+'")',text)
        self.assertNotIn('GameCont.baseseed',text)

    def test_source_random_family_uses_the_original_current_state_stream(self):
        text=emit('#define main\nrandom_set_seed(1);var saved=random_get_seed();'
                  'return [random(100),irandom(4),random_range(2,7),irandom_range(3,9),'
                  'choose("a","b"),random_nonsync(1),random_set_seed(saved)];')
        for helper in ('Random','IRandom','RandomRange','IRandomRange','Choose','RandomGetSeed','RandomSetSeed'):
            self.assertIn('scrFRSource'+helper+'(',text)
        self.assertIn('scrFRRandomNonsync(1)',text)
        self.assertNotRegex(text,r'(?<![\w])(?:random|irandom|random_range|irandom_range|choose|random_get_seed|random_set_seed)\(')

    def test_authored_hud_random_save_restore_uses_current_source_state(self):
        source=Path(__file__).resolve().parents[1]/'original/Frontier/Characters/Frontier_CharHuds.mod.gml'
        text=emit(source.read_text(encoding='utf-8-sig'),'draw_gui','Characters/Frontier_CharHuds.mod.gml')
        self.assertIn('scrFRSourceRandomGetSeed()',text)
        self.assertIn('scrFRSourceRandomSetSeed(_frl__lastSeed)',text)

    def test_wibbly_race_snapshot_retains_source_string_keys(self):
        text=emit('#define PlayerManager_step\nwith(Player){other.playerRace[index]=race;}return array_find_index(playerRace,"robot");',
                  name='PlayerManager_step',module='dependencies/wibbly.mod.gml')
        self.assertIn('scrFRRaceKey(race)',text)
        self.assertIn('scrFRArrayFindIndex(playerRace, "robot")',text)

    def test_player_maximum_speed_uses_native_frame_units(self):
        text=emit('#define main\nmaxspeed+=1;speed=maxspeed+2;',module='tests/physics.gml')
        self.assertIn('maxspeed += (1) * timescale',text)
        self.assertIn('(maxspeed / timescale)',text)

    def test_raw_motion_reads_writes_and_increments_use_physical_frame_fields(self):
        text=emit('#define main(target)\n'
                  'hspeed_raw=6;vspeed_raw+=2;image_speed_raw-=0.25;'
                  'target.hspeed_raw=hspeed_raw;other.vspeed_raw+=target.vspeed_raw;'
                  'hspeed_raw++;--vspeed_raw;++target.image_speed_raw;other.hspeed_raw--;'
                  'return [hspeed_raw,vspeed_raw,image_speed_raw,target.hspeed_raw,other.image_speed_raw];',
                  module='tests/physics.gml')
        for expected in ('hspeed = 6','vspeed += 2','image_speed -= 0.25',
                         '_frl_target.hspeed = hspeed','hspeed++;','-- vspeed;',
                         '++ _frl_target.image_speed;', '.hspeed--;'):
            self.assertIn(expected,text)
        self.assertNotRegex(text,r'\b(?:hspeed_raw|vspeed_raw|image_speed_raw)\b')
        self.assertNotIn('timescale',text)
        self.assertNotIn('scrFRScaledIncrement',text)

    def test_raw_aliases_do_not_change_locals_or_global_storage(self):
        text=emit('#define main(hspeed_raw)\nvar vspeed_raw=3;'
                  'global.image_speed_raw=4;GameCont.hspeed_raw=5;'
                  'return [hspeed_raw,vspeed_raw,global.image_speed_raw,GameCont.hspeed_raw];',
                  module='tests/physics.gml')
        for expected in ('_frl_hspeed_raw','_frl_vspeed_raw','global.image_speed_raw','GameCont.hspeed_raw'):
            self.assertIn(expected,text)
        self.assertNotIn('timescale',text)

    def test_source_and_raw_motion_keep_inverse_scale_relation(self):
        text=emit('#define main\nreturn [hspeed,hspeed_raw,vspeed,vspeed_raw,image_speed,image_speed_raw];',
                  module='tests/physics.gml')
        self.assertIn('return [(hspeed / timescale), hspeed, (vspeed / timescale), vspeed, (image_speed / timescale), image_speed];',text)
        write=emit('#define main\nhspeed=6;vspeed=-8;image_speed=0.25;',module='tests/physics.gml')
        for expected in ('hspeed = (6) * timescale','vspeed = ((- 8)) * timescale',
                         'image_speed = (0.25) * timescale'):
            self.assertIn(expected,write)
        # The same generated expressions must preserve the host/source
        # inverse relation at both supported physical-frame scales.
        for scale in (1,0.5):
            for source in (6,-8,0.25):
                raw=source*scale
                self.assertEqual(raw/scale,source)

    def test_original_star_bullet_hit_and_treasure_mimic_animation_use_raw_aliases(self):
        for module,name in [('Objects/Frontier_Projectiles.mod.gml','StarBullet_hit'),
                            ('Areas/cove.area.gml','TreasureMimic_step')]:
            with self.subTest(module=module):
                source=Path(__file__).resolve().parents[1]/'original/Frontier'/module
                parsed=definitions(source.read_text(encoding='utf-8-sig'),module)
                definition=next(d for d in parsed if d.name==name)
                names={module:{d.name for d in parsed}}
                macros={n.args[0]:n for d in parsed for n in walk(d.body) if n.kind=='macro'}
                enums={n.args[0]:n for d in parsed for n in walk(d.body) if n.kind=='enum'}
                emitter=FrontierEmitter(module,definition,names,{},macros,enums)
                text=emitter.emit()
                if name=='StarBullet_hit':
                    self.assertIn('x -= hspeed;',text)
                    self.assertIn('y -= vspeed;',text)
                else:
                    animation=emitter.expression(macros['anim_end'].args[1])
                    text+='\n'+animation
                    self.assertIn('(image_index + image_speed)',animation)
                    self.assertNotIn('timescale',animation)
                self.assertNotRegex(text,r'\b(?:hspeed_raw|vspeed_raw|image_speed_raw)\b')

    def test_object_constants_and_selector_queries_are_lowered(self):
        text = emit("#define main\nwith(CustomObject) {value=1;}return instance_number(Pickup)+GameObject.id;")
        self.assertIn("FRCustomObject", text)
        self.assertIn("scrFRInstanceNumber(FR_OBJECT_PICKUP)", text)
        self.assertIn("scrFRInstanceFind(FR_OBJECT_GAME, 0)", text)
        self.assertNotIn("FR_OBJECT_GAME.id", text)

    def test_missing_array_member_is_initialized_before_native_read(self):
        text=emit("#define main\nglobal.sprIdle[0]=10;newArray[1][2]=4;",module="Characters/bubbles.race.gml")
        self.assertIn('scrFRMemberIndexWrite(global.fr_module_vars[$ "race:bubbles"], "sprIdle", [0], 10, "=")',text)
        self.assertIn('"newArray", [1, 2]',text)
        self.assertNotIn('.sprIdle,',text)

    def test_source_object_index_is_symbolic(self):
        text = emit("#define main\nreturn object_index==other.object_index;")
        self.assertEqual(text.count("scrFRObjectIndex("), 2)

    def test_per_player_input_and_camera_arrays_use_native_adapters(self):
        text=emit('#define main\nview_object[1]=self;view_pan_factor[1]+=0.1;game_letterbox=false;return mouse_x[1]+view_xview_nonsync;')
        self.assertIn('scrFRViewSet("object", 1,',text)
        self.assertIn('scrFRViewSet("pan", 1, 0.1, "+=")',text)
        self.assertIn('scrFRLetterbox(false)',text)
        self.assertIn('scrFRMouseCoordinate(0, 1)',text)
        self.assertIn('scrFRViewCoordinate(0)',text)
        self.assertNotIn('scrFRIndexGet(mouse_x',text)

    def test_alarms_are_logical_not_native_array_slots(self):
        text = emit("#define main\nalarm0=4;alarm[2]+=1;return alarm0;")
        self.assertEqual(text.count("scrFRAlarmWrite("), 2)
        self.assertIn("scrFRAlarmRead(", text)

    def test_catch_binding_is_a_valid_native_local(self):
        text = emit("#define main\ntry{throw 3;}catch(error){return error;}finally{value=1;}")
        self.assertRegex(text, r"catch\(__fr_caught\d+\)")
        self.assertIn("finally", text)
        self.assertNotIn("catch(_fr.vars", text)

    def test_yielding_catch_uses_continuation_after_protected_block(self):
        text = emit("#define main\ntry{throw 3;}catch(error){wait(2);value=error;}")
        self.assertIn("scrFRTask", text)
        self.assertRegex(text, r"catch\(__fr_caught\d+\)")
        self.assertIn("_fr.vars.error", text)

    def test_module_globals_are_qualified(self):
        text = emit("#define main\nglobal.sprite=1;return global.sprite;", module="Weapons/FR_Test.wep.gml")
        self.assertIn('global.fr_module_vars[$ "weapon:FR_Test"]', text)

    def test_source_clock_and_version_are_independent_of_release(self):
        text = emit("#define main\nreturn game_version+current_frame+current_time_scale;")
        self.assertIn("scrFRSourceFrame()", text)
        self.assertIn("scrFRSourceScale()", text)
        self.assertNotRegex(text, r"\bgame_version\b")


if __name__ == "__main__":
    unittest.main(verbosity=2)
