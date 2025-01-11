#!/bin/sh

diff config $(nix build --print-out-paths --no-link nixpkgs#linuxPackages.kernel.configfile) > config.diff
