let Env = ../../types/Env

let Task = ../../schemas/Task

let mounts =
      [ ../../functions/mkMount.dhall "~/.npm" "~/.cache/podenv/npm"
      , ../../functions/mkMount.dhall "~/.yarn" "~/.cache/podenv/yarn"
      ]

let Base
    : forall (env : Env) -> Env
    =     \(env : Env)
      ->  let fedora =
                (../fedora/create.dhall).Latest
                  (     env
                    //  { packages = Some [ "nodejs", "iproute", "firefox" ] }
                  )

          in      fedora
              //  { image = Some "localhost/podenv/node"
                  , build-env =
                      Some
                        ( ../mkBuildEnv.dhall
                            (   ../getBuildEnvMounts.dhall fedora.build-env
                              # mounts
                            )
                        )
                  , mounts = Some mounts
                  , container-file =
                      Some
                        (   ../../functions/optionalTaskList.dhall
                              fedora.container-file
                              ([] : List ../../types/Task)
                          # [ Task::{
                              , name = Some "Install yarn"
                              , shell = Some "npm install -g yarn"
                              }
                            ]
                        )
                  , container-update =
                      Some
                        [ ../fedora/update.dhall
                        , Task::{
                          , name = Some "Update yarn"
                          , shell = Some "npm update -g yarn"
                          }
                        ]
                  }

in  { Latest = Base }
