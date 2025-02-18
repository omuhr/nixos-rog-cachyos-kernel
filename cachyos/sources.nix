{
  lib,
  fetchzip,
  fetchpatch,
}:
let
  linuxVersion = "6.12.15";
  linuxMinorVersion = lib.versions.majorMinor linuxVersion;
  linuxHash = "sha256-WeffW6eq5oU0/CyWyvF//oxpJBWGFwC9xJUcKZDvORQ=";

  cachyosCommit = "54490391155693163a524f821935cee3ed25f1d4";

  cachyosHash = "sha256-m+S+NFY66qePv4qZbTF5QjLDj+CyGTAqIzKqv6qNfao=";
  boreHash = "sha256-f9zyXVYJvuOVOzohUPIrzqXCVMyFoOE9UubBxrZfXP8=";
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
