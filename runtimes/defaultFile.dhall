{- Returns an environment container-file or container-update if it is defined.
   Otherwise returns the second argument, a default list of tasks.
-}
let defaultFile
    : forall (tasks : Optional (List ../types/Task)) ->
      forall (default : List ../types/Task) ->
        Optional (List ../types/Task)
    = \(tasks : Optional (List ../types/Task)) ->
      \(default : List ../types/Task) ->
        Some (../functions/optionalTaskList.dhall tasks default)

in  defaultFile
