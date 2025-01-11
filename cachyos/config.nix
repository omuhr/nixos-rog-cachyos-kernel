{ lib }:
{
  config = with lib.kernel; {
    PREEMPT_VOLUNTARY = lib.mkForce (unset);
    PREEMPT = lib.mkForce (yes);

    CC_OPTIMIZE_FOR_PERFORMANCE = unset;

    NR_CPUS = lib.mkForce (freeform "320");

    TRANSPARENT_HUGEPAGE_ALWAYS = lib.mkForce (yes);
    TRANSPARENT_HUGEPAGE_MADVISE = lib.mkForce (unset);

    CACHY = yes;
    SCHED_BORE = yes;
    CONTEXT_TRACKING_FORCE = unset;
    #NO_HZ_FULL_NODEF = yes;
    CC_OPTIMIZE_FOR_PERFORMANCE_O3 = yes;
  };
}
