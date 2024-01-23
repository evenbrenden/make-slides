{ pkgs }:

let
  revealjs = pkgs.fetchFromGitHub {
    owner = "hakimel";
    repo = "reveal.js";
    rev = "5.0.4";
    sha256 = "sha256-sVnapzYPo3UzA345JLEIGtS4BnnFEEk4nqlIpraTNwc=";
  };
in pkgs.writeShellScriptBin "make-slides" ''
  ${pkgs.pandoc}/bin/pandoc \
    --from markdown \
    --to revealjs \
    --embed-resources \
    --standalone \
    --variable revealjs-url="${revealjs}" \
    --variable theme="white" \
    --variable transition="none" \
    --variable controls="false" \
    --variable progress="false" \
    --output=slides.html \
    slides.md
''
