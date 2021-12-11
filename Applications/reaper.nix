let
  pkgs = import <nixpkgs> { config = { allowUnfree = true; }; };
  reaper = pkgs.reaper.overrideAttrs (old: rec {
    version = "6.42";
    src = pkgs.fetchurl {
      url = "https://www.reaper.fm/files/6.x/reaper${
          builtins.replaceStrings [ "." ] [ "" ] version
        }_linux_x86_64.tar.xz";
      hash = "sha256:0jli6gra9qmsbnnlwpi4alh4yd1mnsnsny3830wcn2y5gwkvnqg5";
    };
  });
in [ reaper pkgs.libjack2 pkgs.pipewire ]
