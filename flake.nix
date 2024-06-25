{
  description = "make-slides";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

  outputs = { self, nixpkgs }:
    let
      pkgs = nixpkgs.legacyPackages.x86_64-linux;
      system = "x86_64-linux";
    in rec {
      packages.${system} = {
        default = import ./make-slides.nix { inherit pkgs; };
        example = import ./example/example.nix {
          inherit pkgs;
          make-slides = packages.${system}.default;
        };
      };
    };
}
