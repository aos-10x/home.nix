{ config, pkgs, ... }:

{
  home.packages = with pkgs; [ fzf ripgrep ];

  home.file = {
    "profile" = {
      source = ./profile;
      target = ".profile";
    };

    "bashrc" = {
      source = ./bashrc;
      target = ".bashrc";
    };

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
}
