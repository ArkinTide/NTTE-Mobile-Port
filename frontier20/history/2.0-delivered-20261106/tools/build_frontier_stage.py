"""Build only the isolated Frontier stage. Existing maintained source is read-only.

Media inherited from the baseline are hardlinks: this builder never overwrites
an existing baseline bitmap/audio file. Every new resource is prefixed FR.
"""
from pathlib import Path
import hashlib
import importlib.util
import json
import re
import shutil
import sys

ROOT = Path(__file__).resolve().parents[1]
PROJECT = ROOT / "staging/project"
GENERATED = ROOT / "generated-code"
TOOLS = ROOT / "tools"
REQUIRED_DEPS = {"lib", "libGeneral", "libMenu", "libSaves", "libEvents",
                 "libWeps", "libPickups", "libMuts", "libAreas", "wibbly", "campfire",
                 "Frontier_IrisProjectiles"}

def read(path):
    return json.loads(re.sub(r",(?=\s*[}\]])", "", path.read_text(encoding="utf-8-sig")))

def save(path, value):
    path.parent.mkdir(parents=True, exist_ok=True)
    path.write_text(json.dumps(value, ensure_ascii=False, indent=2) + "\n", encoding="utf8")

def copy_asset(source, target):
    source, target = Path(source), Path(target)
    if target.is_file():
        original, staged = source.stat(), target.stat()
        if original.st_size == staged.st_size and original.st_mtime_ns == staged.st_mtime_ns:
            return str(target)
    return shutil.copy2(source, target)

