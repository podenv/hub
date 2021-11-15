-- | This application includes a custom runtime to install the upstream repository key.
let Podenv = ../Podenv.dhall

let container =
      let extra =
            (./fedora.dhall).addRepo
              { name = "vscode"
              , conf =
                  ''
                  name=Visual Studio Code
                  baseurl=https://packages.microsoft.com/yumrepos/vscode
                  enabled=1
                  gpgcheck=1
                  gpgkey=https://packages.microsoft.com/keys/microsoft.asc
                  ''
              , key = "https://packages.microsoft.com/keys/microsoft.asc"
              }

      in  \(packages : List Text) ->
            Podenv.Container ((./fedora.dhall).useImage "latest" extra packages)

let default =
      Podenv.Application::{
      , description = Some "Code editing"
      , runtime =
          container
            [ "code"
            , "mesa-vulkan-drivers"
            , "mesa-dri-drivers"
            , "glxinfo"
            , "iproute"
            , "which"
            , "findutils"
            ]
      , command = [ "code", "--wait" ]
      , capabilities = Podenv.Capabilities::{ wayland = True, x11 = True }
      }

in  { default }
