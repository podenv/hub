../functions/addPackages.dhall
  [ "alsa-plugins-pulseaudio" ]
  (     ../functions/mkSimpleEnv.dhall
          "audacity"
          "Sound editor with graphical UI"
    //  { capabilities = (../schemas/Caps)::{
          , pulseaudio = Some True
          , x11 = Some True
          }
        }
  )
