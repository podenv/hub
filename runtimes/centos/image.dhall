{- A task to define the FROM statement
-}
\(version : Natural) ->
  (../../schemas/Task)::{
  , name = Some "Use registry.centos.org"
  , command = Some "FROM registry.centos.org/centos:${Natural/show version}"
  }
