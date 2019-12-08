let mkSimple = ../functions/mkSimpleEnv.dhall

let Caps =
      (../schemas/Caps)::{
      , network = Some True
      , x11 = Some True
      , large-shm = Some True
      }

let Minimal = mkSimple "firefox" "Mozilla Firefox" // { capabilities = Caps }

let Extended =
      ../functions/addPackages.dhall
        [ "gdouros-symbola-fonts"
        , "mesa-dri-drivers"
        , "libva-intel-driver"
        , "libva-intel-hybrid-driver"
        ]
        (../functions/capMedia.dhall Minimal)

let WithCodecs = ../functions/addPackages.dhall [ "ffmpeg" ] Extended

in  { Minimal =
            Minimal
        //  { name = "firefox-light"
            , description = Some "Mozilla Firefox (without dri)"
            }
    , Extended = Extended
    , WithCodecs =
        WithCodecs // { name = "firefox", description = Some "Mozilla Firefox" }
    }
