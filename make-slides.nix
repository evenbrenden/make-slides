{ pkgs }:

with pkgs;

let
  font-directory = "${pkgs.freefont_ttf}/share/fonts/truetype";
  metadata-file = writeText "metadata.yaml" ''
    ---
    colorlinks: true
    mainfont: FreeSerif
    mainfontoptions:
    - BoldFont=FreeSerifBold
    - ItalicFont=FreeSerifItalic
    - BoldItalicFont=FreeSerifBoldItalic
    mainfontfallback:
    - "NotoColorEmoji:mode=harf"
    ---
  '';
in writeShellApplication {
  name = "make-slides";
  runtimeInputs = [ pandoc librsvg texlive.combined.scheme-medium ];
  text = ''
    # https://tex.stackexchange.com/a/313605
    SOURCE_DATE_EPOCH=0 \
    OSFONTDIR=${font-directory} \
    pandoc \
      --from=markdown \
      --to=beamer \
      --pdf-engine=lualatex \
      --metadata-file=${metadata-file} \
      --output=slides.pdf \
      slides.md
  '';
}
