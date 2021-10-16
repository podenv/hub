let Podenv = ../Podenv.dhall

let minimal =
      Podenv.Application::{
      , description = Some "Mozilla Firefox"
      , runtime = (./fedora.dhall).latest.use [ "firefox" ]
      , command = [ "firefox", "--no-remote" ]
      , capabilities = Podenv.Capabilities::{ wayland = True, network = True }
      }

let default =
          minimal
      //  { runtime =
              (./fedora.dhall).fusion.use
                (   [ "firefox"
                    , "gdouros-symbola-fonts"
                    , "pipewire-pulseaudio"
                    , "ffmpeg"
                    , "mozilla-ublock-origin"
                    ]
                  # ./_graphicDrivers.dhall
                )
          , capabilities =
              minimal.capabilities // { dri = True, pulseaudio = True }
          }

in  { default, minimal }
