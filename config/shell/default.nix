{ config, pkgs, ... }:

{
  home.packages = with pkgs; [ fzf ripgrep ];

  # allow home-manager to manage shell
  programs.bash = {
    enable = true;
    # import my bashrc
    bashrcExtra = ''
     . ${builtins.toString ./bashrc}
    '';
  };

  home.file = {
    "bash_aliases" = {
      source = ./bash_aliases;
      target = ".bash_aliases";
    };

    "bash_functions" = {
      source = ./bash_functions;
      target = ".bash_functions";
    };

    "inputrc" = {
      source = ./inputrc;
      target = ".inputrc";
    };
  };

  targets.genericLinux.enable = true;
}
