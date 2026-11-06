"""Inventory display literals without rewriting source identities or assets."""
from pathlib import Path
from collections import defaultdict
import json
import re
from fr_gml_parser import Node, definitions

ROOT=Path(__file__).resolve().parents[1]
TEXT_PROPERTIES={"weapon_name","weapon_text","skill_name","skill_text","skill_tip",
    "race_name","race_text","race_tb_text","race_lock","race_unlock","race_ttip",
    "race_skin_name","race_skin_lock","race_skin_unlock","race_ultra_name","race_ultra_text",
    "crown_name","crown_text","crown_tip","area_name","area_text","weapon_type_string",
    "skin_name","skin_lock","skin_unlock","skin_ttip","trinket_name","trinket_text","trinket_ttip"}
TEXT_FIELDS={"mytext","text","subtext","use_text","use_subtext","burden_text","burden_subtext",
    "meal_name","meal_text","fish_name","ttip","desc","description","useText","nameText","textName","textDescription",
    "display","display_name"}

def children(node):
    if isinstance(node,Node):
        yield node
        for arg in node.args: yield from children(arg)
    elif isinstance(node,(tuple,list)):
        for arg in node: yield from children(arg)

def field(node):
    if node.kind=="identifier": return node.args[0]
    if node.kind=="member": return node.args[1]
    return ""

def inventory():
    rows=defaultdict(list)
    def collect(value,module,callback,reason):
        for node in children(value):
            if node.kind!="string":continue
            text=node.args[0][1:-1]
            if not re.search(r"[A-Za-z]",text):continue
            if re.search(r"\.(?:png|ogg|wav|gml|txt)|https?://|^Frontier:",text,re.I):continue
            site={"module":module,"callback":callback,"line":node.line,"reason":reason}
            if site not in rows[text]:rows[text].append(site)
    for path in sorted((ROOT/"original/Frontier").rglob("*.gml")):
        module=path.relative_to(ROOT/"original/Frontier").as_posix()
        if module.startswith(("custom_options","LibLoader","Wibbly_Loader","Frontier_Loader")):continue
        for definition in definitions(path.read_text("utf-8-sig"),module):
            for node in children(definition.body):
                if node.kind=="return" and definition.name in TEXT_PROPERTIES:
                    collect(node,module,definition.name,"metadata return")
                if node.kind=="call" and node.args[0].kind=="identifier":
                    name=node.args[0].args[0];args=node.args[1]
                    if name=="loc":collect(args[1:],module,definition.name,"localization fallback")
                    if name.startswith("draw_text") and len(args)>2:
                        collect(args[2],module,definition.name,"rendered text")
                    if name=="SpecialPopupText_create":collect(args[2:],module,definition.name,"popup text")
                if node.kind=="binary" and node.args[0] in {"=","+="}:
                    if field(node.args[1]) in TEXT_FIELDS:
                        collect(node.args[2],module,definition.name,"display field")
                    if field(node.args[1])=="hitid" and node.args[2].kind=="array":
                        collect(node.args[2].args[1:],module,definition.name,"death display identity (translate only at render)")
                if node.kind=="struct":
                    for key,value in node.args:
                        if key in TEXT_FIELDS:collect(value,module,definition.name,"option display field")
            if definition.name=="surgery_namelist":collect(definition.body,module,definition.name,"random surgery display words")
            if definition.name=="surgery_applyText":
                for node in children(definition.body):
                    if node.kind=="binary" and field(node.args[1])=="_text":
                        collect(node.args[2],module,definition.name,"composed stat text")
            if definition.name.endswith("_text") and module=="Frontier_Events.mod.gml":
                collect(definition.body,module,definition.name,"weather flavor text")
    return dict(rows)

if __name__=="__main__":
    data=inventory();out=ROOT/"localization/inventory-display.json"
    out.parent.mkdir(exist_ok=True)
    out.write_text(json.dumps(data,ensure_ascii=False,indent=2)+"\n","utf-8")
    print(f"Inventoried {len(data)} unique display candidates at {out}")
