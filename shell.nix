{ pkgs ? import <nixpkgs> {} }:

pkgs.mkShell {
  buildInputs = with pkgs; [
    (callPackage ./make-slides.nix {})
  ];
}
