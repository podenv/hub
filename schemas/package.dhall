{ Application = ./Application.dhall
, Capabilities = ./Capabilities.dhall
, ContainerBuild = ./ContainerBuild.dhall
, System = ./System.dhall
, Image = (./Runtime.dhall).Image
, Nix = (./Runtime.dhall).Nix
, Flakes = ./Flakes.dhall
, Container = (./Runtime.dhall).Container
, Rootfs = (./Runtime.dhall).Rootfs
, Containerfile =
    let -- "A helper function to simplify documentation..."
        func
        : Text -> ./Runtime.dhall
        = \(containerfile : Text) ->
            (./Runtime.dhall).Container
              (./ContainerBuild.dhall)::{ containerfile }

    in  func
}
