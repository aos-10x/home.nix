#!/usr/bin/env bash

# This script will run all the required steps to bring in our dotfiles!

set -euo pipefail

# Install nix
install_nix () {
  if command -v nix-shell &> /dev/null && \
    nix-shell -p nix-info --run "nix-info -m" &> /dev/null; then
    echo "Nix already installed... exiting."
    return
  fi

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

home_manager_switch () {
  echo "INFO: Running 'home-manager switch'"

  home-manager switch
}

install_docker_deb() {
  sudo apt update
  sudo apt install \
    ca-certificates \
    curl \
    gnupg \
    lsb-release

  # Add GPG key
  curl -fsSL "https://download.docker.com/linux/ubuntu/gpg" | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg

  # Add stable repository
  echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

  # Install
  sudo apt update
  sudo apt install docker-ce docker-ce-cli containerd.io
  sudo usermod -aG docker $USER
}

install_docker_dnf () {
  sudo dnf remove docker \
                  docker-client \
                  docker-client-latest \
                  docker-common \
                  docker-latest \
                  docker-latest-logrotate \
                  docker-logrotate \
                  docker-selinux \
                  docker-engine-selinux \
                  docker-engine

  sudo dnf -y install dnf-plugins-core
  sudo dnf config-manager \
    --add-repo \
    https://download.docker.com/linux/fedora/docker-ce.repo

  sudo dnf install docker-ce \
		   docker-ce-cli \
		   containerd.io \
		   docker-compose-plugin

  sudo usermod -aG docker $USER
}

#install_docker_dnf
#install_nix
install_home_manager
sym_repo
home_manager_switch
