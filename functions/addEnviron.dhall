let getEnviron =
      \(env : ../types/Env) ->
        merge
          { None = [] : ../types/Environ
          , Some = \(some : ../types/Environ) -> some
          }
          env.environ

let addEnviron
    : forall (environ : ../types/Environ) ->
      forall (env : ../types/Env) ->
        ../types/Env
    = \(environ : ../types/Environ) ->
      \(env : ../types/Env) ->
        env // { environ = Some (getEnviron env # environ) }

in  addEnviron
