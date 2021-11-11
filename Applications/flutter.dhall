(../Podenv.dhall).Application::{
, description = Some "Flutter SDK"
, runtime =
    (../Podenv.dhall).Nix
      "let pkgs = (import <nixpkgs> {}); in with pkgs; [(${./nixGL.nix as Text}) flutter clang pkg-config gtk3 pcre epoxy glib.dev mount ]"
, command = [ "nixGLIntel", "bash" ]
, capabilities = (../Podenv.dhall).Capabilities::{
  , terminal = True
  , interactive = True
  , dri = True
  , x11 = True
  , pulseaudio = True
  }
}
