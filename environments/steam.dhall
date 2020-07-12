../functions/addCap.dhall
  ( \(env : ../types/Env) ->
          env.capabilities
      //  { dri = Some True
          , webcam = Some True
          , x11 = Some True
          , pulseaudio = Some True
          , seccomp = Some False
          , large-shm = Some True
          , ipc = Some True
          , network = Some True
          }
  )
  (     ../functions/mkSimpleEnv.dhall "steam" "Steam"
    //  { hostname = Some "localhost"
        , environ = Some
            ( toMap
                { SDL_JOYSTICK_DEVICE = "/dev/input/event18:/dev/input/js0" }
            )
        , packages = Some
          [ "steam"
          , "xz"
          , "file"
          , "diffutils"
          , "findutils"
          , "pciutils"
          , "procps-ng"
          , "glx-utils"
          , "xorg-x11-drv-nvidia-libs"
          ]
        }
  )
