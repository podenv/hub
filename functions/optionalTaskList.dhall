    \(value : Optional (List ../types/Task))
->  \(default : List ../types/Task)
->  Optional/fold
      (List ../types/Task)
      value
      (List ../types/Task)
      (\(some : List ../types/Task) -> some)
      default
