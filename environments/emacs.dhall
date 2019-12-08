let Emacs =
      ../functions/addPackages.dhall
        [ "findutils", "grep" ]
        ( ../functions/capFs.dhall
            ( ../functions/mkSimpleTerminalEnv.dhall
                "emacs"
                "Extensible text editor"
            )
        )

let Graphic = ../functions/capGraphics.dhall Emacs

let IDE =
          ../functions/addPackages.dhall
            [ "make"
            , "git"
            , "cmake"
            , "gcc"
            , "gcc-c++"
            , "openssl-devel"
            , "libssh2-devel"
            , "glibc-common"
            ]
            Emacs
      //  { capabilities =
              (../schemas/Caps)::{
              , x11 = Some True
              , terminal = Some True
              , network = Some True
              , git = Some True
              , ssh = Some True
              }
          }

in  { Nox =
            Emacs
        //  { name = "emacs-nox"
            , description =
                Some "Extensible text editor (minimal terminal mode)"
            , command = Some [ "emacs", "-nw" ]
            }
    , Graphic = Graphic
    , IDE = IDE
    }
