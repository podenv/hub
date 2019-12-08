{- Adds pulseaudio capability
-}
./addCap.dhall
  (\(env : ../types/Env) -> env.capabilities // { pulseaudio = Some True })
