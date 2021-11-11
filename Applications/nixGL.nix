let pkgs = import <nixpkgs> { };
in (import (pkgs.fetchFromGitHub {
  owner = "guibou";
  repo = "nixGL";
  rev = "c4aa5aa15af5d75e2f614a70063a2d341e8e3461";
  sha256 = "sha256-rfA7lqV+cR3bQt4lT2F+6qrIzJSPloJaGVATR9u+5yY=";
}) {
  pkgs = pkgs;
  enable32bits = false;
}).nixGLIntel
