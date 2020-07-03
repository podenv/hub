let Prelude = ../../Prelude.dhall

let Env = ../../types/Env

let Task = ../../types/Task

let Base
    : forall (version : Natural) ->
      forall (pre-tasks : List Task) ->
      forall (env : Env) ->
        Env
    = \(version : Natural) ->
      \(pre-tasks : List Task) ->
      \(env : Env) ->
            env
        //  { build-env = Some
                ( ../mkBuildEnv.dhall
                    [ ../../functions/mkMount.dhall
                        "/var/cache/yum"
                        "~/.cache/podenv/centos-${Natural/show version}"
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

let latest = 8

let DevelBase =
      \(version : Natural) ->
      \(env : Env) ->
        Base
          version
          ([] : List Task)
          (     env
            //  { packages = Some
                  [ "git"
                  , "make"
                  , "rpmdevtools"
                  , "createrepo_c"
                  , "pkgconfig"
                  , "python3-devel"
                  , "systemd-devel"
                  , "libtool"
                  , "gcc-c++"
                  ]
                }
          )

in  { Latest = Base latest ([] : List Task)
    , EL7 = Base 7 ([] : List Task)
    , Base
    , DevelBase
    , Devel = DevelBase latest
    }
