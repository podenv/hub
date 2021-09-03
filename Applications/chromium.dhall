let Podenv = ../Podenv.dhall

in  Podenv.Application::{
    , description = Some "open-source web browser"
    , runtime = (./fedora.dhall).latest.use [ "chromium", "mesa-dri-drivers" ]
    , command = [ "chromium-browser" ]
    , capabilities = Podenv.Capabilities::{
      , network = True
      , wayland = True
      , pipewire = True
      , -- | chrome somehow still needs x11
        x11 = True
      }
    }
