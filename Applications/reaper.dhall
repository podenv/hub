(../Podenv.dhall).Application::{
, description = Some "Complete digital audio production application"
, runtime = (./nix.dhall).use [ "reaper", "libjack2", "pipewire" ]
, command = [ "pw-jack", "reaper" ]
, capabilities = (../Podenv.dhall).Capabilities::{
  , dri = True
  , x11 = True
  , pipewire = True
  , pulseaudio = True
  , alsa = True
  }
}
