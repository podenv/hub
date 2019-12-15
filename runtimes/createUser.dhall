{- Creates user task
-}
    \(user : ../types/User)
->  let uid = Natural/show user.uid

    in  (../schemas/Task)::{
        , name = Some "Create user"
        , shell =
            Some
              ( (../Prelude.dhall).Text.concatSep
                  " && "
                  [ "useradd -u ${uid} -d ${user.home} -m ${user.name}"
                  , "mkdir -p /run/user/${uid}"
                  , "chown ${uid}:${uid} /run/user/${uid}"
                  , "mkdir -p /run/user/0"
                  , "chown 0:0 /run/user/0"
                  ]
              )
        }
