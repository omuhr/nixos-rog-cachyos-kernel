#!/bin/sh -x

KERNEL_CONFIG=$(nix-build ../default.nix -A kernelConfig --system x86_64-linux --builders "ssh://eu.nixbuild.net x86_64-linux - 100 1 big-parallel,benchmark" --eval-store auto --store ssh-ng://eu.nixbuild.net)
GENERATED_CONFIG=$(nix-build ../default.nix -A generateConfig --system x86_64-linux --builders "ssh://eu.nixbuild.net x86_64-linux - 100 1 big-parallel,benchmark" --eval-store auto --store ssh-ng://eu.nixbuild.net)

nix-copy-closure --from eu.nixbuild.net "$KERNEL_CONFIG"
nix-copy-closure --from eu.nixbuild.net "$GENERATED_CONFIG"

nix-shell -p diffutils --run "diff $KERNEL_CONFIG $GENERATED_CONFIG/config" > config.diff

nix-shell -p python3Minimal --run "python ./generate-config.py"
