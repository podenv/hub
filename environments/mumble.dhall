    ../functions/mkSimpleEnv.dhall "mumble" "VoIP solution"
//  { capabilities =
        (../schemas/Caps)::{
        , ipc = Some True
        , network = Some True
        , pulseaudio = Some True
        , x11 = Some True
        }
    }
