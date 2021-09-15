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
                [ "firefox"
                , "gdouros-symbola-fonts"
                , "mesa-dri-drivers"
                , "libva-intel-driver"
                , "libva-intel-hybrid-driver"
                , "pipewire-pulseaudio"
                , "ffmpeg"
                , "mozilla-ublock-origin"
                ]
          , capabilities =
              minimal.capabilities // { dri = True, pulseaudio = True }
          }

in  { default, minimal }
