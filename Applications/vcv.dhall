let Podenv = ../Podenv.dhall

let builder =
      \(packages : List Text) ->
        Podenv.Container
          ( (./fedora.dhall).useGraphicImage
              "latest"
              ((./fedora.dhall).useCopr "ycollet/linuxmao")
              packages
          )

let minimal =
      Podenv.Application::{
      , description = Some "The EuroRack simulator"
      , runtime = builder [ "Rack-v1", "mesa-dri-drivers" ]
      , command = [ "Rack" ]
      , capabilities = Podenv.Capabilities::{
        , alsa = True
        , dri = True
        , pipewire = True
        , x11 = True
        , wayland = True
        }
      }

let default =
          minimal
      //  { runtime =
              builder
                [ "Rack-v1"
                , "mesa-dri-drivers"
                , "rack-v1-Bogaudio"
                , "rack-v1-AudibleInstruments"
                , "rack-v1-Valley"
                , "rack-v1-Befaco"
                , "rack-v1-Bidoo"
                , "rack-v1-DrumKit"
                ]
          }

in  { default, minimal }
