"""Frontier Custom* resource specs and explicit, idempotent staging installer.

Importing this module never modifies a project. object_specs() and
damage_hook_specs() are pure data; apply(project) only writes the project
directory expressly selected by its caller, using that project's templates.
"""
from __future__ import annotations

import argparse
import copy
import json
from pathlib import Path
import re


ROOT = Path(__file__).resolve().parents[1]
TYPE_ALIASES = {
    "CustomObject": "FRCustomObject", "CustomHitme": "FRCustomHitme",
    "CustomEnemy": "FRCustomEnemy", "CustomProjectile": "FRCustomProjectile",
    "CustomSlash": "FRCustomSlash", "CustomProp": "FRCustomProp",
    "CustomDraw": "FRBinding", "CustomScript": "FRBinding",
}


def _event(kind, number, code, collision=None):
    label = {0: "Create", 1: "Destroy", 3: "Step", 7: "Other",
             8: "Draw", 12: "CleanUp"}.get(kind)
    filename = f"Collision_{collision}.gml" if kind == 4 else f"{label}_{number}.gml"
    return {"event_type": kind, "event_num": number, "collision": collision,
            "filename": filename, "code": code.rstrip() + "\n"}


def _callbacks(create, step, destroy, animation_default=False,
               begin_step='scrFRActorStep("on_begin_step");'):
    return [
        _event(0, 0, create), _event(1, 0, destroy),
        _event(3, 0, step),
        _event(3, 1, begin_step),
        _event(3, 2, 'scrFRActorStep("on_end_step");'),
        _event(8, 0, "scrFRActorDraw();"),
        _event(7, 7, f"scrFRActorAnimationEnd({'true' if animation_default else 'false'});"),
        _event(12, 0, "scrFRActorCleanup();"),
    ]


