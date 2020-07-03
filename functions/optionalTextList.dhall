\(value : Optional (List Text)) ->
\(default : List Text) ->
  merge { None = default, Some = \(some : List Text) -> some } value
