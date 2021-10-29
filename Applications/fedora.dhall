let Podenv = ../Podenv.dhall

let fedora = ../Builders/fedora.dhall

let mkUse =
      \(version : Text) ->
      \(pre-task : Text) ->
      \(packages : List Text) ->
        Podenv.Container (fedora.image version pre-task packages)

let mkUsePost =
      \(version : Text) ->
      \(pre-task : Text) ->
      \(packages : List Text) ->
      \(post-task : Text) ->
        let image = fedora.image version pre-task packages

        in  Podenv.Container
              ( image
                with containerfile = image.containerfile ++ post-task ++ "\n"
              )

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

let review =
      Podenv.Application::{
      , description = Some "Review tool for fedora rpm packages"
      , runtime =
          mkUsePost
            "latest"
            ""
            [ "fedora-review" ]
            ''
            # Ensure mock group is set
            RUN usermod -G mock root && echo 'config_opts["use_nspawn"] = False' >> /etc/mock/site-defaults.cfg
            ''
      , syscaps = [ "SYS_ADMIN" ]
      , capabilities = Podenv.Capabilities::{
        , keep = True
        , network = True
        , interactive = True
        , terminal = True
        , root = True
        }
      , volumes = [ "fedora-review:~" ]
      }

in  { default = default "latest"
    , latest.use = mkUse "latest" ""
    , review
    , useSimple
    , useImage = fedora.image
    , `34` = useD "34"
    , rawhide = useD "rawhide"
    , fusion =
        let ver = "34"

        let fusion-repo =
              \(variant : Text) ->
                "https://download1.rpmfusion.org/${variant}/fedora/rpmfusion-${variant}-release-${ver}.noarch.rpm"

        let mkVariant =
              \(variant : Text) ->
                { use = mkUse ver ("RUN dnf install -y " ++ fusion-repo variant)
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
