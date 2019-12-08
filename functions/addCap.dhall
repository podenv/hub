{- Adds capability to an environment
-}
let addCap
    :     forall (func : ../types/Env -> ../types/Caps)
      ->  forall (env : ../types/Env)
      ->  ../types/Env
    =     \(func : ../types/Env -> ../types/Caps)
      ->  \(env : ../types/Env)
      ->  env // { capabilities = (../schemas/Caps)::(func env) }

in  addCap
