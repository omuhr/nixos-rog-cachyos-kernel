{
  buildLinux,
  fetchzip,
  lib,
}:
let
  version = "6.6.70";
in
buildLinux {
  src = fetchzip {
    url = "mirror://kernel/linux/kernel/v${lib.versions.major version}.x/linux-${version}.tar.xz";
    hash = "sha256-A9zR8fCbeYtBqQ+JCbN7h22DGCBjalGzKBoGXqvaiqA=";
  };

  inherit version;
}
