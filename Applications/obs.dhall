let Podenv = ../Podenv.dhall

in  Podenv.Application::{
    , description = Some "Open Broadcaster Software"
    , runtime =
        (./fedora.dhall).latest.useGraphic [ "obs-studio", "qt5-qtwayland" ]
    , command = [ "obs" ]
    , capabilities = Podenv.Capabilities::{
      , wayland = True
      , dri = True
      , dbus = True
      , video = True
      , pipewire = True
      }
    }
