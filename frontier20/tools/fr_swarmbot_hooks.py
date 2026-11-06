"""Collapse only the six authored nested Swarmer filters in a chosen stage."""
from pathlib import Path


def apply(project):
    project = Path(project)
    files = list((project / "scripts").glob("frCode_Frontier_Labs_mod_*/*.gml"))
    if len(files) != 1:
        raise RuntimeError(f"Expected one generated Frontier_Labs module, found {len(files)}")
    path = files[0]
    text = path.read_text("utf-8-sig")
    replacements = [
        ('scrFRMatching(scrFRMatching(enemy, "name", "Swarmer"), "myCommander", scrFRSelf(self))',
         'scrFRSwarmbotMatching("myCommander", scrFRSelf(self))', 3),
        ('scrFRMatching(scrFRMatching(enemy, "name", "Swarmer"), "myCommander", noone)',
         'scrFRSwarmbotMatching("myCommander", noone)', 2),
        ('scrFRMatching(scrFRMatching(enemy, "name", "Swarmer"), "commAvailable", true)',
         'scrFRSwarmbotMatching("commAvailable", true)', 1),
    ]
    for original, optimized, count in replacements:
        if original in text:
            if text.count(original) != count or optimized in text:
                raise RuntimeError("Swarmer nested-filter anchors changed")
            text = text.replace(original, optimized)
        elif text.count(optimized) != count:
            raise RuntimeError("Swarmer nested-filter hooks are missing")
    if text != path.read_text("utf-8-sig"):
        path.write_text(text, "utf-8", newline="\n")
    return {"file": str(path), "single_pass_queries": sum(item[2] for item in replacements)}


if __name__ == "__main__":
    import argparse
    import json
    parser = argparse.ArgumentParser()
    parser.add_argument("project", type=Path)
    print(json.dumps(apply(parser.parse_args().project), ensure_ascii=True, indent=2))
