    \(network : Text)
->  ./mapEnv.dhall
      (     \(env : ../types/Env)
        ->  env // { name = network ++ "-" ++ env.name, network = Some network }
      )
