#!/bin/sh

nix-shell -p diffutils --run "diff $(nix-build ../default.nix -A kernelConfig) $(nix-build ../default.nix -A generateConfig)/config" > config.diff

nix-shell -p python3Minimal --run "./generate-config.py"
