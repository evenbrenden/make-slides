{ pkgs ? import <nixpkgs> {} }:

let
  revealjs = pkgs.fetchFromGitHub {
    owner = "hakimel";
    repo = "reveal.js";
    rev = "4.1.0";
    sha256 = "10xhblbyw8mvak58d294hbxxnf5sq0akj6qldv7brgm6944zppm0";
  };
in
  pkgs.writeShellScriptBin
    "make-slides"
    ''
      rm -rf build
      mkdir -p build
      cp --recursive ${revealjs} build/reveal.js
      cp --recursive img build/
      chmod --recursive +w build

      ${pkgs.pandoc}/bin/pandoc \
        --from markdown \
        --to revealjs \
        --standalone \
        --variable revealjs-url="reveal.js" \
        --variable theme="white" \
        --variable transition="none" \
        --variable controls="false" \
        --variable progress="true" \
        --output=build/slides.html \
        slides.md
    ''
