    ../functions/capGraphics.dhall
      ( ../functions/capAudio.dhall
          (../functions/mkSimpleEnv.dhall "kigo" "Go Board game")
      )
//  { packages = Some [ "kigo", "dbus-x11" ] }
