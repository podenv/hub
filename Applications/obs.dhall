let Podenv = ../Podenv.dhall

in  Podenv.Application::{
    , description = Some "Open Broadcaster Software"
    , runtime = (./fedora.dhall).latest.use [ "obs-studio" ]
    , command = [ "obs" ]
    , capabilities = Podenv.Capabilities::{
      , wayland = True
      , dri = True
      , video = True
      , pipewire = True
      }
    }
