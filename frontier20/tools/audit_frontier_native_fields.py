"""Static evidence for legacy fields accessed on the three native controllers.

This is deliberately a review report, not a completeness or runtime assertion.
Native scripts can initialize fields outside their object event directories.
"""
from collections import defaultdict
import json
from pathlib import Path
import re

from frontier_compiler import sources, ROOT, HOST, FrontierEmitter
from fr_gml_parser import Node, definitions
from fr_emitter_base import walk
from fr_runtime_schema import FIELD_ALIASES

TYPES = {"Player", "GameCont", "KeyCont"}


def target(node):
    if node.kind == "identifier" and node.args[0] in TYPES:
        return node.args[0]
    if node.kind == "call" and node.args[0].kind == "identifier":
        if node.args[0].args[0] in {"instances_matching", "instances_matching_ne", "instance_find", "instance_nearest"}:
            return next((found for n in node.args[1] if (found := target(n))), None)
    return None


def main():
    parsed = {relative: definitions(path.read_text(encoding="utf-8-sig"), relative) for relative, path in sources()}
    names = {relative: {definition.name for definition in defs} for relative, defs in parsed.items()}
    rows = {kind: defaultdict(list) for kind in TYPES}
    for relative, defs in parsed.items():
        for definition in defs:
            emitter = FrontierEmitter(relative, definition, names, {}, {}, {})
            def record(kind, field, line, form):
                rows[kind][field].append({"source": relative, "definition": definition.name, "line": line, "form": form})
            def visit(node, scope=None, role=None):
                if not isinstance(node, Node):
                    if isinstance(node, (tuple, list)):
                        for item in node: visit(item, scope)
                    return
                if node.kind == "member":
                    kind = target(node.args[0])
                    if kind: record(kind, node.args[1], node.line, "member")
                    visit(node.args[0], scope, "member-base")
                    return
                if node.kind == "with":
                    visit(node.args[0], scope)
                    visit(node.args[1], target(node.args[0]))
                    return
                if node.kind == "call":
                    visit(node.args[0], scope, "callee")
                    for arg in node.args[1]: visit(arg, scope)
                    if node.args[0].kind == "identifier" and len(node.args[1]) >= 2:
                        kind = target(node.args[1][0])
                        field = node.args[1][1]
                        if kind and field.kind == "string" and node.args[0].args[0] in {
                            "variable_instance_get", "variable_instance_set", "variable_instance_exists",
                            "instances_matching", "instances_matching_ne", "instances_matching_ge", "instances_matching_le",
                            "instances_matching_gt", "instances_matching_lt"}:
                            record(kind, json.loads(field.args[0]), node.line, "dynamic-name")
                    return
                if node.kind == "identifier" and scope and role not in {"callee", "member-base"}:
                    name = node.args[0]
                    if name not in emitter.locals and emitter.identifier(name) == FIELD_ALIASES.get(name, name):
                        record(scope, name, node.line, "with-identifier")
                for item in node.args: visit(item, scope)
            visit(definition.body)
    native_files = [(path.relative_to(HOST).as_posix(), path.read_text(encoding="utf-8-sig")) for path in HOST.rglob("*.gml")]
    report = {"status": "STATIC_REVIEW_EVIDENCE", "controllers": {}}
    for kind, fields in sorted(rows.items()):
        records = []
        for source, sites in sorted(fields.items()):
            native = FIELD_ALIASES.get(source, source)
            hits = [path for path, text in native_files if re.search(r"(?<![\w])" + re.escape(native) + r"(?![\w])", text)]
            records.append({"source_field": source, "native_field": native,
                            "native_mention_files": len(hits), "native_example": hits[:3], "sites": sites})
        report["controllers"][kind] = records
    destination = ROOT / "generated-code/native-field-review.json"
    destination.write_text(json.dumps(report, ensure_ascii=False, indent=2) + "\n", encoding="utf8")
    for kind, records in report["controllers"].items():
        print(kind + ": " + ", ".join(item["source_field"] for item in records if not item["native_mention_files"]))


if __name__ == "__main__": main()
