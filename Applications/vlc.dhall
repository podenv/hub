(../Podenv.dhall).Application::{
, description = Some "Media Player"
, runtime = (../Podenv.dhall).Nix "(import <nixpkgs> { }).vlc"
, command = [ "vlc" ]
, capabilities = (../Podenv.dhall).Capabilities::{
  , dri = True
  , x11 = True
  , pulseaudio = True
  }
}
