{
  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

  outputs =
    { self, nixpkgs }:
    let
      forAllSystems =
        let
          supportedSystems = [
            "x86_64-linux"
            "aarch64-linux"
          ];
        in
        nixpkgs.lib.genAttrs supportedSystems;
    in
    {
      packages = forAllSystems (
        system:
        (import ./default.nix { pkgs = nixpkgs.legacyPackages.${system}; })
        // {
          default = self.packages.${system}.linuxPackages_cachyos;
        }
      );

      overlays.default = import ./overlay.nix;
      nixosModules.default = import ./module.nix;
    };
}
