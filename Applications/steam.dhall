let Podenv = ../Podenv.dhall

in  Podenv.Application::{
    , description = Some "Steam"
    , command = [ "steam" ]
    , runtime =
        (./fedora.dhall).fusion.nonfree.use
          [ "steam"
          , "xz"
          , "file"
          , "diffutils"
          , "findutils"
          , "pciutils"
          , "procps-ng"
          , "glx-utils"
          , "xorg-x11-drv-nvidia-libs"
          ]
    , capabilities = Podenv.Capabilities::{
      , dri = True
      , x11 = True
      , pulseaudio = True
      , network = True
      }
    }
