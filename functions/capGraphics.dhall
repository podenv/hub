{- Adds the x11 capability
-}
./addCap.dhall
  (\(env : ../types/Env) -> env.capabilities // { x11 = Some True })
