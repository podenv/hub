\(value : Optional Text) ->
\(default : Text) ->
  merge { None = default, Some = \(some : Text) -> some } value
