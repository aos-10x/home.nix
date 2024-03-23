{ pkgs, ... }:

with pkgs;

python310.withPackages (ps: with ps; [
  (callPackage ./pkgs/yawsso { pythonPkgs = python310.pkgs; })
  pynvim

  pylint
  # flake8
  python-lsp-black
  pyls-isort
  pylsp-mypy
])
