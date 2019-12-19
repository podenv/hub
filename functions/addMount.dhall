{- Adds a mountpoint to an environment
-}
let getMounts =
          \(env : ../types/Env)
      ->  Optional/fold
            (List ../types/Mount)
            env.mounts
            (List ../types/Mount)
            (\(some : List ../types/Mount) -> some)
            ([] : List ../types/Mount)

let addMount
    :     forall (mount : ../types/Mount)
      ->  forall (env : ../types/Env)
      ->  ../types/Env
    =     \(mount : ../types/Mount)
      ->  \(env : ../types/Env)
      ->  env // { mounts = Some (getMounts env # [ mount ]) }

in  addMount
