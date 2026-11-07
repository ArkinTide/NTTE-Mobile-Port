"""Idempotent native lifecycle hooks applied only to isolated stage projects."""
from copy import deepcopy
from pathlib import Path
import json
import re

ROOT=Path(__file__).resolve().parents[1]

def read(path): return json.loads(path.read_text(encoding="utf8"))
def save(path,data):
    path.parent.mkdir(parents=True,exist_ok=True)
    path.write_text(json.dumps(data,ensure_ascii=False,indent=2)+"\n",encoding="utf8")

def patch(project,relative,label,body,anchor=None,before=False):
    path=project/relative
    raw=path.read_bytes()
    bom=b"\xef\xbb\xbf" if raw.startswith(b"\xef\xbb\xbf") else b""
    text=raw.decode("utf-8-sig")
    begin="// BEGIN FRONTIER "+label
    end="// END FRONTIER "+label
    # Marker labels can share a prefix (e.g. SOURCE DARK / SOURCE DARK END).
    # Replace an installed block in place: removing and reinserting it after
    # its anchor leaves the insertion newline behind on every staging pass.
    # A before-anchor insertion inherits the anchor line's existing indent.
    # Both delimiters must still be exact whole lines; a longer label must
    # never be mistaken for this block. Preserve each delimiter's indent.
    starts=list(re.finditer(r"^[ \t]*"+re.escape(begin)+r"(?=\r?$)",text,re.M))
    ends=list(re.finditer(r"^[ \t]*"+re.escape(end)+r"(?=\r?$)",text,re.M))
    assert len(starts)==len(ends) and len(starts)<=1,(relative,label,"Frontier hook markers")
    block=None
    if starts:
        block=re.search(r"^(?P<begin_indent>[ \t]*)"+re.escape(begin)+r"(?P<newline>\r?\n).*?^"+
                        r"(?P<end_indent>[ \t]*)"+re.escape(end)+r"(?P<ending>\r?\n|$)",text,re.M|re.S)
        assert block is not None,(relative,label,"Frontier hook marker order")
        newline=block.group("newline")
        ending=block.group("ending")
        begin_indent=block.group("begin_indent")
        end_indent=block.group("end_indent")
    else:
        line_end=re.search(r"\r?\n",text)
        newline=line_end.group() if line_end else "\n"
        ending=newline
        begin_indent=end_indent=""
    body=body.rstrip().replace("\r\n","\n").replace("\n",newline)
    chunk=begin_indent+begin+newline+body+newline+end_indent+end+ending
    if anchor:
        anchor=anchor.replace("\r\n","\n").replace("\n",newline)
        host=text[:block.start()]+text[block.end():] if block else text
        assert host.count(anchor)==1,(relative,anchor,host.count(anchor))
    if block:
        updated=text[:block.start()]+chunk+text[block.end():]
    elif anchor:
        replacement=chunk+anchor if before else anchor+newline+chunk
        updated=text.replace(anchor,replacement,1)
    else:
        updated=text.rstrip()+newline+newline+chunk
    if updated!=text:
        path.write_bytes(bom+updated.encode("utf8"))

def add_object(project,name,parent,events,persistent=False):
    folder=project/"objects"/name;folder.mkdir(parents=True,exist_ok=True)
    template=read(project/"objects/NTTEFullUnlockCont/NTTEFullUnlockCont.yy")
    template["name"]=template["%Name"]=name
    template["persistent"]=persistent
    template["parentObjectId"]={"name":parent,"path":f"objects/{parent}/{parent}.yy"} if parent else None
    template["eventList"]=[]
    for event_type,event_num,filename,code in events:
        event={"$GMEvent":"v1","%Name":"","collisionObjectId":None,"eventNum":event_num,"eventType":event_type,"isDnD":False,"name":"","resourceType":"GMEvent","resourceVersion":"2.0"}
        template["eventList"].append(event)
        (folder/filename).write_text(code+"\n",encoding="utf8")
    save(folder/(name+".yy"),template)
    yyp_path=project/"nuclearthronemobile.yyp"; yyp=read(yyp_path)
    rel=f"objects/{name}/{name}.yy"
    if not any(r["id"]["path"]==rel for r in yyp["resources"]):yyp["resources"].append({"id":{"name":name,"path":rel}})
    save(yyp_path,yyp)

