{- Adds the hostfiles capability
-}
./addCap.dhall
  (\(env : ../types/Env) -> env.capabilities // { hostfiles = Some True })
