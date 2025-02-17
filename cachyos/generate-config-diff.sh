#!/bin/sh -e

$(nix-build '<nixpkgs>' -A diffutils)/bin/diff $(nix-build ../default.nix -A kernelConfig) $(nix-build ../default.nix -A generateConfig)/config > config.diff

./generate-config.py
