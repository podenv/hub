{- Creates a BuildEnv
-}
let Podenv = ../Podenv.dhall

let mkBuildEnv
    : forall (mounts : List Podenv.Types.Mount) -> Podenv.Types.BuildEnv
    =     \(mounts : List Podenv.Types.Mount)
      ->  Podenv.Schemas.BuildEnv::{ mounts = mounts }

in  mkBuildEnv
