{- Adds packages to an environment
-}
let addPackages
    :     forall (packages : List Text)
      ->  forall (env : ../types/Env)
      ->  ../types/Env
    =     \(packages : List Text)
      ->  \(env : ../types/Env)
      ->      env
          //  { packages =
                  Some (../runtimes/getPackages.dhall env.packages # packages)
              }

in  addPackages
