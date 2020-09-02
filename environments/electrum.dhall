../functions/addCap.dhall
  ( \(env : ../types/Env) ->
      env.capabilities // { network = Some True, x11 = Some True }
  )
  ( ../functions/mkSimpleEnv.dhall
      "electrum"
      "Electrum is an easy to use Bitcoin client"
  )
