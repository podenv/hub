let Podenv = ../Podenv.dhall

in  Podenv.Application::{
    , description = Some "Media player software"
    , runtime =
        (./fedora.dhall).fusion.use
          [ "mplayer"
          , "libvdpau-va-gl"
          , "mesa-dri-drivers"
          , "libva-intel-driver"
          , "libva-intel-hybrid-driver"
          ]
    , command = [ "mplayer" ]
    , capabilities = Podenv.Capabilities::{
      , dri = True
      , pulseaudio = True
      , wayland = True
      }
    }
