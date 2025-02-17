{
  callPackage,
  lib,
  stdenvNoCC,
  buildLinux,
  ...
}:
let
  sources = callPackage ./sources.nix { };
in
buildLinux {
  pname = "linux-cachyos-lts";
  src = sources.linux;
  version = sources.linuxVersion;

  structuredExtraConfig = with lib.kernel; {
    # 0001-cachyos-base-all.patch
    AMD_3D_VCACHE = yes;
    #ARCH_SUPPORTS_AUTOFDO_CLANG = yes;
    AUTOFDO_CLANG = unset;
    #ARCH_SUPPORTS_PROPELLER_CLANG = yes;
    PROPELLER_CLANG = unset;
    AMD_PRIVATE_COLOR = yes;
    V4L2_LOOPBACK = module;
    VHBA = module;
    USER_NS_UNPRIVILEGED = yes;
    ANON_MIN_RATIO = freeform "15";
    CLEAN_LOW_RATIO = freeform "0";
    CLEAN_MIN_RATIO = freeform "15";
    DRM_APPLETBDRM = module;
    HID_APPLETB_BL = module;
    HID_APPLETB_KBD = module;
    APPLE_BCE = module;

    # 0001-bore-cachy.patch
    MIN_BASE_SLICE_NS = freeform "2000000";

    PREEMPT_VOLUNTARY = lib.mkForce (unset);
    PREEMPT = lib.mkForce (yes);
    CC_OPTIMIZE_FOR_PERFORMANCE = lib.mkForce (unset);
    TRANSPARENT_HUGEPAGE_ALWAYS = lib.mkForce (yes);
    TRANSPARENT_HUGEPAGE_MADVISE = lib.mkForce (unset);
    CACHY = yes;
    SCHED_BORE = yes;
    CONTEXT_TRACKING_FORCE = unset;
    #NO_HZ_FULL_NODEF = yes;
    PREEMPT_LAZY = unset;
    CC_OPTIMIZE_FOR_PERFORMANCE_O3 = yes;
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

  meta.broken = ! stdenvNoCC.hostPlatform.isx86_64;
}
