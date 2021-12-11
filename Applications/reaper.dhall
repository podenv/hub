(../Podenv.dhall).Application::{
, description = Some "Complete digital audio production application"
, runtime = (../Podenv.dhall).Nix ./reaper.nix as Text
, command = [ "pw-jack", "reaper" ]
, capabilities = (../Podenv.dhall).Capabilities::{
  , dri = True
  , x11 = True
  , pipewire = True
  , pulseaudio = True
  , alsa = True
  }
}
