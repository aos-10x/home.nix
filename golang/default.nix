{ pkgs ? import <nixpkgs> { } }:

pkgs.mkDerivation {
  packages = with pkgs; [
    go
    gopls
    gotools
    go-tools
  ];
}
