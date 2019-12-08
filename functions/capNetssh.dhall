{- Adds network and ssh capability
-}
./addCap.dhall
  (     \(env : ../types/Env)
    ->  env.capabilities // { network = Some True, ssh = Some True }
  )
