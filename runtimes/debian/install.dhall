{- Returns the yum install task
-}
\(packages : List Text) ->
  (../../schemas/Task)::{
  , name = Some "Install packages"
  , shell =
      let packages = (../../Prelude.dhall).Text.concatSep " " packages

      in  Some "apt-get update && apt-get install -y ${packages}"
  }
