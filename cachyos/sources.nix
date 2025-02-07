{
  lib,
  fetchzip,
  fetchpatch,
}:
let
  linuxVersion = "6.12.12";
  linuxMinorVersion = lib.versions.majorMinor linuxVersion;
  linuxHash = "sha256-UJb5asZFIhnp8YbTM9tok5g3KIFU2mlLKzg6pIap5Es=";

  cachyosCommit = "3216bcc085f66090b5a9c891e16b8516c6760856";

  cachyosHash = "sha256-ziozxudbN53sFg0JaNfft7ukha1k6bnieq1Zl9qDLII=";
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
