with import <nixpkgs> {};

let
  base-python-packages = python-packages: with python-packages; [
    # Used by neovim
    pynvim
    jedi-language-server
  ];
in
  python39.withPackages base-python-packages
