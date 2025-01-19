{
  pkgs ? import <nixpkgs> { },
}:
let
  kernelConfig =
    let
      sources = pkgs.callPackage cachyos/sources.nix { };
    in
    pkgs."linuxPackages_${
      builtins.replaceStrings [ "." ] [ "_" ] sources.linuxMinorVersion
    }".kernel.configfile;
in
{
  inherit kernelConfig;

  linuxPackages_cachyos = pkgs.callPackage cachyos/package.nix { };
  generateConfig = pkgs.callPackage cachyos/generate-config.nix { inherit kernelConfig; };
}
