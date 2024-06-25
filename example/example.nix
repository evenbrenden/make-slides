{ pkgs, make-slides }:

pkgs.stdenv.mkDerivation {
  name = "example";
  src = ./.;
  buildInputs = [ make-slides ];
  buildPhase = ''
    mkdir -p $out/share/doc
    make-slides
    cp slides.pdf $out/share/doc
  '';
}
