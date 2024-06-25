{ pkgs }:

with pkgs;

let
  # https://github.com/NixOS/nixpkgs/issues/215857
  font-paths = builtins.concatStringsSep "//:" [ "${freefont_ttf}" "${noto-fonts-color-emoji}" ];
  # https://github.com/jgm/pandoc/pull/9204
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
  pandoc-3-1-12 = import ./pandoc-3-1.12.nix { inherit pkgs; };
in writeShellApplication {
  name = "make-slides";
  runtimeInputs = [ pandoc-3-1-12 librsvg texlive.combined.scheme-medium ];
  text = ''
    # https://github.com/NixOS/nixpkgs/issues/180639#issuecomment-1178984307
    HOME=$(mktemp -d)
    export HOME
    # https://tex.stackexchange.com/a/313605
    SOURCE_DATE_EPOCH=0 \
    OSFONTDIR=${font-paths} \
    pandoc \
      --from=markdown \
      --to=beamer \
      --pdf-engine=lualatex \
      --metadata-file=${metadata-file} \
      --output=slides.pdf \
      slides.md
  '';
}
