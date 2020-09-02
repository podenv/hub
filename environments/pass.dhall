../functions/addCap.dhall
  ( \(env : ../types/Env) ->
          env.capabilities
      //  { gpg = Some True, x11 = Some True, terminal = Some True }
  )
  ( ../functions/mkSimpleEnv.dhall
      "pass"
      "A password manager using standard Unix tools"
  )
