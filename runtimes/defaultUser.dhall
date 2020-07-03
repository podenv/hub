\(user : Optional ../types/User) ->
  merge
    { None = { name = "user", home = "/home/user", uid = 1000 }
    , Some = \(user : ../types/User) -> user
    }
    user
