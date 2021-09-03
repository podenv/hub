let Podenv = ../Podenv.dhall

in  Podenv.Application::{
    , description = Some "VoIP solution"
    , runtime =
        (./fedora.dhall).latest.use [ "mumble", "opus", "qt5-qtwayland" ]
    , command = [ "mumble" ]
    , capabilities = Podenv.Capabilities::{
      , network = True
      , pulseaudio = True
      , wayland = True
      }
    }
