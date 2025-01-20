{
  callPackage,
  stdenvNoCC,
  buildLinux,
  ...
}:
let
  sources = callPackage ./sources.nix { };
in
buildLinux {
  src = sources.linux;
  version = "${sources.linuxVersion}-cachyos-lts";
  modDirVersion = sources.linuxVersion;
  structuredExtraConfig = (callPackage ./config.nix { }).config;

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

  meta.broken = ! stdenvNoCC.hostPlatform.isx86_64;
}
