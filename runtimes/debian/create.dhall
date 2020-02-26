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
          //  { build-env = Some
                  ( ../mkBuildEnv.dhall
                      [ ../../functions/mkMount.dhall
                          "/var/cache/apt"
                          "~/.cache/podenv/apt-${version}"
                      ]
                  )
              , user = Some (../defaultUser.dhall env.user)
              , container-update =
                  ../defaultFile.dhall env.container-update [ ./update.dhall ]
              , container-file =
                  ../defaultFile.dhall
                    env.container-file
                    (   [ ./image.dhall version
                        , ../createUser.dhall (../defaultUser.dhall env.user)
                        ]
                      # pre-tasks
                      # [ ./install.dhall (../getPackages.dhall env.packages) ]
                    )
              }

let latest = "buster"

in  { Latest = Base latest ([] : List Task), Base = Base }
