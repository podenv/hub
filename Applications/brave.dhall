let Podenv = ../Podenv.dhall

let container =
      let extra =
            (./fedora.dhall).addRepo
              { name = "brave-browser"
              , conf =
                  ''
                  name=created by dnf config-manager from https://brave-browser-rpm-release.s3.brave.com/x86_64/
                  baseurl=https://brave-browser-rpm-release.s3.brave.com/x86_64/
                  enabled=1
                  ''
              , key =
                  "https://brave-browser-rpm-release.s3.brave.com/brave-core.asc"
              }

      in  \(packages : List Text) ->
            Podenv.Container ((./fedora.dhall).useImage "latest" extra packages)

let default =
      Podenv.Application::{
      , description = Some "Brave Browser"
      , runtime =
          container
            [ "brave-browser"
            , "mesa-vulkan-drivers"
            , "mesa-dri-drivers"
            , "libglvnd-glx"
            ]
      , command = [ "brave-browser" ]
      , capabilities = Podenv.Capabilities::{
        , dbus = True
        , network = True
        , wayland = True
        , dri = True
        , video = True
        , pipewire = True
        , pulseaudio = True
        }
      }

in  { default }
