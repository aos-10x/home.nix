{ python39Pkgs }:

python39Pkgs.buildPythonPackage rec {
  pname = "yawsso";
  version = "0.7.2";

  src = python39Pkgs.fetchPypi {
    inherit pname version;
    sha256 = "sha256-UdJ8iZV7/Z0TFUeXv9RFZG5U/+X8HtxpuSznUEIzhc4=";
  };

  doCheck = false;
}
