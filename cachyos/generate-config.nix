{ callPackage, fetchurl, kernelConfig, stdenvNoCC, }:
let
  sources = callPackage ./sources.nix { };
  srcName = "linux-${sources.linuxVersion}";

  # pkgbuild = fetchurl {
  #   url = "https://raw.githubusercontent.com/CachyOS/linux-cachyos/c2c0e37f988e56878b930a0ad14830e9e2387b0d/linux-cachyos-lts/PKGBUILD";
  #   hash = "sha256-JRbGj0E3463WIuEcDh+Mh0y3cJi1nEAuWFJZcowIvOU=";
  # };
  pkgbuild = fetchurl {
    url =
      "https://raw.githubusercontent.com/flukejones/cachyos-linux-kermit/454a1ad19bb2a223d77f250fa7006477351e26c2/linux-cachyos/PKGBUILD";
    hash = "AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA";
  };
in stdenvNoCC.mkDerivation {
  name = "config";
  src = null;

  phases = [ "unpackPhase" "configurePhase" "installPhase" ];

  unpackPhase = ''
    cp -r --reflink=auto ${sources.linux} ${srcName}
    chmod -R u=rwX,g=rX,o=rX ${srcName}

    cp --reflink=auto ${kernelConfig} config
    touch ${srcName}/.config
    chmod u=rw,g=r,o=r ${srcName}/.config

    cp --reflink=auto ${pkgbuild} PKGBUILD
    cp --reflink=auto ${sources.cachyos-base-all} 0001-cachyos-base-all.patch
    cp --reflink=auto ${sources.bore-cachy} 0001-bore-cachy.patch
  '';

  configurePhase = ''
    source PKGBUILD
    export _use_auto_optimization=""
    patchShebangs --build ${srcName}/scripts/config

    OLD_PWD=$(pwd)
    prepare || exit 0
    cd "$OLD_PWD"
  '';

  installPhase = ''
    mkdir $out
    cp --reflink=auto ${srcName}/config-${sources.linuxVersion}-1-cachyos-lts $out/config
  '';
}
