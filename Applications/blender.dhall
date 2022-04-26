let default =
    -- This is using nix because the fedora package doesn't come with ffmpeg
      (../Podenv.dhall).Application::{
      , description = Some "3D creation suite"
      , runtime = (./nix.dhall).uses [ ./nixGL.dhall ] [ "blender" ]
      , command = [ "nixGLIntel", "blender" ]
      , capabilities = (../Podenv.dhall).Capabilities::{
        , dri = True
        , x11 = True
        , pulseaudio = True
        }
      }

let fedora =
          default
      //  { runtime = (./fedora.dhall).latest.useGraphic [ "blender" ]
          , command = [ "blender" ]
          }

in  { default, fedora }
