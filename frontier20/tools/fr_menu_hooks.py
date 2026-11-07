"""Native touch menu, debugger plain labels and locked Storms artwork."""
from pathlib import Path
import json
import shutil

ROOT=Path(__file__).resolve().parents[1]

def replace(project,relative,before,after):
    path=Path(project)/relative
    text=path.read_text('utf-8-sig')
    if after in text: return
    assert text.count(before)==1,(relative,before)
    path.write_text(text.replace(before,after,1),'utf8',newline='\n')

def apply(project):
    project=Path(project)
    resource='sprFRStormsLoadout'
    # Text-only source releases retain the .yy template and derivation tool;
    # rebuild these four PNGs from the restored original NTUF artwork.
    artwork=ROOT/'native/menu-assets'/resource
    sprite=json.loads((artwork/(resource+'.yy')).read_text('utf8'))
    layer=sprite['layers'][0]['name']
    expected=[artwork/(f['name']+'.png') for f in sprite['frames']]
    expected += [artwork/'layers'/f['name']/(layer+'.png') for f in sprite['frames']]
    if not all(path.is_file() for path in expected):
        from generate_frontier_menu_art import generate
        generate()
    shutil.copytree(ROOT/'native/menu-assets'/resource,project/'sprites'/resource,dirs_exist_ok=True)
    yyp=project/'nuclearthronemobile.yyp'
    data=json.loads(yyp.read_text('utf8'))
    rel=f'sprites/{resource}/{resource}.yy'
    if not any(r['id']['path']==rel for r in data['resources']):
        data['resources'].append({'id':{'name':resource,'path':rel}})
        yyp.write_text(json.dumps(data,ensure_ascii=False,indent=2)+'\n','utf8')
    replace(project,'scripts/scrNTTEFullCrownLoadoutNative/scrNTTEFullCrownLoadoutNative.gml',
            'if(scrFRCrownKey(_crown)!="") return [scrFRCrownSprite("Loadout"),0];',
            'if(scrFRCrownKey(_crown)!="") return [sprFRStormsLoadout,_unlocked?0:1];')
    # The same group order drives drawing and click rectangles.
    path=project/'objects/CustomModeWeaponSelector/Other_11.gml'
    path.write_text('// Native NTTE/NTUF category metadata, before and during runs.\nscrFRCustomWeaponGroups();\n','utf8')
    replace(project,'objects/CustomModeWeaponSelector/Other_10.gml',
            '(i == 0) ? 0 : ((i == 1) ? _group_count - 1 : i - 1)',
            'scrFRCustomWeaponGroupOrder(i,_group_count)')
    replace(project,'scripts/scr_create_debug_overlay_views/scr_create_debug_overlay_views.gml',
            '\tscr_debug_overlay_load()', '\tscrFRDebugFonts()\n\tscr_debug_overlay_load()')
    replace(project,'scripts/scr_create_debug_overlay_views/scr_create_debug_overlay_views.gml',
            'dbg_button(scrAreaGetName(_area),', 'dbg_button(scrFRDebugAreaLabel(_area),')
    replace(project,'scripts/scr_create_debug_overlay_views/scr_create_debug_overlay_views.gml',
            'scrAreaGetMapName(_area, _subarea, 0, false, false),',
            'scrFRDebugAreaLabel(_area,_subarea),')
    return {'menu_repairs':'native data rows, 77 NTUF weapons, debugger CJK and locked crown'}
