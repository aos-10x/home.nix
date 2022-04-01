{ config, pkgs, ... }:

let
  python = import ./python;
  pkgsUnstable = import <nixpkgs-unstable> { config.allowUnfree = true; };
  buildFromFlake = { repo, system }: (builtins.getFlake repo).defaultPackage."${system}";
  secrets = import ./secrets.nix;
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
    # foot # wayland terminal
    st
    gnome.gnome-books
    pass
    vagrant

    python
    rust-analyzer
    nixpkgs-fmt

    curl
    htop
    jq
    qrencode
    tldr
    tmux
    tree

    (callPackage buildFromFlake { repo = "github:aos/gotors"; })
  ];

  # program configs
  home.file.".ssh/id_rsa_yk.pub".source = ./config/ssh_id_rsa_yk.pub;
  home.file.".ssh/config" = {
    source = pkgs.substituteAll {
      src = ./config/ssh_config;
      hostName = "${secrets.hostName}";
      port = "${secrets.port}";
    };
  };
  home.file.".gnupg/gpg-agent.conf".source = ./config/gpg-agent.conf;

  home.file.".tmux.conf".source = ./config/tmux;

  home.file.".gitconfig" = {
    source = pkgs.substituteAll {
      src = ./config/gitconfig;
      email = "${secrets.emailAddress}";
    };
  };

  home.file.".config/nix/nix.conf".source = ./config/nix.conf;
}
