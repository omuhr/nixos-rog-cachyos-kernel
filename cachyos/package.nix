{
  lib,
  buildLinux,
  fetchzip,
  fetchpatch,
}:
let
  linuxVersion = "6.6.69";
  linuxHash = "sha256-nCla3GbDxPy56r5K1HOpyAJ+8YyE792z5a4eH5I1S7s=";

  cachyosCommit = "7ed2c2912029bc74b8276b7922164d7b538caea9";
  cachyosHash = "sha256-zOZ1wUdpjAul7qZ/YsVXnz1exKE69k9mzC81os2IBFA=";
  boreHash = "sha256-Tz7yxrwo3kzd2J/BvX3HEQmVcMD2ILxFXvY/d46iB7I=";
in
buildLinux {
  src = fetchzip {
    url = "mirror://kernel/linux/kernel/v${lib.versions.major linuxVersion}.x/linux-${linuxVersion}.tar.xz";
    hash = linuxHash;
  };

  version = linuxVersion;

  structuredExtraConfig = with lib.kernel; {
    CACHY = yes;

    SCHED_BORE = yes;

    LTO_NONE = yes;

    HZ_300 = no;
    HZ_1000 = yes;
    HZ = freeform "1000";

    NR_CPUS = lib.mkForce (freeform "320");

    HZ_PERIODIC = no;
    NO_HZ_IDLE = no;
    CONTEXT_TRACKING_FORCE = no;
    NO_HZ_FULL_NODEF = yes;
    NO_HZ_FULL = yes;
    NO_HZ = yes;
    NO_HZ_COMMON = yes;
    CONTEXT_TRACKING = yes;

    PREEMPT_BUILD = yes;
    PREEMPT_NONE = no;
    PREEMPT_VOLUNTARY = lib.mkForce no;
    PREEMPT = lib.mkForce yes;
    PREEMPT_COUNT = yes;
    PREEMPTION = yes;
    PREEMPT_DYNAMIC = yes;

    CC_OPTIMIZE_FOR_PERFORMANCE = no;
    CC_OPTIMIZE_FOR_PERFORMANCE_O3 = yes;

    LRU_GEN = yes;
    LRU_GEN_ENABLED = yes;
    LRU_GEN_STATS = no;

    PER_VMA_LOCK = yes;
    PER_VMA_LOCK_STATS = no;

    TRANSPARENT_HUGEPAGE_MADVISE = lib.mkForce no;
    TRANSPARENT_HUGEPAGE_ALWAYS = lib.mkForce yes;

    USER_NS = yes;
  };

  kernelPatches =
    let
      linuxMinorVersion = lib.versions.majorMinor linuxVersion;
    in
    [
      {
        name = "cachyos-base-all";

        patch = fetchpatch {
          url = "https://raw.githubusercontent.com/CachyOS/kernel-patches/${cachyosCommit}/${linuxMinorVersion}/all/0001-cachyos-base-all.patch";
          hash = cachyosHash;
        };
      }

      {
        name = "bore-cachy";

        patch = fetchpatch {
          url = "https://raw.githubusercontent.com/CachyOS/kernel-patches/${cachyosCommit}/${linuxMinorVersion}/sched/0001-bore-cachy.patch";
          hash = boreHash;
        };
      }
    ];
}
