{ pkgs }:

with pkgs;

let
  regular = "Symbola.otf"; # Referencing Nix store does not work
  bold = "${liberation_ttf}/share/fonts/truetype/LiberationSans-Bold.ttf";
  italic = "${liberation_ttf}/share/fonts/truetype/LiberationSans-Italic.ttf";
  bold-italic = "${liberation_ttf}/share/fonts/truetype/LiberationSans-BoldItalic.ttf";
in writeShellApplication {
  name = "make-slides";
  runtimeInputs = [ pandoc texlive.combined.scheme-medium ];
  text = ''
    pandoc \
      --from markdown \
      --to beamer \
      --pdf-engine lualatex \
      --variable colorlinks \
      --variable 'mainfont=${regular}' \
      --variable 'mainfontoptions:BoldFont=${bold}, ItalicFont=${italic}, BoldItalicFont=${bold-italic}' \
      --output slides.pdf \
      slides.md
  '';
}