def apply_weapon_drops(project):
    """Extend the existing native chest provider at its real consumers."""
    project=Path(project)
    def hook(relative,label,body,anchor):
        text=(project/relative).read_text(encoding="utf8")
        expected="// BEGIN FRONTIER "+label+"\n"+body.rstrip()+"\n// END FRONTIER "+label
        if expected in text:
            return
        patch(project,relative,label,body,anchor=anchor)
    drop="scripts/scrNTTEFullWeaponDrop/scrNTTEFullWeaponDrop.gml"
    hook(drop,"WEAPON DROP RESOLVE",
          'var _fr_weapon=scrFRWeaponDropRaw(_raw);\nif(!is_undefined(_fr_weapon)) return _fr_weapon;',
          anchor='function scrNTTEFullWeaponDropResolve(_raw) {')
    hook(drop,"WEAPON DROP AREA",
          'var _fr_weapon=scrFRWeaponDropRaw(_raw);\nif(!is_undefined(_fr_weapon)) return scr_weapon_get_area(_fr_weapon);',
          anchor='function scrNTTEFullWeaponDropArea(_raw,_context) {')
    hook(drop,"WEAPON DROP DUPLICATES",
          'var _fr_duplicate=scrFRWeaponDropDuplicates(_raw,_nearest);\nif(!is_undefined(_fr_duplicate)) return _fr_duplicate;',
          anchor='function scrNTTEFullWeaponDropDuplicates(_raw,_nearest) {')
    # Keep the original candidate function and its NTTE-only contract intact.
    # The actual chest consumer appends every loaded Frontier raw declaration
    # before the same native shuffle/filter/select implementation runs.
    path=project/drop
    text=path.read_text(encoding="utf8")
    before='scrNTTEFullWeaponDropSelect(scrNTTEFullWeaponDropCandidates(_tutorial),'
    after='scrNTTEFullWeaponDropSelect(scrFRWeaponDropCandidates(scrNTTEFullWeaponDropCandidates(_tutorial)),'
    if after not in text:
        assert text.count(before)==1,(drop,"Frontier candidate consumer",text.count(before))
        text=text.replace(before,after,1)
        path.write_text(text,encoding="utf8")
    hook("scripts/scr_weapon_get_type/scr_weapon_get_type.gml","WEAPON DYNAMIC AREA",
          'var _fr_property=scrFRWeaponRuntimeProperty(_weapon,"area");\nif(!is_undefined(_fr_property)) return _fr_property;',
          anchor='function scr_weapon_get_area(_weapon) {')
    return {"provider":"scrNTTEFullWeaponDropDecide","consumers":5}

def apply_native_enemy_fields(project):
    """Expose initialized native state before source controllers first step."""
    # The source Cove/Lightning controllers inspect the orbit array as soon
    # as HyperCrystal exists. Native Alarm1 fills it later, so an empty array
    # is the correct pre-summon state; a scalar fallback would select an
    # unrelated object/instance in NTT's with-array semantics.
    project=Path(project)
    relative="objects/HyperCrystal/Create_0.gml"
    block="// BEGIN FRONTIER HYPER CRYSTAL ORBIT ARRAY\ncrystal=[];\n// END FRONTIER HYPER CRYSTAL ORBIT ARRAY"
    if block not in (project/relative).read_text(encoding="utf8"):
        patch(project,relative,"HYPER CRYSTAL ORBIT ARRAY","crystal=[];",anchor="crystals = 0")
    # NTT exposes this constructor field to source replacement handlers.
    # This host computes it only later in native Alarm1; expose the exact
    # same decision before Frontier replaces IDPDSpawn in its first step.
    # Campfire/HQ area zero retains the native extra-loop threshold.
    relative="objects/IDPDSpawn/Create_0.gml"
    body="freak=(GameCont.loops-(GameCont.area==0)>=3);"
    block="// BEGIN FRONTIER IDPD SPAWN FREAK\n"+body+"\n// END FRONTIER IDPD SPAWN FREAK"
    if block not in (project/relative).read_text(encoding="utf8"):
        patch(project,relative,"IDPD SPAWN FREAK",body,anchor="elite = 0")
    return {"HyperCrystal":{"crystal":[]},
            "IDPDSpawn":{"freak":"GameCont.loops-(GameCont.area==0)>=3"}}


