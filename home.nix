{ config, pkgs, ... }:

let
  buildFromFlake = { repo, system }: (builtins.getFlake repo).packages."${system}".default;
  pkgsUnstable = import (builtins.fetchGit {
    name = "nixpkgs-unstable";
    url = "https://github.com/NixOS/nixpkgs/";
    ref = "refs/heads/nixpkgs-unstable";
  }) { config.allowUnfree = true; };
  secrets = import ./secrets.nix;
  python = import ./python { pkgs = pkgs; };
in
{
  home.stateVersion = "22.05";
  programs.home-manager.enable = true;

  home.username = "aos";
  home.homeDirectory = "/home/aos";

  imports = [
    ./config/vim
    ./config/shell
  ];

  # Packages to install
  nixpkgs.config.allowUnfree = true;
  home.packages = with pkgs; [
    # rust-analyzer # using LspInstall rust-analyzer
    pop-launcher
    python
    nixpkgs-fmt

    # (callPackage ./golang {})
    go_1_18
    gopls
    gotools
    go-tools

    curl
    direnv
    htop
    jq
    qrencode
    tealdeer
    tmux
    tree
    pre-commit

    # nice things
    kolourpaint

    # Infra tools
    rage
    ipcalc
    ansible
    awscli2
    docker-compose
    packer
    terraform
    terraform-docs
    minikube
    kubectl
    ipcalc
    kubernetes-helm-wrapped
    k9s
    jfrog-cli

    postgresql_13
    _1password
    teleport_11
    vlc

    # custom flakes
    (callPackage buildFromFlake { repo = "github:aos/gotors"; })
  ];

  # program configs
  # home.file.".ssh/config" = {
  #   source = pkgs.substituteAll {
  #     src = ./config/ssh_config;
  #     hostName = "${secrets.hostName}";
  #     port = "${secrets.port}";
  #   };
  # };

  home.file.".tmux.conf".source = ./config/tmux;

  home.file.".gitconfig" = {
    source = pkgs.substituteAll {
      src = ./config/gitconfig;
      email = "${secrets.emailAddress}";
    };
  };

  home.file.".config/nix/nix.conf".source = ./config/nix.conf;

  news.display = "silent";
}
