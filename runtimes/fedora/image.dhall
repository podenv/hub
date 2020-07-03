{- A task to define the FROM statement
-}
\(version : Text) ->
  (../../schemas/Task)::{
  , name = Some "Use registry.fedoraproject.org"
  , command = Some "FROM registry.fedoraproject.org/fedora:${version}"
  }
