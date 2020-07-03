{- Adds a mountpoint to an environment
-}
let getMounts =
      \(env : ../types/Env) ->
        merge
          { None = [] : List ../types/Mount
          , Some = \(some : List ../types/Mount) -> some
          }
          env.mounts

let addMount
    : forall (mount : ../types/Mount) ->
      forall (env : ../types/Env) ->
        ../types/Env
    = \(mount : ../types/Mount) ->
      \(env : ../types/Env) ->
        env // { mounts = Some (getMounts env # [ mount ]) }

in  addMount
