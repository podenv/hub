let Podenv = ../Podenv.dhall

let fedora = ../Builders/fedora.dhall

let mkUse =
      \(version : Text) ->
      \(pre-task : Text) ->
      \(packages : List Text) ->
        Podenv.Container (fedora.image version pre-task packages)

let addRepo =
      \(repo : { name : Text, conf : Text, key : Text }) ->
        let file = "[${repo.name}]" ++ "\n" ++ repo.conf

        in  ''
            RUN rpm --import ${repo.key}
            RUN echo -e ${Text/show file} > /etc/yum.repos.d/${repo.name}.repo
            ''

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

in  { default = default "latest"
    , latest.use = mkUse "latest" ""
    , addRepo
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
