let Env = ../../types/Env

let Task = ../../schemas/Task

let Base
    : forall (env : Env) -> Env
    = \(env : Env) ->
        let fedora =
              (../fedora/create.dhall).Latest
                (env // { packages = Some [ "python3-pip", "git" ] })

        in      fedora
            //  { build-env = Some
                    ( ../mkBuildEnv.dhall
                        (   ../getBuildEnvMounts.dhall fedora.build-env
                          # [ ../../functions/mkMount.dhall
                                "~/.cache/pip"
                                "~/.cache/podenv/pip"
                            ]
                        )
                    )
                , container-file = Some
                    (   ../../functions/optionalTaskList.dhall
                          fedora.container-file
                          ([] : List ../../types/Task)
                      # [ ./install.dhall (../getPackages.dhall env.packages) ]
                    )
                , container-update = Some
                  [ ../fedora/update.dhall
                  , ./install.dhall (../getPackages.dhall env.packages)
                  ]
                }

in  { Latest = Base }
