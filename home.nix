{ config, pkgs, ... }:

let
  python = import ./python;
  pkgsUnstable = import <nixpkgs-unstable> { config.allowUnfree = true; };
  email = "aosdab@gmail.com";
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
    foot # wayland terminal
    gnome.gnome-books
    pkgsUnstable.discord
    pass

    python
    rust-analyzer

    curl
    htop
    jq
    ripgrep
    tldr
    tmux
    tree
  ];

  # program configs
  home.file.".ssh/id_rsa_yk.pub".source = ./config/ssh_id_rsa_yk.pub;
  home.file.".ssh/config".source = ./config/ssh_config;
  home.file.".gnupg/gpg-agent.conf".source = ./config/gpg-agent.conf;

  home.file.".tmux.conf".source = ./config/tmux;

  home.file.".gitconfig" = {
    source = pkgs.substituteAll {
      src = ./config/gitconfig;
      email = "${email}";
    };
  };

  home.file.".config/foot/foot.ini".source = ./config/foot;
}
