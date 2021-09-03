(../Podenv.dhall).Application::{
, description = Some "Display the graphical console for a virtual machine"
, runtime = (./fedora.dhall).latest.use [ "virt-viewer" ]
, command = [ "remote-viewer" ]
, capabilities = (../Podenv.dhall).Capabilities::{
  , wayland = True
  , network = True
  }
}
