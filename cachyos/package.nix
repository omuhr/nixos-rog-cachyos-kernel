{ callPackage, lib, stdenvNoCC, buildLinux, ... }:
let sources = callPackage ./sources.nix { };
in buildLinux {
  pname = "linux-rog-cachyos";
  src = sources.linux;
  version = sources.linuxVersion;

  structuredExtraConfig = with lib.kernel; {
    # 0001-cachyos-base-all.patch
    AMD_3D_VCACHE = module;
    V4L2_LOOPBACK = module;
    VHBA = module;
    DRM_APPLETBDRM = module;
    HID_APPLETB_BL = module;
    HID_APPLETB_KBD = module;

    PREEMPT_VOLUNTARY = lib.mkForce unset;
    PREEMPT = lib.mkForce yes;
    CC_OPTIMIZE_FOR_PERFORMANCE = lib.mkForce unset;
    TRANSPARENT_HUGEPAGE_ALWAYS = lib.mkForce yes;
    TRANSPARENT_HUGEPAGE_MADVISE = lib.mkForce unset;
    CACHY = yes;
    SCHED_BORE = yes;
    CONTEXT_TRACKING_FORCE = unset;
    #NO_HZ_FULL_NODEF = yes;
    PREEMPT_LAZY = unset;
    CC_OPTIMIZE_FOR_PERFORMANCE_O3 = yes;
  };

  kernelPatches = [

    # {
    #   name = "cachyos-base-all";
    #   patch = sources.cachyos-base-all;
    # }

    {
      name = "amd-pstate";
      patch = sources.amd-pstate;
    }

    {
      name = "amd-tlb-broadcast";
      patch = sources.amd-tlb-broadcast;
    }

    {
      name = "asus";
      patch = sources.asus;
    }

    {
      name = "bbr3";
      patch = sources.bbr3;
    }

    {
      name = "cachy";
      patch = sources.cachy;
    }

    {
      name = "crypto";
      patch = sources.crypto;
    }

    {
      name = "fixes";
      patch = sources.fixes;
    }

    {
      name = "t2";
      patch = sources.t2;
    }

    {
      name = "zstd";
      patch = sources.zstd;
    }

    {
      name = "zotac-zone";
      patch = sources.zotac-zone;
    }

    {
      name = "bore-cachy";
      patch = sources.bore-cachy;
    }
  ];

  meta.broken = !stdenvNoCC.hostPlatform.isx86_64;
}
