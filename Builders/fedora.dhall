let Prelude = ../Prelude.dhall

let Podenv = ../Podenv.dhall

let image-ref = \(ver : Text) -> "registry.fedoraproject.org/fedora:${ver}"

let mkVolumes = \(ver : Text) -> [ "cache-dnf-${ver}:/var/cache/dnf" ]

let image =
      \(ver : Text) ->
      \(pre-task : Text) ->
      \(pkgs : List Text) ->
        Podenv.ContainerBuild::{
        , containerfile =
            ''
            FROM ${image-ref ver}
            ARG USER_UID
            RUN ${./mkUser.dhall "fedora"}
            ${pre-task}
            RUN dnf update -y
            RUN dnf install -y ${Prelude.Text.concatSep " " pkgs}
            ''
        , image_volumes = mkVolumes ver
        , image_home = Some "/home/fedora"
        , image_update = Some "dnf update -y"
        }

in  { image-ref, mkVolumes, image }
