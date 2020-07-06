let Prelude = ../../Prelude.dhall

let Env = ../../types/Env

let Task = ../../types/Task

let Base
    : forall (version : Text) ->
      forall (pre-tasks : List Task) ->
      forall (env : Env) ->
        Env
    = \(version : Text) ->
      \(pre-tasks : List Task) ->
      \(env : Env) ->
            env
        //  { build-env = ./build-env.dhall version
            , environ = Some
                (../getEnviron.dhall env # toMap { LANG = "C.utf8" })
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

let latest = "32"

in  { Latest = Base latest ([] : List Task)
    , Rawhide = Base "rawhide"
    , Base
    , Fusion = Base latest [ ./fusion.dhall latest ]
    , Devel =
        \(env : Env) ->
          Base
            "rawhide"
            ([] : List Task)
            (     env
              //  { packages = Some
                      (   [ "git"
                          , "make"
                          , "rpmdevtools"
                          , "createrepo_c"
                          , "pkgconfig"
                          , "python3-devel"
                          , "systemd-devel"
                          , "libtool"
                          , "gcc-c++"
                          , "emacs"
                          , "dnf-utils"
                          , "fedpkg"
                          , "krb5-workstation"
                          ]
                        # ../getPackages.dhall env.packages
                      )
                  }
            )
    }
