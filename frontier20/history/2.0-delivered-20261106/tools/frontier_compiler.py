"""Offline Frontier legacy GML compiler; emits only staged Frontier files.

No source is executed. Every parsing/emission failure is retained; generated
code remains disabled until the native runtime dependencies have been checked.
The host project and the Hardmode pipeline are deliberately never written here.
"""
from __future__ import annotations
from collections import Counter
from copy import deepcopy
from pathlib import Path
import argparse
import hashlib
import json
import re

from fr_gml_parser import Node, definitions
from fr_emitter_base import Emitter, Flow, walk, safe
from fr_runtime_schema import API, FIELD_ALIASES, GAMECONT_FIELD_ALIASES, GAMECONT_SEED_READ_FIELDS, module_key, module_name
from fr_actor_objects import TYPE_ALIASES

# Custom* are legacy object constants, not API calls. Feed the same mapping
# to the base emitter and the generated field/object alias audit.
FIELD_ALIASES.update(TYPE_ALIASES)

ROOT = Path(__file__).resolve().parents[1]
HOST = ROOT.parent / "project"
SOURCE = ROOT / "original/Frontier"
OUT = ROOT / "generated-code"
OFFLINE_LOADERS = {
    "LibLoader.mod.gml", "Frontier_Loader.mod.gml", "Wibbly_Loader.mod.gml",
    "Characters/campfire_loader.mod.gml", "dependencies/LibLoader.mod.gml",
    "dependencies/libAutoUpdate.mod.gml",
    "custom_options_v100_patch.mod.ntgml",
}
STATIC_LIB_DEFINITIONS = {"init": "scrFRLibBootstrap()", "import": "scrFRLibImport(argument0)", "ping": "scrFRLibPing()"}
OFFLINE_CUSTOM_OPTIONS = {"init": "scrFRCustomOptionsInit()", "chat_command": 'scrFROfflineLoader("mod:custom_options")'}
SOURCE_COORDINATES = {
    "mouse_x": ("scrFRMouseCoordinate",0), "mouse_y": ("scrFRMouseCoordinate",1),
    "mouse_delta_x": ("scrFRMouseDelta",0), "mouse_delta_y": ("scrFRMouseDelta",1),
    "mouse_x_nonsync": ("scrFRMouseLocal",0), "mouse_y_nonsync": ("scrFRMouseLocal",1),
    "view_xview": ("scrFRViewCoordinate",0), "view_yview": ("scrFRViewCoordinate",1),
    "view_xview_nonsync": ("scrFRViewCoordinate",0), "view_yview_nonsync": ("scrFRViewCoordinate",1),
}
SOURCE_VIEWS = {"view_object":"object","view_pan_factor":"pan","view_shake":"shake"}
# These two supplied draw callbacks initialize their rising-speed counter in
# one frame and consume it in later frames. A function-local native variable
# cannot retain that state. Keep only these reviewed counters on each binding;
# do not make unrelated source locals persistent or share state across banners.
PERSISTENT_CALLBACK_LOCALS = {
    ("Frontier_Events.mod.gml", "EventDropdown_draw"): {"_dropdownExtraSpeed"},
    ("Areas/deeplabs.area.gml", "DeeplabsFinaleDropdown_draw"): {"_dropdownExtraSpeed"},
}


def save(name, value):
    (OUT / name).write_text(json.dumps(value, ensure_ascii=False, indent=2) + "\n", encoding="utf8")


class FrontierFlow(Flow):
    def compile(self, node, after, break_to=None, continue_to=None):
        if node.kind == "try" and not self.synchronous(node):
            body, error_name, handler, finalizer = node.args
            if not self.synchronous(body) or finalizer.kind != "empty" or not error_name:
                raise NotImplementedError(f"Suspending protected try/finally requires exception-stack lowering at {self.e.module}:{node.line}")
            # The supplied libCharm has a synchronous GMS2 protected body and
            # a yielding legacy fallback handler. Catch locally, then continue
            # the handler in ordinary resumable blocks without losing locals.
            entry = self.compile(handler, after, break_to, continue_to)
            previous = self.e.native_scope
            self.e.native_scope = True
            try:
                protected = self.e.sync(body)
            finally:
                self.e.native_scope = previous
            caught = self.e.new("caught")
            text = f"try {{ {protected}\n_fr.pc={after}; }} catch({caught}) {{ {self.e.local(error_name)}={caught}; _fr.pc={entry}; }}"
            return self.add(node.line, text)
        return super().compile(node, after, break_to, continue_to)


