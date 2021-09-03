let Podenv = ../Podenv.dhall

let builder = (./fedora.dhall).useCopr "ycollet/linuxmao"

let minimal =
      Podenv.Application::{
      , description = Some "The EuroRack simulator"
      , runtime = builder.use [ "Rack-v1", "mesa-dri-drivers" ]
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
              builder.use
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
