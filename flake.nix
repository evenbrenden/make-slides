{
  description = "make-slides";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

  outputs = { self, nixpkgs }:
    let pkgs = nixpkgs.legacyPackages.x86_64-linux;
    in {
      packages.x86_64-linux.make-slides = import ./make-slides.nix { inherit pkgs; };
      packages.x86_64-linux.default = self.packages.x86_64-linux.make-slides;

    };
}
