# Frontier source reproduction

The root `project/` is the exact accepted generated game source and resource
declarations. This directory preserves the native adapters, offline compiler,
localization, importer, dependency/source inventory and text-only original
development snapshot. Game artwork, audio, fonts, icons, commercial runners,
compiled game data and installation packages are absent.

Obtain the required game and MOD assets separately from their authors or other
authorized sources. Original NTUF 1.0.3.3 archive SHA256:
`921cec16f63ed36c95ef97ed5bdd644e142a209965f430b9e0cf47500adcfeea`.
Uncharted Frontier: <https://wigglercola.itch.io/uncharted-frontier>.
The library source/blob inventory is in `dependencies/library-downloads.json`.
No online auto-loader is required; the obsolete credential-bearing loader is
intentionally excluded.

Several upstream GML source files contain encoded PNG images. To retain their
logic without distributing that artwork, `.source.json` files preserve valid
code fragments and the original file/media hashes. No GML placeholder is used.
Use your own exact author archive and dependency source files to reconstruct
these reference inputs in a separate ignored local working directory:

```sh
python frontier20/tools/restore_source_inputs.py \
  --frontier-archive /path/to/Frontier-1.0.3.3.zip \
  --dependency-inputs /path/to/authorized/library/source \
  --output /path/to/private-local-source
```

The helper checks the original file hash, every code segment, each encoded
image hash and decoded PNG hash, and the complete reconstructed bytes. It does
not download anything, execute a MOD, access credentials or modify the tracked
project. Keep the reconstructed image-bearing sources outside public Git.

For author-source regeneration, create a private working copy of `frontier20`,
restore the omitted source/media from your own inputs, and give the importer
and compiler the sibling `project/` expected by their relative layout. The
accepted generated GML remains available in the public root project regardless
of whether the upstream references are restored. A source-only checkout cannot
compile a complete game until all referenced media and native dependencies have
been obtained separately. Host-specific packaging/signing scripts and SDK
caches are not part of the public source payload.

The historical source snapshot describes an earlier local 2.0 build. It is not
current acceptance and does not include its binaries or installer files.
Current validation is the root `docs/VALIDATION.md` and source-baseline record.
