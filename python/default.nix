with import <nixpkgs> { };

let
  yawsso = python39.pkgs.buildPythonPackage rec {
    pname = "yawsso";
    version = "0.7.2";

    src = python39.pkgs.fetchPypi {
      inherit pname version;
      sha256 = "sha256-UdJ8iZV7/Z0TFUeXv9RFZG5U/+X8HtxpuSznUEIzhc4=";
    };

    doCheck = false;
  };
in
python39.withPackages (ps: [ ps.pynvim ps."jedi-language-server" yawsso ])
