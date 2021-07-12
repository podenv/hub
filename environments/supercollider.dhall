../functions/addCap.dhall
  ( \(env : ../types/Env) ->
          env.capabilities
      //  { dri = Some True, x11 = Some True, pipewire = Some True }
  )
  (     ../functions/mkSimpleEnv.dhall
          "supercollider"
          "Programming environment for real-time audio and video processing"
    //  { packages = Some
          [ "supercollider", "pipewire-jack-audio-connection-kit" ]
        , command = Some [ "scide" ]
        }
  )
