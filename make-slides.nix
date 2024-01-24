{ pkgs }:

with pkgs;

let
  fonts = {
    main-directory = "${pkgs.symbola}/share/fonts/opentype";
    main-file = "Symbola.otf";
    bold = "${liberation_ttf}/share/fonts/truetype/LiberationSerif-Bold.ttf";
    italic = "${liberation_ttf}/share/fonts/truetype/LiberationSerif-Italic.ttf";
    bold-italic = "${liberation_ttf}/share/fonts/truetype/LiberationSerif-BoldItalic.ttf";
  };
in writeShellApplication {
  name = "make-slides";
  runtimeInputs = [ pandoc texlive.combined.scheme-medium ];
  text = ''
    OSFONTDIR=${fonts.main-directory} \
    pandoc \
      --from markdown \
      --to beamer \
      --pdf-engine lualatex \
      --variable colorlinks \
      --variable 'mainfont=${fonts.main-file}' \
      --variable 'mainfontoptions:BoldFont=${fonts.bold}, ItalicFont=${fonts.italic}, BoldItalicFont=${fonts.bold-italic}' \
      --output slides.pdf \
      slides.md
  '';
}
