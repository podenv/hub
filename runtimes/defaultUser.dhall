    \(user : Optional ../types/User)
->  Optional/fold
      ../types/User
      user
      (Optional ../types/User)
      (\(user : ../types/User) -> Some user)
      (Some { name = "user", home = "/home/user", uid = 1000 })
