let Podenv = ../Podenv.dhall

in  Podenv.Application::{
    , description = Some "Qt based JACK control application"
    , runtime =
        Podenv.Container
          ((./fedora.dhall).useGraphicImage "latest" "" [ "qjackctl" ])
    , command = [ "qjackctl" ]
    , capabilities = Podenv.Capabilities::{
      , pipewire = True
      , x11 = True
      , alsa = True
      }
    }