def apply_status_timer_cleanup(project):
    """Prune a retired source status target before reading its live timer.

    Frontier_StatusEffects.step declares value inside instance_exists, then
    reads it outside that branch. A dead first target leaves it unset; a later
    dead target can inherit the previous target's timer. Keep the live update
    unchanged and remove only the invalid entry, walking backwards as authored.
    This is a specific content repair, not a default for uninitialized locals.
    """
    paths=list((Path(project)/"scripts").glob("frCode_Frontier_StatusEffects_mod_*/*.gml"))
    assert len(paths)==1,("Frontier status timer script",len(paths))
    path=paths[0]
    text=path.read_text(encoding="utf8")
    owner="function fr_Frontier_StatusEffects_mod_gml_step() {"
    assert text.count(owner)==1,("Frontier status timer owner",text.count(owner))
    live=('if (scrFRInstanceExists(scrFRIndexGet(targets, _frl_i))) {\n'
          '{\n'
          'var _frl_value = (scrFRVariableGet(scrFRIndexGet(targets, _frl_i), key) - scrFRSourceScale());\n'
          ';\n'
          'scrFRVariableSet(scrFRIndexGet(targets, _frl_i), key, _frl_value);\n'
          '}\n'
          '}')
    expiry='\nif ((_frl_value <= 0)) {'
    repair=(' else {\n'
            '// BEGIN FRONTIER RETIRED STATUS TARGET\n'
            'targets = fr_Frontier_StatusEffects_mod_gml_array_delete(targets, _frl_i);\n'
            'continue;\n'
            '// END FRONTIER RETIRED STATUS TARGET\n'
            '}')
    before=live+expiry
    after=live+repair+expiry
    if after in text:
        return {"status":"already-applied","repair":"retired status target"}
    assert text.count(before)==1,("Frontier status timer anchor",text.count(before))
    path.write_text(text.replace(before,after,1),encoding="utf8",newline="\n")
    return {"status":"patched","repair":"retired status target"}


def apply_path_grid_bounds(project):
    """Keep the source path grid's inclusive wall query inside allocated cells.

    instance_rectangle includes the right/bottom endpoints, but a wall at
    gridx+areaWidth maps to column gridw, outside the allocated grid. Retain
    the query and original collision test, rejecting only those outer cells.
    Do not clamp them into a different, valid cell or change other queries.
    """
    paths=list((Path(project)/"scripts").glob("frCode_libGeneral_mod_*/*.gml"))
    assert len(paths)==1,("Frontier path grid script",len(paths))
    path=paths[0]
    text=path.read_text(encoding="utf8")
    owner='function fr_dependencies_libGeneral_mod_gml_path_create('
    assert text.count(owner)==1,("Frontier path grid owner",text.count(owner))
    start=text.index(owner)
    end=text.index('\n// Original ',start)
    body=text[start:end]
    before='if (position_meeting(x, y, scrFRSelf(self))) {'
    after=('// FRONTIER PATH GRID HALF-OPEN WALL CELLS\n'
           'if (x >= _frl__gridx && y >= _frl__gridy\n'
           '    && x < _frl__gridx + _frl__areaWidth && y < _frl__gridy + _frl__areaHeight\n'
           '    && position_meeting(x, y, scrFRSelf(self))) {')
    if after in body:
        return {"status":"already-applied","repair":"path grid outer wall cells"}
    assert body.count(before)==1,("Frontier path grid wall anchor",body.count(before))
    body=body.replace(before,after,1)
    path.write_text(text[:start]+body+text[end:],encoding="utf8",newline="\n")
    return {"status":"patched","repair":"path grid outer wall cells"}


def apply_millipede_chain_lifetime(project):
    """Keep Undergrowth's end-step follower reads inside live chain links.

    Ordinary Step can detach a segment from a retired parent before another
    head's End Step reaches it. The chain head itself also intentionally has
    no parent; identify it by a captured ID rather than callback `other`.
    The authored spacing, visibility and complete-chain retirement stay intact.
    """
    path=Path(project)/"scripts/scrUndergrowthCallbacks/scrUndergrowthCallbacks.gml"
    text=path.read_text(encoding="utf-8-sig")
    owner="function scrUG_MillipedeSegment_end_step() {"
    assert text.count(owner)==1,"Undergrowth Millipede end-step owner changed"
    start=text.index(owner)
    end=text.index("\n// Undergrowth area::MillipedeSegment_draw",start)
    scope=text[start:end]
    old_head="\t\tvar _inst = id,"
    new_head=("\t\t// FRONTIER MILLIPEDE LIVE CHAIN PARENT\n"
              "\t\tvar _ug_head = id,\n\t\t\t_inst = id,")
    old_follow="if(id != other.id){"
    new_follow="if(id != _ug_head && instance_exists(parent)){"
    if new_head in scope and new_follow in scope:
        return {"status":"already-applied","repair":"Millipede live chain parent"}
    assert scope.count(old_head)==1,"Undergrowth Millipede head anchor changed"
    assert scope.count(old_follow)==1,"Undergrowth Millipede follower anchor changed"
    scope=scope.replace(old_head,new_head,1).replace(old_follow,new_follow,1)
    path.write_text(text[:start]+scope+text[end:],encoding="utf8",newline="\n")
    return {"status":"patched","repair":"Millipede live chain parent"}


