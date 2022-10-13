{ pythonPkgs }:

pythonPkgs.buildPythonPackage rec {
  pname = "yawsso";
  version = "0.7.2";

  src = pythonPkgs.fetchPypi {
    inherit pname version;
    sha256 = "sha256-UdJ8iZV7/Z0TFUeXv9RFZG5U/+X8HtxpuSznUEIzhc4=";
  };

  doCheck = false;
}
