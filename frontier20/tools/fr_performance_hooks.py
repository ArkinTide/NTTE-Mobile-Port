"""Install native-only probes explicitly; restore originals for normal builds.

The existing baseline floor script survives incremental staging. Always remove
our prior standardized wrapper before selecting the requested build flavor.
"""
from pathlib import Path
import re


TARGETS = [
    ("scrFrontier_core_api", "scrFRInvokeHere", "_code"),
    ("scrFrontier_registry", "scrFRInstances", '"scrFRInstances"'),
    ("scrFRActors", "scrFRObjectInstances", '"scrFRObjectInstances"'),
    ("scrNTTEFullFloor", "scrNTTEFullInstances", '"scrNTTEFullInstances"'),
]


def function_span(source, name):
    """Find the actual function braces, ignoring strings and source comments."""
    starts = list(re.finditer(r"(?m)^function " + re.escape(name) + r"\(", source))
    assert len(starts) == 1, (name, "Frontier profiling function anchor changed")
    start = starts[0].start()
    opening = source.index("{", starts[0].end())
    depth, i = 1, opening + 1
    while i < len(source):
        c = source[i]
        if source.startswith("//", i):
            newline = source.find("\n", i + 2)
            i = len(source) if newline < 0 else newline + 1
            continue
        if source.startswith("/*", i):
            end = source.find("*/", i + 2)
            assert end >= 0, (name, "Frontier profiling unterminated comment")
            i = end + 2
            continue
        if c in ('"', "'"):
            quote = c
            i += 1
            while i < len(source):
                if source[i] == "\\":
                    i += 2
                elif source[i] == quote:
                    i += 1
                    break
                else:
                    i += 1
            continue
        if c == "{":
            depth += 1
        elif c == "}":
            depth -= 1
            if depth == 0:
                return start, opening, i
        i += 1
    raise AssertionError((name, "Frontier profiling unterminated function"))


def wrapper_parts(name, key, newline):
    prefix = (newline + "// FRONTIER PROFILE " + name + newline
              + "var _fr_profile_token=scrFRProfileEnter(" + key + ");" + newline
              + "try {" + newline)
    suffix = newline + "} finally {scrFRProfileExit(_fr_profile_token);}" + newline
    return prefix, suffix


def unwrap_source(source, name, key):
    _, opening, closing = function_span(source, name)
    inner = source[opening + 1:closing]
    marker = "// FRONTIER PROFILE " + name
    if marker not in inner:
        assert "// FRONTIER PROFILE" not in inner and "_fr_profile_token" not in inner, (
            name, "Frontier profiling partial wrapper changed")
        return source
    assert inner.count(marker) == 1, (name, "Frontier profiling duplicate wrapper")
    for newline in ("\n", "\r\n"):
        prefix, suffix = wrapper_parts(name, key, newline)
        if inner.startswith(prefix) and inner.endswith(suffix):
            original = inner[len(prefix):-len(suffix)]
            assert "// FRONTIER PROFILE" not in original and "_fr_profile_token" not in original, (
                name, "Frontier profiling nested wrapper changed")
            return source[:opening + 1] + original + source[closing:]
    raise AssertionError((name, "Frontier profiling standardized wrapper changed"))


def wrap_source(source, name, key):
    _, opening, closing = function_span(source, name)
    inner = source[opening + 1:closing]
    newline = "\r\n" if "\r\n" in inner else "\n"
    prefix, suffix = wrapper_parts(name, key, newline)
    return source[:opening + 1] + prefix + inner + suffix + source[closing:]


def apply(project, enabled=False):
    project = Path(project)
    writes = {}
    for folder, name, key in TARGETS:
        path = project / "scripts" / folder / (folder + ".gml")
        # Bytes preserve BOM, line endings and unrelated baseline text so the
        # disabled stage is exactly the original body, not merely equivalent.
        source = path.read_bytes().decode("utf8")
        source = unwrap_source(source, name, key)
        if enabled:
            source = wrap_source(source, name, key)
        writes[path] = source.encode("utf8")
    path = project / "scripts/scrFrontier_performance_tests/scrFrontier_performance_tests.gml"
    source = path.read_bytes().decode("utf8")
    source, count = re.subn(r"(?m)^(#macro FR_PROFILE_COMPILED )(true|false)(?=\r?$)",
                            lambda match: match[1] + ("true" if enabled else "false"), source)
    assert count == 1, "Frontier profiling build macro changed"
    writes[path] = source.encode("utf8")
    # Validate every input before changing any file, including legacy stages.
    for path, content in writes.items():
        if path.read_bytes() != content:
            path.write_bytes(content)
    return {"profiling": "compiled" if enabled else "disabled", "instrumented": bool(enabled),
            "functions": [name for _, name, _ in TARGETS]}
