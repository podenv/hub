let getArgs =
      \(env : ../types/Env) ->
        merge
          { None = [] : List Text, Some = \(some : List Text) -> some }
          env.command

let addArgs
    : forall (args : List Text) -> forall (env : ../types/Env) -> ../types/Env
    = \(args : List Text) ->
      \(env : ../types/Env) ->
        env // { command = Some (getArgs env # args) }

in  addArgs
