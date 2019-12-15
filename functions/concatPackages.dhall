let Prelude = ../Prelude.dhall

let Env = ../types/Env

let concatPackages
    : forall (envs : List Env) -> List Text
    =     \(envs : List Env)
      ->  Prelude.List.fold
            Env
            envs
            (List Text)
            (     \(env : Env)
              ->  \(acc : List Text)
              ->  acc # ../runtimes/getPackages.dhall env.packages
            )
            ([] : List Text)

in  concatPackages
