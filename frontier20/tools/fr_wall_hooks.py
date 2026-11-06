"""Install local terrain colour/overlap/reveal fixes in a selected NTUF stage.

Importing this file never mutates a project.  The maintained NTTE project and
the delivered 2.0 packages are not installer targets.
"""
from pathlib import Path
from fr_save_hooks import apply_inroom_generation_boundary


PLAYER_WALL_PATCHES = (
    ('\tinstance_create(other.x + 8, other.y + 8, Hammerhead)',
     '\t// A packed rectangle represents many original wall tiles.\n'
     '\tvar _fr_wall_origin=scrNTTESolidWallContact(other.id,x,y,false);\n'
     '\tinstance_create(_fr_wall_origin[0]+8,_fr_wall_origin[1]+8,Hammerhead)'),
    ('\tvar _iteration = 0, _px = x, _py = y;',
     '\tvar _iteration = 0, _px = x, _py = y;\n'
     '\t// Fix the original contacted tile before ejection can move across cells.\n'
     '\tvar _fr_wall_contact=scrNTTESolidWallContact(other.id,x,y);'),
    ('\t\twith (other) {\n\t\t\t_wx = bbox_center_x\n\t\t\t_wy = bbox_center_y\n\t\t}',
     '\t\t_wx = _fr_wall_contact[0]\n\t\t_wy = _fr_wall_contact[1]'),
)

PICKUP_WALL_BEFORE = ('move_bounce_solid(true)\n'
    'move_outside_solid(point_direction(other.x + 8, other.y + 8, x, y), 2)')
PICKUP_WALL_AFTER = ('// A compact wall must eject the pickup from its contacted native cell,\n'
    '// rather than transporting it along the rectangle to a remote edge.\n'
    'var _fr_pickup_wall_origin=scrNTTESolidWallContact(other.id,x,y,false);\n'
    'move_bounce_solid(true)\n'
    'move_outside_solid(point_direction(_fr_pickup_wall_origin[0]+8, _fr_pickup_wall_origin[1]+8, x, y), 2)')


def apply_player_wall_contact(project, report):
    """Keep native tile response while retaining the compact representation."""
    path = Path(project) / 'objects/Player/Collision_Wall.gml'
    source = path.read_text('utf-8-sig')
    result = source
    for before, after in PLAYER_WALL_PATCHES:
        if after in result:
            if result.count(after) != 1 or result.count(before) != after.count(before):
                raise RuntimeError(f'NTUF Player wall contact duplicate anchor: {path}')
            continue
        if result.count(before) != 1:
            raise RuntimeError(f'NTUF Player wall contact anchor changed: {path}')
        result = result.replace(before, after, 1)
    # Validate every anchor before writing any of this event. No terrain is
    # split, no RNG consumed, and roll/Frog/secret-passage logic is untouched.
    status = 'already-applied'
    if result != source:
        path.write_text(result, 'utf-8', newline='\n')
        status = 'patched'
    report.append({'file': str(path), 'status': status})


def apply_pickup_wall_contact(project, report):
    """Preserve native tile ejection, resolving only a compact wall's cell."""
    path = Path(project) / 'objects/WepPickup/Collision_Wall.gml'
    source = path.read_text('utf-8-sig')
    if PICKUP_WALL_AFTER in source:
        if source.count(PICKUP_WALL_AFTER) != 1 or source.count(PICKUP_WALL_BEFORE) != 0:
            raise RuntimeError(f'NTUF pickup wall contact duplicate anchor: {path}')
        report.append({'file': str(path), 'status': 'already-applied'})
        return
    if source.count(PICKUP_WALL_BEFORE) != 1:
        raise RuntimeError(f'NTUF pickup wall contact anchor changed: {path}')
    path.write_text(source.replace(PICKUP_WALL_BEFORE, PICKUP_WALL_AFTER, 1), 'utf-8', newline='\n')
    report.append({'file': str(path), 'status': 'patched'})


def _script(project, name):
    return Path(project) / "scripts" / name / (name + ".gml")


def _replace(path, before, after, report, legacy=None):
    source = path.read_text("utf-8-sig")
    if after in source:
        report.append({"file": str(path), "status": "already-applied"})
        return
    if legacy is not None and legacy in source:
        if source.count(legacy) != 1:
            raise RuntimeError(f"NTUF legacy wall fix anchor changed: {path}")
        path.write_text(source.replace(legacy, after, 1), "utf-8", newline="\n")
        report.append({"file": str(path), "status": "upgraded"})
        return
    if source.count(before) != 1:
        raise RuntimeError(f"NTUF wall fix anchor changed: {path}: {before}")
    path.write_text(source.replace(before, after, 1), "utf-8", newline="\n")
    report.append({"file": str(path), "status": "patched"})


