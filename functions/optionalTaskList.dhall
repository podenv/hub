\(value : Optional (List ../types/Task)) ->
\(default : List ../types/Task) ->
  merge { None = default, Some = \(some : List ../types/Task) -> some } value
