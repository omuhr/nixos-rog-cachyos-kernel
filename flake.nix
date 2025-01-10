{
  inputs = { };

  outputs = {
    overlays.default = import ./overlay.nix;
    nixosModules.default = import ./module.nix;
  };
}
