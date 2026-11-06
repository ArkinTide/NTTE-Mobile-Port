"""Audit original NTT object/sprite/sound references left in emitted GML.

This catches valid legacy engine constants which the GMS2 compiler otherwise
mistakes for unset instance fields. It never writes a game project.
"""
from __future__ import annotations

import json
from pathlib import Path
import re

from freeze_frontier_base_assets import NativeWad
from fr_gml_frontend import tokenize


ROOT = Path(__file__).resolve().parents[1]


def main():
    wad = NativeWad("D:/Steam/steamapps/common/Nuclear Throne/9940/NuclearThroneTogether.exe")
    types = {name: "sprite" for name in wad.sprites}
    for chunk, kind in [("OBJT", "object"),("SOND", "sound"),("FONT", "font")]:
        for pos in wad.table(chunk):
            types[wad.string(wad.u32(pos))] = kind
    project = ROOT.parent / "project/nuclearthronemobile.yyp"
    yyp = json.loads(re.sub(r",(?=\s*[}\]])", "",project.read_text("utf-8-sig")))
    available = {entry["id"]["name"] for entry in yyp["resources"]}
    available.update(entry["id"]["name"] for entry in json.loads((ROOT/"generated-assets/resources.json").read_text("utf-8")))
    # Existing mobile macros/globalvars and the native bridge are executable
    # definitions, not GameMaker resources.
    native = [ROOT.parent/"project/scripts/macros_general/macros_general.gml", *ROOT.glob("native/*.gml")]
    for path in native:
        available.update(re.findall(r"^\s*#macro\s+(\w+)",path.read_text("utf-8-sig"), re.M))
    unresolved = {}
    for path in sorted((ROOT/"generated-code").rglob("*.gml")):
        tokens = tokenize(path.read_text("utf-8-sig"))
        for i, token in enumerate(tokens):
            name = token.text
            if token.kind != "identifier" or name not in types or name in available:
                continue
            if i and tokens[i-1].text == ".":
                continue
            unresolved.setdefault(name,{"kind":types[name],"sites":[]})["sites"].append({"path":path.relative_to(ROOT).as_posix(),"line":token.line})
    report = {"status":"PASS" if not unresolved else "UNRESOLVED", "unresolved":unresolved,
        "native_reference":"Original NTT9940 SPRT/OBJT/SOND/FONT", "source_form_offset":wad.form}
    output = ROOT / "analysis/engine-constants-audit.json"
    output.write_text(json.dumps(report,ensure_ascii=False,indent=2)+"\n","utf-8")
    print(json.dumps({name:{"kind":value["kind"],"count":len(value["sites"])} for name,value in unresolved.items()}))


if __name__ == "__main__":
    main()
