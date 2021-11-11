-- This is using nix because the fedora package doesn't come with ffmpeg
(../Podenv.dhall).Application::{
, description = Some "3D creation suite"
, runtime =
    (../Podenv.dhall).Nix
      "[(${./nixGL.nix as Text}) ((import <nixpkgs> { }).blender)]"
, command = [ "nixGLIntel", "blender" ]
, capabilities = (../Podenv.dhall).Capabilities::{
  , dri = True
  , x11 = True
  , pulseaudio = True
  }
}
