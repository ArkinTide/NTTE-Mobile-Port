"""Preserve source police reservations at the native room-clear boundary."""
from pathlib import Path
from fr_content_hooks import patch


def apply(project):
    project = Path(project)
    paths = list((project / "scripts").glob("frCode_CustomIDPDHandler_mod_*/*.gml"))
    assert len(paths) == 1
    path = paths[0]
    source = path.read_text(encoding="utf8")
    opening = 'name = "IDPDPortal";'
    patched = opening + '\nfr_pending_police_spawn=true;'
    if patched not in source:
        assert source.count(opening) == 1
        source = source.replace(opening, patched, 1)
    spawn = 'scrFRModCall("mod", scrFRIndexGet(on_spawn, 0), scrFRIndexGet(on_spawn, 1));'
    done = spawn + '\nfr_pending_police_spawn=false;'
    if done not in source:
        assert source.count(spawn) == 1, "Source police spawn callback anchor changed"
        source = source.replace(spawn, done, 1)
    path.write_text(source, encoding="utf8")
    patch(project, "scripts/scr_check_enemies/scr_check_enemies.gml", "PENDING POLICE CLEAR",
          '_count+=scrFRPendingPoliceCount();', anchor='    return _count>_amount', before=True)
    relative = "objects/Corpse/Alarm_0.gml"
    path = project / relative
    source = path.read_text(encoding="utf8")
    old = 'if !instance_exists(IDPDSpawn) && !(instance_exists(Nothing2Appear)'
    new = 'if !instance_exists(IDPDSpawn) && scrFRPendingPoliceCount()==0 && !(instance_exists(Nothing2Appear)'
    if new not in source:
        assert source.count(old) == 1
        path.write_text(source.replace(old, new, 1), encoding="utf8")
    return {"pending_police_handoff": True}
