    ../functions/mkSimpleEnv.dhall
      "zeal"
      "Offline documentation browser inspired by Dash"
//  { capabilities = (../schemas/Caps)::{ network = Some True, x11 = Some True }
    , mounts = Some
        [ { host-path = "~/.cache/zeal", container-path = "/home/user" } ]
    }
