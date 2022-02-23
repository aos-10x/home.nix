{ config, pkgs, ... }:

let
  python = import ./python;
in
{
  home.stateVersion = "22.05";
  programs.home-manager.enable = true;

  home.username = "aos";
  home.homeDirectory = "/home/aos";

  # Packages to install
  home.packages = with pkgs; [
    foot # wayland terminal

    python
    rust-analyzer

    curl
    htop
    jq
    neovim
    ripgrep
    tldr
    tmux
  ];

  # program configs
  home.file.".bashrc".source = ./config/bashrc;
  home.file.".bash_aliases".source = ./config/bash_aliases;

  home.file.".ssh/id_rsa_yk.pub".source = ./config/ssh_id_rsa_yk.pub;
  home.file.".ssh/config".source = ./config/ssh_config;
  home.file.".gnupg/gpg-agent.conf".source = ./config/gpg-agent.conf;

  home.file.".tmux.conf".source = ./config/tmux;

  home.file.".gitconfig".source = ./config/gitconfig;

  home.file.".config/nvim/init.vim".source = ./config/init.vim;
  home.file.".vimrc".source = ./config/vimrc;

  home.file.".config/foot/foot.ini".source = ./config/foot;
}
