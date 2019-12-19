let getEnviron =
          \(env : ../types/Env)
      ->  Optional/fold
            ../types/Environ
            env.environ
            ../types/Environ
            (\(some : ../types/Environ) -> some)
            ([] : ../types/Environ)

let addEnviron
    :     forall (environ : ../types/Environ)
      ->  forall (env : ../types/Env)
      ->  ../types/Env
    =     \(environ : ../types/Environ)
      ->  \(env : ../types/Env)
      ->  env // { environ = Some (getEnviron env # environ) }

in  addEnviron