def apply_cyberspace_revive(project):
    """Retain durable native state across the source's Revive/Alarm0 API.

    The source-specific compiler boundary dispatches the original pair of
    events to a native adapter. Capture the dead Robot before native weapon
    drops, then reconcile only its first real Wibbly respawn bonus branch.
    The native ordinary co-op Revive object/events remain unchanged.
    """
    project=Path(project)
    relative="objects/Player/Destroy_0.gml"
    body="scrFRCyberspaceRememberPlayer(id);"
    marker="// BEGIN FRONTIER CYBERSPACE DEAD PLAYER STATE\n"+body+"\n// END FRONTIER CYBERSPACE DEAD PLAYER STATE"
    destroy=(project/relative).read_text(encoding="utf8")
    # Validate both owners before writing either disposable project file.
    assert destroy.count("snd_stop(sndFishTB)")==1,"Cyberspace native Player Destroy anchor changed"
    paths=list((project/"scripts").glob("frCode_wibbly_mod_*/*.gml"))
    assert len(paths)==1,("Cyberspace Wibbly respawn script",len(paths))
    path=paths[0];text=path.read_text(encoding="utf8")
    owner="function fr_dependencies_wibbly_mod_gml_PlayerManager_step() {"
    assert text.count(owner)==1,"Cyberspace Wibbly respawn owner changed"
    start=text.index(owner);end=text.index("\n// Original ",start)
    scope=text[start:end]
    respawn="if ((scrFRIndexGet(livingPlayers, _frl__index) == 0)) {"
    assert scope.count(respawn)==1,"Cyberspace Wibbly respawn branch changed"
    branch_start=scope.index(respawn)
    before="var _frl__ammoType = 1;"
    assert scope[branch_start:].count(before)==1,"Cyberspace Wibbly respawn entry anchor changed"
    capture=("// BEGIN FRONTIER CYBERSPACE RESPAWN ENTRY\n"
             "scrFRCyberspaceRespawnBegin(id);\n"
             "// END FRONTIER CYBERSPACE RESPAWN ENTRY\n")
    anchor="if ((accuracy < 0)) {\n{\naccuracy = 0;\n;\n}\n}"
    addition=("\n// BEGIN FRONTIER CYBERSPACE RESPAWN TOTALS\n"
              "scrFRCyberspaceRespawnReady(id);\n"
              "// END FRONTIER CYBERSPACE RESPAWN TOTALS")
    assert scope.count(anchor)==1,"Cyberspace Wibbly respawn totals anchor changed"
    if marker not in destroy:
        patch(project,relative,"CYBERSPACE DEAD PLAYER STATE",body,anchor="snd_stop(sndFishTB)",before=True)
    if capture not in scope:
        scope=scope[:branch_start]+scope[branch_start:].replace(before,capture+before,1)
    if addition not in scope:
        scope=scope.replace(anchor,anchor+addition,1)
    path.write_text(text[:start]+scope+text[end:],encoding="utf8",newline="\n")
    return {"status":"ready","adapter":"source Cyberspace Revive only"}


