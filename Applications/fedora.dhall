let Prelude = ../Prelude.dhall

let Podenv = ../Podenv.dhall

let fedora = ../Builders/fedora.dhall

let mkUse =
      \(version : Text) ->
      \(pre-task : Text) ->
      \(packages : List Text) ->
        Podenv.Container (fedora.image version pre-task packages)

let -- | When the application name is the package and command name
    useSimple =
      \(name : Text) ->
      \(desc : Text) ->
        Podenv.Application::{
        , name
        , description = Some desc
        , runtime = mkUse "latest" "" [ name ]
        , command = [ name ]
        }

let default =
      \(version : Text) ->
        Podenv.Application::{
        , runtime = Podenv.Image (fedora.image-ref version)
        , volumes = fedora.mkVolumes version
        , capabilities = Podenv.Capabilities::{
          , terminal = True
          , interactive = True
          , network = True
          }
        }

let -- | Create a default app and use function
    useD =
      \(version : Text) -> { default = default version, use = mkUse version "" }

let fusion-repo =
      \(variant : Text) ->
      \(ver : Text) ->
        "https://download1.rpmfusion.org/${variant}/fedora/rpmfusion-${variant}-release-${ver}.noarch.rpm"

let -- | A more beefy image with common graphic runtime pre-installed
    -- See: https://fedoraproject.org/wiki/Firefox_Hardware_acceleration
    useGraphicImage =
      \(ver : Text) ->
      \(extra : Text) ->
        let -- | A list of packages that are often required but missing from the requirements
            gfx-pkgs =
              [ "mesa-dri-drivers"
              , "mesa-vulkan-drivers"
              , "libglvnd-glx"
              , "glxinfo"
              , "gtk4"
              , "ffmpeg"
              , "libva"
              , "libva-utils"
              , "libva-intel-driver"
              , "xdg-utils"
              , "which"
              , "findutils"
              , "strace"
              ]

        let gfx-runtime =
                  "RUN dnf install -y "
              ++  fusion-repo "free" "\$(rpm -E %fedora)"
              ++  " && dnf install -y "
              ++  Prelude.Text.concatSep " " gfx-pkgs

        in  fedora.image ver (gfx-runtime ++ "\n" ++ extra)

in  { default = default "latest"
    , latest =
      { use = mkUse "latest" ""
      , useGraphic =
          \(pkgs : List Text) ->
            Podenv.Container (useGraphicImage "latest" "" pkgs)
      }
    , useSimple
    , useImage = fedora.image
    , useGraphicImage
    , `34` = useD "34"
    , rawhide = useD "rawhide"
    , fusion =
        let ver = "34"

        let mkVariant =
              \(variant : Text) ->
                { use =
                    mkUse ver ("RUN dnf install -y " ++ fusion-repo variant ver)
                }

        in  mkVariant "free" // { nonfree = mkVariant "nonfree" }
    , useCopr =
        \(name : Text) ->
          { use =
              mkUse
                "latest"
                "RUN dnf -y install dnf-plugins-core && dnf -y copr enable ${name}"
          }
    }
