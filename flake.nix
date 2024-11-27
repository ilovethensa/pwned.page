{
  description = "My personal website";
  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-23.05";
  inputs.flake-utils.url = "github:numtide/flake-utils";

  outputs = {
    self,
    nixpkgs,
    flake-utils,
  }:
    flake-utils.lib.eachDefaultSystem (system: let
      pkgs = nixpkgs.legacyPackages.${system};
    in {
      packages.website = pkgs.buildNpmPackage {
      pname = "website";
      version = "0.1.2";

      src = ./.;

      buildInputs = [
        pkgs.vips
      ];

      nativeBuildInputs = [
        pkgs.pkg-config
      ];

      installPhase = ''
        runHook preInstall
        cp -pr --reflink=auto dist $out/
        runHook postInstall
      '';

      npmDepsHash = "sha256-Qz7EAPFkU1412QtOvkQ5qsHocS5Da6Mihh7cZED0+84=";
    };

      defaultPackage = self.packages.${system}.website;
      devShells.default = pkgs.mkShell {packages = [pkgs.yarn pkgs.nodejs];};
    });
}
