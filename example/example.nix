{ pkgs, make-slides }:

pkgs.stdenv.mkDerivation {
  name = "example";
  src = ./.;
  buildInputs = [ make-slides ];
  buildPhase = ''
    # luaotfload needs a writable cache path.
    export HOME=$TMPDIR
    mkdir -p $out/share/doc
    make-slides example.md
    cp output.pdf $out/share/doc
  '';
}
