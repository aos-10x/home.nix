{ config, pkgs, ... }:

let
  buildFromFlake = { repo, system }: (builtins.getFlake repo).packages."${system}".default;
  secrets = import ./secrets.nix;
  python = import ./python { pkgs = pkgs; };
  nixpkgs_go_1_18 = import (
    builtins.fetchTarball
    "https://github.com/nixOS/nixpkgs/archive/80c24eeb9ff46aa99617844d0c4168659e35175f.tar.gz"
  ) { };
  nixpkgs_teleport_11 = import (
    builtins.fetchTarball
    "https://github.com/nixOS/nixpkgs/archive/69a165d0fd2b08a78dbd2c98f6f860ceb2bbcd40.tar.gz"
  ) { };
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

  nixpkgs.overlays = [
    (self: super: {
      fcitx-engines = pkgs.fcitx5;
    })
  ];

  # Packages to install
  nixpkgs.config.allowUnfree = true;
  home.packages = with pkgs; [
    # rust-analyzer # using LspInstall rust-analyzer
    pop-launcher
    python
    nixpkgs-fmt
    nb

    # (callPackage ./golang {})
    nixpkgs_go_1_18.go_1_18
    gopls
    gotools
    go-tools

    curl
    direnv
    htop
    jless
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
    #{
    #  plugins = [
    #    pkgs.kubernetes-helmPlugins.helm-diff
    #  ];
    #}
    k9s
    jfrog-cli
    wireshark

    postgresql_13
    _1password
    nixpkgs_teleport_11.teleport_11
    vlc

    # custom flakes
    (callPackage buildFromFlake { repo = "github:aos/gotors"; })
    (callPackage buildFromFlake { repo = "github:aos/atools"; })
  ];

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
