{
  lib,
  fetchzip,
  fetchpatch,
}:
let
  linuxVersion = "6.6.69";
  linuxHash = "sha256-nCla3GbDxPy56r5K1HOpyAJ+8YyE792z5a4eH5I1S7s=";
  linuxMinorVersion = lib.versions.majorMinor linuxVersion;

  cachyosCommit = "7ed2c2912029bc74b8276b7922164d7b538caea9";
  cachyosHash = "sha256-zOZ1wUdpjAul7qZ/YsVXnz1exKE69k9mzC81os2IBFA=";
  boreHash = "sha256-Tz7yxrwo3kzd2J/BvX3HEQmVcMD2ILxFXvY/d46iB7I=";
in
{
  inherit linuxVersion;

  linux = fetchzip {
    url = "mirror://kernel/linux/kernel/v${lib.versions.major linuxVersion}.x/linux-${linuxVersion}.tar.xz";
    hash = linuxHash;
  };

  cachyos-base-all = fetchpatch {
    url = "https://raw.githubusercontent.com/CachyOS/kernel-patches/${cachyosCommit}/${linuxMinorVersion}/all/0001-cachyos-base-all.patch";
    hash = cachyosHash;
  };

  bore-cachy = fetchpatch {
    url = "https://raw.githubusercontent.com/CachyOS/kernel-patches/${cachyosCommit}/${linuxMinorVersion}/sched/0001-bore-cachy.patch";
    hash = boreHash;
  };
}
