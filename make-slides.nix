{ pkgs }:

with pkgs;

let
  fonts = symlinkJoin {
    name = "make-slides-fonts";
    paths = [ freefont_ttf noto-fonts-color-emoji ];
  };
  font-directory = "${fonts}//"; # https://github.com/NixOS/nixpkgs/issues/215857
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
