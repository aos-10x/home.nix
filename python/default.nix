with import <nixpkgs> { };

let
  yawsso = import ./pkgs/yawsso { python39Pkgs = python39.pkgs; };
in
python39.withPackages (ps: with ps; [
  pynvim
  # jedi-language-server
  yawsso
])