def object_specs():
    common = 'max_hp=1;spr_idle=-1;spr_walk=-1;spr_hurt=-1;spr_dead=-1;raddrop=0;size=1;\n'
    create_object = 'scrFRActorInit();image_speed=.4*timescale;'
    ordinary_step = 'scrFRActorStep("on_step");'
    ordinary_destroy = 'scrFRActorFinalCallback("on_destroy");scrFRActorCleanup();'
    inherited_destroy = 'scrFRActorFinalCallback("on_destroy");event_inherited();scrFRActorCleanup();'
    specs = [
        {"name": "FRCustomObject", "parent": None, "sprite": None, "mask": None,
         "events": _callbacks(create_object, ordinary_step, ordinary_destroy)},
        {"name": "FRCustomHitme", "parent": "hitme", "sprite": None, "mask": None,
         "events": _callbacks(common + 'event_inherited();scrFRActorInit();hp=max_hp;\n'
                              'snd_hurt=sndHitFlesh;snd_dead=-1;image_speed=.4*timescale;\n'
                              'friction=.4*timescale*timescale;',
                              ordinary_step, ordinary_destroy)},
        {"name": "FRCustomEnemy", "parent": "enemy", "sprite": None, "mask": None,
         "events": _callbacks(common + 'meleedamage=0;event_inherited();scrFRActorInit();\n'
                              'max_hp=1;hp=1;fr_maxhealth_init=true;',
                              "scrFREnemyStep();", inherited_destroy)},
        {"name": "FRCustomProp", "parent": "prop", "sprite": None, "mask": None,
         "events": _callbacks(common + 'event_inherited();scrFRActorInit();',
                              "scrFRPropStep();", inherited_destroy,
                              begin_step="scrFRPropBeginStep();")},
        {"name": "FRCustomProjectile", "parent": "projectile", "sprite": None, "mask": None,
         "events": _callbacks('event_inherited();scrFRActorInit();typ=0;deflected=0;\n'
                              'knockback_speed=0;image_speed=.4*timescale;',
                              ordinary_step, inherited_destroy)},
        {"name": "FRCustomSlash", "parent": "Slash", "sprite": "sprSlash", "mask": "mskSlash",
         "events": _callbacks('event_inherited();scrFRActorInit();', ordinary_step,
                              inherited_destroy, animation_default=True)},
        {"name": "FRBinding", "parent": None, "sprite": None, "mask": None,
         "events": [_event(0, 0, "scrFRBindingInit();"),
                    _event(3, 1, 'scrFRBindingStep("begin_step");'),
                    _event(3, 0, 'scrFRBindingStep("step");'),
                    _event(3, 2, 'scrFRBindingStep("end_step");'),
                    _event(8, 0, "scrFRBindingDraw();")]},
        {"name": "FRMarker", "parent": None, "sprite": None, "mask": None,
         "events": [_event(0, 0, "visible=false;"),
                    _event(3, 0, "if(!lockstep_stop && scrFRReadyTick()) instance_destroy();")]},
        {"name": "FRSourceEffect", "parent": "FRCustomObject", "sprite": None, "mask": None,
         "events": [_event(0, 0, "event_inherited();")]},
        {"name": "FRSourcePickup", "parent": "FRCustomObject", "sprite": None, "mask": None,
         "events": [_event(0, 0, "event_inherited();")]},
        {"name": "FRChickenB", "parent": "FRSourceEffect", "sprite": "sprChickenB", "mask": None,
         "events": [_event(0, 0, "event_inherited();image_speed=0.4*timescale;depth=-2;"),
                    _event(7, 7, "instance_destroy();")]},
        {"name": "FRInvCrystal", "parent": "Crystal", "sprite": "sprFRBase_CrystalPropBlue", "mask": None,
         "events": [_event(0, 0, "event_inherited();scrFRInvCrystalCreate();")]},
        {"name": "FRScorchTop", "parent": "FRCustomObject", "sprite": "sprScorchTop", "mask": None,
         "events": [_event(0, 0, "event_inherited();depth=6;image_speed=0;image_index=irandom(max(0,image_number-1));")]},
    ]
    for spec in specs:
        if spec["name"] == "FRCustomProjectile":
            # The Palace moving wall follows native physical movement on
            # every host frame, including the source-clock render halves.
            for event in spec["events"]:
                if event["filename"] == "Step_0.gml":
                    event["code"] = 'if(!scrFRPalaceSmushStep()) scrFRActorStep("on_step");\n'
                if event["filename"] == "Step_2.gml":
                    event["code"] = 'if(!scrFRPalaceBlockEndStep()) scrFRActorStep("on_end_step");\n'
            spec["events"].extend([
                _event(4, 0, "scrFRProjectileWall();", "Wall"),
                _event(4, 0, "scrFRProjectileCollision();", "hitme"),
            ])
        elif spec["name"] == "FRCustomSlash":
            spec["events"].extend([
                _event(4, 0, 'if(!is_undefined(on_wall)) {if(!lockstep_stop) scrFRActorCallback("on_wall");}\n'
                       'else event_inherited();', "Wall"),
                _event(4, 0, 'if(!is_undefined(on_hit)) {\n'
                       '    if(!lockstep_stop && (team!=other.team || other.team==team_none)) scrFRActorCallback("on_hit");\n'
                       '} else event_inherited();', "hitme"),
                _event(4, 0, 'if(!scrFRSlashProjectileCallback()) event_inherited();', "projectile"),
            ])
    return specs


def damage_hook_specs():
    return [
        {"path": "scripts/scr_hit/scr_hit.gml", "marker": "// BEGIN FRONTIER CUSTOM HURT",
         "anchor": "function scr_hit(_instance, _amount, _hitid = HitId.None, _ntte_raw = false, _ntte_direction = undefined, _ntte_force = 0) {",
         "insertion": '\n    // BEGIN FRONTIER CUSTOM HURT\n'
                      '    if(scrFRActorHasHurt(_instance)) {\n'
                      '        var _fr_direction=(_ntte_raw==1)?0:(is_undefined(_ntte_direction)?scrNTTEFullValue(id,"direction",0):_ntte_direction);\n'
                      '        return scrFRActorHurt(_instance,_amount,_hitid,(_ntte_raw==1)?0:_ntte_force,_fr_direction);\n'
                      '    }\n    // END FRONTIER CUSTOM HURT\n'},
        {"path": "scripts/scr_hit/scr_hit.gml", "marker": "// BEGIN FRONTIER CUSTOM PROJECTILE HURT",
         "anchor": "function scr_projectile_hit(_instance, _amount, _kb_amount = 0, _kb_direction = undefined, _ntte_native_direct = false, _ntte_hitid = undefined) {",
         "insertion": '\n    // BEGIN FRONTIER CUSTOM PROJECTILE HURT\n'
                      '    if(_amount>0 && scrFRActorHasHurt(_instance)) {\n'
                      '        var _fr_direction=is_undefined(_kb_direction)?scrNTTEFullValue(id,"direction",0):_kb_direction;\n'
                      '        var _fr_hitid=is_undefined(_ntte_hitid)?scrNTTEFullValue(id,"hitid",HitId.None):_ntte_hitid;\n'
                      '        return scrFRActorHurt(_instance,_amount,_fr_hitid,_kb_amount,_fr_direction);\n'
                      '    }\n    // END FRONTIER CUSTOM PROJECTILE HURT\n'},
    ]


