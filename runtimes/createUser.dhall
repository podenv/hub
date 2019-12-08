{- Creates user task
-}
    \(uid : Natural)
->  \(name : Text)
->  let uid = Natural/show uid

    in  (../schemas/Task)::{
        , name = Some "Create user"
        , shell =
            Some
              ( (../Prelude.dhall).Text.concatSep
                  " && "
                  [ "useradd -u ${uid} ${name}"
                  , "mkdir -p /run/user/${uid}"
                  , "chown ${uid}:${uid} /run/user/${uid}"
                  , "mkdir -p /run/user/0"
                  , "chown 0:0 /run/user/0"
                  ]
              )
        }
