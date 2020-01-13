    ../functions/mkSimpleEnv.dhall "linphone" "Open Source VOIP project"
//  { capabilities =
        (../schemas/Caps)::{
        , network = Some True
        , pulseaudio = Some True
        , x11 = Some True
        }
    }
