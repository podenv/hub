../functions/addPackages.dhall
  [ "wl-clipboard" ]
  (     ../functions/mkSimpleEnv.dhall
          "pwsafe"
          "A unix commandline program that manages encrypted password databases"
    //  { capabilities = (../schemas/Caps)::{
          , terminal = Some True
          , wayland = Some True
          }
        }
  )
