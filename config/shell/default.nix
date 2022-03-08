{ config, pkgs, ... }:

{
  home.packages = with pkgs; [ fzf ripgrep ];

  home.file = {
    "bashrc" = {
      source = ./bashrc;
      target = ".bashrc";
    };

    "bash_aliases" = {
      source = ./bash_aliases;
      target = ".bash_aliases";
    };

    "inputrc" = {
      source = ./inputrc;
      target = ".inputrc";
    };
  };
}
