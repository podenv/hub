{- Adds x11, dri and pulseaudio capability
-}
./addCap.dhall
  (     \(env : ../types/Env)
    ->      env.capabilities
        //  { dri = Some True, pulseaudio = Some True, x11 = Some True }
  )
