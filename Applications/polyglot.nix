# A nix package for https://github.com/vmchale/polyglot
{ pkgs ? import <nixpkgs> {} }:
pkgs.stdenv.mkDerivation rec {
  pname = "polyglot";
  version = "0.5.29";
  src = pkgs.fetchurl {
    url =
      "https://github.com/vmchale/polyglot/releases/download/${version}/poly-x86_64-unknown-linux-gcc-9";
    sha256 = "sha256-Gs6l2toQ6bVh8Af38/TO2SietcZNahk1HY9xc/JtuwY=";
  };
  dontStrip = true;
  unpackPhase = ''
    mkdir -p $out/bin
    cp $src $out/bin/poly
    chmod +x $out/bin/poly
  '';
  dontInstall = true;
}