def stage():
    assert (PROJECT / "nuclearthronemobile.yyp").is_file(), "Copy baseline before staging"
    yyp_path = PROJECT / "nuclearthronemobile.yyp"
    yyp = read(yyp_path)
    resources = {r["id"]["path"]: r for r in yyp["resources"]}
    receipts = []

    def script(name, text):
        rel = f"scripts/{name}/{name}.yy"
        template = read(PROJECT / "scripts/scrNTTEFullAreas/scrNTTEFullAreas.yy")
        template["name"] = template["%Name"] = name
        save(PROJECT / rel, template)
        target = PROJECT / f"scripts/{name}/{name}.gml"
        target.write_text(text.rstrip()+"\n", encoding="utf8")
        resources[rel] = {"id": {"name": name, "path": rel}}
        receipts.append({"kind": "script", "path": target.relative_to(PROJECT).as_posix(), "sha256": hashlib.sha256(target.read_bytes()).hexdigest()})

    assets = read(ROOT / "generated-assets/resources.json")
    for resource in assets:
        rel = resource["id"]["path"]
        source_dir = ROOT / "generated-assets" / Path(rel).parent
        target_dir = PROJECT / Path(rel).parent
        assert resource["id"]["name"].startswith(("sprFR_", "sprFRBase_", "sndFR_"))
        shutil.copytree(source_dir, target_dir, dirs_exist_ok=True, copy_function=copy_asset)
        resources[rel] = resource

    manifest = read(GENERATED / "registration-manifest.json")
    active = []
    for module in manifest["modules"]:
        source = module["source"]
        if source.endswith(".ntgml"):
            continue
        if source.startswith("dependencies/") and module["module_key"].split(":",1)[1] not in REQUIRED_DEPS:
            continue
        active.append(module)
        name = "frCode_" + re.sub(r"\W", "_", Path(source).stem)[:38] + "_" + hashlib.sha256(source.encode()).hexdigest()[:10]
        script(name, (GENERATED / (re.sub(r"\W", "_", source)+".gml")).read_text(encoding="utf8"))

    # Follow the authored loader's groups. Registering everything alphabetically
    # made Areas/Characters visible before Main and the object registries existed.
    def load_order(module):
        source = module["source"]
        first = {"custom_options.mod.gml":0, "Frontier_Main.mod.gml":1,
                 "CustomIDPDHandler.mod.gml":2}
        if source.startswith("dependencies/"): return (-1, source)
        if source in first: return (0, str(first[source]))
        group = source.split("/",1)[0]
        groups = {"Objects":2,"Areas":3,"Characters":4,"Crowns":5,
                  "Mutations":6,"Skins":7,"Trinkets":8,"Weapons":9}
        return (groups.get(group,1),source.casefold())
    identity_modules=list(active)
    active.sort(key=load_order)
    registration = ["// Generated from the parsed, audited module manifest.", "function scrFRRegisterModules() {"]
    seen = set()
    for module in active:
        key=module["module_key"]
        assert key not in seen, f"duplicate active module {key}"
        seen.add(key)
        fields=", ".join(json.dumps(k)+":"+v for k,v in module["callbacks"].items())
        registration.append(f"    scrFRRegisterModule({json.dumps(key)}, {{{fields}}});")
        kind=key.split(":",1)[0]
        source=module["source"].removeprefix("dependencies/")
        for suffix in (".mod.gml", ".area.gml", ".wep.gml", ".race.gml", ".skill.gml", ".skin.gml", ".crown.gml"):
            source=source.removesuffix(suffix)
        registration.append(f"    global.fr_module_aliases[$ {json.dumps(kind+':'+source)}]={json.dumps(key)};")
    registration.append("}")
    script("scrFrontierModules", "\n".join(registration))

    asset_lines=["function scrFRRegisterAssets() {"]
    asset_manifest=read(ROOT/"generated-assets/manifest.json")
    for asset in asset_manifest["assets"]:
        if asset["kind"]=="sound":
            path=asset["path"].lower()
            asset_lines.append(f"    global.fr_sound_assets[$ {json.dumps(path)}]={asset['resource']};")
    for call in read(ROOT/"generated-assets/asset-manifest.json")["artwork"]:
        asset_lines.append(f"    global.fr_asset_sources[$ {json.dumps(call['source']+':'+str(call['line']))}]={call['native_resource']};")
    for path, variants in read(ROOT/"generated-assets/path-lookup.json").items():
        # Dynamic replacement arrays have their own declared variant. Static
        # sites above retain exact frame/origin identities; path fallback is
        # only used by source APIs whose argument is assembled at runtime.
        for alias in (path, "../"+path):
            asset_lines.append(f"    global.fr_asset_sources[$ {json.dumps(alias)}]={variants[0]['resource']};")
    asset_lines += ["}", "function scrFRAssetAtSource(_source,_line) {", "    var _key=_source+\":\"+string(_line);", "    assert(variable_struct_exists(global.fr_asset_sources,_key),\"Unknown Frontier declared asset \"+_key);", "    return global.fr_asset_sources[$ _key];", "}"]
    script("scrFrontierAssets", "\n".join(asset_lines))

    identities=["function scrFRRegisterIdentities() {", "    scrFRRegisterAreas();"]
    ledger={"weapons":{}, "skills":{}, "races":{}}
    for i,module in enumerate(m for m in identity_modules if m["module_key"].startswith("weapon:")):
        key=module["module_key"]; name=key.split(":",1)[1]; wid=179+i
        ledger["weapons"][key]=wid
        for alias in (name, "Weapons/"+name, "weapons/"+name, key):
            identities.append(f"    global.fr_weapon_ids[$ {json.dumps(alias)}]={wid};")
        identities.append(f"    global.fr_weapon_keys[$ \"{wid}\"]={json.dumps(key)};")
        for field,default in {"name":json.dumps(name),"type":"0","cost":"0","load":"1","area":"-1","auto":"false","sprt":"sprDefault","text":"\"\"","swap":"sndSwapPistol","mele":"false","gold":"false","rads":"0","lout":"-1","naim":"false"}.items():
            identities.append(f"    wep_{field}[{wid}]={default};")
    identities.append(f"    maxwep={178+len(ledger['weapons'])};")
    for i,module in enumerate(m for m in identity_modules if m["module_key"].startswith("skill:")):
        key=module["module_key"]; sid=38+i; ledger["skills"][key]=sid
        identities += [f"    global.fr_skill_ids[$ {json.dumps(key.split(':',1)[1])}]={sid};",f"    global.fr_skill_keys[$ \"{sid}\"]={json.dumps(key)};"]
    for i,module in enumerate(m for m in identity_modules if m["module_key"].startswith("race:")):
        key=module["module_key"]; rid=19+i; ledger["races"][key]=rid
        identities += [f"    global.fr_race_ids[$ {json.dumps(key.split(':',1)[1])}]={rid};",f"    global.fr_race_keys[$ \"{rid}\"]={json.dumps(key)};"]
    identities.append("}")
    script("scrFrontierIdentities", "\n".join(identities))
    ledger_path=ROOT/"staging/identity-ledger.json"
    if ledger_path.exists():
        assert read(ledger_path)==ledger, "Existing Frontier content IDs must remain stable"
    save(ledger_path,ledger)

    for native in sorted((ROOT/"native").glob("*.gml")):
        if native.stem in {"actors","races"}: continue # object/race utilities own these scripts
        script("scrFrontier_"+native.stem, native.read_text(encoding="utf8"))

    for filename in ("fr_actor_objects.py", "fr_ntte_hooks.py", "fr_area_hooks.py", "fr_crown_hooks.py", "fr_content_hooks.py", "fr_legacy_hooks.py", "fr_race_hooks.py", "fr_player_hooks.py", "fr_save_hooks.py", "fr_unlock_hooks.py", "fr_prompt_hooks.py", "fr_ammo_hooks.py", "fr_iris_hooks.py", "fr_input_hooks.py", "fr_test_hooks.py"):
        path=TOOLS/filename
        if not path.is_file(): continue
        spec=importlib.util.spec_from_file_location(path.stem,path); tool=importlib.util.module_from_spec(spec);spec.loader.exec_module(tool)
        if hasattr(tool,"apply"):
            tool.apply(PROJECT)

    # The helpers may register native actor resources into yyp themselves.
    latest=read(yyp_path)
    if not any(f["folderPath"]=="folders/Frontier.yy" for f in latest["Folders"]):
        latest["Folders"].append({"$GMFolder":"", "%Name":"Frontier", "folderPath":"folders/Frontier.yy", "name":"Frontier", "resourceType":"GMFolder", "resourceVersion":"2.0"})
    for resource in latest["resources"]: resources[resource["id"]["path"]]=resource
    latest["resources"]=list(resources.values())
    save(yyp_path,latest)
    # Display/package metadata changes only; GAME_BUILD3004 remains the
    # established native save protocol rather than a release counter.
    uber=PROJECT/"objects/UberCont/Create_0.gml"
    version_source=uber.read_text(encoding="utf8")
    version_source,count=re.subn(r'#macro GAME_VERSION "[^"]+"','#macro GAME_VERSION "2.0"',version_source)
    assert count==1
    uber.write_text(version_source,encoding="utf8")
    updater=PROJECT/"scripts/scrNTTEUpdate/scrNTTEUpdate.gml"
    update_source=updater.read_text(encoding="utf8")
    for macro,value in (("NTTE_RELEASE_NUMBER","96"),("NTTE_RELEASE_TAG",'"2.0"'),
                        ("NTTE_RELEASE_VERSION",'"2.0.0"')):
        update_source,count=re.subn(r'(#macro '+macro+r') [^\r\n]+',r'\g<1> '+value,update_source)
        assert count==1,macro
    # Updater comparison keeps a three-component canonical version while
    # the requested public game and package version is2.0.
    updater.write_text(update_source,encoding="utf8")
    for platform in ("android","ios","windows"):
        option_path=PROJECT/f"options/{platform}/options_{platform}.yy"
        option=read(option_path)
        option[f"option_{platform}_version"]="2.0.0.0" if platform=="windows" else "2.0"
        if platform=="ios": option["option_ios_build_number"]=96
        save(option_path,option)
    save(ROOT/"staging/build-receipt.json",{"status":"DEVELOPMENT_NOT_PLAYABLE_VERIFIED", "active_modules":len(active), "assets":len(assets), "identities":ledger, "script_hashes":receipts})
    print(json.dumps({"active_modules":len(active),"new_assets":len(assets),"scripts":len(receipts),"resources":len(latest["resources"])}))

if __name__=="__main__": stage()
