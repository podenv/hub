(../schemas/Env)::{
, name = "virt-viewer"
, description = Some "Display the graphical console for a virtual machine"
, url = Some "https://virt-manager.org/"
, packages = Some [ "virt-viewer" ]
, command = Some [ "remote-viewer" ]
, capabilities = (../schemas/Caps)::{ x11 = Some True, network = Some True }
}
