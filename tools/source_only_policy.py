"""Text-only source policy shared by cleanup and publication checks."""
from pathlib import PurePosixPath
import subprocess,tempfile,hashlib
ASSET_EXTS=set('png jpg jpeg gif bmp ico icns webp avif svg psd ase aseprite kra tga dds ktx pvr ogg wav mp3 flac aac m4a opus mid midi mp4 mov webm ttf otf woff woff2 fnt dll exe so dylib a lib bin win ios droid apk ipa aab zip 7z rar pdf glb gltf fbx obj blend'.split())
SOURCE_EXTS=set('gml yy yyp resource_order vsh fsh ini json md js loc txt java gitignore gitattributes mit csv py xml cpp bat nsi ext sh yml yaml h hpp c css html lock toml ps1 patch license'.split())
SOURCE_NAMES={'LICENSE','COPYING','NOTICE','Makefile','CMakeLists.txt','.gitkeep','.gitignore','.gitattributes','pre-push'}
def allowed_path(path):
    p=PurePosixPath(path);ext=p.suffix.lower().lstrip('.')
    return ext not in ASSET_EXTS and (ext in SOURCE_EXTS or p.name in SOURCE_NAMES)
def text_blob(data,legacy_license=False):
    if not data:return True
    try:
        if data.startswith((b'\xff\xfe',b'\xfe\xff')):
            decoded=data.decode('utf16')
        else:decoded=data.decode('utf-8-sig')
        return '\0' not in decoded
    except UnicodeError:
        if not legacy_license:return False
        try:decoded=data.decode('cp1252')
        except UnicodeError:return False
        return all(ord(c)>=32 or c in '\r\n\t\f' for c in decoded)
def audit(repo,history=False,index=False):
    command=['git','-c','safe.directory='+str(repo).replace('\\','/')]
    def git(*args,data=None):return subprocess.check_output([*command,*args],cwd=repo,input=data)
    if history:
        entries=[line.split(' ',1) for line in git('rev-list','--objects','--all').decode('utf8').splitlines()]
        names={parts[0]:parts[1] for parts in entries if len(parts)==2}
        ids=[parts[0] for parts in entries]
    elif index:
        entries=[row.split(b'\t',1) for row in git('ls-files','--stage','-z').split(b'\0') if row]
        names={left.split()[1].decode():right.decode('utf8') for left,right in entries}
        ids=list(names)
    else:
        entries=[row.split(b'\t',1) for row in git('ls-tree','-rz','HEAD').split(b'\0') if row]
        names={left.split()[2].decode():right.decode('utf8') for left,right in entries}
        ids=list(names)
    check=git('cat-file','--batch-check',data=('\n'.join(ids)+'\n').encode()).decode().splitlines()
    blobs={p[0]:int(p[2]) for line in check if len(p:=line.split())==3 and p[1]=='blob'}
    # rev-list also lists trees (including the root's empty name). Never turn
    # those directory entries into deletion paths: only file blobs qualify.
    bad_paths=sorted({name for oid,name in names.items() if oid in blobs and not allowed_path(name)})
    source_ids=sorted(oid for oid in blobs if allowed_path(names.get(oid,'')))
    bad_ids=[];total=0
    with tempfile.TemporaryFile() as src:
        src.write(('\n'.join(blobs)+'\n').encode());src.seek(0)
        proc=subprocess.Popen([*command,'cat-file','--batch'],cwd=repo,stdin=src,stdout=subprocess.PIPE)
        for oid,size in blobs.items():
            header=proc.stdout.readline().decode().strip().split()
            assert header==[oid,'blob',str(size)],header
            data=proc.stdout.read(size);assert len(data)==size
            assert proc.stdout.read(1)==b'\n'
            total+=size
            if not text_blob(data,names.get(oid,'').lower().endswith('/license.txt')):bad_ids.append(oid)
        assert proc.wait()==0
    return {'scope':'all reachable refs' if history else ('index' if index else 'HEAD'),'blobs':len(blobs),'bytes':total,
        'non_source_paths':bad_paths,'binary_blob_ids':bad_ids,
        'source_blobs':len(source_ids),'source_blob_set_sha256':hashlib.sha256('\n'.join(source_ids).encode()).hexdigest(),
        'status':'PASS' if not bad_paths and not bad_ids else 'FAIL'}
