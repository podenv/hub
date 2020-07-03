{- Creates an environment where the env, package and command are identical
-}
let mkSimple
    : forall (name : Text) -> forall (description : Text) -> ../types/Env
    = \(name : Text) ->
      \(description : Text) ->
        (../schemas/Env)::{
        , name
        , description = Some description
        , packages = Some [ name ]
        , command = Some [ name ]
        }

in  mkSimple
