{ config, pkgs, ... }:

{
  home.sessionVariables = {
    SYSTEMD_LESS = "FRXMK"; # allow journalctl to wrap long lines
  };

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
