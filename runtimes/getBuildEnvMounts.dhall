let Podenv = ../Podenv.dhall

let get
    :     forall (build-env : Optional Podenv.Types.BuildEnv)
      ->  List Podenv.Types.Mount
    =     \(build-env : Optional Podenv.Types.BuildEnv)
      ->  Optional/fold
            Podenv.Types.BuildEnv
            build-env
            (List Podenv.Types.Mount)
            (\(some : Podenv.Types.BuildEnv) -> some.mounts)
            ([] : List Podenv.Types.Mount)

in  get
