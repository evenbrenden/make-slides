{ pkgs }:

with pkgs;

let
  fonts = rec {
    main-directory = "${pkgs.freefont_ttf}/share/fonts/truetype";
    main-file = "FreeSerif.ttf";
    bold = "${main-directory}/FreeSerifBold.ttf";
    italic = "${main-directory}/FreeSerifItalic.ttf";
    bold-italic = "${main-directory}/FreeSerifBoldItalic.ttf";
  };
in writeShellApplication {
  name = "make-slides";
  runtimeInputs = [ pandoc texlive.combined.scheme-medium ];
  text = ''
    # https://tex.stackexchange.com/a/313605
    SOURCE_DATE_EPOCH=0 \
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
