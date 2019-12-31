    ../functions/addCap.dhall
      (     \(env : ../types/Env)
        ->  env.capabilities // { mount-cwd = Some True, uidmap = Some True }
      )
      ( ../functions/mkSimpleEnv.dhall
          "hugo"
          "A Fast and Flexible Static Site Generator"
      )
//  { packages = Some [ "hugo", "iproute" ] }
