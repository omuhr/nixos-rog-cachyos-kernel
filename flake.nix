{
  inputs = { };

  outputs = { self }: {
    overlays.default = import ./overlay.nix;
    nixosModules.default = import ./module.nix;
  };
}
