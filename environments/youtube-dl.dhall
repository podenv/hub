../functions/addCap.dhall
  ( \(env : ../types/Env) ->
          env.capabilities
      //  { network = Some True, uidmap = Some True, mount-cwd = Some True }
  )
  ( ../functions/mkSimpleEnv.dhall
      "youtube-dl"
      "command-line program to download videos"
  )
