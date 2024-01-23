{ pkgs ? import <nixpkgs> { } }:

let
  revealjs = pkgs.fetchFromGitHub {
    owner = "hakimel";
    repo = "reveal.js";
    rev = "4.1.0";
    sha256 = "10xhblbyw8mvak58d294hbxxnf5sq0akj6qldv7brgm6944zppm0";
  };
in pkgs.writeShellScriptBin "make-slides" ''
  ${pkgs.pandoc}/bin/pandoc \
    --from markdown \
    --to revealjs \
    --self-contained \
    --variable revealjs-url="${revealjs}" \
    --variable theme="white" \
    --variable transition="none" \
    --variable controls="false" \
    --variable progress="true" \
    --output=slides.html \
    slides.md
''
