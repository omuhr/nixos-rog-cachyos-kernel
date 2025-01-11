{
  pkgs ? import <nixpkgs> { },
}:
{
  linuxPackages_cachyos = pkgs.callPackage cachyos/package.nix { };
  generateConfig = pkgs.callPackage cachyos/generate-config.nix { };
}
