#!/usr/bin/env bash

# This script will run all the required steps to bring in our dotfiles!

set -euo pipefail

if command -v nix-shell &> /dev/null && \
  nix-shell -p nix-info --run "nix-info -m" &> /dev/null; then
  echo "Nix already installed... exiting."
  exit 0
fi

# Install nix
install_nix () {
  echo "INFO: installing Nix..."
  # We need to automate this
  sh <(curl -L https://nixos.org/nix/install) --daemon
}

# Install home manager
install_home_manager () {
  echo "INFO: Installing home-manager..."

  # Add Home Manager channel (Nixpkgs master or unstable)
  nix-channel --add https://github.com/nix-community/home-manager/archive/master.tar.gz home-manager
  nix-channel --add https://nixos.org/channels/nixpkgs-unstable nixpkgs-unstable
  nix-channel --update

  # Need this if we're not on NixOS
  if ! grep 'NAME="NixOS"' /etc/os-release; then
    export NIX_PATH=$HOME/.nix-defexpr/channels:/nix/var/nix/profiles/per-user/root/channels
  fi

  # install Home Manager
  nix-shell '<home-manager>' -A install
}

# Symlink repo
sym_repo () {
  echo "INFO: Symlinking repository to ~/.config/nixpkgs"

  rm -rfv ~/.config/nixpkgs
  ln -s "$(realpath .)" ~/.config/nixpkgs
}

switch () {
  echo "INFO: Running 'home-manager switch'"

  home-manager switch
}

install_nix
install_home_manager
sym_repo
switch