def apply(project):
    project=Path(project).resolve()
    assert project== (ROOT/"staging/project").resolve(),"Frontier development stage only"
    apply_weapon_drops(project)
    apply_native_enemy_fields(project)
    apply_status_timer_cleanup(project)
    apply_path_grid_bounds(project)
    apply_millipede_chain_lifetime(project)
    apply_cyberspace_revive(project)
    add_object(project,"FRWorld",None,[
        (0,0,"Create_0.gml","scrFRWorldInit();"),
        (3,1,"Step_1.gml","scrFRWorldBegin();"),
        (3,0,"Step_0.gml","scrFRWorldStep();"),
        (3,2,"Step_2.gml","scrFRWorldEnd();"),
        (8,0,"Draw_0.gml",'scrFRHook("draw",[]);'),
        (8,64,"Draw_64.gml",'scrFRHook("draw_gui",[]);'),
        (8,73,"Draw_73.gml",'scrFRHook("draw_gui_end",[]);'),
    ],True)
    add_object(project,"FRFireCont",None,[
        (0,0,"Create_0.gml","visible=false;persistent=false;fr_fire_owner=noone;fr_fire_serial=scrFRLogicSerial();"),
        (3,1,"Step_1.gml",""),(3,0,"Step_0.gml",""),
        (3,2,"Step_2.gml","scrFRFireContFinalize();"),
        (8,0,"Draw_0.gml",""),
    ])
    patch(project,"objects/UberCont/Create_0.gml","BOOT",'if(!instance_exists(FRWorld)) instance_create(0,0,FRWorld);')
    patch(project,"objects/UberCont/Draw_64.gml","PAUSED SOURCE HUD",'if(paused && !want_pause) scrFRHook("draw_pause",[]);')
    patch(project,"objects/GameCont/Create_0.gml","RUN START",'if(scrFREnabled() && instance_exists(FRWorld)) {\n    FRWorld.fr_previous_game=id;\n    scrFRSkillsInit();\n    scrFRHook("game_start",[]);\n    scrFRWeaponsRefresh();\n}')
    patch(project,"scripts/scrFire/scrFire.gml","WEAPON FIRE",'if(scrFRWeaponFire(_wep,_primary)) { } else',anchor='\tif (_wep >= wep_ntte_bubble_bat && _wep <= wep_ntte_last) {',before=True)
    patch(project,"scripts/scrPlayerFiring/scrPlayerFiring.gml","WEAPON INPUT",'if(scrFRWeaponInput(wep,_primary)) return;',anchor='function scrPlayerFiring(_primary = true) {')
    patch(project,"objects/Player/Step_0.gml","WEAPON CARRIER STEP","scrFRWeaponStep();")
    patch(project,"objects/Player/Destroy_0.gml","WEAPON PRIMARY DEATH DROP",
          "scrFRWeaponPickupAdopt(id,other.ntte_state);",anchor='\tcurse = other.curse')
    patch(project,"objects/Player/Destroy_0.gml","WEAPON SECONDARY DEATH DROP",
          "scrFRWeaponPickupAdopt(id,other.bntte_state);",anchor='\tcurse = other.bcurse')
    patch(project,"scripts/scrPowers/scrPowers.gml","WEAPON CHICKEN THROW",
          "scrFRWeaponPickupAdopt(id,other.ntte_state);",anchor='\t\t\t\twith scrWeaponPickupCreate(x, y, wep) {')
    patch(project,"scripts/scrPowers/scrPowers.gml","WEAPON CUZ THROW STATES",
          "var _fr_throw_states=ntte_extra_states;",anchor='function scrCuzThrowAllAbility() {')
    patch(project,"scripts/scrPowers/scrPowers.gml","WEAPON CUZ THROW FIRE",
          'if(i<array_length(_fr_throw_states) && is_struct(_fr_throw_states[i])\n'
          '    && is_struct(_fr_throw_states[i][$ "fr_source_weapon"]??undefined)) {\n'
          '    ntte_state=_fr_throw_states[i];scrFRWeaponSlotsSync(id);\n}',
          anchor='\t\twep = _wep')
    patch(project,"scripts/scrPowers/scrPowers.gml","WEAPON CUZ THROW DROP",
          "if(i<array_length(_fr_throw_states)) scrFRWeaponPickupAdopt(id,_fr_throw_states[i]);",
          anchor='\t\twith (scrWeaponPickupCreate(x, y, _wep)) {')
    patch(project,"scripts/scrPowers/scrPowers.gml","WEAPON CUZ THROW REMOVE",
          "if(i<array_length(_fr_throw_states)) array_delete(_fr_throw_states,i,1);",
          anchor='\t\tarray_delete(_weps, i, 1)')
    patch(project,"objects/Player/Step_0.gml","WEAPON PRIMARY RELOAD","scrFRWeaponReloaded(true);",anchor='\t\tif (reload <= 0) {')
    patch(project,"objects/Player/Step_0.gml","WEAPON SECONDARY RELOAD","scrFRWeaponReloaded(false);",anchor='\t\tif (breload <= 0) {')
    for getter,prop in (("scr_weapon_get_cost","cost"),("scr_weapon_get_load","load"),("scr_weapon_get_sprite","sprt"),("scr_weapon_is_auto","auto")):
        patch(project,"scripts/scr_weapon_get_type/scr_weapon_get_type.gml","WEAPON DYNAMIC "+prop.upper(),
              'var _fr_property=scrFRWeaponRuntimeProperty(_weapon,"'+prop+'");\nif(!is_undefined(_fr_property)) return _fr_property;',
              anchor='function '+getter+'(_weapon) {')
    patch(project,"objects/MenuOptions/Create_0.gml","OPTION ENUM","",anchor='\tNUM_MENU_OPTIONS')
    enum_path=project/"objects/MenuOptions/Create_0.gml"
    enum_text=enum_path.read_text(encoding="utf8").replace('\tNUM_MENU_OPTIONS','\tFrontier, Frontier_Page,\n\tNUM_MENU_OPTIONS')
    enum_text=enum_text.replace('\tFrontier, Frontier_Page,\n\tFrontier, Frontier_Page,','\tFrontier, Frontier_Page,')
    enum_path.write_text(enum_text,encoding="utf8")
    patch(project,"objects/MenuOptions/Other_20.gml","OPTIONS PAGES","scrFRMenuOptionsBuild();")
    patch(project,"scripts/custom_sound_check/custom_sound_check.gml","SOUND REPLACEMENTS",'if(variable_global_exists("fr_enabled") && global.fr_enabled) snd=scrFRSoundResolve(snd);',anchor='function custom_sound_check(snd) {')
    patch(project,"scripts/scrDrawBloom/scrDrawBloom.gml","SOURCE BLOOM",'scrFRHook("draw_bloom",[]);',anchor='    scrNTTEFullProjectileBloomDraw();')
    patch(project,"scripts/scrDarkness/scrDarkness.gml","SOURCE DARK",'scrFRDarkDraw("draw_dark",_xview,_yview);',anchor='\tscrNTTEFullWorldDarkDraw(true,_xview,_yview);')
    patch(project,"scripts/scrDarkness/scrDarkness.gml","SOURCE DARK END",'scrFRDarkDraw("draw_dark_end",_xview,_yview);',anchor='\tscrNTTEFullWorldDarkDraw(false,_xview,_yview);')
    skills="scripts/scrSkills/scrSkills.gml"
    patch(project,skills,"SKILL METADATA","scrFRSkillsInit();",anchor='    scrNTTEFullSkillMetadataInit()')
    patch(project,skills,"SKILL GET","if(_skill>=38 && !is_undefined(scrFRSkillKey(_skill))) return scrFRGetSkill(_skill);",anchor='function scr_skill_get(_skill) {')
    for getter,callback,default in (("name","skill_name",'"MUT"+string(_skill)'),("text","skill_text",'"???"'),("sound","skill_sound","-1"),("tips","skill_tip",'""')):
        patch(project,skills,"SKILL DYNAMIC "+getter.upper(),
              f'if(_skill>=38 && !is_undefined(scrFRSkillKey(_skill))) return scrFRWeaponProperty(scrFRSkillKey(_skill),"{callback}",{default});',
              anchor=f'function scr_skill_get_{getter}(_skill) {{')
    patch(project,skills,"SKILL SET","if(_skill>=38 && !is_undefined(scrFRSkillKey(_skill))) return scrFRSetSkill(_skill,_value);",anchor='function scr_skill_set(_skill, _value) {')
    patch(project,skills,"SKILL AVAIL","if(_skill>=38 && !is_undefined(scrFRSkillKey(_skill))) return scrFRSkillAvailable(_skill);\nif(variable_global_exists(\"fr_skill_pool\") && !(global.fr_skill_pool[$ string(_skill)]??true)) return false;",anchor='function scr_skill_can_appear(_skill) {')
    patch(project,"scripts/scrNTTEFullSystems/scrNTTEFullSystems.gml","SKILL ICON","if(_skill>=38 && !is_undefined(scrFRSkillKey(_skill))) return scrFRSkillIcon(_skill,_button);",anchor='function scrNTTEFullSkillIcon(_skill,_button=false) {')
    return {"status":"STAGED_NOT_RUNTIME_VERIFIED","world":"FRWorld","fire_proxy":"FRFireCont"}

if __name__=="__main__":print(json.dumps(apply(ROOT/"staging/project")))