def _load(path):
    return json.loads(re.sub(r",(?=\s*[}\]])", "", path.read_text("utf-8-sig")))


def _write_json(path, data):
    path.parent.mkdir(parents=True, exist_ok=True)
    path.write_text(json.dumps(data, ensure_ascii=False, indent=2) + "\n", "utf-8")


def apply(project):
    project = Path(project).resolve()
    yyp = project / "nuclearthronemobile.yyp"
    data = _load(yyp)
    object_template = _load(project / "objects/hitme/hitme.yy")
    script_template = _load(project / "scripts/scr_hit/scr_hit.yy")
    resources = {entry["id"]["path"] for entry in data["resources"]}
    report = {"objects": [], "hooks": [], "scripts": ["scrFRActors"]}

    def register(name, path):
        if path not in resources:
            data["resources"].append({"id": {"name": name, "path": path}})
            resources.add(path)

    script = copy.deepcopy(script_template)
    script["name"] = script["%Name"] = "scrFRActors"
    script_path = "scripts/scrFRActors/scrFRActors.yy"
    _write_json(project / script_path, script)
    (project / "scripts/scrFRActors/scrFRActors.gml").write_text(
        (ROOT / "native/actors.gml").read_text("utf-8"), "utf-8")
    register("scrFRActors", script_path)

    for spec in object_specs():
        name = spec["name"]
        obj = copy.deepcopy(object_template)
        obj["name"] = obj["%Name"] = name
        obj["parentObjectId"] = ({"name": spec["parent"], "path": f'objects/{spec["parent"]}/{spec["parent"]}.yy'}
                                 if spec["parent"] else None)
        for key, kind in (("spriteId", "sprite"), ("spriteMaskId", "mask")):
            value = spec[kind]
            obj[key] = {"name": value, "path": f"sprites/{value}/{value}.yy"} if value else None
        obj["eventList"] = []
        directory = project / "objects" / name
        directory.mkdir(parents=True, exist_ok=True)
        for event in spec["events"]:
            collision = event["collision"]
            obj["eventList"].append({
                "$GMEvent": "v1", "%Name": "", "collisionObjectId":
                    {"name": collision, "path": f"objects/{collision}/{collision}.yy"} if collision else None,
                "eventNum": event["event_num"], "eventType": event["event_type"],
                "isDnD": False, "name": "", "resourceType": "GMEvent", "resourceVersion": "2.0",
            })
            (directory / event["filename"]).write_text(event["code"], "utf-8")
        path = f"objects/{name}/{name}.yy"
        _write_json(project / path, obj)
        register(name, path)
        report["objects"].append(name)
    for hook in damage_hook_specs():
        path = project / hook["path"]
        source = path.read_text("utf-8-sig")
        if hook["insertion"] in source:
            report["hooks"].append({"marker": hook["marker"], "status": "already-applied"})
            continue
        if hook["marker"] in source or source.count(hook["anchor"]) != 1:
            raise RuntimeError("Frontier actor hook anchor changed: " + hook["marker"])
        path.write_text(source.replace(hook["anchor"], hook["anchor"] + hook["insertion"], 1), "utf-8")
        report["hooks"].append({"marker": hook["marker"], "status": "patched"})
    _write_json(yyp, data)
    return report


if __name__ == "__main__":
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--apply", type=Path, help="Explicit staging project to modify")
    args = parser.parse_args()
    result = apply(args.apply) if args.apply else {
        "types": TYPE_ALIASES, "objects": object_specs(), "damage_hooks": damage_hook_specs()}
    print(json.dumps(result, ensure_ascii=True, indent=2))
