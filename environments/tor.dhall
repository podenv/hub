let Browser =
      ../functions/addCap.dhall
        (     \(env : ../types/Env)
          ->      env.capabilities
              //  { network = Some True
                  , x11 = Some True
                  , mount-run = Some True
                  , foreground = Some True
                  , large-shm = Some True
                  }
        )
        (     ../functions/mkSimpleEnv.dhall "tor-browser" "Tor browser"
          //  { command = Some [ "torbrowser-launcher" ]
              , packages = Some [ "torbrowser-launcher", "dbus-glib", "libXt" ]
              , mounts =
                  Some
                    [ ../functions/mkMountMap.dhall "~/.cache/torbrowser"
                    , ../functions/mkMountMap.dhall "~/.config/torbrowser"
                    , ../functions/mkMountMap.dhall
                        "~/.local/share/torbrowser/gnupg_homedir"
                    ]
              }
        )

in  { Browser = Browser }
