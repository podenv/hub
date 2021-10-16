let Podenv = ../Podenv.dhall

in  Podenv.Application::{
    , description = Some "Open Broadcaster Software"
    , runtime =
        (./fedora.dhall).fusion.use
          ([ "obs-studio", "qt5-qtwayland" ] # ./_graphicDrivers.dhall)
    , command = [ "obs" ]
    , capabilities = Podenv.Capabilities::{
      , wayland = True
      , dri = True
      , dbus = True
      , video = True
      , pipewire = True
      }
    }
