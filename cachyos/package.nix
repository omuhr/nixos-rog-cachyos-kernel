{
  lib,
  callPackage,
  buildLinux,
}:
let
  sources = callPackage ./sources.nix { };
in
buildLinux {
  src = sources.linux;
  version = sources.linuxVersion;

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
    #CONTEXT_TRACKING_FORCE = no;
    #NO_HZ_FULL_NODEF = yes;
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
