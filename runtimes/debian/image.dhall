{- A task to define the FROM statement
-}
\(version : Text) ->
  (../../schemas/Task)::{
  , command = Some "FROM docker.io/library/debian:${version}"
  }
