    \(value : Optional (List Text))
->  \(default : List Text)
->  Optional/fold
      (List Text)
      value
      (List Text)
      (\(some : List Text) -> some)
      default
