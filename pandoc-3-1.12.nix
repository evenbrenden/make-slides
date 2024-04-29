{ pkgs }:

pkgs.stdenv.mkDerivation rec {
  pname = "pandoc";
  version = "3.1.12";
  src = pkgs.fetchurl {
    url = "https://github.com/jgm/pandoc/releases/download/${version}/pandoc-${version}-linux-amd64.tar.gz";
    sha256 = "sha256-4w0gzD+a76EXvyGD/nTPx8sEMjfVbrYycrgr92tTeZE=";
  };
  installPhase = ''
    mkdir -p $out
    cp -a * $out
  '';
}
