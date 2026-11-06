"""Keep source dispatch intact while excluding known absent optional phases."""
from pathlib import Path
import re


PHASES = {"late_step": "late_step", "end_step": "end_step",
          "create_update": "update", "create_end_update": "end_update"}
SNAPSHOT_FIELDS = ("loadedPackages", "scriptReferences", "activeReferences", "activeHooks",
                   "updateid", "endupdateid", "level_loading", "canLoad", "bind_late_step",
                   "bind_end_step", "previousmutations")
STORAGE_QUERY = 'scrFRMatching(FRCustomObject, "name", "libGlobal")'
STORAGE_COLLECTOR = 'scrFRLibStorageInstances()'
STORAGE_QUERY_COUNT = 4


def storage_snapshot_block(direct=False):
    lines = []
    for field in SNAPSHOT_FIELDS:
        read = ('scrFRVariableGet(scrFRIndexGet(_frl__global, 0), "' + field + '")' if direct
                else 'fr_dependencies_lib_mod_gml_GlobalGet("' + field + '")')
        lines.append('global.fr_module_vars[$ "mod:lib"].' + field + ' = ' + read + ';\n;')
    return "\n".join(lines)


def storage_snapshot_wrapper():
    return ("// FRONTIER LIB UNIQUE STORAGE READS BEGIN\nif (scrFRLibStorageOracle()) {\n"
            + storage_snapshot_block() + "\n} else {\n" + storage_snapshot_block(True)
            + "\n}\n// FRONTIER LIB UNIQUE STORAGE READS END")


MUTATION_START = ('{\nvar _frl_i = 0;\nfor (; ((_frl_i < array_length(fr_dependencies_lib_mod_gml_GlobalGet("previousmutations"))) '
                  '|| (_frl_i < array_length(_frl_mutations))); _frl_i++) {')


def mutation_source_loop(body):
    assert body.count(MUTATION_START) == 1, "Frontier lib unchanged mutation loop anchor changed"
    start = body.index(MUTATION_START)
    depth = 0
    # Source strings/comments do not participate in GML brace nesting.
    for token in re.finditer(r'"(?:\\.|[^"\\])*"|//[^\n]*|/\*[\s\S]*?\*/|[{}]', body[start:]):
        value = token.group()
        if value == "{":
            depth += 1
        elif value == "}":
            depth -= 1
            if depth == 0:
                raw = body[start:start + token.end()]
                assert raw.count('fr_dependencies_lib_mod_gml_GlobalSet("previousmutations", _frl_mutations);') == 1, "Frontier lib mutation source write changed"
                return raw
    raise AssertionError("Frontier lib mutation source block is unbalanced")


def mutation_guard_block(raw):
    return ('// FRONTIER LIB UNCHANGED MUTATIONS BEGIN\n'
            'if (!scrFRLibMutationsUnchanged(_frl_mutations)) ' + raw
            + '\n// FRONTIER LIB UNCHANGED MUTATIONS END')


def apply(project):
    project = Path(project)
    writes = {}
    candidates = list((project / "scripts").glob("frCode_lib_mod_*/frCode_lib_mod_*.gml"))
    assert len(candidates) == 1, "Frontier lib compiled script is ambiguous"
    path = candidates[0]
    source = path.read_text(encoding="utf-8-sig")
    start = source.index("function fr_dependencies_lib_mod_gml_step(")
    end = source.find("\n// Original", start + 1)
    if end < 0:
        end = len(source)
    body = source[start:end]
    wrapper = storage_snapshot_wrapper()
    if "// FRONTIER LIB UNIQUE STORAGE READS BEGIN" in body:
        assert body.count(wrapper) == 1, "Frontier lib unique storage read wrapper changed"
    else:
        raw = storage_snapshot_block()
        assert body.count(raw) == 1, "Frontier lib unique storage read anchor changed"
        # The original source's unique-instance/staleness test and rebuild
        # branch are retained. These eleven reads are contiguous, with no
        # callback or mutation between their already-completed lookup.
        assert body.count('scrFRIndexGet(_frl__global, 0).lastUpdatedFrame = scrFRSourceFrame();') == 1, "Frontier lib unique storage branch changed"
        body = body.replace(raw, wrapper, 1)
    mutation_raw = mutation_source_loop(body)
    guarded = mutation_guard_block(mutation_raw)
    if "// FRONTIER LIB UNCHANGED MUTATIONS BEGIN" in body:
        assert body.count(guarded) == 1, "Frontier lib unchanged mutation guard changed"
    else:
        body = body.replace(mutation_raw, guarded, 1)
    source = source[:start] + body + source[end:]
    anchor = 'scrFRWithValues(fr_dependencies_lib_mod_gml_GlobalGet("activeHooks"))'
    for name, phase in PHASES.items():
        start = source.index("function fr_dependencies_lib_mod_gml_" + name + "(")
        end = source.find("\n// Original", start + 1)
        if end < 0:
            end = len(source)
        body = source[start:end]
        replacement = 'scrFRWithValues(scrFRLibPhaseHooks(fr_dependencies_lib_mod_gml_GlobalGet("activeHooks"),"' + phase + '"))'
        if replacement in body:
            continue
        assert body.count(anchor) == 1, (name, "Frontier phase dispatcher anchor changed")
        source = source[:start] + body.replace(anchor, replacement, 1) + source[end:]
    # Only this fixed class/name query bypasses the generic array/filter
    # adapters. Every call still performs a fresh native enumeration, including
    # duplicate, missing, renamed and deactivated storage identities.
    if STORAGE_COLLECTOR in source:
        assert source.count(STORAGE_COLLECTOR) == STORAGE_QUERY_COUNT and STORAGE_QUERY not in source, "Frontier lib storage collector anchors changed"
    else:
        assert source.count(STORAGE_QUERY) == STORAGE_QUERY_COUNT, "Frontier lib storage query anchors changed"
        source = source.replace(STORAGE_QUERY, STORAGE_COLLECTOR)
    writes[path] = source
    for relative, anchor in [
        ("scripts/scrFrontier_registry/scrFrontier_registry.gml", "    array_push(global.fr_module_order,_key);"),
        ("scripts/scrFrontier_offline_lib/scrFrontier_offline_lib.gml", "    global.fr_initialized[$ _key]=true;"),
    ]:
        path = project / relative
        text = path.read_text(encoding="utf-8-sig")
        replacement = anchor + "\n    scrFRLibPhaseRegistryChanged(); // FRONTIER OPTIONAL PHASE CACHE"
        if replacement not in text:
            assert text.count(anchor) == 1, (relative, "Frontier module lifecycle anchor changed")
            text = text.replace(anchor, replacement, 1)
        writes[path] = text
    for path, text in writes.items():
        path.write_text(text, encoding="utf8", newline="\n")
    return {"optional_phase_filter": list(PHASES.values()), "ownership_dispatch": "original",
            "unique_storage_direct_reads": len(SNAPSHOT_FIELDS), "unchanged_mutation_fastpath": True,
            "fresh_native_storage_queries": STORAGE_QUERY_COUNT}