class FrontierEmitter(Emitter):
    flow_class = FrontierFlow
    def __init__(self, module, definition, all_definitions, artwork, macros, enums):
        super().__init__(module, definition, all_definitions, artwork)
        self.macros = macros
        self.enums = enums
        self.persistent_locals = PERSISTENT_CALLBACK_LOCALS.get((module, definition.name), set())
        self.draw_logic = False  # Report render-side state separately; never guess gating.
        for node in walk(definition.body):
            if node.kind == "try" and node.args[1]:
                self.locals.add(node.args[1])

    def local(self, name):
        if name in self.persistent_locals:
            return "fr_callback_" + name
        return super().local(name)

    def identifier(self, value):
        if value not in self.locals:
            if (value == "event_perform" and self.module == "Areas/cyberspace.area.gml"
                and self.definition.name == "cyberspace_revive"):
                # NTT Revive's synthetic Player collision / Alarm0 are not
                # Epsilon's co-op collision / damage Alarms4+5. Adapt only
                # this authored revival sequence, not ordinary native Revive.
                self.calls.add("scrFRCyberspaceReviveEvent")
                return "scrFRCyberspaceReviveEvent"
            argument=re.fullmatch(r"argument(\d+)",value)
            if argument:
                index=int(argument.group(1))
                if index<len(self.definition.parameters):
                    return self.local(self.definition.parameters[index])
                if self.async_mode:
                    return "(array_length(_fr.args)>"+str(index)+" ? _fr.args["+str(index)+"] : undefined)"
                return "(argument_count>"+str(index)+" ? argument["+str(index)+"] : undefined)"
            if value == "self":
                return "scrFRSelf(_fr.scope)" if self.async_mode and not self.native_scope else "scrFRSelf(self)"
            if value in self.macros:
                return "frMacro_" + safe(self.module) + "_" + value
            if value in self.enums:
                return "frEnum_" + safe(self.module) + "_" + value
            if value == "mod_current":
                return json.dumps(module_name(self.module))
            if value in {"mod_current_type", "mod_type_current"}:
                return json.dumps(module_key(self.module).split(":", 1)[0])
            if value == "current_time_scale":
                return "scrFRSourceScale()"
            if value == "current_frame":
                return "scrFRSourceFrame()"
            if value == "current_frame_is_active":
                return "scrFRReadyTick()"
            if value == "crown_current":
                return "scrFRCrownCurrent()"
        return super().identifier(value)

    def domain(self, node):
        name = node.args[0] if node.kind == "identifier" and node.args[0] not in self.locals else None
        if node.kind == "member" and not (node.args[0].kind == "identifier" and node.args[0].args[0] == "global"):
            name = node.args[1]
        if name in {"bskin", "skin"}:
            return "Skin"
        return super().domain(node)

    def with_targets(self, node):
        # Legacy with accepts arrays of instances, structs and scalar data.
        # The runtime must wrap scalar values rather than dropping them.
        return "scrFRWithValues(" + self.expression(node) + ")"

    def query_domain_value(self, domain, value):
        if domain == "Area":
            self.calls.add("scrFRAreaTryResolve")
            return "scrFRAreaTryResolve(" + value + ")"
        return super().query_domain_value(domain,value)

    def emit(self):
        text = super().emit()
        text = text.replace("if(instance_exists(__fr_with", "if(scrFRScopeExists(__fr_with")
        text = text.replace("if (!instance_exists(_fr.scope))", "if (!scrFRScopeExists(_fr.scope))")
        return text

    def expression(self, node, condition=False, lvalue=False):
        bbox_scope = None
        if node.kind == "identifier" and node.args[0] in {"bbox_right", "bbox_bottom"} and node.args[0] not in self.locals:
            bbox_scope = "_fr.scope" if self.async_mode and not self.native_scope else "scrFRSelf(self)"
            bbox_field = node.args[0]
        elif node.kind == "member" and node.args[1] in {"bbox_right", "bbox_bottom"} and not (node.args[0].kind == "identifier" and node.args[0].args[0] == "global"):
            bbox_scope = self.expression(node.args[0])
            bbox_field = node.args[1]
        if bbox_scope and not lvalue:
            self.calls.add("scrFRSourceBBoxRead")
            return "scrFRSourceBBoxRead(" + bbox_scope + ", " + json.dumps(bbox_field) + ")"
        ammo=self.ammo_target(node)
        if ammo and not lvalue:
            self.calls.add("scrFRAmmoArray")
            return "scrFRAmmoArray("+ammo[0]+", "+json.dumps(ammo[1])+")"
        if node.kind=="identifier" and node.args[0]=="id" and "id" not in self.locals and not lvalue:
            # Legacy NTT exposed numerical instance IDs. Modern runner refs
            # must be converted at a source read boundary: Deeplabs actually
            # uses id+1 to find its adjacent generated floor instance.
            return "real(id)"
        if node.kind=="member" and node.args[0].kind=="identifier" and node.args[0].args[0]=="GameCont" and node.args[1] in GAMECONT_SEED_READ_FIELDS:
            if lvalue:
                raise ValueError(f"Unreviewed write to native source seed field at {self.module}:{node.line}")
            self.calls.add("scrFRPlayerCompatSeedField")
            return "scrFRPlayerCompatSeedField("+json.dumps(node.args[1])+")"
        if self.module=="dependencies/wibbly.mod.gml" and self.definition.name=="PlayerManager_step" and node.kind=="binary" and node.args[0]=="=" and not condition:
            left,right=node.args[1:]
            if (left.kind=="index" and left.args[0].kind=="member" and left.args[0].args[1]=="playerRace"
                and right.kind=="identifier" and right.args[0]=="race" and "race" not in self.locals):
                # The source stores race keys for is_string/mod dispatch and
                # array_find_index(...,"robot"). Native inventory identities
                # remain numeric; only this authored string snapshot changes.
                converted=Node("call",[Node("identifier",["scrFRRaceKey"],node.line),[right]],node.line)
                return self.expression(Node("binary",["=",left,converted],node.line),condition,lvalue)
        if node.kind == "index" and node.args[0].kind == "identifier" and node.args[0].args[0] == "argument" and "argument" not in self.locals:
            # argument is a VM parameter accessor, not an ordinary array value
            # in synchronous native GML. Passing it to IndexGet loses the
            # caller's parameters. Preserve direct access, including named
            # parameter aliases and NTT's undefined optional-argument result.
            if node.args[1] or len(node.args[2]) != 1:
                raise ValueError(f"Unsupported argument accessor at {self.module}:{node.line}")
            index = node.args[2][0]
            if not self.async_mode:
                if index.kind == "number" and re.fullmatch(r"\d+", index.args[0]):
                    return self.identifier("argument" + index.args[0])
                value = self.expression(index)
                return "(argument_count>" + value + " && " + value + ">=0 ? argument[" + value + "] : undefined)"
        source_value=self.source_engine_target(node)
        if source_value and not lvalue:
            name,index=source_value
            if name in SOURCE_COORDINATES:
                helper,axis=SOURCE_COORDINATES[name]
                self.calls.add(helper)
                args=str(axis)+((', '+index) if index and helper!='scrFRMouseLocal' else '')
                return helper+'('+args+')'
            if name in SOURCE_VIEWS:
                self.calls.add('scrFRViewValue')
                return 'scrFRViewValue('+json.dumps(SOURCE_VIEWS[name])+((', '+index) if index else '')+')'
            if name=='game_letterbox':
                self.calls.add('scrFRLetterbox')
                return 'scrFRLetterbox()'
        object_scope = None
        if node.kind == "identifier" and node.args[0] == "object_index" and "object_index" not in self.locals:
            object_scope = "_fr.scope" if self.async_mode and not self.native_scope else "scrFRSelf(self)"
        elif node.kind == "member" and node.args[1] == "object_index" and not (node.args[0].kind == "identifier" and node.args[0].args[0] == "global"):
            object_scope = self.expression(node.args[0])
        if object_scope and not lvalue:
            self.calls.add("scrFRObjectIndex")
            return "scrFRObjectIndex(" + object_scope + ")"
        if node.kind == "member" and node.args[0].kind == "identifier" and node.args[0].args[0] in {"GameObject", "Effect", "Pickup"}:
            if lvalue:
                raise ValueError(f"Selector object member cannot be a direct lvalue at {self.module}:{node.line}")
            self.calls.add("scrFRVariableGet")
            return "scrFRVariableGet(scrFRInstanceFind(" + self.expression(node.args[0]) + ", 0), " + json.dumps(node.args[1]) + ")"
        weapon_slot = self.weapon_slot_target(node)
        if weapon_slot and not lvalue:
            self.calls.add("scrFRWeaponSlotRead")
            return "scrFRWeaponSlotRead(" + weapon_slot[0] + ", " + json.dumps(weapon_slot[1]) + ")"
        if node.kind == "binary" and node.args[0] in {"==", "!=", "<>", "="} and (node.args[0] != "=" or condition):
            left, right = node.args[1:]
            if self.domain(left) == "Area" or self.domain(right) == "Area":
                # Optional companion areas can appear in authored queries
                # without being loaded. Equality against such an area simply
                # misses; entering/assigning that route must still use the
                # strict resolver in the ordinary assignment lowering.
                self.calls.add("scrFRAreaTryResolve")
                op = "==" if node.args[0] == "=" else node.args[0]
                a, b = self.expression(left, condition), self.expression(right, condition)
                if self.domain(left) == "Area":
                    alternatives = self.domain_alternatives(right)
                    if right.kind == "binary" and alternatives:
                        joiner = " || " if op == "==" else " && "
                        return "(" + joiner.join("(" + a + " " + op + " scrFRAreaTryResolve("
                            + self.expression(item) + "))" for item in alternatives) + ")"
                    b = "scrFRAreaTryResolve(" + b + ")"
                else:
                    a = "scrFRAreaTryResolve(" + a + ")"
                return "(" + a + " " + op + " " + b + ")"
            if self.domain(left) == "Weapon" or self.domain(right) == "Weapon":
                self.calls.add("scrFRSourceWeaponEqual")
                equal = "scrFRSourceWeaponEqual(" + self.expression(left) + ", " + self.expression(right) + ")"
                return "(!" + equal + ")" if node.args[0] in {"!=", "<>"} else equal
        alarm = self.alarm_target(node)
        if alarm and not lvalue:
            self.calls.add("scrFRAlarmRead")
            return "scrFRAlarmRead(" + alarm[0] + ", " + alarm[1] + ")"
        if node.kind == "binary" and node.args[0] in {"=", "+=", "-=", "*=", "/=", "%=", "&=", "|=", "^=", "<<=", ">>="} and not condition:
            engine=self.source_engine_target(node.args[1])
            if engine:
                name,index=engine
                if name in SOURCE_VIEWS:
                    self.calls.add('scrFRViewSet')
                    return 'scrFRViewSet('+json.dumps(SOURCE_VIEWS[name])+', '+(index or 'global.index')+', '+self.expression(node.args[2])+', '+json.dumps(node.args[0])+')'
                if name=='game_letterbox' and node.args[0]=='=':
                    self.calls.add('scrFRLetterbox')
                    return 'scrFRLetterbox('+self.expression(node.args[2])+')'
                raise ValueError(f'Unsupported source camera/input write {name} at {self.module}:{node.line}')
            if node.args[1].kind == "identifier" and node.args[1].args[0] == "current_time_scale" and "current_time_scale" not in self.locals:
                if node.args[0] != "=":
                    raise ValueError(f"Unsupported source timescale compound write at {self.module}:{node.line}")
                self.calls.add("scrFRSourceScaleSet")
                return "scrFRSourceScaleSet(" + self.expression(node.args[2]) + ")"
            left = node.args[1]
            ammo=self.ammo_target(left)
            if ammo:
                if node.args[0]!="=":
                    raise ValueError(f"Unsupported whole ammo table operation at {self.module}:{node.line}")
                self.calls.add("scrFRAmmoArrayWrite")
                return "scrFRAmmoArrayWrite("+ammo[0]+", "+json.dumps(ammo[1])+", "+self.expression(node.args[2])+")"
            weapon_slot = self.weapon_slot_target(left)
            if weapon_slot:
                if node.args[0] != "=":
                    raise ValueError(f"Unsupported weapon-slot operation at {self.module}:{node.line}")
                self.calls.add("scrFRWeaponSlotWrite")
                return "scrFRWeaponSlotWrite(" + weapon_slot[0] + ", " + json.dumps(weapon_slot[1]) + ", " + self.expression(node.args[2]) + ")"
            alarm = self.alarm_target(left)
            if alarm:
                self.calls.add("scrFRAlarmWrite")
                return "scrFRAlarmWrite(" + alarm[0] + ", " + alarm[1] + ", " + self.expression(node.args[2]) + ", " + json.dumps(node.args[0]) + ")"
            if left.kind == "index" and left.args[1] in {"", "@"}:
                return self.index_mutation(left, node.args[2], node.args[0])
            if node.args[0] == "=" and ((left.kind == "identifier" and left.args[0] == "sprite_index" and "sprite_index" not in self.locals) or (left.kind == "member" and left.args[1] == "sprite_index")):
                wrapped = Node("call", [Node("identifier", ["scrFRAreaSourceSprite"], node.line), [node.args[2]]], node.line)
                self.calls.add("scrFRAreaSourceSprite")
                return super().expression(Node("binary", ["=", left, wrapped], node.line), condition, lvalue)
            alarm = self.alarm_target(node.args[1])
            if alarm:
                self.calls.add("scrFRAlarmWrite")
                return "scrFRAlarmWrite(" + alarm[0] + ", " + alarm[1] + ", " + self.expression(node.args[2]) + ", " + json.dumps(node.args[0]) + ")"
        if node.kind in {"unary", "postfix"}:
            target = node.args[1] if node.kind == "unary" else node.args[0]
            op = node.args[0] if node.kind == "unary" else node.args[1]
            alarm = self.alarm_target(target) if op in {"++", "--"} else None
            if alarm:
                self.calls.add("scrFRAlarmIncrement")
                return "scrFRAlarmIncrement(" + alarm[0] + ", " + alarm[1] + ", " + ("1" if op == "++" else "-1") + ", " + str(node.kind == "postfix").lower() + ")"
            if op in {"++", "--"} and target.kind == "index" and target.args[1] in {"", "@"}:
                return self.index_mutation(target, None, op, node.kind == "postfix")
            if alarm:
                self.calls.add("scrFRAlarmIncrement")
                return "scrFRAlarmIncrement(" + alarm[0] + ", " + alarm[1] + ", " + ("1" if op == "++" else "-1") + ", " + str(node.kind == "postfix").lower() + ")"
        if node.kind == "call" and node.args[0].kind == "identifier":
            name = node.args[0].args[0]
            arguments = node.args[1]
            if name in {"is_string", "is_real", "is_numeric"} and len(arguments) == 1 and (self.domain(arguments[0]) == "Area" or (arguments[0].kind == "identifier" and arguments[0].args[0] == "_area")):
                target = "scrFRSourceAreaIsString" if name == "is_string" else "scrFRSourceAreaIsReal"
                self.calls.add(target)
                return target + "(" + self.expression(arguments[0]) + ")"
            if name == "current_frame_is_active":
                self.calls.add("scrFRReadyTick")
                return "scrFRReadyTick()"
            if name in {"alarm_get", "alarm_set"}:
                scope = "_fr.scope" if self.async_mode and not self.native_scope else "scrFRSelf(self)"
                values = [scope, *(self.expression(child) for child in arguments)]
                target = "scrFRAlarmRead" if name == "alarm_get" else "scrFRAlarmWrite"
                self.calls.add(target)
                return target + "(" + ", ".join(values) + ")"
            asset = self.artwork.get((self.module, node.line))
            if asset and asset["function"] == name:
                if "replace" in name:
                    self.calls.add("scrFRSpriteReplace")
                    return "scrFRSpriteReplace(" + self.expression(arguments[0]) + ", " + asset["native_resource"] + ")"
                return asset["native_resource"]
            if name == "script_ref_create" and arguments:
                first = arguments[0]
                if first.kind == "string" and first.args[0][1:-1] in self.definitions[self.module]:
                    first = Node("identifier", [first.args[0][1:-1]], first.line)
                values = [json.dumps(module_key(self.module).split(":", 1)[0]), json.dumps(module_name(self.module)), self.expression(first)]
                values.extend(self.expression(child) for child in arguments[1:])
                return "[" + ", ".join(values) + "]"
        if node.kind == "struct":
            return "{" + ", ".join(json.dumps(key) + ": " + self.expression(value) for key, value in node.args) + "}"
        if node.kind == "index" and node.args[0].kind == "identifier":
            value = node.args[0].args[0]
            if value in {"view_xview", "view_yview", "view_object"}:
                return super().expression(node, condition, lvalue)
            if (HOST / "objects" / value).is_dir():
                if len(node.args[2]) != 1 or node.args[1]:
                    raise ValueError(f"Unsupported object index at {self.module}:{node.line}")
                return "instance_find(" + value + ", " + self.expression(node.args[2][0]) + ")"
        if node.kind == "index" and node.args[1] in {"", "@"}:
            # GMS2's VM compiler rejects an array accessor immediately on a
            # computed expression (NTT accepts get_array()[0]). Read through
            # an ordinary function; modern arrays already have reference
            # semantics, so @ writes use the normal array accessor.
            target = self.expression(node.args[0])
            indexes = [self.expression(child) for child in node.args[2]]
            if lvalue:
                return target + "[" + ", ".join(indexes) + "]"
            self.calls.add("scrFRIndexGet")
            return "scrFRIndexGet(" + ", ".join([target, *indexes]) + ")"
        return super().expression(node, condition, lvalue)

    def alarm_target(self, node):
        if node.kind == "index" and node.args[1] in {"", "@"} and len(node.args[2])==1:
            base=node.args[0]
            if base.kind=="identifier" and base.args[0]=="alarm" and "alarm" not in self.locals:
                return ("_fr.scope" if self.async_mode and not self.native_scope else "scrFRSelf(self)",self.expression(node.args[2][0]))
            if base.kind=="member" and base.args[1]=="alarm":
                return self.expression(base.args[0]),self.expression(node.args[2][0])
        if node.kind == "identifier" and node.args[0] not in self.locals:
            name = node.args[0]
            scope = "_fr.scope" if self.async_mode and not self.native_scope else "scrFRSelf(self)"
        elif node.kind == "member":
            name = node.args[1]
            scope = self.expression(node.args[0])
        else:
            return None
        match = re.fullmatch(r"alarm(\d+)", name)
        return (scope, match.group(1)) if match else None

    def source_engine_target(self,node):
        index=None
        if node.kind=='index' and node.args[1] in {'','@'} and len(node.args[2])==1:
            index=self.expression(node.args[2][0]);node=node.args[0]
        if node.kind=='identifier' and node.args[0] not in self.locals and node.args[0] in {*SOURCE_COORDINATES,*SOURCE_VIEWS,'game_letterbox'}:
            return node.args[0],index
        return None

    def index_mutation(self, node, value, operation, post=False):
        indexes=[]
        root=self.expand_macro_lvalue(node)
        while root.kind=="index" and root.args[1] in {"", "@"}:
            indexes=list(root.args[2])+indexes
            root=root.args[0]
        path="["+", ".join(self.expression(index) for index in indexes)+"]"
        ammo=self.ammo_target(root)
        if ammo:
            target=ammo[0]+", "+json.dumps(ammo[1])
            if operation in {"++","--"}:
                self.calls.add("scrFRAmmoIndexIncrement")
                return "scrFRAmmoIndexIncrement("+target+", "+path+", "+("1" if operation=="++" else "-1")+", "+str(post).lower()+")"
            # Epsilon recomputes the native baseline, while the legacy player
            # manager reapplies stored Wibbly bonuses after Back Muscle or a
            # respawn. Setting that same delta avoids adding it a second time.
            if (self.module=="dependencies/wibbly.mod.gml" and self.definition.name=="PlayerManager_step"
                and operation=="+=" and value.kind=="index"):
                helper="scrFRAmmoBonusSet"
            else:
                helper="scrFRAmmoIndexWrite"
            self.calls.add(helper)
            suffix="" if helper=="scrFRAmmoBonusSet" else ", "+json.dumps(operation)
            return helper+"("+target+", "+path+", "+self.expression(value)+suffix+")"
        scope=None
        if root.kind=="member":
            scope=self.expression(root.args[0])
            owner=root.args[0].args[0] if root.args[0].kind=="identifier" else None
            field=(GAMECONT_FIELD_ALIASES.get(root.args[1],root.args[1]) if owner=="GameCont" else
                   root.args[1] if owner=="global" else FIELD_ALIASES.get(root.args[1],root.args[1]))
        elif root.kind=="identifier" and root.args[0] not in self.locals:
            scope="_fr.scope" if self.async_mode and not self.native_scope else "scrFRSelf(self)"
            field=FIELD_ALIASES.get(root.args[0],root.args[0])
        prefix="scrFRMemberIndex" if scope else "scrFRIndexPath"
        target=(scope+", "+json.dumps(field)) if scope else self.expression(root)
        if operation in {"++","--"}:
            helper=prefix+"Increment"
            self.calls.add(helper)
            return helper+"("+target+", "+path+", "+("1" if operation=="++" else "-1")+", "+str(post).lower()+")"
        helper=prefix+"Write"
        self.calls.add(helper)
        return helper+"("+target+", "+path+", "+self.expression(value)+", "+json.dumps(operation)+")"

    def expand_macro_lvalue(self, node, expanding=()):
        # Index lowering extracts the storage owner before GML's preprocessor
        # can expand #macro aliases. Preserve that owner structurally: Wibbly's
        # speedBonus[index] is GameCont.wib_speedBonus, not Player.speedBonus.
        # Only the storage spine is expanded; index expressions retain the
        # ordinary expression and local-variable rules.
        if node.kind=="identifier" and node.args[0] not in self.locals and node.args[0] in self.macros:
            name=node.args[0]
            if name in expanding:
                raise ValueError(f"Recursive macro lvalue at {self.module}:{node.line}: {name}")
            return self.expand_macro_lvalue(self.macros[name].args[1], expanding+(name,))
        if node.kind in {"index", "member"}:
            return Node(node.kind,[self.expand_macro_lvalue(node.args[0],expanding),*node.args[1:]],node.line)
        return node

    def weapon_slot_target(self, node):
        if node.kind == "identifier" and node.args[0] in {"wep", "bwep"} and node.args[0] not in self.locals:
            return ("_fr.scope" if self.async_mode and not self.native_scope else "scrFRSelf(self)", node.args[0])
        if node.kind == "member" and node.args[1] in {"wep", "bwep"}:
            if node.args[0].kind == "identifier" and node.args[0].args[0] == "global":
                return None
            return self.expression(node.args[0]), node.args[1]
        return None

    def ammo_target(self,node):
        if node.kind=="identifier" and node.args[0] in {"typ_amax","typ_ammo","typ_name"} and node.args[0] not in self.locals:
            return ("_fr.scope" if self.async_mode and not self.native_scope else "scrFRSelf(self)",node.args[0])
        if node.kind=="member" and node.args[1] in {"typ_amax","typ_ammo","typ_name"}:
            if node.args[0].kind=="identifier" and node.args[0].args[0] in {"global","GameCont"}:
                return None
            return self.expression(node.args[0]),node.args[1]
        return None

    def simple(self, node):
        if node.kind == "var":
            # NTT allows var to repeat an argument/local declaration. Modern
            # GML rejects declaring a parameter, while reassignment has the
            # same function-scoped legacy behavior.
            rows = []
            for name, init in node.args:
                if name in self.definition.parameters or name in self.persistent_locals:
                    if init is not None:
                        rows.append(self.local(name) + " = " + self.expression(init) + ";")
                else:
                    rows.append(("" if self.async_mode else "var ") + self.local(name) + " = " + (self.expression(init) if init is not None else "undefined") + ";")
            return "\n".join(rows)
        if node.kind == "throw":
            return "throw " + self.expression(node.args[0]) + ";"
        if node.kind == "enum":
            # Hoisted globally by compile_module, preserving original members.
            return "; // enum hoisted: " + node.args[0]
        if node.kind == "macro":
            # Hoisted globally rather than emitted in a continuation block.
            return "; // macro hoisted: " + node.args[0]
        return super().simple(node)

    def sync(self, node):
        if node.kind == "switch":
            # Legacy NTT permits runtime case expressions. Resolve the first
            # matching ordinal before a native constant-label switch, keeping
            # break, continue and source fallthrough semantics intact.
            target, cases = node.args
            value, selected = self.new("switch_value"), self.new("switch_case")
            rows = ["{ var " + value + "=" + self.expression(target) + ", " + selected + "=-1;"]
            default = -1
            domain = self.domain(target)
            for index, (label, body) in enumerate(cases):
                if label is None:
                    default = index
                    continue
                match = self.expression(label)
                if domain:
                    match = self.query_domain_value(domain,match)
                rows.append("if(" + selected + "==-1 && " + value + "==(" + match + ")) " + selected + "=" + str(index) + ";")
            rows.append("if(" + selected + "==-1) " + selected + "=" + str(default) + ";")
            rows.append("switch(" + selected + ") {")
            self.sync_loop_stack.append(None)
            for index, (label, body) in enumerate(cases):
                rows.append("case " + str(index) + ":\n" + "\n".join(self.sync(child) for child in body.args))
            self.sync_loop_stack.pop()
            rows.append("}\n}")
            return "\n".join(rows)
        if node.kind == "try":
            body, error_name, handler, finalizer = node.args
            result = "try " + self.sync(body)
            if error_name:
                caught = self.new("caught")
                binding = ("" if self.async_mode else "var ") + self.local(error_name) + "=" + caught + ";"
                result += " catch(" + caught + ") { " + binding + "\n" + self.sync(handler) + "\n}"
            if finalizer.kind != "empty":
                result += " finally " + self.sync(finalizer)
            return result
        return super().sync(node)


