../functions/addCap.dhall
  (     \(env : ../types/Env)
    ->      env.capabilities
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
  (     ../functions/mkSimpleEnv.dhall "chromium" "open-source web browser"
    //  { command = Some [ "chromium-browser" ]
        , packages = Some [ "chromium", "mesa-dri-drivers" ]
        }
  )
