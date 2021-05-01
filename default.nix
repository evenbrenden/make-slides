{ pkgs ? import <nixpkgs> {} }:

pkgs.callPackage ./make-slides.nix {}
