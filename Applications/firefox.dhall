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
              (./fedora.dhall).latest.useGraphic
                [ "firefox"
                , "gdouros-symbola-fonts"
                , "pipewire-pulseaudio"
                , "mozilla-ublock-origin"
                ]
          , capabilities =
              minimal.capabilities // { dri = True, pulseaudio = True }
          }

in  { default, minimal }
