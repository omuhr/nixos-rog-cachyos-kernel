{
  buildLinux,
  fetchzip,
  lib,
  fetchpatch,
}:
buildLinux rec {
  src = fetchzip {
    url = "mirror://kernel/linux/kernel/v${lib.versions.major version}.x/linux-${version}.tar.xz";
    hash = "sha256-ASEcl8afiNYl6xDY9cZz5rdskaVy8f36d4Aart7/I14=";
  };

  version = "6.12.9";

  kernelPatches = [
    {
      name = "cachyos-base-all";

      patch = fetchpatch {
        url = "https://raw.githubusercontent.com/CachyOS/kernel-patches/c8e2591aa83fdec3345f9699030926715db727d0/${lib.versions.majorMinor version}/all/0001-cachyos-base-all.patch";
        hash = "sha256-k4WzphgNureRZEp6h4spfTIlIpdKHQT34MCwyS6B6jc=";
      };
    }
  ];
}
