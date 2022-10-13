with import <nixpkgs> { };

python39.withPackages (ps: with ps; [
  (callPackage ./pkgs/yawsso { pythonPkgs = python39.pkgs; })
  pynvim

  pylint
  # flake8
  python-lsp-black
  pyls-isort
  pylsp-mypy
])