def sources():
    files = [(p.relative_to(SOURCE).as_posix(), p) for p in SOURCE.rglob("*") if p.suffix in {".gml", ".ntgml"}]
    deps = ROOT / "dependencies"
    if deps.is_dir():
        files += [("dependencies/" + p.relative_to(deps).as_posix(), p) for p in deps.rglob("*") if p.suffix in {".gml", ".ntgml"}]
    return sorted(files)


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument("--parse-only", action="store_true")
    options = parser.parse_args()
    OUT.mkdir(exist_ok=True)
    modules = {}
    parse_rows = []
    for relative, path in sources():
        raw = path.read_bytes()
        row = {"source": relative, "module_key": module_key(relative), "bytes": len(raw), "sha256": hashlib.sha256(raw).hexdigest()}
        try:
            parsed = definitions(raw.decode("utf-8-sig"), relative)
            modules[relative] = parsed
            row.update(status="PARSED", definitions=len(parsed), callbacks=[{"name": d.name, "line": d.line} for d in parsed])
        except Exception as error:
            row.update(status="PARSE_ERROR", error=f"{type(error).__name__}: {error}")
        parse_rows.append(row)
    parse_report = {"status": "PASS" if all(x["status"] == "PARSED" for x in parse_rows) else "FAIL", "modules": parse_rows,
                    "source_modules": sum(not x["source"].startswith("dependencies/") for x in parse_rows),
                    "parsed_modules": len(modules), "total_modules": len(parse_rows)}
    save("parser-audit.json", parse_report)
    if options.parse_only:
        print(json.dumps({k: v for k, v in parse_report.items() if k != "modules"}))
        return 0 if parse_report["status"] == "PASS" else 1

    names = {p: {d.name for d in values} for p, values in modules.items()}
    artwork = {}
    asset_index = ROOT / "generated-assets/asset-manifest.json"
    if asset_index.is_file():
        data = json.loads(asset_index.read_text(encoding="utf8"))
        for asset in data.get("artwork", []):
            artwork[asset["source"], asset["line"]] = asset
    rows = []
    counts = Counter()
    api_calls = {}
    identifiers = Counter()
    with_sites = []
    skipped = []
    alias_sites = []
    for relative, parsed in modules.items():
        macros = {n.args[0]: n for d in parsed for n in walk(d.body) if n.kind == "macro"}
        enums = {n.args[0]: n for d in parsed for n in walk(d.body) if n.kind == "enum"}
        records = []
        code = []
        for name, node in macros.items():
            if relative in OFFLINE_LOADERS or (relative == "dependencies/lib.mod.gml" and name == "URL"):
                skipped.append({"source": relative, "name": "#macro " + name, "line": node.line, "reason": "Offline static bootstrap replaces original downloader"})
                continue
            try:
                emitter = FrontierEmitter(relative, parsed[0], names, artwork, macros, enums)
                code.append("#macro frMacro_" + safe(relative) + "_" + name + " " + emitter.expression(node.args[1]))
            except Exception as error:
                records.append({"name": "#macro " + name, "line": node.line, "status": "EMISSION_ERROR", "error": repr(error)})
        for name, node in enums.items():
            emitter = FrontierEmitter(relative, parsed[0], names, artwork, macros, enums)
            members = [key + (" = " + emitter.expression(value) if value else "") for key, value in node.args[1]]
            code.append("enum frEnum_" + safe(relative) + "_" + name + " {" + ", ".join(members) + "}")
        for definition in parsed:
            emitter = FrontierEmitter(relative, definition, names, artwork, macros, enums)
            record = {"name": definition.name, "line": definition.line, "native_name": emitter.native_name, "uses_coroutine": emitter.async_mode}
            try:
                replacement = None
                if relative in OFFLINE_LOADERS:
                    replacement = "scrFROfflineLoader(" + json.dumps(module_key(relative)) + ")"
                elif relative == "dependencies/lib.mod.gml":
                    replacement = STATIC_LIB_DEFINITIONS.get(definition.name)
                elif relative == "custom_options.mod.gml":
                    replacement = OFFLINE_CUSTOM_OPTIONS.get(definition.name)
                elif relative == "dependencies/libSaves.mod.gml" and definition.name == "save_load":
                    # Packaged files and private configuration are synchronous
                    # native I/O. Preserve source defaults/save_reset without
                    # suspending callers for the old asynchronous file_load.
                    replacement = "scrFRSaveLoad(argument0,argument1,argument_count==2)"
                elif relative == "dependencies/libAreas.mod.gml":
                    if definition.name == "area_set":
                        replacement = "scrFRAreaSet(argument0,argument1,argument2)"
                    elif definition.name == "area_generate":
                        replacement = "scrFRAreaGenerate(argument0,argument1,argument2,argument3,argument4,argument5,argument6,argument7)"
                elif relative == "Objects/Frontier_Projectiles.mod.gml":
                    if definition.name == "weapon_get":
                        replacement = "scrFRSourceWeaponGet(argument0,argument1)"
                    elif definition.name == "charge_weapon_fire_init":
                        replacement = "scrFRWeaponChargeInit(argument0)"
                if replacement:
                    replacement=re.sub(r"\bargument(\d+)\b",lambda match:"(argument_count>"+match[1]+" ? argument["+match[1]+"] : undefined)",replacement)
                    result = "function " + emitter.native_name + "() { return " + replacement + "; }"
                    skipped.append({"source": relative, "name": definition.name, "line": definition.line,
                                    "reason": "Synchronous native configuration I/O preserves source default merge and save_reset" if relative == "dependencies/libSaves.mod.gml" else "Offline static bootstrap replaces original downloader/menu entry", "replacement": replacement})
                    record["replaced_by_design"] = replacement
                    record["uses_coroutine"] = False
                else:
                    result = emitter.emit()
                    if relative == 'CustomIDPDHandler.mod.gml' and definition.name == 'init':
                        old='if ((!scrFRVariableExists(GameCont, "vanlevel")))'
                        assert result.count(old)==1
                        result=result.replace(old,'if (instance_exists(GameCont) && (!scrFRVariableExists(GameCont, "vanlevel")))')
                        record['native_adaptation']='Native menus have no active GameCont; game_start initializes vanlevel for real runs'
                    if relative == "dependencies/libEvents.mod.gml" and definition.name == "update":
                        opening = result.index("{") + 1
                        result = result[:opening] + "\nif(scrFRGenerationEventsSkip()) return;\nif(scrFRContinueEventsRestore()) return;\n" + result[opening:]
                code.append("// Original " + relative + ":" + str(definition.line) + "\n" + result)
                record.update(status="GENERATED", calls=sorted(emitter.calls))
                counts["definitions_generated"] += 1
                counts["coroutines"] += record["uses_coroutine"]
                if replacement:
                    records.append(record)
                    continue
                for node in walk(definition.body):
                    if node.kind == "call" and node.args[0].kind == "identifier":
                        call = node.args[0].args[0]
                        if call not in names[relative]:
                            api_calls.setdefault(call, []).append({"source": relative, "definition": definition.name, "line": node.line,
                                                                   "emitted": emitter.identifier(call), "arguments": len(node.args[1])})
                    if node.kind == "identifier":
                        identifiers[node.args[0]] += 1
                        if node.args[0] in FIELD_ALIASES:
                            alias_sites.append({"source": relative, "definition": definition.name, "line": node.line, "kind": "identifier", "original": node.args[0], "emitted": emitter.identifier(node.args[0])})
                    if node.kind == "member" and node.args[1] in FIELD_ALIASES:
                        alias_sites.append({"source": relative, "definition": definition.name, "line": node.line, "kind": "member", "original": node.args[1], "target": emitter.expression(node.args[0]), "emitted": emitter.expression(node)})
                    if node.kind == "with":
                        with_sites.append({"source": relative, "definition": definition.name, "line": node.line,
                                           "target_ast": node.args[0].kind, "target": emitter.expression(node.args[0]),
                                           "requires_value_preservation": node.args[0].kind != "identifier" or not (HOST / "objects" / node.args[0].args[0]).is_dir()})
            except Exception as error:
                record.update(status="EMISSION_ERROR", error=f"{type(error).__name__}: {error}")
                counts["definitions_failed"] += 1
            records.append(record)
        destination = safe(relative) + ".gml"
        (OUT / destination).write_text("\n\n".join(code) + "\n", encoding="utf8")
        rows.append({"source": relative, "module_key": module_key(relative), "generated": destination,
                     "offline_loader_replaced": relative in OFFLINE_LOADERS, "definitions": records,
                     "macros": list(macros), "enums": list(enums)})
    required = sorted({site["emitted"] for sites in api_calls.values() for site in sites if site["emitted"].startswith("scrFR")})
    report = {"status": "GENERATED_NOT_ENABLED_OR_RUNTIME_VERIFIED", "parser_status": parse_report["status"],
              "modules": rows, "counts": dict(counts), "required_runtime_adapters": required,
              "offline_loaders": sorted(OFFLINE_LOADERS), "namespace": {"functions": "fr_<safe_source_path>_<definition>", "runtime": "scrFR*", "module_globals": "global.fr_module_vars"}}
    save("compilation-map.json", report)
    save("api-dependencies.json", {"status": "AUDIT_REQUIRED_NO_STUBS", "calls": api_calls, "required_adapters": required})
    save("identifier-frequency.json", dict(identifiers.most_common()))
    save("offline-replacements.json", {"status": "REPLACED_BY_DESIGN", "definitions": skipped})
    save("field-alias-audit.json", {"aliases": FIELD_ALIASES, "sites": alias_sites})
    save("with-scope-audit.json", {"required_runtime_helpers": ["scrFRWithValues", "scrFRSelf", "scrFRScopeExists"],
                                   "note": "Array with targets must preserve scalar and struct data, source order and repetitions; never silently filter to instances.",
                                   "sites": with_sites})
    save("registration-manifest.json", {"status": "STAGED", "modules": [{"source": x["source"], "module_key": x["module_key"], "offline_loader_replaced": x["offline_loader_replaced"],
          "callbacks": {d["name"]: d["native_name"] for d in x["definitions"] if d["status"] == "GENERATED"}} for x in rows]})
    print(json.dumps({"parser_status": parse_report["status"], "modules": len(rows), "counts": dict(counts), "required_adapters": len(required)}))
    return 0 if parse_report["status"] == "PASS" and not counts["definitions_failed"] else 1


if __name__ == "__main__":
    raise SystemExit(main())
