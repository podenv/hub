let getArgs =
          \(env : ../types/Env)
      ->  Optional/fold
            (List Text)
            env.command
            (List Text)
            (\(some : List Text) -> some)
            ([] : List Text)

let addArgs
    : forall (args : List Text) -> forall (env : ../types/Env) -> ../types/Env
    =     \(args : List Text)
      ->  \(env : ../types/Env)
      ->  env // { command = Some (getArgs env # args) }

in  addArgs
