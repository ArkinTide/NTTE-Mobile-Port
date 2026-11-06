"""Audited native ammo consumers for per-player Frontier bonuses.

Writes only the isolated Frontier stage. Native shared baseline construction
is deliberately left intact; actual grant/cap consumers name their Player.
"""
from pathlib import Path

ROOT=Path(__file__).resolve().parents[1]


def hook_specs():
    rows=[]
    def add(path,old,new,count=1):
        rows.append({"path":path,"old":old,"new":new,"count":count})
    ammo="scripts/scrAmmoInit/scrAmmoInit.gml"
    for field,helper in (("typ_ammo","scrAmmoGetPickupAmount"),("typ_amax","scrAmmoGetTypeCapacity")):
        add(ammo,f"function {helper}(_type) {{",f"function {helper}(_type,_owner=undefined) {{\n    if(is_undefined(_owner)) _owner=id;")
        add(ammo,f"return {field}[_type]",f'return scrFRAmmoRead(_owner,"{field}",_type)')
    for index in ("_atype","_btype","_type"):
        add(ammo,f"ammo[{index}] < typ_amax[{index}]",f'ammo[{index}] < scrFRAmmoRead(id,"typ_amax",{index})')
    add("scripts/scrPlayerGiveAmmo/scrPlayerGiveAmmo.gml","typ_amax[_ammo_type]",'scrFRAmmoRead(id,"typ_amax",_ammo_type)',3)
    add("objects/AmmoPickup/Collision_Player.gml","typ_ammo[_ammo_type]",'scrFRAmmoRead(id,"typ_ammo",_ammo_type)')
    for chest in ("AmmoChest","AmmoChestMystery"):
        add(f"objects/{chest}/Collision_Player.gml","scrAmmoGetPickupAmount(_ammo_type)","scrAmmoGetPickupAmount(_ammo_type,_player)",2)
    hud="scripts/scrDrawPlayerHUD/scrDrawPlayerHUD.gml"
    add(hud,"scrAmmoGetPickupAmount(_type)","scrAmmoGetPickupAmount(_type,_player)",2)
    add(hud,"scrAmmoGetTypeCapacity(_ammo_type)","scrAmmoGetTypeCapacity(_ammo_type,_player)")
    add(hud,"scrAmmoGetTypeCapacity(type)","scrAmmoGetTypeCapacity(type,_player)")
    for script,field,index,count in (
        ("scrNTTEFullBackpackNative","typ_ammo","_type",1),
        ("scrNTTEFullBonus","typ_amax","_type",3),
        ("scrNTTEFullBonus","typ_amax","_i",1),
        ("scrNTTEFullMergedCustomStock","typ_ammo","_type",1),
        ("scrNTTEFullWeaponLoadoutNative","typ_ammo","_type",2),
    ):
        add(f"scripts/{script}/{script}.gml",f"{field}[{index}]",f'scrFRAmmoRead(id,"{field}",{index})',count)
    for script,count in (("scrNTTEFullRogueCarbine",2),("scrNTTEFullWeaponMimicProjectileNative",1)):
        add(f"scripts/{script}/{script}.gml","typ_amax[Ammo.Bullets]",'scrFRAmmoRead(creator,"typ_amax",Ammo.Bullets)',count)
    console="scripts/handle_console_command/handle_console_command.gml"
    for index in ("i","wep","bwep"):
        add(console,f"typ_amax[scr_weapon_get_type({index})]",f'scrFRAmmoRead(id,"typ_amax",scr_weapon_get_type({index}))')
    return rows


def apply(project):
    project=Path(project).resolve()
    assert project==(ROOT/"staging/project").resolve(),"Frontier development stage only"
    changes={};report=[]
    for hook in hook_specs():
        path=project/hook["path"]
        source=changes.get(path,path.read_text(encoding="utf-8-sig"))
        if source.count(hook["new"])==hook["count"] and hook["old"] not in source:
            report.append({"path":hook["path"],"read":hook["old"],"status":"already-applied"});continue
        if source.count(hook["old"])!=hook["count"]:
            raise RuntimeError(f'Frontier ammo consumer changed: {hook["path"]}: {hook["old"]!r}; expected {hook["count"]}, found {source.count(hook["old"])}')
        changes[path]=source.replace(hook["old"],hook["new"])
        report.append({"path":hook["path"],"read":hook["old"],"status":"patched"})
    for path,source in changes.items():path.write_text(source,encoding="utf8")
    return {"hooks":report}


def audit():
    """Read-only anchor validation against the maintained host baseline."""
    host=ROOT.parent/"project"
    for hook in hook_specs():
        source=(host/hook["path"]).read_text(encoding="utf-8-sig")
        assert source.count(hook["old"])==hook["count"],(hook["path"],hook["old"],source.count(hook["old"]))
    return {"status":"PASS","consumers":len(hook_specs())}


if __name__=="__main__":
    import json
    print(json.dumps(audit()))
