#!/usr/bin/env bash

set -euo pipefail

# Install nix
install_nix () {
  # We need to automate this
  sh <(curl -L https://nixos.org/nix/install) --daemon
}

# Install home manager
install_home_manager () {
  # Add Home Manager channel (Nixpkgs master or unstable)
  nix-channel --add https://github.com/nix-community/home-manager/archive/master.tar.gz home-manager
  nix-channel --add https://nixos.org/channels/nixpkgs-unstable nixpkgs-unstable
  nix-channel --update

  # Need this if we're not on NixOS
  if ! grep 'NAME="NixOS"' /etc/os-release; then
    export NIX_PATH=$HOME/.nix-defexpr/channels:/nix/var/nix/profiles/per-user/root/channels${NIX_PATH:+:$NIX_PATH}
  fi

  # install Home Manager
  nix-shell '<home-manager>' -A install
}

# Symlink repo
sym_repo () {
  rm ~/.config/nixpkgs
  ln -sf ~/code/nixfiles ~/.config/nixpkgs
}

# `home-manager switch`
