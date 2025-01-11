{ callPackage, linuxManualConfig }:
let
  sources = callPackage ./sources.nix { };
in
linuxManualConfig {
  src = sources.linux;
  version = "${sources.linuxVersion}-cachyos-lts";
  modDirVersion = sources.linuxVersion;
  configfile = ./config;

  kernelPatches = [
    {
      name = "cachyos-base-all";
      patch = sources.cachyos-base-all;
    }

    {
      name = "bore-cachy";
      patch = sources.bore-cachy;
    }
  ];
}