def apply(project):
    """Patch only the caller-selected project, with exact idempotent anchors."""
    project = Path(project)
    report = []
    apply_player_wall_contact(project, report)
    apply_pickup_wall_contact(project, report)
    walls = _script(project, "scrNTTESolidWalls")
    _replace(walls,
             'area=GameCont.area;solid=true;visible=false;mask_index=mskWall;',
             'area=GameCont.area;solid=true;visible=false;mask_index=mskWall;\n'
             '    // Retain actual source weather/area colour per packed piece.\n'
             '    ntte_fill_color=scrFRWallBackgroundColor();ntte_fill_color_area=area;', report,
             legacy='area=GameCont.area;solid=true;visible=false;mask_index=mskWall;\n'
                    '    // Retain actual source weather/area colour per packed piece.\n'
                    '    ntte_fill_color=scrFRWallBackgroundColor();')
    _replace(walls,
             '_v.area=_state.area;_v.image_blend=_state.blend;_v.image_alpha=_state.alpha;',
             '_v.area=_state.area;_v.image_blend=_state.blend;_v.image_alpha=_state.alpha;\n'
             '    scrFRWallCopyFillColor(_v,_state);', report,
             legacy='_v.area=_state.area;_v.image_blend=_state.blend;_v.image_alpha=_state.alpha;\n'
                    '    _v.ntte_fill_color=_state.color;')
    _replace(walls,
             '_state={area:_wall.area,blend:_wall.image_blend,alpha:_wall.image_alpha};',
             '_state={area:_wall.area,blend:_wall.image_blend,alpha:_wall.image_alpha,\n'
             '            color:scrFRWallFillColor(_wall)};', report)
    _replace(walls,
             'var _fill=UberCont.ntte_fill_visible,_color=draw_get_color(),_alpha=draw_get_alpha(),\n'
             '        _area=undefined,_base=0,_last_color=-1,_last_alpha=-1;',
             'var _fill=UberCont.ntte_fill_visible,_color=draw_get_color(),_alpha=draw_get_alpha(),\n'
             '        _last_color=-1,_last_alpha=-1;', report)
    _replace(walls,
             'if(_area!=area) {_area=area;_base=scrAreaGetBackroundColor(area,false);}\n'
             '            var _tint=scrNTTESolidWallColor(_base,image_blend);',
             'var _tint=scrNTTESolidWallColor(scrFRWallFillColor(id),image_blend);', report)
    # Border state is also a production caller of SolidWallPiece. Preserve
    # weather on its old-area half, then rebase only its new-area half.
    _replace(_script(project, "scrNTTEFullLairBorder"),
             '_state={area:_created.area,blend:_created.image_blend,alpha:_created.image_alpha};',
             '_state={area:_created.area,blend:_created.image_blend,alpha:_created.image_alpha,\n'
             '                    color:scrFRWallFillColor(_created),color_area:_created.area};', report)

    generator = _script(project, "scrNTTEFullInRoomGeneration")
    _replace(generator,
             '_background=scrAreaGetBackroundColor(GameCont.area)',
             '_background=scrFRWallBackgroundColor()', report)
    apply_inroom_generation_boundary(project, report, compact_defer=True)
    _replace(generator,
             'var _overlap_objects=[Floor,Wall,InvisiWall,TopSmall,TopPot,Bones]',
             '// Split only contacted old packed cells, and keep every resulting\n'
             '        // remainder classified as old terrain during source reconciliation.\n'
             '        _all_before=scrFRWallPrepareInRoomMerge(_all_before)\n'
             '        var _overlap_objects=[Floor,Wall,InvisiWall,TopSmall,TopPot,Bones]', report)
    _replace(generator,
             '// END NTTE INROOM OVERLAP SOURCE REPAIR V1\n    return _generation',
             '// END NTTE INROOM OVERLAP SOURCE REPAIR V1\n'
             '    // Old-map context is restored for a local area orb: only its new\n'
             '    // authored walls change biome; empty exterior keeps the room colour.\n'
             '    scrNTTESolidWallGenerate()\n'
             '    return _generation', report)
    _replace(project / "objects" / "GenCont" / "Destroy_0.gml",
             'scrNTTESolidWallGenerate();',
             'if(!scrNTTEFullValue(id,"ntte_full_sync_compact_defer",false)) scrNTTESolidWallGenerate();', report)
    _replace(_script(project, "scrNTTEFullCrystalHeart"),
             'if (real(_all[_i])>real(_generation)) array_push(_out,_all[_i])',
             'if (_all[_i].object_index!=NTTESolidWall && real(_all[_i])>real(_generation)) array_push(_out,_all[_i])', report)

    # Native Wall owns distinct body/top frame indices. NTTE uses topindex=0
    # to remove the decorative cap on a freshly authored secret corridor.
    _replace(project / "objects" / "SubTopCont" / "Draw_0.gml",
             'draw_sprite_ext(topspr, instance_is(id,NTTEFullWallFake)?topindex:image_index,',
             'draw_sprite_ext(topspr, topindex,', report)
    _replace(_script(project, "scrNTTEFullWallFakeNative"),
             'depth=_top?(_reveal?-6:-5):(_reveal?2:4)',
             '// SubTopCont is -6. A tied depth lets its later-created tops\n'
             '    // paint over the revealed room again; compose strictly afterwards.\n'
             '    depth=_top?(_reveal?-7:-5):(_reveal?2:4)', report)
    _replace(_script(project, "scrNTTEFullTop"),
             '        x=round(x); y=round(y);',
             '        // Keep ordinary wall-top occupants within a reachable lip.\n'
             '        // Deliberate islands, flying ravens and props retain their source placement.\n'
             '        scrFRWallTopConstrainSpawn(id);\n'
             '        x=round(x); y=round(y);', report)
    return report


if __name__ == "__main__":
    import argparse
    import json
    parser = argparse.ArgumentParser()
    parser.add_argument("project", type=Path)
    args = parser.parse_args()
    print(json.dumps(apply(args.project), ensure_ascii=True, indent=2))
