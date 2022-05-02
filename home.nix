{ config, pkgs, ... }:

let
  buildFromFlake = { repo, system }: (builtins.getFlake repo).defaultPackage."${system}";
  pkgsUnstable = import <nixpkgs-unstable> { config.allowUnfree = true; };
  secrets = import ./secrets.nix;

  python = import ./python;
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
    python
    rust-analyzer
    nixpkgs-fmt

    curl
    direnv
    htop
    jq
    qrencode
    tealdeer
    tmux
    tree

    # Infra tools
    rage
    ansible
    ansible-lint
    awscli2
    packer
    teleport
    terraform

    # custom flakes
    (callPackage buildFromFlake { repo = "github:aos/gotors"; })
  ];

  # program configs
  # home.file.".ssh/id_rsa_yk.pub".source = ./config/ssh_id_rsa_yk.pub;
  # home.file.".ssh/config" = {
  #   source = pkgs.substituteAll {
  #     src = ./config/ssh_config;
  #     hostName = "${secrets.hostName}";
  #     port = "${secrets.port}";
  #   };
  # };
  # home.file.".gnupg/gpg-agent.conf".source = ./config/gpg-agent.conf;
  # home.file.".gdbinit".source = ./config/gdbinit;

  home.file.".tmux.conf".source = ./config/tmux;

  home.file.".gitconfig" = {
    source = pkgs.substituteAll {
      src = ./config/gitconfig;
      email = "${secrets.emailAddress}";
    };
  };

  home.file.".config/nix/nix.conf".source = ./config/nix.conf;
}
