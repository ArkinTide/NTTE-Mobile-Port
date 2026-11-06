"""Freeze original native sprite strips absent from the mobile base.

This optional provenance tool reads recovered base-game artwork only. Its
checked-in strips and manifest are the portable inputs consumed by the main
Frontier importer; a future build does not require the Hardmode checkout.
"""
from __future__ import annotations

import base64
import hashlib
from io import BytesIO
import json
from pathlib import Path
import re
import struct

from PIL import Image


ROOT = Path(__file__).resolve().parents[1]
WORK = ROOT.parents[1]
OUT = ROOT / "base-assets"


class NativeWad:
    """Read GMS1.4's embedded sprite/texture tables without executing it."""
    def __init__(self, path):
        self.path = Path(path)
        self.bytes = self.path.read_bytes()
        self.form = -1
        while True:
            self.form = self.bytes.find(b"FORM", self.form + 1)
            if self.form < 0:
                raise ValueError("No supported native FORM in " + str(path))
            if self.bytes[self.form+8:self.form+12] == b"GEN8":
                break
        self.data = self.bytes[self.form:]
        pos, self.chunks = 8, {}
        end = 8 + self.u32(4)
        while pos < end:
            self.chunks[self.data[pos:pos+4].decode("ascii")] = pos
            pos += self.u32(pos+4) + 8
        if "TGIN" in self.chunks:
            raise ValueError("NativeWad input must be the original NTT9940 GMS1.4 executable")
        self.sprite_list = []
        for pos in self.table("SPRT"):
            name = self.string(self.u32(pos))
            count = self.u32(pos+56)
            self.sprite_list.append({"name": name, "width": self.u32(pos+4), "height": self.u32(pos+8),
                "origin": [self.i32(pos+48), self.i32(pos+52)],
                "frames": [struct.unpack_from("<10Hh", self.data, self.u32(pos+60+i*4)) for i in range(count)]})
        self.sprites = {sprite["name"]: sprite for sprite in self.sprite_list}
        self.texture_pointers = [self.u32(pos+4) for pos in self.table("TXTR")]
        self.pages = {}

    def u32(self, offset):
        return struct.unpack_from("<I", self.data, offset)[0]

    def i32(self, offset):
        return struct.unpack_from("<i", self.data, offset)[0]

    def string(self, offset):
        return self.data[offset:self.data.index(0, offset)].decode("utf-8")

    def table(self, chunk):
        base = self.chunks[chunk]+8
        return [self.u32(base+4+i*4) for i in range(self.u32(base))]

    def strip(self, name):
        sprite = self.sprites[name]
        images = []
        for x,y,w,h,tx,ty,tw,th,bw,bh,page in sprite["frames"]:
            if page not in self.pages:
                self.pages[page] = Image.open(BytesIO(self.data[self.texture_pointers[page]:])).convert("RGBA")
            image = Image.new("RGBA", (sprite["width"],sprite["height"]))
            image.paste(self.pages[page].crop((x,y,x+w,y+h)), (tx,ty))
            images.append(image)
        strip = Image.new("RGBA", (sprite["width"]*len(images),sprite["height"]))
        for i, image in enumerate(images):
            strip.paste(image,(i*sprite["width"],0))
        return strip, sprite


def digest(data):
    return hashlib.sha256(data).hexdigest()


def load(path):
    return json.loads(re.sub(r",(?=\s*[}\]])", "", path.read_text("utf-8-sig")))


def main():
    OUT.mkdir(parents=True, exist_ok=True)
    entries = []
    project = WORK / "hardmode-port/project"
    for colour in ("Blue", "Green"):
        for suffix in ("", "Hurt"):
            name = "sprCrystalProp" + colour + suffix
            folder = project / "sprites" / name
            yy = load(folder / (name + ".yy"))
            frames = [Image.open(folder / (f["name"] + ".png")).convert("RGBA") for f in yy["frames"]]
            strip = Image.new("RGBA", (sum(f.width for f in frames), frames[0].height))
            left = 0
            for frame in frames:
                strip.paste(frame, (left, 0))
                left += frame.width
            target = OUT / (name + ".png")
            strip.save(target)
            entries.append({"path": target.name, "resource": "sprFRBase_" + name[3:],
                "frames": len(frames), "origin": [yy["sequence"]["xorigin"], yy["sequence"]["yorigin"]],
                "sha256": digest(target.read_bytes()),
                "provenance": "Recovered original native sprite " + name,
                "descriptor_sha256": digest((folder / (name + ".yy")).read_bytes()),
                "frame_rgba_sha256": [digest(frame.tobytes()) for frame in frames]})
    recovered = WORK / "hardmode-ntt100034/mod/areas/caves.area.gml"
    text = recovered.read_text("utf-8-sig")
    for colour in ("Blue", "Green"):
        name = "sprCrystalProp" + colour + "Dead"
        match = re.search(r"global\." + name + r'\s*=\s*sprite_add_base64\("([^"]+)",(\d+),(\d+),(\d+)\)', text)
        if not match:
            raise RuntimeError("Recovered native declaration missing: " + name)
        target = OUT / (name + ".png")
        target.write_bytes(base64.b64decode(match[1], validate=True))
        entries.append({"path": target.name, "resource": "sprFRBase_" + name[3:],
            "frames": int(match[2]), "origin": [int(match[3]), int(match[4])],
            "sha256": digest(target.read_bytes()),
            "provenance": "Original native corpse strip preserved as literal sprite_add_base64 in Hardmode caves.area.gml",
            "declaration_sha256": digest(match[0].encode())})
    wad = NativeWad("D:/Steam/steamapps/common/Nuclear Throne/9940/NuclearThroneTogether.exe")
    executable_hash = digest(wad.bytes)
    for name in ["sprVanOpenIdle","sprUnlockContinue","sprExtraFeet","sprSnowBanditGun",
                 "sprWeaponFire","sprDragonFire","sprCannonFire","sprGrenadeBlink",
                 "mskRhinoFreak","mskHeavyBullet","mskBouncerBullet"]:
        strip, sprite = wad.strip(name)
        target = OUT / (name + ".png")
        strip.save(target)
        entries.append({"path": target.name, "resource": "sprFRBase_" + (name[3:] if name.startswith("spr") else name),
            "frames": len(sprite["frames"]), "origin": sprite["origin"],
            "sha256": digest(target.read_bytes()),
            "provenance": "Exact original NTT9940 native sprite extracted from embedded SPRT/TPAG/TXTR",
            "source_executable_sha256": executable_hash, "source_form_offset": wad.form,
            "source_sprite": name})
    (OUT / "manifest.json").write_text(json.dumps({"assets": entries}, ensure_ascii=False, indent=2) + "\n", "utf-8")
    print(json.dumps({"native_sprite_strips": len(entries), "output": str(OUT)}))


if __name__ == "__main__":
    main()
