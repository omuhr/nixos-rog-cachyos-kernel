{
  lib,
  fetchzip,
  fetchpatch,
}:
let
  linuxVersion = "6.12.10";
  linuxMinorVersion = lib.versions.majorMinor linuxVersion;
  linuxHash = "sha256-3YIRaCn/cMkp9h2GXZgsZHHh6F59LfendPqnwawpQ4E=";

  cachyosCommit = "f5bbf91fc68f0afb0e5a9d9ccfa15dc9d8015f75";

  cachyosHash = "sha256-5mliK00yNMT0D3lO6v84EEsJDVlxWXgtXbj5XSBkPd0=";
  dkmsClangHash = "sha256-2QhyC7DGOw9SmPsxvFweHeeeXKh/Gr0heLgs36lmwmM=";
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
