{- Adds packages to an environment.
   This function remove any previous runtime container-file to force re-creation
-}
let addPackages
    : forall (packages : List Text) ->
      forall (env : ../types/Env) ->
        ../types/Env
    = \(packages : List Text) ->
      \(env : ../types/Env) ->
            env
        //  { packages = Some
                (../runtimes/getPackages.dhall env.packages # packages)
            , container-file = None (List ../types/Task)
            , container-update = None (List ../types/Task)
            }

in  addPackages
