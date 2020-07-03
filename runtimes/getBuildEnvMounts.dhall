let Podenv = ../Podenv.dhall

let get
    : forall (build-env : Optional Podenv.Types.BuildEnv) ->
        List Podenv.Types.Mount
    = \(build-env : Optional Podenv.Types.BuildEnv) ->
        merge
          { None = [] : List Podenv.Types.Mount
          , Some = \(some : Podenv.Types.BuildEnv) -> some.mounts
          }
          build-env

in  get
