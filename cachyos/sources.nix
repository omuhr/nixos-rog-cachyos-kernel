{ lib, fetchzip, fetchpatch, }:
let
  linuxVersion = "6.14.2";
  linuxMinorVersion = lib.versions.majorMinor linuxVersion;
  linuxHash = "sha256-bMq/VKT4CyJFjAnwXqz3+SsiBNroflILYw6HRN+F92I=";

  cachyosCommit = "4df02d6037a2ea9ac1dc67f80db59798117694f1";

  # cachyosHash = "sha256-WbACCKuU9+Pc8Tnb2xVmDrdWmTTG4/x59flzWVdzrB8=";

  amd-pstateHash = "sha256-rwDe33RDqBTwyrWT60odwXJheb0yMDG/AOAp0bT9keo=";
  amd-tlb-broadcastHash = "sha256-B0fwTLBFYcMEiVWuot6OuFEBj9vqdOqVxau9IPqeyCE=";
  asusHash = "sha256-vpKsaVIu89z7WlUb/yqNjp4CRtjvxjQZyho7dEJpqWA=";
  bbr3Hash = "sha256-zVhvUS5aO/sJxJiKzRFFVH1rfD7hTCw5CMg5kVr9R64=";
  cachyHash = "sha256-mmywMawcGMagOj+GoG1IHGi0R9ORWma3+Nr7ba5YkUY=";
  cryptoHash = "sha256-yPfrx3HWVyLeBVa+/vZEsGfVdt5/lRWGINYfa0cUpE8=";
  fixesHash = "sha256-uc/ixwYvNRW0WjLDKS8Ebr+Y4nWF/z2ri2Q1MTXYrP0=";
  t2Hash = "sha256-1Ay/0/CIqiYQUlBT7j7Vtel7pabJpR3yIeNcCSAyiDk=";
  zstdHash = "sha256-Yyz0ZMvCyskHeG8Zfh1Qf5vj0bbHWMjAM8uWLD8+f+I=";
  zotac-zoneHash = "sha256-mpP2Z5MfTPO8lMx9TZb3E311jsD/LazVeKBGGOzSurQ=";

  boreHash = "sha256-qDE2IlxLkVykYX23P05Uc5JWT/1oeo3tVKhtPsCDrzM=";
in {
  inherit linuxVersion linuxMinorVersion;

  linux = fetchzip {
    url = "mirror://kernel/linux/kernel/v${
        lib.versions.major linuxVersion
      }.x/linux-${linuxVersion}.tar.xz";
    hash = linuxHash;
  };

  amd-pstate = fetchpatch {
    url =
      "https://raw.githubusercontent.com/flukejones/cachyos-kernel-patches/${cachyosCommit}/${linuxMinorVersion}/0001-amd-pstate.patch";
    hash = amd-pstateHash;
  };
  amd-tlb-broadcast = fetchpatch {
    url =
      "https://raw.githubusercontent.com/flukejones/cachyos-kernel-patches/${cachyosCommit}/${linuxMinorVersion}/0002-amd-tlb-broadcast.patch";
    hash = amd-tlb-broadcastHash;
  };
  asus = fetchpatch {
    url =
      "https://raw.githubusercontent.com/flukejones/cachyos-kernel-patches/${cachyosCommit}/${linuxMinorVersion}/0003-asus.patch";
    hash = asusHash;
  };
  bbr3 = fetchpatch {
    url =
      "https://raw.githubusercontent.com/flukejones/cachyos-kernel-patches/${cachyosCommit}/${linuxMinorVersion}/0004-bbr3.patch";
    hash = bbr3Hash;
  };
  cachy = fetchpatch {
    url =
      "https://raw.githubusercontent.com/flukejones/cachyos-kernel-patches/${cachyosCommit}/${linuxMinorVersion}/0005-cachy.patch";
    hash = cachyHash;
  };
  crypto = fetchpatch {
    url =
      "https://raw.githubusercontent.com/flukejones/cachyos-kernel-patches/${cachyosCommit}/${linuxMinorVersion}/0006-crypto.patch";
    hash = cryptoHash;
  };
  fixes = fetchpatch {
    url =
      "https://raw.githubusercontent.com/flukejones/cachyos-kernel-patches/${cachyosCommit}/${linuxMinorVersion}/0007-fixes.patch";
    hash = fixesHash;
  };
  t2 = fetchpatch {
    url =
      "https://raw.githubusercontent.com/flukejones/cachyos-kernel-patches/${cachyosCommit}/${linuxMinorVersion}/0008-t2.patch";
    hash = t2Hash;
  };
  zstd = fetchpatch {
    url =
      "https://raw.githubusercontent.com/flukejones/cachyos-kernel-patches/${cachyosCommit}/${linuxMinorVersion}/0009-zstd.patch";
    hash = zstdHash;
  };
  zotac-zone = fetchpatch {
    url =
      "https://raw.githubusercontent.com/flukejones/cachyos-kernel-patches/${cachyosCommit}/${linuxMinorVersion}/0010-zotac-zone.patch";
    hash = zotac-zoneHash;
  };

  bore-cachy = fetchpatch {
    url =
      "https://raw.githubusercontent.com/flukejones/cachyos-kernel-patches/${cachyosCommit}/${linuxMinorVersion}/sched/0001-bore-cachy.patch";
    hash = boreHash;
  };
}
