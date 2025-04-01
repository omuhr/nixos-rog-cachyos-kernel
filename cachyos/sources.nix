{
  lib,
  fetchzip,
  fetchpatch,
}:
let
  linuxVersion = "6.12.21";
  linuxMinorVersion = lib.versions.majorMinor linuxVersion;
  linuxHash = "sha256-CItjO1ZoQKzkleD5O4k7cTn9YGWGQ2rNoLHZBfZ3ufI=";

  cachyosCommit = "31cccbc041cbd1b9907a22464ebdcce80ffc799f";

  cachyosHash = "sha256-WbACCKuU9+Pc8Tnb2xVmDrdWmTTG4/x59flzWVdzrB8=";
  boreHash = "sha256-uhuso01DVwuWO26z9Q9xf4TfGSmZOXkqZi4AvIjHCUY=";
in
{
  inherit linuxVersion linuxMinorVersion;

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
