{ pkgs }:

with pkgs;

writeShellApplication {
  name = "make-slides";
  runtimeInputs = [ pandoc texlive.combined.scheme-medium ];
  text = ''
    pandoc \
      --from markdown \
      --to beamer \
      --pdf-engine lualatex \
      --variable mainfont="Symbola" \
      --variable colorlinks \
      --output slides.pdf \
      slides.md
  '';
}
