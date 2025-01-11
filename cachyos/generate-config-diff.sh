#!/bin/sh

diff $(nix-build ../default.nix -A generateConfig)/config $(nix build --print-out-paths --no-link nixpkgs#linuxPackages_6_6.kernel.configfile) > config.diff
