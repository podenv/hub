let Prelude = ../../Prelude.dhall

let Env = ../../types/Env

let Task = ../../types/Task

let Base
    :     forall (version : Text)
      ->  forall (pre-tasks : List Task)
      ->  forall (env : Env)
      ->  Env
    =     \(version : Text)
      ->  \(pre-tasks : List Task)
      ->  \(env : Env)
      ->      env
          //  { build-env =
                  Some
                    ( ../mkBuildEnv.dhall
                        [ ../../functions/mkMount.dhall
                            "/var/cache/dnf"
                            "~/.cache/podenv/dnf-${version}"
                        ]
                    )
              , container-update =
                  ../defaultFile.dhall env.container-update [ ./update.dhall ]
              , container-file =
                  ../defaultFile.dhall
                    env.container-file
                    (   [ ./image.dhall version
                        , ../createUser.dhall 1000 "user"
                        ]
                      # pre-tasks
                      # [ ./install.dhall (../getPackages.dhall env.packages) ]
                    )
              }

let latest = "31"

in  { Latest = Base latest ([] : List Task)
    , Rawhide = Base "rawhide"
    , Base = Base
    , Fusion = Base latest [ ./fusion.dhall latest ]
    }
