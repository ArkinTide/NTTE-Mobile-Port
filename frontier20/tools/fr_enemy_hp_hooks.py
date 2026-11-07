"""Install the native NTTE enemy final-Create HP boundary reproducibly.

Only Scary Face is deferred. Native loop/custom HP, drop modifiers and the
single original Luck roll stay in the existing creation-effects consumer.
"""
from __future__ import annotations

import argparse
from pathlib import Path
import re


ROOT = Path(__file__).resolve().parents[2]
EFFECTS = "scripts/scrEnemyApplyCreationEffects/scrEnemyApplyCreationEffects.gml"
MARKER = "// NTTE FINAL ENEMY HP"


def enemy_types(project):
    project = Path(project)
    parents = {}
    for folder in (project / "objects").iterdir():
        model = folder / (folder.name + ".yy")
        if not model.is_file():
            continue
        match = re.search(r'"parentObjectId"\s*:\s*\{\s*"name"\s*:\s*"([^"]+)"',
                          model.read_text(encoding="utf-8-sig"))
        parents[folder.name] = match[1] if match else None
    result = []
    for name in sorted(parents):
        if not name.startswith("NTTE"):
            continue
        item, seen = name, set()
        while item and item not in seen and item != "enemy":
            seen.add(item)
            item = parents.get(item)
        if item == "enemy":
            result.append(name)
    return result


def apply(project):
    project = Path(project).resolve()
    canonical = ROOT / "project"
    effects = (canonical / EFFECTS).read_text(encoding="utf-8-sig")
    assert effects.count("function scrNTTEFullEnemyCreationHPFinish()") == 1
    writes = {project / EFFECTS: effects}
    names = enemy_types(project)
    assert names, "No NTTE native enemy constructors found"
    for name in names:
        path = project / "objects" / name / "Create_0.gml"
        assert path.is_file(), (name, "Enemy leaf has no explicit Create event")
        text = path.read_text(encoding="utf-8-sig")
        code = re.sub(r'/\*.*?\*/|//[^\n]*|"(?:\\.|[^"\\])*"', '', text, flags=re.S)
        assert not re.search(r'\b(?:exit|return)\b', code), (name, "Early exit bypasses final enemy HP")
        hook = f"if(object_index=={name}) scrNTTEFullEnemyCreationHPFinish(); {MARKER}"
        if MARKER in text:
            assert text.count(hook) == 1, (name, "Unknown final-Create HP hook")
            assert text.rstrip().endswith(hook), (name, "HP finalizer no longer ends the leaf constructor")
        else:
            text = text.rstrip() + "\n" + hook + "\n"
        writes[path] = text
    for path, text in writes.items():
        path.write_text(text, encoding="utf8", newline="\n")
    return {"native_final_leaf_count": len(names), "native_final_leaf_types": names,
            "deferred_effect": "Scarier Face", "reapplied_drop_modifiers": False,
            "rerolled_luck": False}


if __name__ == "__main__":
    parser = argparse.ArgumentParser()
    parser.add_argument("project", type=Path)
    args = parser.parse_args()
    print(apply(args.project))
