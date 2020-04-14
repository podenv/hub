    \(env : ../types/Env)
->  merge
      { None = [] : ../types/Environ
      , Some = \(some : ../types/Environ) -> some
      }
      env.environ
